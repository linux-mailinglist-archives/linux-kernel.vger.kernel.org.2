Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FB32604D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBZJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhBZJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:39:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AECC061756;
        Fri, 26 Feb 2021 01:38:41 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ba1so5032205plb.1;
        Fri, 26 Feb 2021 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8EEUIDrN8UWVFTUfP1Df0MDXCQYR+fu8HKWkSjVtwI=;
        b=EmkfzG5JEWgo/nd6OLBPnotWprmzJpnt+wwskPKmJ1nsg72IRgfJmrDDv1dhs0kqaY
         JwP3UrhIEN5ucsLKrysRZMyj/KhYRzPbrcTv/rqV3NLaJENZYQnTMIzd9jxnbpKANwWQ
         jGsRjBq3J7gM7lirDCmEK7SPpUA9tCaM2zFBZcAusF++Cf2Dq/P2cVIj+ut7hNoSNkOJ
         H87iBqzxvsLXAsOvnEzlaQ48BQphG+9ZeDUZS7VRaiKyWV/DNnICxuJXWhU1osFDNhnb
         tnWZuEVAJnt8U6D5r6NAEeciv/K2FyRyEFDhp+gmtGFUciCav107AIxese3WJj1njKBu
         LA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8EEUIDrN8UWVFTUfP1Df0MDXCQYR+fu8HKWkSjVtwI=;
        b=jfyNY8/U55TUoGngvN0sCT/GazvkYV53H1I9Fcki9io9qofUNj3iAXHQNQRWq5znN1
         T7b4gyR/DRZZZi7VeFwEahU8Zn3WpddKpFVHXj+ysd9Eevdk1LG27LlKYs4mORsEfZza
         0ZwC0bLf343VamPMnuE1NUdATv8Zhvv0J1o/A7ctYSigySahcuDmQh+dTrpoW7QNy3OB
         G6q/c/Jg5MUiIOAQGyUj3WFEh9sMmfXH/vJmq4jcR2OYNQyrfORA5BahEvtHZTkB2slO
         iuP0MoSuPRQ5LDF5BR6Y0ym7pSFdsf15aAgQdhWKcGdu7OUdhG35T+dkj+Z8cbT+yPAv
         DXNw==
X-Gm-Message-State: AOAM5332ksG+4gmqYyR0mOfdmYlwhwIqBuJNfmDvoolvFwxhBo3de0aH
        OBXrpQj2uP/poIlo5bcrEFQ=
X-Google-Smtp-Source: ABdhPJy+KpCuRTYdUpEL1Cd8ESfOydS5uHaJE8dnG3yJBTtJ9XCz6lancMXNhzMPfV/69ZiWTxlZFg==
X-Received: by 2002:a17:902:7787:b029:e4:571f:4485 with SMTP id o7-20020a1709027787b02900e4571f4485mr2346789pll.30.1614332320661;
        Fri, 26 Feb 2021 01:38:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6adb:2468:cd7e:b0b6:7857])
        by smtp.gmail.com with ESMTPSA id n1sm8548833pgi.78.2021.02.26.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:38:40 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com, corbet@lwn.net, mchehab@kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v8 2/3] checkpatch: add verbose mode
Date:   Fri, 26 Feb 2021 15:08:26 +0530
Message-Id: <20210226093827.12700-3-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210226093827.12700-1-dwaipayanray1@gmail.com>
References: <20210226093827.12700-1-dwaipayanray1@gmail.com>
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

Verbose mode can be used with the --list-types option.
The --list-types output also supports color coding now.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 133 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 113 insertions(+), 20 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..f42e5ba16d9b 100755
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
@@ -158,15 +163,51 @@ sub list_types {
 	my $text = <$script>;
 	close($script);
 
-	my @types = ();
+	my %types = ();
 	# Also catch when type or level is passed through a variable
-	for ($text =~ /(?:(?:\bCHK|\bWARN|\bERROR|&\{\$msg_level})\s*\(|\$msg_type\s*=)\s*"([^"]+)"/g) {
-		push (@types, $_);
+	while ($text =~ /(?:(\bCHK|\bWARN|\bERROR|&\{\$msg_level})\s*\(|\$msg_type\s*=)\s*"([^"]+)"/g) {
+		if (defined($1)) {
+			if (exists($types{$2})) {
+				$types{$2} .= ",$1" if ($types{$2} ne $1);
+			} else {
+				$types{$2} = $1;
+			}
+		} else {
+			$types{$2} = "UNDETERMINED";
+		}
 	}
-	@types = sort(uniq(@types));
+
 	print("#\tMessage type\n\n");
-	foreach my $type (@types) {
+	if ($color) {
+		print(" ( Color coding: ");
+		print(RED . "ERROR" . RESET);
+		print(" | ");
+		print(YELLOW . "WARNING" . RESET);
+		print(" | ");
+		print(GREEN . "CHECK" . RESET);
+		print(" | ");
+		print("Multiple levels / Undetermined");
+		print(" )\n\n");
+	}
+
+	foreach my $type (sort keys %types) {
+		my $orig_type = $type;
+		if ($color) {
+			my $level = $types{$type};
+			if ($level eq "ERROR") {
+				$type = RED . $type . RESET;
+			} elsif ($level eq "WARN") {
+				$type = YELLOW . $type . RESET;
+			} elsif ($level eq "CHK") {
+				$type = GREEN . $type . RESET;
+			}
+		}
 		print(++$count . "\t" . $type . "\n");
+		if ($verbose && exists($verbose_messages{$orig_type})) {
+			my $message = $verbose_messages{$orig_type};
+			$message =~ s/\n/\n\t/g;
+			print("\t" . $message . "\n\n");
+		}
 	}
 
 	exit($exitcode);
@@ -198,6 +239,46 @@ if (-f $conf) {
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
@@ -208,6 +289,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -247,13 +329,27 @@ GetOptions(
 
 help(0) if ($help);
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
+
+if ($color =~ /^[01]$/) {
+	$color = !$color;
+} elsif ($color =~ /^always$/i) {
+	$color = 1;
+} elsif ($color =~ /^never$/i) {
+	$color = 0;
+} elsif ($color =~ /^auto$/i) {
+	$color = (-t STDOUT);
+} else {
+	die "$P: Invalid color mode: $color\n";
+}
+
+load_docs() if ($verbose);
 list_types(0) if ($list_types);
 
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
-die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
-
 my $exit = 0;
 
 my $perl_version_ok = 1;
@@ -268,18 +364,6 @@ if ($#ARGV < 0) {
 	push(@ARGV, '-');
 }
 
-if ($color =~ /^[01]$/) {
-	$color = !$color;
-} elsif ($color =~ /^always$/i) {
-	$color = 1;
-} elsif ($color =~ /^never$/i) {
-	$color = 0;
-} elsif ($color =~ /^auto$/i) {
-	$color = (-t STDOUT);
-} else {
-	die "$P: Invalid color mode: $color\n";
-}
-
 # skip TAB size 1 to avoid additional checks on $tabsize - 1
 die "$P: Invalid TAB size: $tabsize\n" if ($tabsize < 2);
 
@@ -2209,7 +2293,16 @@ sub report {
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

