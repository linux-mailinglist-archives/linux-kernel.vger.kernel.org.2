Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1148E31AB89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBMNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:15:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418FC061756;
        Sat, 13 Feb 2021 05:15:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t26so1478723pgv.3;
        Sat, 13 Feb 2021 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2aORxbnf+DGbq/G4gpJwPMJHXkfAOgGQl6kIcx8lWY=;
        b=Zw/8jv3uoTx0FwSukqrtymCPtwkwVuUt9kifaufVBs4ohaotDmFlY9Fpdo5eDiBlHO
         yMqKr4RxzpeUuTRo6jtYsxq7dNlu8shBS/u1RJnKCIlCSBCcIfj21Qsro6eYYAQeCqBy
         6kWik8aIRrzZNk2C8sfLfs83Rh4ySVH9joCrqY1nyC2OI4n0MTpePMOchMMngCXQGGnv
         wNB/T3fgzK7QDSHMpn8ES6EtkpBeVZQaCaRuSud5cEGBid6KYLatik132wDpdlSMwL6B
         1GlBQv9xZVGqvWq8mUHWmpbN3Q0KMMacuRL4SfdkKXXm2EtY1JUWJdGTdAufXiuVW7ot
         RUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2aORxbnf+DGbq/G4gpJwPMJHXkfAOgGQl6kIcx8lWY=;
        b=E+JjkmPQD450PElo/1TvTkVRIGjlc/PWZ09F2Opb6QC7ABxLIAqeUnzIdMjHQ+PUq2
         l9hwKtiqafwKve1Ip86/E22vyzNNXxlcdyMSkl/GSqthl0uL5c4dOwtl3mMdMk2O4UO7
         cCbZV6yN6FrXiDkG5ConHwC9qTr0iuyE+gOnwErhKsv5/+GSGj60LGqRL3auszdWcibG
         w8noa/I+8wu5Wp4NjG8QqjxAgMmMAIjxaHiVDJ7ZNfy47GmVrPVo0FInLn/bsJ13vnSw
         /6RodqUjf15z3ICm66HZ/pqveGGV2dv+FiO5smBXQ8nyCysDDrokMGDFY7IZnE5YZriH
         PWdw==
X-Gm-Message-State: AOAM530X6AkSDKEcGDLHu2g3qWt6iq1I6Fjj+vEhCYcKjkZNCiTrUXj1
        nM4Kr17JiHYDaghFhYN/5c0=
X-Google-Smtp-Source: ABdhPJwe6R5ksjqCQM0kCEASY2V32ehEVTfcap1G8r918bgM/0AxuvhdmBz1pDddbTlFrWqpUiWnUQ==
X-Received: by 2002:a63:ed58:: with SMTP id m24mr7496367pgk.45.1613222118080;
        Sat, 13 Feb 2021 05:15:18 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6ab4:5c97:80e6:be35:2e49])
        by smtp.gmail.com with ESMTPSA id p11sm833533pjb.3.2021.02.13.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:15:17 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC v3 1/3] checkpatch: add verbose mode
Date:   Sat, 13 Feb 2021 18:45:11 +0530
Message-Id: <20210213131513.51386-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213131513.51386-1-dwaipayanray1@gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
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
descriptions in the docs are kept in a fixed format using rst field
lists, an example of which is as follows:

:LINE_SPACING:
  Vertical space is wasted given the limited number of lines an
  editor window can display when multiple blank lines are used.

:MISSING_SIGN_OFF:
  The patch is missing a Signed-off-by line.  A signed-off-by
  line should be added according to Developer's certificate of
  Origin.
  ref: `Documentation/process/submitting-patches.rst`

The verbose descriptions are not shown when the --terse option
is enabled.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 55 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a549b009d2f..062545e68405 100755
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
+		if ($line =~ /^\:(.+)\:$/) {
+			if ($desc ne '') {
+				$verbose_messages{$type} = trim($desc);
+			}
+			$type = $1;
+			$desc = '';
+			$in_desc = 1;
+		} elsif ($in_desc) {
+			if ($line =~ /^(?:\s{2,}|$)/) {
+				$line =~ s/^\s{2}//;
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
@@ -249,6 +294,8 @@ help(0) if ($help);
 
 list_types(0) if ($list_types);
 
+load_docs() if ($verbose && !$terse);
+
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
@@ -2209,7 +2256,13 @@ sub report {
 		splice(@lines, 1, 1);
 		$output = join("\n", @lines);
 	}
-	$output = (split('\n', $output))[0] . "\n" if ($terse);
+
+	if ($terse) {
+		$output = (split('\n', $output))[0] . "\n";
+	} elsif ($verbose &&
+		 exists $verbose_messages{$type}) {
+		$output .= $verbose_messages{$type} . "\n\n";
+	}
 
 	push(our @report, $output);
 
-- 
2.30.0

