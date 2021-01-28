Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73BD307846
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhA1Oiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhA1Oiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:38:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FDDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l18so4420775pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+eyDPRdJhZxxJdOiumoXFsr/6qKDBUjP/60ZOGxnOc=;
        b=ii36kCLCHnt3TutN31jHxg/8gwjcze3fPnuGU41Ln+1G0N5aGVKlRoaKuSGiLP/FIr
         kegSEbtPASb0w7dxTY8+WmtQ7k1q3oUfbnx2qdZeu5AygjJ6ShHSwjaKV/S1aP9h+ccS
         y5Cm3cQWpIohCASeZhTi009mv4mRUOVpWqEJw/zu1jTiaNBXuhWjcYK6gWFt1dmNzkU0
         R7dZxuCZK6Urci4lQ9GxwTjJdV+iVye9KG2UG5avW8zOpVEktaOOUjVKmK1w1nLum26G
         M1ezQlmsyIzmj1IqQ7Q0MJgZ5YZ1diBxEnHlQ1ZEVx2EVo7BXxL/GicKyPwhaOc+R6cz
         QYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+eyDPRdJhZxxJdOiumoXFsr/6qKDBUjP/60ZOGxnOc=;
        b=I+Vh7K16aLHNSjuD43ZouBaWCi5VgUPxh49bU9j36oopODzKJxdfGuabwT4aOIOtSE
         WcsMKmAOreqNQCwPYaDWA5esy+oHISbPN5DeLmZMa2FdP/WaUaTbkCEZOJx/e8CB8X6M
         5iPuRnavDdbDLJslnr+O9vT85bxcXoR+WhT/I3kCTbhZpcts5xdSmRUZ39Gme5kUdODS
         9inM8CzqsHBqcwALQrHtQuedkA2pWs0WUtRSj/rt1xT7rIF1TNuuNnNDNyqHO8dzLU/v
         rSjZ5OBu+klq0owVj6DtWjKlhimOmgCn8mAwDEcusz76gDw0XZsY7wHVCg9N4GH7U0lk
         g8bQ==
X-Gm-Message-State: AOAM5336X+Go87CE+vV6fAmi5KDcfI1B/AnqQ8QFqBtHBTrbJw+j13Ur
        upkIcdhyBsf0Cse1Tqxit+8I2gzJyGnxi5mS
X-Google-Smtp-Source: ABdhPJx9QBqHgCNIDl+wrmU8+QMyW9ZXDw+TyC23ZBXoAwZ1DqT8LU/YDsZd730DjT8jmGR3WM7Thw==
X-Received: by 2002:a17:90a:b398:: with SMTP id e24mr67344pjr.45.1611844685505;
        Thu, 28 Jan 2021 06:38:05 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:686d:e9f6:a78b:e60e:9585])
        by smtp.gmail.com with ESMTPSA id w14sm5358621pjl.38.2021.01.28.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:38:04 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2 1/3] checkpatch: add verbose mode
Date:   Thu, 28 Jan 2021 20:08:00 +0530
Message-Id: <20210128143802.15888-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128143802.15888-1-dwaipayanray1@gmail.com>
References: <20210128143802.15888-1-dwaipayanray1@gmail.com>
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
descriptions in the docs are kept in a fixed format, an example
of which is as follows:

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
 scripts/checkpatch.pl | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 05e908dcf0a0..2011d90c3e97 100755
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
@@ -198,6 +202,45 @@ if (-f $conf) {
 	unshift(@ARGV, @conf_args) if @conf_args;
 }
 
+sub load_docs {
+	open(my $docs, '<', "$docsfile")
+	    or warn "$P: Can't read the documentation file $docsfile $!\n";
+
+	my @lines = ();
+	while (<$docs>) {
+		my $line = $_;
+
+		$line =~ s/\s*\n?$//g;
+		push (@lines, $line);
+	}
+	close($docs);
+
+	my $linenr = 0;
+	my $cnt = scalar @lines;
+	while ($linenr < $cnt) {
+		while ($linenr < $cnt &&
+		       $lines[$linenr++] !~ /^\:(.+)\:$/)
+		{
+		}
+
+		last if ($linenr >= $cnt);
+
+		my $type = $lines[$linenr - 1];
+		$type =~ s/^\:(.+)\:$/$1/;
+		my $message = '';
+
+		while ($linenr < $cnt &&
+		       $lines[$linenr] =~ /^(?:\s+(.+)$|$)/) {
+			$message .= $1 if (defined $1);
+			$message .= "\n";
+			$linenr++;
+		}
+
+		$message = trim($message);
+		$verbose_messages{$type} = $message;
+	}
+}
+
 # Perl's Getopt::Long allows options to take optional arguments after a space.
 # Prevent --color by itself from consuming other arguments
 foreach (@ARGV) {
@@ -208,6 +251,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -249,6 +293,8 @@ help(0) if ($help);
 
 list_types(0) if ($list_types);
 
+load_docs() if ($verbose && !$terse);
+
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
@@ -2209,7 +2255,13 @@ sub report {
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

