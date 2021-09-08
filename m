Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE9403C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352010AbhIHPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhIHPAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76BBC60E77;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=F2eheWIUBx/EoMu2x24ycu8JLAfsbzlSl0+DmRLYS14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewLdT7EMeh9pFUUFlj6Q/p0EH/yG1sl/QMVVaxtdnfLoMyVN89I1KEcZJg6kpmeTI
         huXi1+L6izXXVg7Dbfwnv88iOPHz6XkNXGv2TVAzHL6tXvLyw3YIj6/f0eoJSYjDX8
         E28fW4y/0u/DJpj/7qWEfbJxI6nrDu8Z8lPwxiPSiTU7OSiL8/zr8FGbMwMOozx51p
         QbctyfPNqLo6SIOxdvc+MjkuKlBSDPoKnRFK1cN+0R0piRxOzAgbPN8lX0Xms9+Kzg
         ICjTYy3yofphXN/Wn1dWWh70UZthbzwDo3t+D/OW+g7ztN5KDCECuncPaoyNf3DhqA
         HftgyRQBEcH7g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2S-006r3l-Ma; Wed, 08 Sep 2021 16:59:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] scripts: get_abi.pl: add an option to filter undefined results
Date:   Wed,  8 Sep 2021 16:58:50 +0200
Message-Id: <504f317750e978861fbc713072d1a309ac8b14b3.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of this script can be too big. Add an option to
filter out results, in order to help finding issues at the
ABI files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 7600e50b53bb..9ca43b225d9a 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -18,6 +18,7 @@ my $enable_lineno = 0;
 my $show_warnings = 1;
 my $prefix="Documentation/ABI";
 my $sysfs_prefix="/sys";
+my $search_string;
 
 #
 # If true, assumes that the description is formatted with ReST
@@ -31,6 +32,7 @@ GetOptions(
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
 	"show-hints" => \$hint,
+	"search-string=s" => \$search_string,
 	man => \$man
 ) or pod2usage(2);
 
@@ -578,6 +580,7 @@ sub check_undefined_symbols {
 		my $defined = 0;
 		my $exact = 0;
 		my $whats = "";
+		my $found_string;
 
 		my $leave = $file;
 		$leave =~ s,.*/,,;
@@ -585,6 +588,11 @@ sub check_undefined_symbols {
 		my $path = $file;
 		$path =~ s,(.*/).*,$1,;
 
+		if ($search_string) {
+			$found_string = 1 if ($file =~ m#$search_string#);
+		}
+
+		print "--> $file\n" if ($found_string && $hint);
 		if (defined($leaf{$leave})) {
 			my $what = $leaf{$leave};
 			$whats .= " $what" if (!($whats =~ m/$what/));
@@ -610,6 +618,7 @@ sub check_undefined_symbols {
 				if (substr($file, 0, $len) eq $new) {
 					my $newf = $a . substr($file, $len);
 
+					print "    $newf\n" if ($found_string && $hint);
 					foreach my $w (split / /, $what) {
 						if ($newf =~ m#^$w$#) {
 							$exact = 1;
@@ -632,10 +641,10 @@ sub check_undefined_symbols {
 		next if ($file =~ m#/parameters/#);
 
 		if ($hint && $defined) {
-			print "$leave at $path might be one of:$whats\n";
+			print "$leave at $path might be one of:$whats\n"  if (!$search_string || $found_string);
 			next;
 		}
-		print "$file not found.\n";
+		print "$file not found.\n" if (!$search_string || $found_string);
 	}
 }
 
@@ -686,6 +695,10 @@ sub undefined_symbols {
 		$what =~ s/\\([\[\]\(\)\|])/$1/g;
 		$what =~ s/(\d+)\\(-\d+)/$1$2/g;
 
+		if ($search_string) {
+			print "What: $what\n" if ($what =~ m#$search_string#);
+		}
+
 		$leave =~ s/[\(\)]//g;
 
 		foreach my $l (split /\|/, $leave) {
@@ -748,6 +761,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
 	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
+	       [--search-string <regex>]
 	       <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
@@ -795,6 +809,11 @@ times, to increase verbosity.
 Show hints about possible definitions for the missing ABI symbols.
 Used only when B<undefined>.
 
+=item B<--search-string> [regex string]
+
+Show only occurences that match a search string.
+Used only when B<undefined>.
+
 =item B<--help>
 
 Prints a brief help message and exits.
-- 
2.31.1

