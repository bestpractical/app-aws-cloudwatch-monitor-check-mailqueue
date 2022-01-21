use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'App::AWS::CloudWatch::Monitor::Check::MailQueue',
    AUTHOR => 'Best Practical Solutions, LLC <modules@bestpractical.com>',
    ABSTRACT_FROM => 'lib/App/AWS/CloudWatch/Monitor/Check/MailQueue.pm',
    VERSION_FROM => 'lib/App/AWS/CloudWatch/Monitor/Check/MailQueue.pm',
    LICENSE => 'apache_2_0',
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'https://github.com/bestpractical/app-aws-cloudwatch-monitor-check-mailqueue.git',
                web => 'https://github.com/bestpractical/app-aws-cloudwatch-monitor-check-mailqueue',
            },
        },
    },

    MIN_PERL_VERSION => '5.10.1',
    BUILD_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.64',  # for TEST_REQUIRES
    },
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.64',
    },
    TEST_REQUIRES => {
        'FindBin' => 0,
        'File::Find' => 0,
        'File::Spec' => 0,
        'Test::More' => '0.98',  # for subtest()
    },
    PREREQ_PM => {
        'parent' => 0,
        'strict' => 0,
        'warnings' => 0,
        'App::AWS::CloudWatch::Monitor' => 0,
    },

    test => {
        TESTS => 't/*.t',
    },
);
