Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B400320A26
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 13:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBUL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBUL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:58:42 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B397C061786
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 03:58:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so4865239pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3IQGEkMNg3SPWQMPEj53QXgIVqHL4s9+hHV8n/Qa3c=;
        b=n9oFtiiYkxyHmUHCc43SLu+ZSfNPcaZUkiN4xVFFnXoZv0gl60geo8YxOIjCy0Uj17
         XwXklT9FdAVs3qVN1LL1drCS8opXbDhNRmyBUeiT3lhP4s7NTfCrP6bYmdZuUmS86YnS
         rgTqm4iGh65WvHN3kK7cNc2t8T23goOT/acJNYn3PdHCWOcUr0Vy+dtFBblR+n8enMuk
         9cTLd1c6AnHrwCk7WQ6SGqBa/4Jbd68VPkYgLCTjIltZqum61thsSGl/sEyBCxAbmAGN
         yJy1kXoTa1wy+oXlo4XsecCATo2Vj756GYpE2uRsB0LOjgWttrvXrrmRWTCPLN3/Zd0Q
         5Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3IQGEkMNg3SPWQMPEj53QXgIVqHL4s9+hHV8n/Qa3c=;
        b=b792n0n5ibJp8OppogjZwYMpXGkFv6z2eg5kQX542YUSV/s3PCDE8f6/NTE0L1wu/N
         1yrbbmH6VqOMAMMLCpyVFDs0yDnv0soXz6a4H29Gd+WHBZyPsWTsQ40g7OJ5URtQZS5Y
         +CZ8j675p5byeFPXrTBeWXWomKuci0ZJl2LT4TC0vIVutGxVDt3xUV4F8lakL8C0Wsqq
         nwYo4ty7yKZk6Ejd+Dxzmyvjl+1EMpmNluvdhA1I0FJP8UulLoZNpw8ZhXnuEFlNWqnm
         5a6bmgXjCrkm8n4AtbB8Fta7/FjcHaKl1tAbSlp/OOra+A89C8atOSJWljryH6EXY4it
         EsEg==
X-Gm-Message-State: AOAM530uWKi2wuDUyD9fDOeFTE0CHSIdhmB03OQhOn0mHDtHfmL6Qelz
        Y1SAFBtMxVHGcixHpK0+Yifg8u6dc0Mh2BIb
X-Google-Smtp-Source: ABdhPJxfC99UCDUV8B9Ey0aLgQPoIEWsxpy3Ws5vzVfpSwjDr1Km27jI2tTLJxXiaGNo5MmvZ6SOgg==
X-Received: by 2002:a62:1855:0:b029:1d9:2fe3:5b28 with SMTP id 82-20020a6218550000b02901d92fe35b28mr17950819pfy.42.1613908681689;
        Sun, 21 Feb 2021 03:58:01 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6950:6d00:817e:a84c:30d2])
        by smtp.gmail.com with ESMTPSA id r5sm15694563pfh.13.2021.02.21.03.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 03:58:01 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v6 1/2] checkpatch: add verbose mode
Date:   Sun, 21 Feb 2021 17:28:01 +0530
Message-Id: <20210221115802.19788-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221115802.19788-1-dwaipayanray1@gmail.com>
References: <20210221115802.19788-1-dwaipayanray1@gmail.com>
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
usage. Some examples of this format are:

  **LINE_SPACING**
    Vertical space is wasted given the limited number of lines an
    editor window can display when multiple blank lines are used.

  **MISSING_SIGN_OFF**
    The patch is missing a Signed-off-by line.  A signed-off-by
    line should be added according to Developer's certificate of
    Origin.

To avoid lengthy output, the verbose description is printed only
for the first instance of a particular message type.

The --verbose option cannot be used along with the --terse option.

Verbose mode can also be used with the --list-types option, which
will then output the verbose descriptions along with the checkpatch
message types.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 68 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a549b009d2f..b44fcf13dec1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -23,6 +23,9 @@ my $V = '0.32';
 use Getopt::Long qw(:config no_auto_abbrev);
 
 my $quiet = 0;
+my $verbose = 0;
+my %verbose_messages = ();
+my %verbose_emitted = ();
 my $tree = 1;
 my $chk_signoff = 1;
 my $chk_patch = 1;
@@ -61,6 +64,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
+my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
@@ -78,6 +82,7 @@ Version: $V
 
 Options:
   -q, --quiet                quiet
+  -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
   --patch                    treat FILE as patchfile (default)
@@ -167,6 +172,11 @@ sub list_types {
 	print("#\tMessage type\n\n");
 	foreach my $type (@types) {
 		print(++$count . "\t" . $type . "\n");
+		if ($verbose && exists($verbose_messages{$type})) {
+			my $message = $verbose_messages{$type};
+			$message =~ s/\n/\n\t/g;
+			print("\t" . $message . "\n\n");
+		}
 	}
 
 	exit($exitcode);
@@ -198,6 +208,46 @@ if (-f $conf) {
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
@@ -208,6 +258,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -247,13 +298,15 @@ GetOptions(
 
 help(0) if ($help);
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
+
+load_docs() if ($verbose);
 list_types(0) if ($list_types);
 
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
-die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
-
 my $exit = 0;
 
 my $perl_version_ok = 1;
@@ -2209,7 +2262,16 @@ sub report {
 		splice(@lines, 1, 1);
 		$output = join("\n", @lines);
 	}
-	$output = (split('\n', $output))[0] . "\n" if ($terse);
+
+	if ($terse) {
+		$output = (split('\n', $output))[0] . "\n";
+	}
+
+	if ($verbose && exists($verbose_messages{$type}) &&
+	    !exists($verbose_emitted{$type})) {
+		$output .= $verbose_messages{$type} . "\n\n";
+		$verbose_emitted{$type} = 1;
+	}
 
 	push(our @report, $output);
 
-- 
2.30.0

