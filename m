Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6F434026
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhJSVKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJSVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:10:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:07:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s17so21966489ioa.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2PP+gJhdXF1cyjoyavD7iQtLnRNWYAFizmuB5awnVM=;
        b=pmOSoRjvHOikCuVD5dVKy8pWOuWERdY6BAXaOWaMnBB/moT0pEqTLVSc1jo83p1w9c
         lTrIasuLjHUaqSheSNlzfBAmOGc/DwBr/fW5wWwQ72OFzLjDGkDFMqAbXTjP94JGANDL
         +1xxFlV5Z+mrf6izP0HQXLa+BGUKk4THD5nm8EdyLagP0Gp0mCSFVUYVJeyuPpFplvn4
         54GBs/vB0/DqgHJp/rX9JKpSbkmGMw3Bnl121UhDKVxpDnHCg0gTVFB8FqiIj6RhUjTs
         q/Qv5RDtSbNkxH96QFWg4EeOh2YnQ9mv09h3+IgF9oUU+/btqKj6ySULh0zmRYI2Tc6j
         53yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2PP+gJhdXF1cyjoyavD7iQtLnRNWYAFizmuB5awnVM=;
        b=vw+VFD/RUBVXA+DAuwOYqlduYHEk+g8KJRc3pDmKzflWo9avRBMuCsByx2GQ5sgRvq
         oRclo64vrf0OQ33WAJYy3czohFU3g/V9gcHb/Tpvlj4Qr/TmCxvJ08wFdUf54LJSQEE4
         YJ8ax6EYUKq2+wld8b4bmLYoNz5ae1H+SUO5MndEfF7h9gkJ9Ls03DwDFyv0MZJEh6bQ
         /AS0DLM4booXoiLAZFAdl1BiyJ4rUgUosHYT2WbrOHSTOgP9tS8apBHETPaoESPIyj6b
         i9pxOTnjs6ht4do9hljHiiLDa2oMJFdhrIuBoZifoi80Lm7v2IpxVhVmYs/dO/t+xFvs
         dI7A==
X-Gm-Message-State: AOAM530x56l+xcRJzKXxMxBhrYrTm4p9Vk5N78SoJ5PXrm97tUrmql9K
        awJOB3ycXm3ByF/FG5UaFPM=
X-Google-Smtp-Source: ABdhPJwmlFJQ2yWSWujlEFWr2UIL6l7msG+QpJgzAcD0jUKg1CBBlpjDKS4wujR21Ds0oJ/4LkScIQ==
X-Received: by 2002:a5d:8884:: with SMTP id d4mr20499832ioo.137.1634677669026;
        Tue, 19 Oct 2021 14:07:49 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id g11sm127019ioo.3.2021.10.19.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:07:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/1] dyndbg: refine verbosity 1-4 summary-detail
Date:   Tue, 19 Oct 2021 15:07:46 -0600
Message-Id: <20211019210746.185307-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YWbTsfXB7mq/z7qq@kroah.com>
References: <YWbTsfXB7mq/z7qq@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust current v*pr_info() calls to fit an overview..detail scheme:

1- module level activity: add/remove, etc
2- command ingest, splitting, summary of effects.
   per >control write
3- command parsing: op, flags, search terms
4- per-site change msg
   can yield ~3k x 2 logs per echo "+p;-p" > command.

Summarize these 4 levels in MODULE_PARM_DESC, and update verbose=3 in Doc.

2- is new, to isolate a problem where a stress-test script (which
feeds ~4kb multi-command strings) would produce short writes,
truncating last command and causing parsing errors, which confused
test results.  The script fix was to use syswrite, to deliver full
proper commands.

4- gets per-callsite "changed:" pr-infos, which are very noisy during
stress tests, and formerly obscured v1-3 messages, and overwhelmed the
static-key workload being tested.

The verbose parameter has previously seen adjustment:
commit 481c0e33f1e7 ("dyndbg: refine debug verbosity; 1 is basic, 2 more chatty")

The script driving these adjustments is:

 !/usr/bin/perl -w

=for Doc

1st purpose was to benchmark the effect of wildcard queries on query
performance; if wildcards are risk free cheap enough, we can deploy
them in the (floating) format search.  1st finding: wildcards take 2x
as long to process.

2nd purpose was to benchmark real static-key changes VS simple flag
changes.  Found ~100x decrease for the hard work.

The script maximizes workload per >control by packing it a ~4kb
string of "+p; -p;" commands; this uncovered some broken stuff.

The 85th query failed, and appears to be truncated, so is gramatically
incorrect.  Its either an error here, or in the kernel.  Its not
happening atm, retest.

Plot thickens: fail only happens doing +-p, not +-mf, likely load
dependent.  Error remains consistent.  Looks like a short write,
longer on writer than kernel-reader.  Try syswrite on handle to
control this.  That fixed short write.

=cut

use Getopt::Std;

getopts('vN:k:', \my %opts) or die <<EOH;
$0 options:
    -v		verbose
    -k=n	kernel dyndbg verbosity
    -N=n	number of loops.. tbrc
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

sub bench_static_key_toggle {
    vx 0;
    dobatch(' file "*" module "*" func "*" ', "mf");
    dobatch(' file "*" module "*" func "*" ', "p");
}

sub bench_verbose_levels {
    for my $i (0..4) {
	vx $i;
	dobatch(' file "*" module "*" func "*" ', "mf");
    }
}

bench_static_key_toggle();

__END__

Heres how the test-script runs:

:: verbose=3 parsing info

[   48.401646] dyndbg: query 95: "file "*" module "*" func "*"  -mf # off " mod:*
[   48.402040] dyndbg: split into words: "file" "*" "module" "*" "func" "*" "-mf"
[   48.402456] dyndbg: op='-'
[   48.402615] dyndbg: flags=0x6
[   48.402779] dyndbg: *flagsp=0x0 *maskp=0xfffffff9
[   48.403033] dyndbg: parsed: func="*" file="*" module="*" format="" lineno=0-0
[   48.403674] dyndbg: applied: func="*" file="*" module="*" format="" lineno=0-0

:: verbose=2 >control summary.
   ~300k site matches/changes per 4kb command

[   48.404063] dyndbg: processed 96 queries, with 296160 matches, 0 errs

:: 2 queries against each other, no-search vs all-wildcard-search

qry: ct:48 x <<
  file "*" module "*" func "*"  +mf # on ;  file "*" module "*" func "*"  -mf # off
 >>
len: 4080, 576
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search:  0 wallclock secs ( 0.00 usr +  0.03 sys =  0.03 CPU) @ 333.33/s (n=10)
            (warning: too few iterations for a reliable count)
 wildcards:  0 wallclock secs ( 0.00 usr +  0.09 sys =  0.09 CPU) @ 111.11/s (n=10)
            (warning: too few iterations for a reliable count)

:: 2 queries, both doing real work / changing stati-key states.

qry: ct:49 x <<
  file "*" module "*" func "*"  +p # on ;  file "*" module "*" func "*"  -p # off
 >>
len: 4067, 490
Benchmark: timing 10 iterations of no_search, wildcards...
 no_search: 20 wallclock secs ( 0.00 usr + 20.36 sys = 20.36 CPU) @  0.49/s (n=10)
 wildcards: 21 wallclock secs ( 0.00 usr + 21.08 sys = 21.08 CPU) @  0.47/s (n=10)
bash-5.1#

Thats 150k static-key-toggles / sec
  ~600x slower than simple flags
  on qemu --smp 3 run

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  2 +-
 lib/dynamic_debug.c                           | 25 +++++++++++--------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index ae264aab42b6..a89cfa083155 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -356,7 +356,7 @@ Examples
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
-    dynamic_debug.verbose=1
+    dynamic_debug.verbose=3
     // enable pr_debugs in the btrfs module (can be builtin or loadable)
     btrfs.dyndbg="+p"
     // enable pr_debugs in all files under init/
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 87b1b0121234..dd7f56af9aed 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -71,6 +71,8 @@ static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
 module_param(verbose, int, 0644);
+MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
+		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
@@ -118,6 +120,8 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
+#define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -130,7 +134,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
 		 query->function ?: "",
 		 query->filename ?: "",
@@ -213,7 +217,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
+			v4pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
@@ -273,7 +277,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		buf = end;
 	}
 
-	if (verbose) {
+	if (verbose >= 3) {
 		int i;
 		pr_info("split into words:");
 		for (i = 0; i < nwords; i++)
@@ -333,7 +337,7 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
-	vpr_info("parsed line %d-%d\n", query->first_lineno,
+	v3pr_info("parsed line %d-%d\n", query->first_lineno,
 		 query->last_lineno);
 	return 0;
 }
@@ -447,7 +451,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	vpr_info("op='%c'\n", op);
+	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -461,7 +465,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -477,7 +481,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -540,9 +544,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		}
 		i++;
 	}
-
 	if (i)
-		vpr_info("processed %d queries, with %d matches, %d errs\n",
+		v2pr_info("processed %d queries, with %d matches, %d errs\n",
 			 i, nfound, errs);
 
 	if (exitcode)
@@ -780,7 +783,7 @@ static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 	tmpbuf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
-	vpr_info("read %d bytes from userspace\n", (int)len);
+	v2pr_info("read %zu bytes from userspace\n", len);
 
 	ret = ddebug_exec_queries(tmpbuf, NULL);
 	kfree(tmpbuf);
@@ -968,7 +971,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.31.1

