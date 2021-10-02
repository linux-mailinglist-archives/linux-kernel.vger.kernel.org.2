Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B428141FE24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhJBVBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:01:02 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D4C061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 13:59:16 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 66so15237804vsd.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmzUTe+8tf9ORwUXfCYWyn0YV7gPAwJ8f50O9C3XDxo=;
        b=mdlwitb4ukMaUy4k+twHIt8adEjjYpR/lyKNtIdJY6fMRwu5R1xbWoKmGKu46OhMSc
         CRHJDDgJpaIsQ6L9pMZiqCAfQ7pmE8n32m8IAPAakz1/Ll3OHpMnxt/dfm6e4NA5qCkj
         +ykTPJYVjmV1CZ3qwnxB27D8dK85rahDO4OdVMq3y8QikZzi6RI0T4AYmmBsXumKsmSX
         u43zbGZ+SbifQ17gsPCnQdWmbx/8p0JEshnc+Phfkaz0u/Prwycx8VpsncbghDRAgHvL
         YF/qAm0ojVBZtoYQ4GqyDkBFKOAUAimyZGphQ4BeZIM+t3nCBa9TeC7zQaQz+kSmipsC
         mtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmzUTe+8tf9ORwUXfCYWyn0YV7gPAwJ8f50O9C3XDxo=;
        b=zL/SxfCKi5FALc9Ou79dIGvhFyXZ0Tl+0168LbPJLo7xuKuvT94JofkvPkd8/TFpO1
         Wqkm15rq+ltVSGQWV1YPYR05ST9eVvlxXJj6++OEV2JMt61TsrAYbtkH+8+cPv/jOnGC
         3BXlLYg1sauNzsxgXskoKRsWY8sgLoxoCDDoogWj00z5t3pPifaColKH8hLIK1rS9SdY
         OyFeU7IuPJw98IsZnppLFfq6Q4VG/SSCLUcBRfSDlxut8ThmgVYlGJt+VIcgFXnrxJBa
         CmaaLGl5OuWjASu0IYx/nch7SxqbNvnlJyDXwauu6nXc/ofSs+0bg+mbx6+6Tcj4RLRR
         gn9A==
X-Gm-Message-State: AOAM533BjDug0XVkM/h7v+wFEZ6/TH+w17GwTncOsZjx7iCzKfcxNDZA
        xdjRtI7HXLMh6pGcPRy2qghVWdEIOJ2jymhpGDNX5nwLZkU=
X-Google-Smtp-Source: ABdhPJxToHxbeuCX57mgSUFC52UmNlKEpTPuE9FrS5bqOvgh3LqGg2JpVMiJqEWdgWiQyXIvkQAmM287GeMQ7Vwj1Cg=
X-Received: by 2002:a05:6102:5c2:: with SMTP id v2mr9564352vsf.48.1633208355408;
 Sat, 02 Oct 2021 13:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210929183735.6630-1-jim.cromie@gmail.com> <20210929183735.6630-4-jim.cromie@gmail.com>
 <YVVU0ZixMFzAtEMf@kroah.com>
In-Reply-To: <YVVU0ZixMFzAtEMf@kroah.com>
From:   jim.cromie@gmail.com
Date:   Sat, 2 Oct 2021 14:58:48 -0600
Message-ID: <CAJfuBxyBeah848zZOYTMTDCByuz9LLQXc4QT81aqvaZxdXVPhg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dyndbg: rationalize verbosity
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 29, 2021 at 12:37:32PM -0600, Jim Cromie wrote:
> > change current v*pr_info() calls to fit this new scheme:
> >
> > -1 module level activity: add/remove, etc
> > -2 command ingest, splitting
> >    per >control write
> > -3 command parsing - many v1s here now
> > -4 per-site changes - was v2
> >
> > -2 is new, to isolate a problem where a stress-test script (which
> > feeds large multi-command strings) would produce short writes,
> > truncating last command and causing parsing errors, which confused
> > test results.  The 1st fix was to use syswrite in the script, to
> > deliver full proper commands.
> >
> > -4 gets per-callsite "changed:" pr-infos, which are very noisy during
> > stress tests, and obscure v1-3 messages.
> >
> > Update docs verbose example to 3 per its comment (potential conflict here)
...

> > -    dynamic_debug.verbose=1
> > +    dynamic_debug.verbose=3
>
> Did you just change the user/kernel interface here?

I hope not.
pinning specific meanings to verbose=1
STM a pretty tight interpretation.

If it is an issue that it got documented, I added those examples,
so I can at least speak to intent.

commit 29e36c9ffb696ed8d73e1aee713d483ec74a9a43
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Fri Apr 27 14:30:41 2012 -0600

    dynamic_debug: update Documentation/*, Kconfig.debug

- its a bootargs example
so without the =1, it parses wrong, and elicits a warning -
Booting kernel: `' invalid for parameter `dynamic_debug.verbose'
maybe it should have been a boolean param,
but int seemed more generic, with an intrinsic 0..N range

- as an example, its not really meant to be normative, more helpful.
turning on verbose and leaving it is not intended as a recommendation

Id also plead that --verbose and --debug are the 1st knobs
a user would turn when trying to understand a new tool / command / feature


Also, the verbose knob has already seen some "enhancement"
481c0e33f1e7 dyndbg: refine debug verbosity; 1 is basic, 2 more chatty



What happens to the
> systems that were using '1' as a value?  Do they have to be changed?

verbose changes no operation. Only the feedback after
    echo $bogus_cmd >control

If a user is getting parsing errors, they need to correct the $cmd 1st,
(and enable verbose to see what went wrong when they resubmit the commands.)
expecting a syslog-watcher to backstop that is "unreliable"



>
> Why is this needed?

Ultimately, I needed it cuz I ran the following script against >control,
to pound the crap out of the static_key toggling slow-path.

script hammers hard by writing as many $cmd_off $cmd_on pairs as possible
  echo "$cmd_on; $cmd_off" >control

I found that the Nth cmd was getting truncated, wasnt sure why.
Needed better selectivity of log messages, was buried by "callsite
changed" messages.

Changing the script to use syswrite 4k fixed the problem,
I concluded the kernel was blameless, but could be more helpful.

#!/usr/bin/perl -w

=for Doc

1st purpose is to benchmark the effect of wildcard queries on query
performance; if wildcards are cheap enough, we can deploy them in the
(floating) format search.

This uncovered some broken stuff; the 85th query failed, and appears
to be truncated, so is gramatically incorrect.  Its either an error
here, or in the kernel.  Its not happening atm, retest.

Plot thickens: fail only happens doing +-p, not +-mf.  Or something
quirky.  Error remains consistent.  Looks like a short write, longer
on writer than kernel-reader.  Try syswrite on handle to control this.

=cut

use Getopt::Std;

getopts('vN:k:', \my %opts) or die <<EOH;
$0 options:
    -v verbose
    -k=n kernel dyndbg verbosity
    -N=n number of loops.. tbrc
EOH
$opts{N} //= 10; # !undef, 0 tests too long.

my $ctrl = '/proc/dynamic_debug/control';

vx($opts{k}) if defined $opts{k}; # works on -k0

open(my $CTL, '>', $ctrl) or die "cant open $ctrl for writing: $!\n";


sub vx {
    my $arg = shift;
    my $cmd = "echo $arg > /sys/module/dynamic_debug/parameters/verbose";
    system($cmd);
    warn("vx problem: rc:$? err:$! qry: $cmd\n") if ($?);
}

sub doit { # aka Qx
    my ($grep, $cmd) = @_;

    print "qry: $cmd >>\n";
    print qx/ echo '$cmd' > $ctrl /;
    #print qx/ grep $grep $ctrl /;
    open(my $h, "grep $grep $ctrl|") or die;
    while (<$h>) {
/ (=.+?) / and print "  yields: $1\n" and last;
    }
}

sub qryOK {
    my $qry = shift;

    print "syntax test: <\n$qry>\n" if $opts{v};
    my $bytes = syswrite $CTL, $qry;
    printf "short read: $bytes / %d\n", length $qry if $bytes < length $qry;
    if ($?) {
warn "rc:$? err:$! qry: $qry\n";
return 0;
    }
    return 1;
}

sub build_queries {
    my ($cmd, $flags, $ct) = @_;

    # build experiment and reference queries

    my $cycle = " $cmd +$flags # on ; $cmd -$flags # off \n";
    my $ref   = " +$flags ; -$flags \n";

    my $len = length $cycle;
    my $max = int(4096 / $len); # break/fit to buffer size
    $ct |= $max;
    print "qry: ct:$max x << \n$cycle >>\n";

    return unless qryOK($ref);
    return unless qryOK($cycle);

    my $wild = $cycle x $ct;
    my $empty = $ref x $ct;

    printf "len: %d, %d\n", length $wild, length $empty;

    return { trial => $wild,
     ref => $empty,
     probe => $cycle,
     zero => $ref,
     count => $ct,
     max => $max
    };
}

my $query_set = build_queries(' file "*" module "*" func "*" ', "mf");

qryOK($query_set->{zero});
qryOK($query_set->{probe});

qryOK($query_set->{ref});
qryOK($query_set->{trial});

#exit;
use Benchmark;
sub dobatch {
    my ($cmd, $flags, $reps, $ct) = @_;
    $reps ||= $opts{N};

    my $qs = build_queries($cmd, $flags, $ct);

    timethese($reps,
      {
  wildcards => sub {
      syswrite $CTL, $qs->{trial};
  },
  no_search => sub {
      syswrite $CTL, $qs->{ref};
  }
      }
);
}

vx 0;
dobatch(' file "*" module "*" func "*" ', "mf");
dobatch(' file "*" module "*" func "*" ', "p");

__END__


the last 2 lines run benchmarks
+/-p  (active static-key update)
vs +/- mf, (same apply code, just no static-key change)




Turning off the callsite-changed reports sped the tests considerably,
and is worth being able to do if isolating and stressing the static-key
from the console is useful.


As for the benchmark,

299k static-keys en/disabled every 0.48/sec

I cant say if thats fast or slow,  but it might be useful to compare
to something.




[   17.799142] dyndbg: query 95: <file "*" module "*" func "*"  -mf #
off > mod:<*>
[   17.799546] dyndbg: split into words: <file> <*> <module> <*>
<func> <*> <-mf>
[   17.799954] dyndbg: op=<->
[   17.800106] dyndbg: flags=0x6
[   17.800270] dyndbg: *flagsp=0x0 *maskp=0xfffffff9
[   17.800531] dyndbg: parsed: func=<*> file=<*> module=<*> format=<> lineno=0-0
[   17.801258] dyndbg: applied: func=<*> file=<*> module=<*> format=<>
lineno=0-0
[   17.801654] dyndbg: processed 96 queries, with 299040 matches, 0 errs
qry: ct:48 x <<
  file "*" module "*" func "*"  +mf # on ;  file "*" module "*" func
"*"  -mf # off
 >>
len: 4080, 576
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search:  0 wallclock secs ( 0.00 usr +  0.07 sys =  0.07 CPU) @
142.86/s (n=10)
            (warning: too few iterations for a reliable count)
 wildcards:  0 wallclock secs ( 0.00 usr +  0.14 sys =  0.14 CPU) @
71.43/s (n=10)
            (warning: too few iterations for a reliable count)
qry: ct:49 x <<
  file "*" module "*" func "*"  +p # on ;  file "*" module "*" func
"*"  -p # off
 >>
len: 4067, 490
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search: 21 wallclock secs ( 0.00 usr + 21.01 sys = 21.01 CPU) @
0.48/s (n=10)
 wildcards: 22 wallclock secs ( 0.00 usr + 21.26 sys = 21.26 CPU) @
0.47/s (n=10)
bash-5.1#






ISTM 1234 module-level ... callsite-updates seemed a worthwhile
mental model to rationalize the progressively detailed reports of a $cmd error.
And preserve output availability while suppressing noisy (for many
purposes) output.


If you conclude this change is good,
and want any of the above in a commit --amend, I'll do that.

otherwize I'll resend this (and others, including the !SOB one)
as part of next rev of  "use dyndbg in drm.debug".

>
> thanks,
>
> greg k-h
