#!/usr/bin/env node

const chalk = require('chalk');

require('../lib/cli').run(process.argv.slice(2))
    .then(() => process.on('exit', () => process.exit(0)))
    .catch((err) => {
        console.log('Error: ', err); // eslint-disable no-console
        process.on('exit', () => process.exit(1));
    });