package mdkapplet;

use Exporter;
use lib qw(/usr/lib/libDrakX);
use common;
our @ISA = 'Exporter';
our @EXPORT = qw(%comm_codes);


our %comm_codes = (
    locked => {
        code => 2,
        status => 'locked',
        log => "urpmi database locked, skipping updating urpmi database",
    },
    error_updating => {
        code => 3,
        status => 'critical',
        log => N_("Error updating media"),
    },
    no_update_medium => {
        code => 4,
        status => 'no_update_medium',
        log => "no update media configured",
    },
    no_enabled_medium => {
        code => 5,
        status => 'no_enabled_medium',
        log => "all update media are disabled",
    },
    updates => {
        code => 6,
        status => 'updates',
        log => "Checking... Updates are available\n\n",
    },
    uptodate => {
        code => 7,
        status => 'okay',
        log => "Packages are up to date\n",
    },
    db_not_open => {
        code => 8,
        status => 'critical',
        log => "Failed to open urpmi database\n",
    },
    unconfigured_restricted_media => {
        code => 9,
        status => 'unconfigured_restricted_media',
        log => "Missing restricted media\n",
    },
    no_enterprise_update_medium => {
        code => 10,
        status => 'no_enterprise_update_medium',
        log => "Missing enterprise update media\n",
    },
);

1;
