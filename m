Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869FA320C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhBUSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:07:28 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:49940 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229910AbhBUSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:07:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 512F1100E7B44;
        Sun, 21 Feb 2021 18:06:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3867:3868:3871:4250:4321:4605:5007:6299:7652:7903:8603:9592:10004:10400:10848:11232:11658:11914:12043:12291:12296:12297:12555:12683:12740:12760:12895:13095:13439:14110:14181:14659:14721:21080:21221:21433:21451:21611:21627:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: night24_5605ad127671
X-Filterd-Recvd-Size: 3858
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Feb 2021 18:06:44 +0000 (UTC)
Message-ID: <46c3b16602f36858b194b22dfbdb2150e25f5d94.camel@perches.com>
Subject: Re: [PATCH v6 1/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Feb 2021 10:06:43 -0800
In-Reply-To: <20210221115802.19788-2-dwaipayanray1@gmail.com>
References: <20210221115802.19788-1-dwaipayanray1@gmail.com>
         <20210221115802.19788-2-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-02-21 at 17:28 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch.pl to emit additional verbose
> test descriptions. The verbose mode is optional and can be enabled
> by the flag -v or --verbose.

OK, maybe add color coding to the list_types output.
Something like:
---
 scripts/checkpatch.pl | 61 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bbff13e0ca7e..ccd4a1bd73cb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -163,14 +163,39 @@ sub list_types {
 	my $text = <$script>;
 	close($script);
 
-	my @types = ();
+	my %types = ();
 	# Also catch when type or level is passed through a variable
-	for ($text =~ /(?:(?:\bCHK|\bWARN|\bERROR|&\{\$msg_level})\s*\(|\$msg_type\s*=)\s*"([^"]+)"/g) {
-		push (@types, $_);
+	while ($text =~ /\b(CHK|WARN|ERROR|&\{\$msg_level})\s*\(\s*"([^"]+)"/g) {
+		if (exists($types{$2})) {
+			$types{$2} .= ",$1" if ($types{$2} ne $1);
+		} else {
+			$types{$2} = $1;
+		}
+	}
+	print("#\tMessage type");
+	if ($color) {
+		print(" (color coding: ");
+		print(RED . "ERROR" . RESET);
+		print("|");
+	        print(YELLOW . "WARNING" . RESET);
+		print("|");
+		print(GREEN . "CHECK" . RESET);
+		print("|");
+		print("Multiple levels" . RESET);
+		print(")");
 	}
-	@types = sort(uniq(@types));
-	print("#\tMessage type\n\n");
-	foreach my $type (@types) {
+	print("\n\n");
+	foreach my $type (sort keys %types) {
+		if ($color) {
+			my $level = $types{$type};
+			if ($level eq 'ERROR') {
+				$type = RED . $type . RESET;
+			} elsif ($level eq 'WARN') {
+				$type = YELLOW . $type . RESET;
+			} elsif ($level eq 'CHK') {
+				$type = GREEN . $type . RESET;
+			}
+		}
 		print(++$count . "\t" . $type . "\n");
 		if ($verbose && exists($verbose_messages{$type})) {
 			my $message = $verbose_messages{$type};
@@ -301,6 +326,18 @@ help(0) if ($help);
 die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
 die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
 
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
 load_docs() if ($verbose);
 list_types(0) if ($list_types);
 
@@ -321,18 +358,6 @@ if ($#ARGV < 0) {
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
 

