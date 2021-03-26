Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96934A05D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCZDve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZDvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:51:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q5so3971790pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWyZ+Ft6razDfb3Op1Vk7RZO248xZM/96lMO8G6VmsA=;
        b=AZ7AevXRvToF7DgH4A+vXPV3b8nq/Ia/x96AvsA1DDSDyGo/9x7h6mKFlNWIhv883F
         zMpSUiR+WhRfATap6ul1qm2JJfE23oNfu2kMEToEB80Zs0R7rjh4AuLwhtt8E3H4iHjP
         MVZMr8BgQ/SXT1Irb0/nmBkp+npE63PdjqN+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWyZ+Ft6razDfb3Op1Vk7RZO248xZM/96lMO8G6VmsA=;
        b=fXwwdq/rTarFasM2l8yf17rczieeViRlOu3GqLsNNoNSZsXuE7gEwIf28+rvXtle47
         M9aNhPkAvYHzxVaYeddAU5HUDqn5y9fLudpQmmFz2ma7zprPERZRNB1aDLRC4LWaUk10
         x+bXdqWEbwo1IgMClhPs4QOz9ybpkPo0F3OSK87Q6vvxVu+JXTVl5GXsIploYpbtTx3/
         owibpXcbcDdT2SbibgC8O7NrjLZRnpkufyZFMyP+o4zzrh/dRPF+ZLbKM0EEo76uQnOx
         5IKpK03wDfkYtlzgR0YUDYvYNJShWqmA3ZYFYRusQYbmck98pr8Uz0opzn9mgPcry0fu
         oL4w==
X-Gm-Message-State: AOAM531FlX84m+YVZebLnrw/VfxqF/DVjj8xtuTlXeWrpG/KJdsbrSyx
        HPAgNu+IVkujwKfjeJa+5mYGTw==
X-Google-Smtp-Source: ABdhPJy8Hq/NX1Ri+Gq9lfbiCMaFVOQzWx6oB1IYW5v+fcvCtKGWsn/iZrqI/tSR8dkjmYXF0RKhkw==
X-Received: by 2002:aa7:9797:0:b029:1f8:1a14:b055 with SMTP id o23-20020aa797970000b02901f81a14b055mr10984265pfp.57.1616730661796;
        Thu, 25 Mar 2021 20:51:01 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:d0b:23e:bf14:3ec9])
        by smtp.gmail.com with ESMTPSA id v11sm7196345pgg.68.2021.03.25.20.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 20:51:01 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Ivo Sieben <meltedpianoman@gmail.com>,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 1/3] checkpatch: ctx_statement_block: Fix preprocessor guard tracking
Date:   Thu, 25 Mar 2021 20:50:33 -0700
Message-Id: <20210326035035.3057800-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326035035.3057800-1-jwerner@chromium.org>
References: <20210326035035.3057800-1-jwerner@chromium.org>
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

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0af..ffccbd2033e579 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1572,9 +1572,9 @@ sub ctx_statement_block {
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
 
-- 
2.29.2

