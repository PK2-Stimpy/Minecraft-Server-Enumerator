from mcstatus import JavaServer
import sys

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

try:
	server = JavaServer.lookup(sys.argv[1] + ":" + sys.argv[2])
#	server = JavaServer.lookup(sys.argv[1] + ":" + sys.argv[2], sys.argv[2], sys.argv[3])
	status = server.status()

	print((bcolors.HEADER+sys.argv[1]+":"+sys.argv[2]+" -> "+bcolors.OKGREEN+"ONLINE("+str(status.players.online)+"/"+str(status.players.max)+") "+bcolors.OKCYAN+"MOTD='"+status.description+"'").replace("\n", "\\n") + bcolors.ENDC)
except:
	print(bcolors.HEADER+sys.argv[1]+":"+sys.argv[2]+" -> "+bcolors.FAIL+"OFFLINE"+bcolors.ENDC)

