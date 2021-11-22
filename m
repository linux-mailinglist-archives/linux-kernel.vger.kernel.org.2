Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3544588A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 05:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhKVEuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 23:50:55 -0500
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:55612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231656AbhKVEuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:50:55 -0500
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7847F10229386;
        Mon, 22 Nov 2021 04:47:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5436FA000417;
        Mon, 22 Nov 2021 04:47:38 +0000 (UTC)
Message-ID: <06c0cdc157ae1502e8e9eb3624b9ea995cf11e7a.camel@perches.com>
Subject: [PATCH] checkpatch: Improve Kconfig help test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Nov 2021 20:47:46 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.40
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5436FA000417
X-Stat-Signature: mhs638tj7htpm6ne9eb73ranyw3743o7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18bNBTebDLzld17O4NwMZnbHfffQQ0JHKU=
X-HE-Tag: 1637556458-620712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig help test erroneously counts patch context lines as part of
the help text.

Fix that and improve the message block output.

Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 scripts/checkpatch.pl | 52 +++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1784921c645da..21397fbc22c88 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3479,47 +3479,47 @@ sub process {
 		    # Kconfig supports named choices), so use a word boundary
 		    # (\b) rather than a whitespace character (\s)
 		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
-			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+			my $ln = $linenr;
+			my $needs_help = 0;
+			my $has_help = 0;
+			my $help_length = 0;
+			while (defined $lines[$ln]) {
+				my $f = $lines[$ln++];
 
 				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+				last if ($f !~ /^[\+ ]/);	# !patch context
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+					$needs_help = 1;
+					next;
+				}
+				if ($f =~ /^\+\s*help\s*$/) {
+					$has_help = 1;
+					next;
 				}
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
+				$f =~ s/^.//;	# strip patch context [+ ]
+				$f =~ s/#.*//;	# strip # directives
+				$f =~ s/^\s+//;	# strip leading blanks
+				next if ($f =~ /^$/);	# skip blank lines
 
+				# At the end of this Kconfig block:
 				# This only checks context lines in the patch
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
+				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
+					       if|endif|menu|endmenu|source)\b/x) {
 					last;
 				}
-				$length++;
+				$help_length++ if ($has_help);
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($needs_help &&
+			    $help_length < $min_conf_desc_length) {
+				my $stat_real = get_stat_real($linenr, $ln - 1);
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a help paragraph that fully describes the config symbol\n" . "$here\n$stat_real\n");
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
 # check MAINTAINERS entries


