ms:
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/db.sql && \
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/seed.sql  

migrate:
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/db.sql 


seed:
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/seed.sql

proc:
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/proc.sql 

dball:
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/db.sql && \
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/seed.sql && \
	mysql -u root -h 127.0.0.1 --password=asd@asd@ < db/proc.sql 


kill: 
	kill $(pgrep mtm)
pid: 
	sudo ss -lptn 'sport = :5000'

run: 
	go run main.go

build: 
	go build ./

prod: 
	./mtm > /dev/null 2>&1 & 
