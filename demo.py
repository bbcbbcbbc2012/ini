#!/usr/bin/python
#Filename demo.py
'''this is a demo to using python to manage address!'''

import cPickle as p

class address:
    def __init__(self, name, email = '', phone = ''):
        self.name = name
        self.email = email
        self.phone = phone
    
    def output(self):
		print self.name, self.email, self.phone

class ad_mgr:
    def __init__(self):
        self.data = {}

    def add(self, item):
        self.data[item.name] = item

    def remove(self, name):
        for n, info in self.data.items():
            if n == name:
                del self.data[name]
                break
        
    def find(self, name):
		print 'finding %s' % name
		for n, info in self.data.items():
			if n == name:
				print 'find out %s info:' % name,
				info.output()

    def save(self, filename):
        f = file(filename, 'w')
        p.dump(self, f)
        f.close()

    def load(self, filename):
        f = file(filename, 'r')
        self = p.load(f)
        f.close()

    def addad(self, name, email='', phone=''):
        item = address(name, email, phone)
        self.add(item)

    def list(self):
        for n, info in self.data.items():
            info.output()



mgr = ad_mgr()
mgr.addad('jjxh', 'fiestviva@mail.com', '123456')
mgr.addad('xhjj', 'haomaque@yahoo.com.cn', '0000000')

mgr.list()

mgr.find('xhjj')
mgr.save('data')
mgr.load('data')
mgr.list()

