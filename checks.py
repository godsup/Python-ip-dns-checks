# Python code to get info from csv and post response to anohter csv file

# Here we import neccecary packages
import os
import csv
import socket

name = ""
ip = []
dns = []
status = []

#This function pings IP
#os.system gets True or False value from the ping command, if response is 0 or True it will return yes else return no
def checkping(ip):
    response = os.system('ping -c 1 ' + ip + '1>/dev/null 2>/dev/null')
    print('PING =')
    print(response)
    if response == 0:
        return 'yes'
    else:
        return 'no'

#This function dig dns 
def checkdns(dns):
    response = os.popen('dig ' + dns + ' +short').read()
    print("DNS =")
    print(response)
    if response:
        return 'yes'
    else:
        return 'no'

def checknmap(ip):
    response = os.popen('nmap ' + ip + " -Pn -p 22 | egrep -io 'open|closed|filtered'").read()
    print('NMAP =')
    print(response)
    if response.strip() == 'open':
        return 'open'
    elif response == 'filtered':
        return 'filtered'
    else:
        return 'closed'    



results_ping = []
results_dig = []
results_nmap = []



# Here we open file which has the list of ips and hostnames
with open('info.csv', 'r', newline='') as csvfile:
# Skips the heading using next() method
    heading = next(csvfile)
# Create reader object by passing the file object to reader method
    reader = csv.reader(csvfile)
    file = True
    for row in reader:
        ip = row[0]
        dns = row[1]
        results_ping.append(checkping(ip))
        results_dig.append(checkdns(dns))
        results_nmap.append(checkdns(ip))

        with open('Output Final.csv', 'a', newline='') as csvoutput:
            output = csv.writer(csvoutput)
            if file:
                something = 'nmap'
                output.writerow(['DNS'] + ['IP'] + ['Ping'] + ['DNS'] + ['NMAP'])
                file = False
            else:
                output.writerow([dns] + [ip] + [checkping(ip)] + [checkdns(dns)] + [checknmap(dns)])


#['DNS'] + ['IP'] + ['Ping'] + ['DNS'] + 
# [] = list
# [()] = tuple
# {} = object
# () = function

