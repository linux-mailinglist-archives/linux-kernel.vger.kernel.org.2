Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650213BA603
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGBWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:40:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43092 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhGBWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:40:20 -0400
Received: from usagi.middle.earth (ethbase.usagi.not.afront.org [IPv6:2620:137:e001:0:1897:4108:901b:c660])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id C8DDF4D252307;
        Fri,  2 Jul 2021 15:37:45 -0700 (PDT)
Received: from usagi.middle.earth (localhost [IPv6:::1])
        by usagi.middle.earth (Postfix) with ESMTP id 9132E27AB476;
        Fri,  2 Jul 2021 15:37:43 -0700 (PDT)
From:   "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Subject: [PATCH] checkpatch: Add check for common mailing list helper checks
Date:   Fri,  2 Jul 2021 15:37:43 -0700
Message-Id: <20210702223743.1240694-1-warthog9@eaglescrag.net>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 02 Jul 2021 15:37:45 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

Mailing lists in an attempt to try and avoid sending certain
administrative e-mails to the list, will check the first few lines
(usually ~10) looking for keywords.  If those key words are found it
shunts the e-mail to the list admin contact instead of potentially
passing it through to the list.

This adds a known list of the potential things that are checked for, and
while it may search deeper into the message (it goes till it believes
it's into the patch section) than the mailing list software this should
help give some warning if the wrong word is potentially added in the
wrong place in the beginning of a patch message.

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
---
 scripts/checkpatch.pl | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..c2f6e349f304 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2852,6 +2852,40 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
+# check if this may trip up common mailing list helpers to redirect email to the admin contact
+		if ($in_commit_log &&
+		    ($line =~ /\bcancel\b/i ||
+		    $line =~ /\badd me\b/i ||
+		    $line =~ /\bdelete me\b/i ||
+		    $line =~ /\bremove\s+me\b/i ||
+		    $line =~ /\bchange\b.*\baddress\b/ ||
+		    $line =~ /\bsubscribe\b/i ||
+		    $line =~ /^sub\b/i ||
+		    $line =~ /\bunsubscribe\b/i ||
+		    $line =~ /^unsub\b/i ||
+		    $line =~ /^\s*help\s*$/i ||
+		    $line =~ /^\s*info\s*$/i ||
+		    $line =~ /^\s*info\s+\S+\s*$/i ||
+		    $line =~ /^\s*lists\s*$/i ||
+		    $line =~ /^\s*which\s*$/i ||
+		    $line =~ /^\s*which\s+\S+\s*$/i ||
+		    $line =~ /^\s*index\s*$/i ||
+		    $line =~ /^\s*index\s+\S+\s*$/i ||
+		    $line =~ /^\s*who\s*$/i ||
+		    $line =~ /^\s*who\s+\S+\s*$/i ||
+		    $line =~ /^\s*get\s+\S+\s*$/i ||
+		    $line =~ /^\s*get\s+\S+\s+\S+\s*$/i ||
+		    $line =~ /^\s*approve\b/i ||
+		    $line =~ /^\s*passwd\b/i ||
+		    $line =~ /^\s*newinfo\b/i ||
+		    $line =~ /^\s*config\b/i ||
+		    $line =~ /^\s*newconfig\b/i ||
+		    $line =~ /^\s*writeconfig\b/i ||
+		    $line =~ /^\s*mkdigest\b/i)){
+			WARN("MAILING LIST HELPER",
+			     "Line matches common mailing list helpers, and may not be delivered correctly. Consider rewording (particularly the first word)\n" . $herecurr);
+		}
+
 # Verify the existence of a commit log if appropriate
 # 2 is used because a $signature is counted in $commit_log_lines
 		if ($in_commit_log) {
-- 
2.26.3

