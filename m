Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4135DE21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhDML4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhDML4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:56:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:56:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so1194823pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GdUuVkq37s2mjrHvWrsTawX+gUToY+ZbjVsrHfnBxG8=;
        b=tPP9MuRMh5OqcnA22XXlHjV6ncn/eltGGEiDR1v4Kkgmr+tyerfSZMoXVlhNuvQ1bZ
         ULQ0N8gU9k9igomZlGu0kesnk2RxWAGmO27pdJoLMheXASrvWsZ3Sp60Cltg30mGgcj2
         fw0yigjDpHif7mChNAJ+zJF9H3wyBTVGr5KF63Usef5Ez3tIPbukkZWuz6+HjU6Bo54F
         l/33jJgWg7HNs1+5jm4TqqPWl+nJ5DWrHs79wlKRSkghWcGKIeXLurupf6niXz0xq5l4
         C9nU4GrGWg+QBkN4821l6HoC43NboWpF1gU78bSuTn+qE0YnaYhJNILZYl/s43jM2qah
         U/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GdUuVkq37s2mjrHvWrsTawX+gUToY+ZbjVsrHfnBxG8=;
        b=HfWUCJw7F43aMyha0n1wBpaiQ7dU5aO24EWsEi3EGhpHB4XdfIJJaxcv0OnWigHXx6
         25kIyEoBvz0C/FhdLEI8M/fyuQQvhqIwvD12WTxt9ej96AQECgzkne6njfagklXIQj/i
         9on3i4rfKxIbYqnZao2Lsd+kFnA5ZYIoYkstLLd1B6n2GF2tpzlNudkhY8QFlY1xEdgy
         fF0JIyWjvES6ekWFxNzYQEbrGZfZy+tbOkanhhT80bT5T3nzPALQ6nqRAqG25JlvOg00
         3U763Szon5WAjJY1g6HYR15ov7vGk9e/tr6YyO3qy6qRa30DXF+O1IK15gMwrhV9yqaD
         hzEg==
X-Gm-Message-State: AOAM533c3ZPWkq23VxffPaR2sDn0wh1qIxZgBJmDeKwDRBGHOFx9cddU
        Mk3Qc1qMSKsltsdN4mrjrvA=
X-Google-Smtp-Source: ABdhPJw6JhDw7Es1hsbaJJDTxD0CtptHqleh5p7bpV3QthzcG+yxJsHo+ZO+RAPWLuJITzud88kq4w==
X-Received: by 2002:a17:90b:198c:: with SMTP id mv12mr4472107pjb.51.1618314976609;
        Tue, 13 Apr 2021 04:56:16 -0700 (PDT)
Received: from bj06390pcu01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 123sm9813499pfx.180.2021.04.13.04.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Apr 2021 04:56:16 -0700 (PDT)
From:   Nianfu Bai <bnf20061983@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com
Subject: [PATCH] clocksource/drivers/sprd: Remove the dependency between sprd timer and SPRD arch
Date:   Tue, 13 Apr 2021 19:55:42 +0800
Message-Id: <1618314942-9050-1-git-send-email-bnf20061983@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nianfu Bai <nianfu.bai@unisoc.com>

Tick broadcast installed by insmod cannot switch to oneshot mode correctly
caused by linux timer framework, need to build in kernel image. SPRD_TIMER
has been selected by SPRD arch, we have to enable SPRD arch when we build
sprd timer in kernel image, this action conflicts with general kernel image,
so we need to remove the dependency between sprd timer and SPRD arch.

Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
---
 drivers/clocksource/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 39aa21d..04b333c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -447,10 +447,8 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if EXPERT
+	bool "Spreadtrum timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on (ARCH_SPRD || COMPILE_TEST)
-	default ARCH_SPRD
 	select TIMER_OF
 	help
 	  Enables support for the Spreadtrum timer driver.
-- 
1.9.1

