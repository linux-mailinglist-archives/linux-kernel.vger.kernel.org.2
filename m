Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2582E3BAA06
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGCSmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 14:42:23 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:38192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229463AbhGCSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 14:42:21 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E70D6182CED2A;
        Sat,  3 Jul 2021 18:39:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id DCA101E04D7;
        Sat,  3 Jul 2021 18:39:45 +0000 (UTC)
Message-ID: <b1592f359a7e68704c0faac77015b9b2aa8e4073.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add check for common mailing list helper
 checks
From:   Joe Perches <joe@perches.com>
To:     "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 03 Jul 2021 11:39:44 -0700
In-Reply-To: <20210702223743.1240694-1-warthog9@eaglescrag.net>
References: <20210702223743.1240694-1-warthog9@eaglescrag.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.40
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DCA101E04D7
X-Stat-Signature: r7hh9tepy71m8h7e1kynfe4buat5jkg6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/NHSD30RN5KEFKYVkoV1xj4fTWrjZUb1s=
X-HE-Tag: 1625337585-147391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-02 at 15:37 -0700, John 'Warthog9' Hawley (VMware)
wrote:
> From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> 
> Mailing lists in an attempt to try and avoid sending certain
> administrative e-mails to the list, will check the first few lines
> (usually ~10) looking for keywords.  If those key words are found it
> shunts the e-mail to the list admin contact instead of potentially
> passing it through to the list.

Perhaps the below is a bit better, but I believe a few of the tests
are going to be tripped a bit too often.

Especially "cancel", "config" and maybe "subscribe" too.

For instance:

$ git log --grep='\bcancel\b' -P -i --pretty=oneline -10000 | wc -l
1693

$ git log --grep='^config\b' -P -i --pretty=oneline -10000 | wc -l
890

$ git log --grep='\bsubscribe\b' -P -i --pretty=oneline -10000 | wc -l
123

---
 scripts/checkpatch.pl | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4a..fcbcc26da875e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -865,6 +865,37 @@ our $allowed_asm_includes = qr{(?x:
 )};
 # memory.h: ARM has a custom one
 
+our $mailing_list_phrases = qr{(?xi:
+	\bcancel\b |
+	\badd\s+me\b |
+	\bdelete\s+me\b |
+	\bremove\s+me\b |
+	\bchange\b.*\baddress\b |
+	\bsubscribe\b |
+	^sub\b |
+	\bunsubscribe\b |
+	^unsub\b |
+	^\s*help\s*$ |
+	^\s*info\s*$ |
+	^\s*info\s+\S+\s*$ |
+	^\s*lists\s*$ |
+	^\s*which\s*$ |
+	^\s*which\s+\S+\s*$ |
+	^\s*index\s*$ |
+	^\s*index\s+\S+\s*$ |
+	^\s*who\s*$ |
+	^\s*who\s+\S+\s*$ |
+	^\s*get\s+\S+\s*$ |
+	^\s*get\s+\S+\s+\S+\s*$ |
+	^\s*approve\b |
+	^\s*passwd\b |
+	^\s*newinfo\b |
+	^\s*config\b |
+	^\s*newconfig\b |
+	^\s*writeconfig\b |
+	^\s*mkdigest\b
+)};
+
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
 my %spelling_fix;
@@ -2581,6 +2612,7 @@ sub process {
 	my $has_patch_separator = 0;	#Found a --- line
 	my $has_commit_log = 0;		#Encountered lines before patch
 	my $commit_log_lines = 0;	#Number of commit log lines
+	my $commit_log_missing = 0;	#Emitted a missing commit message warning
 	my $commit_log_possible_stack_dump = 0;
 	my $commit_log_long_line = 0;
 	my $commit_log_has_diff = 0;
@@ -2852,16 +2884,23 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
+# check if words in the commit message may trip up common mailing list helpers
+# to redirect email to the admin contact
+		if ($in_commit_log && $commit_log_lines < 10 &&
+		    $line =~ /($mailing_list_phrases)/) {
+			WARN("MAILING_LIST_HELPER",
+			     "Line matches common mailing list helpers and may not be delivered correctly - consider rewording '$1'\n" . $herecurr);
+		}
+
 # Verify the existence of a commit log if appropriate
-# 2 is used because a $signature is counted in $commit_log_lines
 		if ($in_commit_log) {
 			if ($line !~ /^\s*$/) {
 				$commit_log_lines++;	#could be a $signature
 			}
-		} elsif ($has_commit_log && $commit_log_lines < 2) {
+		} elsif ($has_commit_log && !$commit_log_missing) {
 			WARN("COMMIT_MESSAGE",
 			     "Missing commit description - Add an appropriate one\n");
-			$commit_log_lines = 2;	#warn only once
+			$commit_log_missing = 1;	#warn only once
 		}
 
 # Check if the commit log has what seems like a diff which can confuse patch

