Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4243924CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhE0C2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhE0C2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:28:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C94C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d78so2463641pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHEDMWzziqg3c+GNyO6Hs+F2OxvgbmmF/Qffu4gyWyY=;
        b=Zo4V7P/f6bAAFeIXxK02yi4EEdVDJStQRCnWoULt3RlquOmeP73ETf7SUTotFPpgHR
         rRf4FIJ6YAKkgVyA5jiZl4qaWZtsGudzom7vzt86DkODzselmEiC3VH2VfloTNXhSgRj
         jZsmRFmOfpmCPuR6HlsXxpjJ7GRj5+ikuO+IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHEDMWzziqg3c+GNyO6Hs+F2OxvgbmmF/Qffu4gyWyY=;
        b=FZtrSgv95yVdQZGp3yN5lW0k2tJWExferAMN71bhkX46+Lb7NBW8sKi18/T/gMN/Ch
         T+lLjfxU1l2eh2s53K7xAMBcq334UWAvcOrg0f9ozkxnBcEhxHSNfUNqSzgnWGwjva9l
         4TPOflwwOiLPKMguHXz9Va8qO/+ju/xbJWPD3JXu798p/QCZEUuhVLrBYT2dPNzhAXz4
         /MSBFBx9uYKtwM9CqlrD6KTjfMA/q3BXUPm4lkBHc+EQNoqaw3ZH3smg1Q3+ACkDK/LY
         QpOvocTm04woEMenu5OpxG9yD2QY0JTylqBlsDcyGZTpUbN2HwIkLL0492VIoiQOsnmb
         cTgw==
X-Gm-Message-State: AOAM532OfZFKNDGjWbj5YzWYE8aUf9mmIgxpcijDmq9GcFt+Qfs2L6zk
        Mcw20Xl2C76sWricq127u+BIeg==
X-Google-Smtp-Source: ABdhPJwU+bM9+DB2U8YWupUj44mIjCtsR7G1IuH59efblwCnxxjnGxruhZb5QxHumXqiHK0krd8WVw==
X-Received: by 2002:a65:4d03:: with SMTP id i3mr1545982pgt.422.1622082397896;
        Wed, 26 May 2021 19:26:37 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:9021:eef6:e19b:9dd])
        by smtp.gmail.com with ESMTPSA id gj21sm470703pjb.49.2021.05.26.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 19:26:37 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2 1/3] checkpatch: Fix preprocessor guard handling in context tracker functions
Date:   Wed, 26 May 2021 19:26:22 -0700
Message-Id: <20210527022624.1034423-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527022624.1034423-1-jwerner@chromium.org>
References: <20210527022624.1034423-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preprocessor guard tracking in ctx_statement_block() is (and seems
to have always been) subtly broken whenever tracking over an #else: the
code is supposed to restore state from the current top of the stack
(like and #endif just without removing it). However, it indexes the
stack at [$#stack - 1]. In Perl, $# does not give you the length of an
array, it gives you the highest valid index. Therefore, the correct
index should just be [$#stack].

The preprocessor guard tracking also gets confused when
ctx_statement_block() was called on a line that is already inside a
preprocessor guard, and steps out of it within the same statement. This
happens commonly with constructs like this:

 #if CONFIG_XXX
   for (a = first_a(); !a_finished(); a = next_a()) {
 #else
   for (b = first_b(); !b_finished(); b = next_b()) {
 #endif
     ... loop body ...

The best course of action in this case is to not try to restore any
previous state (which we don't have) at all, so we should just keep our
current state if $#stack is already 0.

Also fix an analogous problem in ctx_block_get().

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 scripts/checkpatch.pl | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0af..4aab2450ad629e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1530,15 +1530,13 @@ sub ctx_statement_block {
 
 	my $type = '';
 	my $level = 0;
-	my @stack = ();
+	my @stack = (['', $level]);
 	my $p;
 	my $c;
 	my $len = 0;
 
 	my $remainder;
 	while (1) {
-		@stack = (['', 0]) if ($#stack == -1);
-
 		#warn "CSB: blk<$blk> remain<$remain>\n";
 		# If we are about to drop off the end, pull in more
 		# context.
@@ -1572,9 +1570,9 @@ sub ctx_statement_block {
 		# Handle nested #if/#else.
 		if ($remainder =~ /^#\s*(?:ifndef|ifdef|if)\s/) {
 			push(@stack, [ $type, $level ]);
-		} elsif ($remainder =~ /^#\s*(?:else|elif)\b/) {
-			($type, $level) = @{$stack[$#stack - 1]};
-		} elsif ($remainder =~ /^#\s*endif\b/) {
+		} elsif ($remainder =~ /^#\s*(?:else|elif)\b/ && $#stack > 0) {
+			($type, $level) = @{$stack[$#stack]};
+		} elsif ($remainder =~ /^#\s*endif\b/ && $#stack > 0) {
 			($type, $level) = @{pop(@stack)};
 		}
 
@@ -1744,9 +1742,9 @@ sub ctx_block_get {
 		# Handle nested #if/#else.
 		if ($lines[$line] =~ /^.\s*#\s*(?:ifndef|ifdef|if)\s/) {
 			push(@stack, $level);
-		} elsif ($lines[$line] =~ /^.\s*#\s*(?:else|elif)\b/) {
-			$level = $stack[$#stack - 1];
-		} elsif ($lines[$line] =~ /^.\s*#\s*endif\b/) {
+		} elsif ($lines[$line] =~ /^.\s*#\s*(?:else|elif)\b/ && $#stack > 0) {
+			$level = $stack[$#stack];
+		} elsif ($lines[$line] =~ /^.\s*#\s*endif\b/ && $#stack > 0) {
 			$level = pop(@stack);
 		}
 
-- 
2.29.2

