Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E042A416251
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhIWPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242092AbhIWPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:43:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6973A60EE4;
        Thu, 23 Sep 2021 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411693;
        bh=RmbGsIzi9OFhRBsPwEMh0AUPi8dAARxCMykBCofHklM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5GvFtutjvfrAtrEjL0GKjYit9jsJ6fAdJAwlUDlVACVKbAHpii/i2gWHeKk/qzYo
         nBZf/B9HXTp1+qEoiZjceTSbtQngx8pu/mYsgRvDR9nZC82dJQf8D0rBf5E41LD9Df
         XLTXYVqQc+op+C+TDVX18HDSq6PyXIxuutQrfrIsp+cpNxOfTcrsfJu8wcvcnE1Skf
         vlqmb+c8JjgbcObzAMGZ86WMJMDvDOMByeXjmTW6SN3zNE/CPHfljYiYV7h2XtcsRw
         1JWohu2xsm4ZDjSISjwmdD4TVGyRg/7NwlId1wfTxlJXGwc7WgqSBfFBI53wWh2VGi
         qrpg7bWxPBtXw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTQqp-000p6G-O0; Thu, 23 Sep 2021 17:41:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     #@kernel.org, YUyICHTRdfL8Ul7X@kroah.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] scripts: get_abi.pl: improve debug logic
Date:   Thu, 23 Sep 2021 17:41:14 +0200
Message-Id: <0203416c6c418abb4fc20577a5f48d0d2a41bae7.1632411447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632411447.git.mchehab+huawei@kernel.org>
References: <cover.1632411447.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a level for debug, in order to allow it to be extended to
debug other parts of the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 9eb8a033d363..bb80303fea22 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -9,6 +9,7 @@ use Getopt::Long;
 use File::Find;
 use Fcntl ':mode';
 use Cwd 'abs_path';
+use Data::Dumper;
 
 my $help = 0;
 my $hint = 0;
@@ -20,13 +21,18 @@ my $prefix="Documentation/ABI";
 my $sysfs_prefix="/sys";
 my $search_string;
 
+# Debug options
+my $dbg_what_parsing = 1;
+my $dbg_what_open = 2;
+my $dbg_dump_abi_structs = 4;
+
 #
 # If true, assumes that the description is formatted with ReST
 #
 my $description_is_rst = 1;
 
 GetOptions(
-	"debug|d+" => \$debug,
+	"debug=i" => \$debug,
 	"enable-lineno" => \$enable_lineno,
 	"rst-source!" => \$description_is_rst,
 	"dir=s" => \$prefix,
@@ -46,7 +52,7 @@ my ($cmd, $arg) = @ARGV;
 pod2usage(2) if ($cmd ne "search" && $cmd ne "rest" && $cmd ne "validate" && $cmd ne "undefined");
 pod2usage(2) if ($cmd eq "search" && !$arg);
 
-require Data::Dumper if ($debug);
+require Data::Dumper if ($debug & $dbg_dump_abi_structs);
 
 my %data;
 my %symbols;
@@ -106,7 +112,7 @@ sub parse_abi {
 	my @labels;
 	my $label = "";
 
-	print STDERR "Opening $file\n" if ($debug > 1);
+	print STDERR "Opening $file\n" if ($debug & $dbg_what_open);
 	open IN, $file;
 	while(<IN>) {
 		$ln++;
@@ -178,7 +184,7 @@ sub parse_abi {
 							$data{$what}->{filepath} .= " " . $file;
 						}
 					}
-					print STDERR "\twhat: $what\n" if ($debug > 1);
+					print STDERR "\twhat: $what\n" if ($debug & $dbg_what_parsing);
 					$data{$what}->{line_no} = $ln;
 				} else {
 					$data{$what}->{line_no} = $ln if (!defined($data{$what}->{line_no}));
@@ -827,7 +833,7 @@ if ($cmd eq "undefined" || $cmd eq "search") {
 #
 find({wanted =>\&parse_abi, no_chdir => 1}, $prefix);
 
-print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
+print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug & $dbg_dump_abi_structs);
 
 #
 # Handles the command
@@ -860,7 +866,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
+B<abi_book.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
 	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
 	       [--search-string <regex>]
 	       <COMAND> [<ARGUMENT>]
@@ -900,10 +906,14 @@ logic (--no-rst-source).
 
 Enable output of #define LINENO lines.
 
-=item B<--debug>
+=item B<--debug> I<debug level>
 
-Put the script in verbose mode, useful for debugging. Can be called multiple
-times, to increase verbosity.
+Print debug information according with the level, which is given by the
+following bitmask:
+
+    -  1: Debug parsing What entries from ABI files;
+    -  2: Shows what files are opened from ABI files;
+    -  4: Dump the structs used to store the contents of the ABI files.
 
 =item B<--show-hints>
 
-- 
2.31.1

