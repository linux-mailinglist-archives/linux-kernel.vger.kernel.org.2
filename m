Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190463AC9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhFRLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhFRLau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 254E261351;
        Fri, 18 Jun 2021 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624015721;
        bh=5Pz1lNiWEhdxcezIWbGtg4zMJZ0g3vMwrjj21gjwJ1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As9lj7p7HqC2AMpE5ep3GslM0kgf7qfGXiINV/Bnk47S7/h+eX3aC/rQ51jrd/Xdu
         V7SDFyAeTI9Wuv4ZnRvX1lpi5s4pWaEtIZvmTek8DdglDyaLR8ilG3ZuF3VsDL2/cs
         7EkuWLPwcMX8ji0g1Y35UPku43ifRausmNUwh9trft93TRXvM5B3yxzy/TInxNyxaT
         kJGxf5QQNvIM8PgV8aO3JVV+qZnSNxbs5w+TJAdeKvcVwTy1d7glQ3lZaXWEPqE9dL
         ISP8oNxxrpWgkyLzX+gMYRvs0irJi/FIHyFB/eT7A8FNkbaAAAdUtDhwsOY3iZqFiQ
         /gaqPfZcQlayQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1luCfu-008agM-Sk; Fri, 18 Jun 2021 13:28:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/1] get_abi.pl: Check for missing symbols at the ABI specs
Date:   Fri, 18 Jun 2021 13:28:37 +0200
Message-Id: <fe2f4437c8b8b4ec01b7911b0ee64e9d6804449e.1624014140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624014140.git.mchehab+huawei@kernel.org>
References: <cover.1624014140.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for the symbols that exists under /sys but aren't
defined at Documentation/ABI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 72 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d7aa82094296..e85cee0f8901 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -14,6 +14,7 @@ my $man = 0;
 my $debug = 0;
 my $enable_lineno = 0;
 my $prefix="Documentation/ABI";
+my $sysfs_prefix="/sys";
 
 #
 # If true, assumes that the description is formatted with ReST
@@ -36,7 +37,7 @@ pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
 
 my ($cmd, $arg) = @ARGV;
 
-pod2usage(2) if ($cmd ne "search" && $cmd ne "rest" && $cmd ne "validate");
+pod2usage(2) if ($cmd ne "search" && $cmd ne "rest" && $cmd ne "validate" && $cmd ne "undefined");
 pod2usage(2) if ($cmd eq "search" && !$arg);
 
 require Data::Dumper if ($debug);
@@ -521,6 +522,68 @@ sub search_symbols {
 	}
 }
 
+my %leaf;
+
+my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xff]) }x;
+sub parse_existing_sysfs {
+	my $file = $File::Find::name;
+
+	my $mode = (stat($file))[2];
+	return if ($mode & S_IFDIR);
+
+	# /sys/.*/<foo>
+	return if ($file =~ m/(initstate|bind|unbind)/);
+
+	my $leave = $file;
+	$leave =~ s,.*/,,;
+
+	if (defined($leaf{$leave})) {
+		# FIXME: need to check if the path makes sense
+		my $what = $leaf{$leave};
+
+		$what =~ s/,/ /g;
+
+		$what =~ s/\<[^\>]+\>/.*/g;
+		$what =~ s/\{[^\}]+\}/.*/g;
+		$what =~ s/\[[^\]]+\]/.*/g;
+		$what =~ s,/\.\.\./,/.*/,g;
+		$what =~ s,/\*/,/.*/,g;
+
+		$what =~ s/\s+/ /g;
+
+		# Escape all other symbols
+		$what =~ s/$escape_symbols/\\$1/g;
+
+		foreach my $i (split / /,$what) {
+			if ($file =~ m#^$i$#) {
+#				print "$file: $i: OK!\n";
+				return;
+			}
+		}
+
+		print "$file: $leave is defined at $what\n";
+
+		return;
+	}
+
+#	print "$file not found.\n";
+}
+
+sub undefined_symbols {
+	foreach my $what (sort keys %data) {
+		my $leave = $what;
+		$leave =~ s,.*/,,;
+
+		if (defined($leaf{$leave})) {
+			$leaf{$leave} .= " " . $what;
+		} else {
+			$leaf{$leave} = $what;
+		}
+	}
+
+	find({wanted =>\&parse_existing_sysfs, no_chdir => 1}, $sysfs_prefix);
+}
+
 # Ensure that the prefix will always end with a slash
 # While this is not needed for find, it makes the patch nicer
 # with --enable-lineno
@@ -536,7 +599,9 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 #
 # Handles the command
 #
-if ($cmd eq "search") {
+if ($cmd eq "undefined") {
+	undefined_symbols;
+} elsif ($cmd eq "search") {
 	search_symbols;
 } else {
 	if ($cmd eq "rest") {
@@ -575,6 +640,9 @@ B<rest>                  - output the ABI in ReST markup language
 
 B<validate>              - validate the ABI contents
 
+B<undefined>             - existing symbols at the system that aren't
+                           defined at Documentation/ABI
+
 =back
 
 =head1 OPTIONS
-- 
2.31.1

