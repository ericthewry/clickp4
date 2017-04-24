json:
	@mkdir -p build >>/dev/null 
	@python tools/parse_config.py
	@p4c-bmv2 src/clickp4.p4 --json build/clickp4.json >>/dev/null

clean:
	@rm -rf build