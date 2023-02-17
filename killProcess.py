#!/usr/bin/python
import os, signal

def process():

	#Ask user for name of process
	name = input("Enter process name: ")
	try:
		#iteration through each instance of the process
		for line in os.popen("ps ax | grep "+ name + "| grep -v grep"):
			fields = line.split()
			
			#extracting process id from output
			pid = fields[0]
			
			#terminating the process
			os.kill(int(pid), signal.SIGKILL)
		print("Process sucessfully terminated")
	except:
		print("Errors ecountered while running script")
		
process()
