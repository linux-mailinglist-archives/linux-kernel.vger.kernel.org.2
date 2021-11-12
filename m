Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAA44E159
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 06:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhKLFRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 00:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhKLFRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:17:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7AC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 21:14:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id np3so5787340pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 21:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=hLkTfb1RyKmeImGvFTCvcbgIrDSsZCsoOldGIOBr0Ns=;
        b=h+ckvOLmRolJOVQkjYvR/X00rzzNVRDuecfuSzUx/3QjnixFWUvZu2/yRjIKHoy1Ql
         nFFkCUJaf9BjEsWjF4fwjagut2GCQfJi2S3GIyIHL3XVGRwpY3ncrasAQILRgnHJ1BIL
         V1wFTHcCmUfP2WW+PVeBC5Cg1Gv93XFYoFgqc+8biUQ1yjeZtexvs4qrDbwL49NRvX6o
         8q+YknFfat/ZAh54QCkjgD3ZzsuuJQQ14TGuu4tawu4KhvhhLytLHbWodxRdawde3/vY
         Y/jCnRgI8tq5nSbz04LGPu0hmyxo/RNMxhUzW05UGqzvhuNdg4uCYwK+sF+VFmH0wPTF
         eQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hLkTfb1RyKmeImGvFTCvcbgIrDSsZCsoOldGIOBr0Ns=;
        b=mdFE05WzZ7S6xuOCJIVSiGcdi/SSwvTEaAvCmORmSYzR0Oa2BeFCWL5bznIDgtYXoQ
         zRH2107YnPLU5ue7RVZffqWZcpo8ZqEO+GzdWsiZ3eimXBQMoJhc7QbZ/lGm2Wy+cXR5
         KMAm8fLsBE8LKv4pbDO48EG/oy8qMSjAXF8eyQN0SApvu2jT7/P5wp11e2mY3kmRf8aR
         yKz0uOxnJ8M2jHK2xcZDJCWcJFqMBssZU5Iw1rxG9Y+KTBHb7hlMCr0LCSS+kSLVZtPd
         865PolOtoJnDXWvYIa8jl2I/IJod0BHVfnlSfKpEgqRsB7DRbuD7HMP5NnBvEa/A2dRr
         vk8g==
X-Gm-Message-State: AOAM5323vjo3KTwzjje8AY4/xHF3tL1YxIOxyLyFGir57kFgGgwe7lTT
        AFJ1FHWCuwOGMTVqYoVHsmD1z/FlQfAYpw==
X-Google-Smtp-Source: ABdhPJxN9Rq+EQgM58n6tpU1kSRviT0fOG3c2Pi+w6j0DiiSRaXzY1CPIl68Q+0TUhPk750SyIHk2w==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr14494485pjb.75.1636694079989;
        Thu, 11 Nov 2021 21:14:39 -0800 (PST)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id p12sm5353414pfh.52.2021.11.11.21.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 21:14:39 -0800 (PST)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     pmladek@suse.com, akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] watchdog: ignore nohz_full cores in new cpumask
Date:   Fri, 12 Nov 2021 13:14:34 +0800
Message-Id: <20211112051434.23642-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the nohz_full is enabled, when update watchdog_mask, the
nohz_full cores should be ignored.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/watchdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..3ef11a94783c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -628,7 +628,9 @@ void lockup_detector_soft_poweroff(void)
 static void proc_watchdog_update(void)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
-	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
+	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER));
+	if (cpumask_empty(&watchdog_cpumask))
+		return;
 	lockup_detector_reconfigure();
 }
 
-- 
2.17.1

