Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0F31DDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhBQQzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhBQQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:55:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CAC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:54:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c19so1805677pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYoK/Tw5oB77I374vAKWgvMSSaE63sx1dFoY33I3OsM=;
        b=QLUf6QH4t8JQ9w7H0cVt8SOghs0OyQGkdC8dToWvHQi9RfhrF5wu50MKe0hJXgjWP7
         cCYl3gZL7M+7MmYW+YSs6P0LUxCTvRMnhWQDSAxUvLpQlv6FNizzKiQDMI0xB1t5p8fb
         6FNYEKfwui7mQZ2OYKqocbPCOa21auCB7rxIxQ2OA7qO5vzZwluDJ7FLKpuxBuid3yJO
         k1L2uIULi8TG1+TBZUv0hKb0RnN89iOOOl2sY3kp5xJc+kGdSj2VAetl8JDleRvWX0Ge
         wVNEOBdfgtsTMPWQeSHQDo9vYENn/Du+lG0ZM8LByXP5N9pH53YTp+GBiYgOtg6Z6DKx
         hcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYoK/Tw5oB77I374vAKWgvMSSaE63sx1dFoY33I3OsM=;
        b=OF4hcNrOVHCyahaCnD4Jqfw+1dLAUQXnrz0CSTkJ02a4o2OGaXxNQHSOol8IqqcDBr
         uckWX7ayH/C6sc4xoCY/EsXsgTjNEx5b+hBm/Wvo6R8jxZyUpD1eCpGVYbaMWwbXRNkh
         R+jF/UFqjZSsnBUV6Ulh8neIjQRq5qhjmFhN/yUmnfU5V5zRQRBGQc5/o9rbR/sIWNUu
         Td9xGr/CuQOU1lKeI0Ew82E+KbtvOQPC9C3ypYE8AcmKFTE7Af1vULbKUwNCEnt0sJRc
         Wdfb9+ixChMrx+3RlsyK54AwrSgs6cKlyMZysYRldwZ7K2Uw/lxr2CxkfNo+BoAsBSI+
         oeNA==
X-Gm-Message-State: AOAM531+tfssvA/9qFDTvePHq/7eKy23Wjc4SXyPjlGKmsjHl/mtr2tP
        jkv668oXzkBQVqDMdfY6xD0=
X-Google-Smtp-Source: ABdhPJxNBwIGp2QuYb2d2tQBMy6iqTJc9Fnxlt6GzUWN/uzClu3MOT950J2/+73hhTdPeHkrb22vxA==
X-Received: by 2002:a17:902:8697:b029:e3:9724:e260 with SMTP id g23-20020a1709028697b02900e39724e260mr2250832plo.31.1613580872092;
        Wed, 17 Feb 2021 08:54:32 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:69b4:3f63:7c5a:6972:6781])
        by smtp.gmail.com with ESMTPSA id t21sm3063897pfe.174.2021.02.17.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:54:31 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v4 1/2] checkpatch: add verbose mode
Date:   Wed, 17 Feb 2021 22:24:33 +0530
Message-Id: <20210217165434.69298-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217165434.69298-1-dwaipayanray1@gmail.com>
References: <20210217165434.69298-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new verbose mode to checkpatch.pl to emit additional verbose
test descriptions. The verbose mode is optional and can be enabled
by the flag -v or --verbose.

The test descriptions are parsed from the checkpatch documentation
file at `Documentation/dev-tools/checkpatch.rst`. The test
descriptions in the docs are kept in a fixed format grouped by
usage. Some examples of the descriptions are:

  **LINE_SPACING**
    Vertical space is wasted given the limited number of lines an
    editor window can display when multiple blank lines are used.

  **MISSING_SIGN_OFF**
    The patch is missing a Signed-off-by line.  A signed-off-by
    line should be added according to Developer's certificate of
    Origin.
    ref: `Documentation/process/submitting-patches.rst`

The verbose descriptions are not shown when the --terse option
is enabled.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a549b009d2f..eeec412610d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -23,6 +23,8 @@ my $V = '0.32';
 use Getopt::Long qw(:config no_auto_abbrev);
 
 my $quiet = 0;
+my $verbose = 0;
+my %verbose_messages = ();
 my $tree = 1;
 my $chk_signoff = 1;
 my $chk_patch = 1;
@@ -61,6 +63,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
+my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
@@ -78,6 +81,7 @@ Version: $V
 
 Options:
   -q, --quiet                quiet
+  -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
   --patch                    treat FILE as patchfile (default)
@@ -198,6 +202,46 @@ if (-f $conf) {
 	unshift(@ARGV, @conf_args) if @conf_args;
 }
 
+sub load_docs {
+	open(my $docs, '<', "$docsfile")
+	    or warn "$P: Can't read the documentation file $docsfile $!\n";
+
+	my $type = '';
+	my $desc = '';
+	my $in_desc = 0;
+
+	while (<$docs>) {
+		chomp;
+		my $line = $_;
+		$line =~ s/\s+$//;
+
+		if ($line =~ /^\s*\*\*(.+)\*\*$/) {
+			if ($desc ne '') {
+				$verbose_messages{$type} = trim($desc);
+			}
+			$type = $1;
+			$desc = '';
+			$in_desc = 1;
+		} elsif ($in_desc) {
+			if ($line =~ /^(?:\s{4,}|$)/) {
+				$line =~ s/^\s{4}//;
+				$desc .= $line;
+				$desc .= "\n";
+			} else {
+				$verbose_messages{$type} = trim($desc);
+				$type = '';
+				$desc = '';
+				$in_desc = 0;
+			}
+		}
+	}
+
+	if ($desc ne '') {
+		$verbose_messages{$type} = trim($desc);
+	}
+	close($docs);
+}
+
 # Perl's Getopt::Long allows options to take optional arguments after a space.
 # Prevent --color by itself from consuming other arguments
 foreach (@ARGV) {
@@ -208,6 +252,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -247,13 +292,15 @@ GetOptions(
 
 help(0) if ($help);
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
+
 list_types(0) if ($list_types);
+load_docs() if ($verbose);
 
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
-die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
-
 my $exit = 0;
 
 my $perl_version_ok = 1;
@@ -2209,7 +2256,15 @@ sub report {
 		splice(@lines, 1, 1);
 		$output = join("\n", @lines);
 	}
-	$output = (split('\n', $output))[0] . "\n" if ($terse);
+
+	if ($terse) {
+		$output = (split('\n', $output))[0] . "\n";
+	}
+
+	if ($verbose &&
+	    exists $verbose_messages{$type}) {
+		$output .= $verbose_messages{$type} . "\n\n";
+	}
 
 	push(our @report, $output);
 
-- 
2.30.0

