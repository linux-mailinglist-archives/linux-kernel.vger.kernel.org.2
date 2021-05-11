Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694EC37A060
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEKHK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhEKHK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:10:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF431C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:09:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k19so15408008pfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GdUuVkq37s2mjrHvWrsTawX+gUToY+ZbjVsrHfnBxG8=;
        b=jSDIRup+Xz5DtuSRCZtSmyrx1zTSsWclThcglQ/TmsJrLJbjCD9EjfDuVJ3IA064oC
         yCAm1oSsGXxWx8+w6MSd2pmtajo8tlkYWQ3qXe3jadTSgyOtJL8vLaRAU216YhK6PWT4
         ItoP2Gt/LpJEECvL1pPhAkTqPASFfgIDv+6XuDxkoPFaJA0CFxeomdn56kubmf1WK3Lj
         BmVXy3TZj6Q0sUZGJTlKfOvRezzXjWcNPCS9rnH17b4NCsnbYu0JhpxObI8DKjXZRJXz
         aJA3hGEBLoWgRe7NylBHfEGdPvdUqoO4/0R/ty6rsEP3S4j3ntg71oGDgBf4FY1U5j8J
         bP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GdUuVkq37s2mjrHvWrsTawX+gUToY+ZbjVsrHfnBxG8=;
        b=RHAlMha4MYF/a/z+oErJ9lMA0NcglRo/Ja/45XF4sQMbbYw5aAsyRv24LHJ3xck5tq
         FsG1/1+2JhnfCKam9R8wd/qM6tNGU13JXv4oiXPq8D2OGzZl8wBiH0dvR72aUzu3PA1b
         Wvpx4zG9BdIwg882K9XNlTW0M5H/DTfHjSX9BW/GAFHhGnfrd2aL1yro5tSEyszVi+H+
         SBmKE+q0tNU8N4C7v4/4qTLxfpCLWYZOqKUyxckgjZhHYSFmtcqC1/mXPeOqBbzg+CjG
         hd56v9gyTc0OeDWi97fAEMtS9GWaQWC+2N7lrm7+cQbM95lV06CSf83c2vKGNicVGXut
         iPJg==
X-Gm-Message-State: AOAM532aDNgoEWZpSsiL65Q33iEazMZfr66BJMXfy64h/1vsReI9LwpE
        a6kV09lakFBspuV2G75urskP0YAf4XqXPioCq2k=
X-Google-Smtp-Source: ABdhPJxqVWxz03aYJAR0ZXjsZ4rK0JpYQjEjArHyIFggj45vBQPwAlD41PsMGpO74nPslHY9yI0doA==
X-Received: by 2002:a65:62da:: with SMTP id m26mr15817107pgv.195.1620716991468;
        Tue, 11 May 2021 00:09:51 -0700 (PDT)
Received: from bj06390pcu01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y26sm76238pge.94.2021.05.11.00.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 00:09:50 -0700 (PDT)
From:   Nianfu Bai <bnf20061983@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, nianfu.bai@unisoc.com,
        ruifeng.zhang1@unisoc.com
Subject: [PATCH] clocksource/drivers/sprd: Remove the dependency between sprd timer and SPRD arch
Date:   Tue, 11 May 2021 15:08:45 +0800
Message-Id: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
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

