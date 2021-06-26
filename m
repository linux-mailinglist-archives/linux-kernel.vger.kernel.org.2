Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEBE3B4C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFZDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFZDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:42:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44783C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11632818otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYg1Jg0R/kLPAS1GJHcswaDvowOMqmlpAdA+14k20dc=;
        b=IZsMFcYhofCo91soP0FzmZUajIRqbM7jIthWPMsHwnO0x8QyX6dwAedUTxys8iqG7P
         gyoRXWgDOPwocd16WmnPbB0N6Z887RPyer2AMTLbPCCj2WoNzdjpDNfBJKGN0X/+yiii
         JEWKs18KX3b7bK6gozJR5qjTlTuQw114JWk6lRYy/KXhgGWuDz3qaTEiVmeKc5f33Pdm
         5rIRFJU62ipJWX6mM4C+adcs2QEL8OTuoX8xbhhcXXwj6CFeFP0wNjl1+15ePOmSEPGc
         zsjupMMvO18DQmMQW8ZHH/knh3EdCu4tuvNBHq/hNKlJkNLozWkewKm/jC63uDJOSJRt
         XPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYg1Jg0R/kLPAS1GJHcswaDvowOMqmlpAdA+14k20dc=;
        b=Wv7zIt+qKJumwLpBY3y4n4ncWok3XwxQr57vHl512YXaNkIjahLXYpWcuZ2kWZ/mpq
         j35jcVqvrVR8aeRws9uvs99dfBtTBOh+gsbjT9huBid9LSvRpZgDg0CV8+n9s2WWc8aL
         EqsZLpP1Xc5I5GHGsZQq7PLnqgGV06LH6mKjtVREdVDXcYh2DMc+X5XlJ7Z684FRHxJL
         He6URQSbcvAaH94BRTfOvWjDpM4v6icDDl0sjJOwoCi9wHRxfFF7GkureLMs3kcZFYm1
         O/DROVWsUDDY+TEQOT56S005mWDCkAZ5FnDnrhNHSEy2DmIV+a8y1nX7V4Lf4cDWrn/v
         d7ig==
X-Gm-Message-State: AOAM532S45/eXXSiF06U5OQJT1L6nyi4f4EL/eDbiNij5aAb4BblAY7q
        agX0/Yu/jp2sUiVs2SAetaY=
X-Google-Smtp-Source: ABdhPJxXLfiIbv+TtVKb1udXcVfhp/0D8If4gz6zvVPfp6e6HKMNwH5TFQcJ9aiN8pEmtOZrnxaT9Q==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr12904110otf.370.1624678827653;
        Fri, 25 Jun 2021 20:40:27 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k26sm1174817ook.0.2021.06.25.20.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:40:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     joe@perches.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/3] checkpatch: suppress BUG_ON warn when it is named in commitmsg
Date:   Fri, 25 Jun 2021 21:40:16 -0600
Message-Id: <20210626034016.170306-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626034016.170306-1-jim.cromie@gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allow mention of BUG_ON in the preamble/commitmsg/intro to silence the
warning normally issued when one is added.  This presumes the commit
message will adequately explain the reason "BUG_ON" is appropriate.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a8dfba53b593..32612f39d742 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2560,6 +2560,18 @@ sub exclude_global_initialisers {
 		$realfile =~ m@/bpf/.*\.bpf\.c$@;
 }
 
+sub commitmsg_refers_to {	# see if $srch is in commit message
+	my ($srch, $lines) = @_;
+	#print "ok checking for $srch in $lines lines\n";
+	for my $i (0..$lines) {
+		if ($rawlines[$i] =~ /$srch/) {
+			print "\thmm: $srch mentioned in preamble, presuming it is explained\n";
+			return 1;
+		}
+	}
+	return 0;
+}
+
 sub process {
 	my $filename = shift;
 
@@ -2586,6 +2598,7 @@ sub process {
 	my $has_patch_separator = 0;	#Found a --- line
 	my $has_commit_log = 0;		#Encountered lines before patch
 	my $commit_log_lines = 0;	#Number of commit log lines
+	my $eopreamble = 0;		# above truncates at =~ /^\. \w+/
 	my $commit_log_possible_stack_dump = 0;
 	my $commit_log_long_line = 0;
 	my $commit_log_has_diff = 0;
@@ -2731,6 +2744,7 @@ sub process {
 		    ($line =~ /^rename (?:from|to) \S+\s*$/ ||
 		     $line =~ /^diff --git a\/[\w\/\.\_\-]+ b\/\S+\s*$/))) {
 			$is_patch = 1;
+			$eopreamble = $linenr;
 		}
 
 #extract the line range in the file after the patch is applied
@@ -4654,7 +4668,7 @@ sub process {
 		}
 
 # avoid BUG() or BUG_ON()
-		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
+		if ($line =~ /\b(BUG|BUG_ON)\b/ && !commitmsg_refers_to($1, $eopreamble)) {
 			my $msg_level = \&WARN;
 			$msg_level = \&CHK if ($file);
 			&{$msg_level}("AVOID_BUG",
-- 
2.31.1

