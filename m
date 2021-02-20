Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4D32052A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhBTMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:03:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24365C061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:02:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t26so7096059pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wq6g82nsj4oHvtZvnLkkAyzvX7bdqmsVNynOg49+qAY=;
        b=ExFnD7ldQCZRfHTPwOM/miJmuvlt96QtDSXJeYGu0pPyJkRtKoHzk7hCdqmOJ1S0MP
         tYJP1IdIVtE/Dlq2fUmoM/xKTSpc9pGcU4gimcsZOb7Qdx0+S8YcdN67xSbw5rlc5qzx
         n9YgktdNzvo+YhHi13W8yVqMYGBYlrR4GzVUybfS6iOMVEyn4DD2jTPvh7fVGHwVKZVx
         rwOSAJ7FEzIeqliVEnaLm6b41GxBrhRbp/Lob/da5gEn0XBhrx53D6ElUM6o7aE9ouoS
         xhGSglGzzQkd/DOTlqIi2X+gA0YfMhWPZVsc+spjepzn85ly5sHFtXFyDaU42AO242A7
         WO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wq6g82nsj4oHvtZvnLkkAyzvX7bdqmsVNynOg49+qAY=;
        b=pikoFZrUQSt4iZ9RfMIA5+6EYB4/f2INqC7tJ3o9GdMTkv2n0LLssV8xN3cxB0TDMR
         K+7OQnhUBEmmVB/KN8J0Sv7nZG088/RmC3ZLErBGFT8MzvHyZeaEXjEAznE6KezX4Lkw
         arOCO2bo+aSX0sPtyDHW2JIgniUNsGkGA1RV1J/UDob0qqBXcXpxpkGgmDfcUT7fJewg
         Hbd+yiAHjk2yMmI00A7FN+9bEALF/CyrC+3x9A26e9OrPo8NXDIMgontd+cmfE6njTwd
         pBc2CZhmM2DmpI8+huOt8jvJt3NSDmqS2IY9DuZxui8vQQkBUUDhUnjHtrKRD2aGHsqs
         FXdQ==
X-Gm-Message-State: AOAM531aIznppfGg0AoZTPLB4SNdvcyZ3RY1v9cdJ8XGaTo8h8s44TBp
        KyXNAQ6EGEm2YAXlbNzUfRY=
X-Google-Smtp-Source: ABdhPJwgpodUPNjWBeOY9z9W0mZBD2BxFItk0w6Y6+sGEW9Dg9wBnvc2PceChXET+iNH8Y/tp8Z4CQ==
X-Received: by 2002:a63:524b:: with SMTP id s11mr12013149pgl.332.1613822539529;
        Sat, 20 Feb 2021 04:02:19 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6b3c:bf56:7f84:6ce5:cf93])
        by smtp.gmail.com with ESMTPSA id ml7sm6567046pjb.28.2021.02.20.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:02:19 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v5 1/2] checkpatch: add verbose mode
Date:   Sat, 20 Feb 2021 17:32:19 +0530
Message-Id: <20210220120220.32585-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210220120220.32585-1-dwaipayanray1@gmail.com>
References: <20210220120220.32585-1-dwaipayanray1@gmail.com>
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

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 63 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9a549b009d2f..0a91f818ab6f 100755
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
@@ -198,6 +203,46 @@ if (-f $conf) {
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
@@ -208,6 +253,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -247,13 +293,15 @@ GetOptions(
 
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
@@ -2209,7 +2257,16 @@ sub report {
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

