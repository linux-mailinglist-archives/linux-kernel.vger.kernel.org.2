Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEA42AC29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhJLSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhJLSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:40:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:37:18 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n7so41155iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=407bQN3BNnj/ULJKMvpptH4AszOJMHY+BDHDpDHjc9o=;
        b=ISClzWgA1WKcr1nQjMRSgTmZzLROYuWC+aWBgcyTSqnr6L3yacrB24GWzW0yoQU15D
         obOdmPL8TAe1iD75Os3kWLztlYXnROWnVruzjCiRBlqeGE5Em94JcKpblXRnCLytKcuK
         dJlGp6pQAcDbiecNunLXf58mNGH5dDiVnmi6pmVaE1y0X/al1PgeMuXdksudxunAacKP
         BjmQVZAFk4AffKT13+SNw21J3JZqgNPQfqsU+n+bUdc/qKAxq/pd7QOIQIvr+xHVZz1T
         1rBk0MzejSxd8Zzgpvo/RCuIYif18szaCXtGs4y6AZn/+PdwuwNo5qUYp3/V8OHpc/Y2
         1WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=407bQN3BNnj/ULJKMvpptH4AszOJMHY+BDHDpDHjc9o=;
        b=Mer6nX4MBKvz1PIE4bsNIvomet5BDc9x2Feyhowxy8mH8Pi2XZAJckSHEN4bNME8mX
         8zJ05lr0JNFJDrmpPZ6zw3uQ+E/K5qNKmQISe9buD/bbHy/iVEWWtN7bIhOTcZMba5H2
         uDVOXlS1vUOUYC5vpgjyyoHKr7KNAfYLr9ZLnL1ZZasXeczF0jtyaIO6yKp4Q66GurER
         oviCsf+si4rL2kZGudc0dt9dGl3IMx1AVNdGwgspEdptWrQGYWQd0gDtF110zlJXntpj
         NEp/SvrawrM08PAxMGgbsz7gUsOQPA1BdOZ41Mu+aQgqP12lNcTnynoJGtJlNegJ2+6Y
         S1KA==
X-Gm-Message-State: AOAM531SCJuyDF37uqvUQWqEzENwWnfjgWSGb/FTvHm4NbLUe9Xmaoc6
        RFxDsBWLDpZNQiTz3vqeUsw=
X-Google-Smtp-Source: ABdhPJyUtEa8b3v1YzZa56yBYmlJZpHs5Sx//AQaZ6FG3jaduUrTPCVi6Sqk1oktN5Dzl45U5nETUw==
X-Received: by 2002:a6b:d210:: with SMTP id q16mr7038390iob.187.1634063608708;
        Tue, 12 Oct 2021 11:33:28 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/5] dyndbg: refine verbosity 1-4 summary-detail
Date:   Tue, 12 Oct 2021 12:33:07 -0600
Message-Id: <20211012183310.1016678-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust current v*pr_info() calls to fit an overview..detail scheme:

-1 module level activity: add/remove, etc
-2 command ingest, splitting, summary of effects.
   per >control write
-3 command parsing, 6 vpr-infos changed to this.
-4 per-site change - was v2, too noisy there.
   can yield 3k logs per command.

-2 is new, to isolate a problem where a stress-test script (which
feeds large multi-command strings) would produce short writes,
truncating last command and causing parsing errors, which confused
test results.  The 1st fix was to use syswrite in the script, to
deliver full proper commands.

-4 gets per-callsite "changed:" pr-infos, which are very noisy during
stress tests, and formerly obscured v1-3 messages, and dominated the
static-key workload being tested.

The verbose parameter has previously seen adjustment:
commit 481c0e33f1e7 ("dyndbg: refine debug verbosity; 1 is basic, 2 more chatty")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
The script driving these adjustments is:

 !/usr/bin/perl -w

=for Doc

1st purpose was to benchmark the effect of wildcard queries on query
performance; if wildcards are cheap enough, we can deploy them in the
(floating) format search.  1st finding: wildcards take 2x as long to
process.

2nd purpose was to benchmark real static-key changes VS simple flag
changes.  Found ~100x decrease for the hard work.

The script maximizes workload per >control by packing it a long
sequence of "+p; -p;" commands; this uncovered some broken stuff.

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
---
 lib/dynamic_debug.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfe1e6a857bc..e645807cb20a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -118,6 +118,8 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
+#define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -130,7 +132,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
 		 query->function ?: "",
 		 query->filename ?: "",
@@ -213,7 +215,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
+			v4pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
@@ -273,7 +275,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		buf = end;
 	}
 
-	if (verbose) {
+	if (verbose >= 3) {
 		int i;
 		pr_info("split into words:");
 		for (i = 0; i < nwords; i++)
@@ -333,7 +335,7 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
-	vpr_info("parsed line %d-%d\n", query->first_lineno,
+	v3pr_info("parsed line %d-%d\n", query->first_lineno,
 		 query->last_lineno);
 	return 0;
 }
@@ -447,7 +449,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	vpr_info("op='%c'\n", op);
+	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -461,7 +463,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -477,7 +479,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -540,7 +542,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		}
 		i++;
 	}
-	vpr_info("processed %d queries, with %d matches, %d errs\n",
+	v2pr_info("processed %d queries, with %d matches, %d errs\n",
 		 i, nfound, errs);
 
 	if (exitcode)
@@ -781,7 +783,7 @@ static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 	tmpbuf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
-	vpr_info("read %d bytes from userspace\n", (int)len);
+	v2pr_info("read %zu bytes from userspace <\n%s>\n", len, tmpbuf);
 
 	ret = ddebug_exec_queries(tmpbuf, NULL);
 	kfree(tmpbuf);
@@ -969,7 +971,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.31.1

