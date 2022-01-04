import streamlit as st
import pandas as pd
import psycopg2
import hashlib

conn = psycopg2.connect(database = 'soccer',user = 'postgres',password = '1234',host = 'localhost',port = '5432' )
cur = conn.cursor()

def make_hashes(password):
    return hashlib.sha256(str.encode(password)).hexdigest()

def check_hashes(password,hashed_text):
    if make_hashes(password) == hashed_text:
        return hashed_text
        return False

def create_usertable():
    cur.execute('CREATE TABLE IF NOT EXISTS userstable(username TEXT,password TEXT)')

def add_userdata(username,password):
    cur.execute('INSERT INTO userstable(username, password) VALUES (%s,%s)', (username, password))

    conn.commit()

def login_user(username,password):
    cur.execute('SELECT * FROM userstable WHERE username = %s AND password = %s',(username,password))
    data = cur.fetchall()
    return data


def main():
    st.title('UEFA Tournament')
    menu = ['Home','Fans','Admin Login','Admin SignUp','Queries']
    choice = st.sidebar.selectbox("Menu",menu)

    if choice == 'Home':
        st.subheader("Home page")
    if choice == 'Fans':
        st.subheader("All the details of the tournament are here!!")
        task = st.selectbox("Select the category to veiw the details :)",["Choose the data to be displayed","Player","Team","Match","League","Stadium"])
        df =None
        if task == 'Choose':
            st.write('Select from the above options to view the details')
            df = None
        if task == 'Player':
            cur.execute('Select * from player;')
            rows = list(cur.fetchall())
            df = pd.DataFrame(rows)
            df.columns = ['First Name','Last Name','Jersey Number','Country','Date of birth','Position','Goals','Cards','Assists','Player ID','Team']
        if task == 'Team':
            cur.execute('Select name,logo,owned_by,year_founded,home_stadium from team;')
            rows = list(cur.fetchall())
            df = pd.DataFrame(rows)
            df.columns = ['Name','Short Form','Owner','Year Established','Home Stadium']
        if task == 'Match':
            cur.execute('Select Match_number,Date,Played_between,Winner,Loser,Draw from match;')
            rows = list(cur.fetchall())
            df = pd.DataFrame(rows)
            df.columns = ['Match Number','Date','Played Between','Team Won','Team Lost','Was it a draw?']
        if task == 'League':
            cur.execute('select logo, lname,sponsor, country, position from team join league on team.lname = league.name;')
            rows = list(cur.fetchall())
            df = pd.DataFrame(rows)
            df.columns = ['Team Name','League Name','League Sponsor','Country','Position']
        if task == 'Stadium':
            cur.execute('select stadium_name, capacity, location from stadium;')
            rows = list(cur.fetchall())
            df = pd.DataFrame(rows)
            df.columns = ['Stadium Name','Seating Capacity','Location']
        st.dataframe(df)

    if choice == 'Queries':
        flag = 1
        if st.sidebar.checkbox("Simple Queries"):
            flag = 1
        if st.sidebar.checkbox("Complex Queries"):
            flag = 0
        if flag == 1:
            task = st.selectbox("Select the queries to veiw the details :)",["Choose the query to be displayed","Query1","Query2","Query3","Query4","Query5"])
            df =None
            if task == 'Query1':
                st.subheader('Count the total number of countries from which the players are taking part in the tournament')
                cur.execute('SELECT count(DISTINCT nationality) FROM player;')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Count']
            if task == 'Query2':
                st.subheader('List the Firstname, Lastname, Position and the Jersey numbers of the players who are from French nationality')
                cur.execute("SELECT first_name, last_name, position, jersey_number FROM player WHERE nationality = 'FRA';")
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['First Name','Last Name','Position','Jersey Number']
            if task == 'Query3':
                st.subheader('Display the Maximum and Minimum stadium capacities')
                cur.execute('SELECT MAX(capacity),MIN(capacity) FROM stadium;')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Maximum Capacity','Minimum Capacity']
            if task == 'Query4':
                st.subheader('Display the number of sponsors who sponsored the amount greater than or equal to the average amount sponsored')
                cur.execute('SELECT count(*) FROM sponsor WHERE sponsored_amount >= (SELECT AVG(sponsored_amount) FROM sponsor);')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Count']
            if task == 'Query5':
                st.subheader('Display the Firstname, Lastname, Experience and Team of managers who have more than or equal to 10 years of experience')
                cur.execute('SELECT first_name, last_name, experience, name FROM ( manager JOIN team ON manager.employee_id = team.employee_id )WHERE experience >= 10;')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['First Name','Last Name','Experience','Team Name']
            st.dataframe(df)
        if flag == 0:
            task = st.selectbox("Select the queries to veiw the details :)",["Choose the query to be displayed","Query1","Query2","Query3","Query4"])
            df =None
            if task == 'Query1':
                st.subheader('Display the team short forms along with the league and country they are from and also display their corresponding position in their league in a increasing order of position')
                cur.execute('SELECT logo , lname , country, position FROM team JOIN league on team.lname = league.name ORDER BY position;')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Short Form','League Name','Country','Position']
            if task == 'Query2':
                st.subheader('Display the winner of the matches which did not end in draw along with the date when the match occured and also display the referee/referees who monitered the match along with their employee_license and also display the staddium in which the match took place')
                cur.execute("SELECT winner, date, first_name, last_name, license_id,stadium_name FROM ((match JOIN referee ON match.match_number=referee.match_number) JOIN stadium ON match.match_number = stadium.match_number) WHERE draw = 'N';")
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Winner','Date','First Name','Last Name','License ID','Stadium Name']
            if task == 'Query3':
                st.subheader('Displaying Firstname, Lastname, Nubmer of goals and the Team of a player who has scored more goals than the average number of goals scored by the Center Forwards ( CF ) of each team in an increasing order of goals')
                cur.execute("SELECT first_name, last_name, goals, name FROM player WHERE goals > (SELECT AVG ( goals ) FROM player WHERE position = 'CF') ORDER BY goals;")
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['First Name','Last Name','Goals','Team Name']
            if task == 'Query4':
                st.subheader('Display the team which emerged as the winner of the tournament along with the total amount of sponsorship recieved by that team')
                cur.execute('SELECT name , SUM(sponsored_amount) FROM sponsor JOIN sponsored ON sponsor.sponsor_name= sponsored.sponsor_name WHERE name = (SELECT winner FROM tournament) GROUP BY name;')
                rows = list(cur.fetchall())
                df = pd.DataFrame(rows)
                df.columns = ['Tournament Winner','Total Sponsorship']
            st.dataframe(df)
    
    if choice == 'Admin Login':
        st.subheader("Admin Section")
        username = st.sidebar.text_input("User Name")
        password = st.sidebar.text_input("Password",type ='password')
        flag = 1
        if st.sidebar.button("Login"):
            flag = 1
        if st.sidebar.button("Logout"):
            flag = 0
        if flag:
            create_usertable()
            hashed_pswd = make_hashes(password)

            result = login_user(username,check_hashes(password,hashed_pswd))
            if result:
                st.success("Logged In as {}".format(username))
                st.subheader("Check the task to be performed in the sidebar checkbox ! ")
                df =None 
                if st.sidebar.checkbox("Insert values"):
                    task = st.selectbox("Select the table to update : ",["Match","Player","Referee"])   
                    if task == 'Match':
                        form = st.form(key='my-form')
                        mno = form.text_input('Enter Match Number')
                        date = form.text_input('Enter Date in YYYY-MM-DD format')
                        pbw = form.text_input('Enter Teams Played')
                        winner = form.text_input('Enter Winner')
                        loser = form.text_input('Enter Loser')
                        draw = form.text_input('Enter Y if Draw else N')
                        name = form.text_input('Enter Tournament Name')
                        submit = form.form_submit_button('Submit')
                        st.write('Press submit to insert the data into database')
                        if submit:
                            cur.execute('INSERT into match VALUES (%s,%s,%s,%s,%s,%s,%s);',(mno,date,pbw,winner,loser,draw,name))
                            st.write(f'Data succesfully added!')
                            conn.commit()
                        cur.execute('Select Match_number,Date,Played_between,Winner,Loser,Draw from match;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['Match Number','Date','Played Between','Team Won','Team Lost','Was it a draw?']


                    if task == 'Player':
                        form = st.form(key='my-form')
                        fn = form.text_input('Enter First Name')
                        ln = form.text_input('Enter Last Name')
                        jno = form.text_input('Enter Jersey Number')
                        coun = form.text_input('Enter Nationality')
                        dob = form.text_input('Enter Date of Birth in YYYY-MM-DD format')
                        pos = form.text_input('Enter Position played')
                        g = form.text_input('Enter No of Goals')
                        c = form.text_input('Enter No of Cards')
                        a = form.text_input('Enter No of Assists')
                        pid = form.text_input('Enter Player ID')
                        tname = form.text_input('Enter Team Name')
                        submit = form.form_submit_button('Submit')
                        st.write('Press submit to insert the data into database')
                        if submit:
                            cur.execute('INSERT into player VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);',(fn,ln,jno,coun,dob,pos,g,c,a,pid,tname))
                            st.write(f'Data succesfully added!')
                            conn.commit()
                        cur.execute('Select * from player;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['First Name','Last Name','Jersey Number','Country','Date of birth','Position','Goals','Cards','Assists','Player ID','Team']
                    if task == 'Referee':
                        form = st.form(key='my-form')
                        fn = form.text_input('Enter First Name')
                        ln = form.text_input('Enter Last Name')
                        coun = form.text_input('Enter Nationality')
                        lid = form.text_input('Enter License ID')
                        dob = form.text_input('Enter Date of Birth in YYYY-MM-DD format')
                        mno = form.text_input('Enter Match number')
                        submit = form.form_submit_button('Submit')
                        st.write('Press submit to insert the data into database')
                        if submit:
                            cur.execute('INSERT into referee VALUES (%s,%s,%s,%s,%s,%s);',(fn,ln,coun,lid,dob,mno))
                            st.write(f'Data succesfully added!')
                            conn.commit()
                        cur.execute('Select * from referee;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['First Name','Last Name','Nationality','License ID','Date of Birth','Match Number']

                if st.sidebar.checkbox("Delete values"):
                    task = st.selectbox("Select the table to update : ",["Match","Player","Referee"])
                    if task == 'Match':
                        cur.execute('Select Match_number,Date,Played_between,Winner,Loser,Draw from match;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['Match Number','Date','Played Between','Team Won','Team Lost','Was it a draw?']
                        form = st.form(key='my-form')
                        mno = form.text_input('Enter the Match Number to be deleted : ')
                        submit = form.form_submit_button('Submit')
                        if submit:
                            cur.execute('DELETE FROM match WHERE match_number = %s;',(mno,))
                            st.write(f'Data succesfully deleted!')
                            conn.commit()
                    if task == 'Player':
                        cur.execute('Select * from player;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['First Name','Last Name','Jersey Number','Country','Date of birth','Position','Goals','Cards','Assists','Player ID','Team']
                        form = st.form(key='my-form')
                        pid = form.text_input('Enter the Player ID to be deleted : ')
                        submit = form.form_submit_button('Submit')
                        if submit:
                            cur.execute('DELETE FROM player WHERE player_id = %s;',(pid,))
                            st.write(f'Data succesfully deleted!')
                            conn.commit()
                    if task == 'Referee':
                        cur.execute('Select * from referee;')
                        rows = list(cur.fetchall())
                        df = pd.DataFrame(rows)
                        df.columns = ['First Name','Last Name','Nationality','License ID','Date of Birth','Match Number']
                        form = st.form(key='my-form')
                        lid = form.text_input('Enter the License ID to be deleted : ')
                        submit = form.form_submit_button('Submit')
                        if submit:
                            cur.execute('DELETE FROM referee WHERE license_id = %s;',(lid,))
                            st.write(f'Data succesfully deleted!')
                            conn.commit()


                if st.sidebar.checkbox("Display values"):    
                    st.dataframe(df)

            else:
                st.warning("Incorrect Username/Password")

    elif choice == "Admin SignUp":
        st.subheader("Create New Account")
        new_user = st.text_input("Username",key='1')
        new_password = st.text_input("Password",type='password',key='2')

        if st.button("Signup"):
            create_usertable()
            add_userdata(new_user,make_hashes(new_password))
            st.success("You have successfully created a valid Account")
            st.info("Go to Login Menu to login")


if __name__ == '__main__':
    main()