Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E24452A68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhKPGSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhKPGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:18:38 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94398C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:15:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r23so831546pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QkrYpt9IQ0bHjWjYZo+IoTq8RSUQIDWbxBrObFK2GZw=;
        b=HrIbDra3NxTGNowq+v765jwapxJXRm8WODPAd10MhleXUcRgK4nEoqU3nDa+EOCW3p
         ThgWmB3pSFXVI3kh5cstHibZ2JBU7babXBKfpWYFUZ9R02IFtRwbWRwgZU4Omf5mj0QK
         tbxBmRdA6cVcstIsCzpuksMHZZ2WFAvPE+vF553gSzkfvjZz9qK4RqWJCZm3llE00wzW
         fparbYmotuogovQHLQ0JDuDH9bDivPKoWrWuadh0F56QPb2/41b7ac1j0vqDA/n9EaqU
         ER+xDyiWE+Sx11htYyJJpSyMXKH6ikPVD+10gqhZSt8Cg4LLDt1vyPgOqfV0v9dCrhky
         dA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QkrYpt9IQ0bHjWjYZo+IoTq8RSUQIDWbxBrObFK2GZw=;
        b=IevQr8QZdss5rPhDzslRHIqASPumJPJpy0MJLtOqbO952Biy/vsxBh71VJY3g6JCbW
         FcJGWcCWZ6ulv5dZ+E0Ze5w9yAKW9txbcAlllipHkUAmNZHTSmGpC84ES5e76afhfNwH
         F+gAYOMEU6NtMq+LqAPDpN4w4PUGI7KnvBcnvq9WRDoq5pSKVTWY9wgvVwJBeJyRyroB
         MqAIWL6bVPZ2QH986qJzEnUMcbtJlEYMtMHzvjkDE/RTVGrO8PZ6NzKrBByp6lbIKadv
         hAZxm8f2tr1W5TNq3hLXIpxlLKxveixEzHLHa+Mfj4QZukHZ3G4UBQlMeDkIcJr8rCqd
         8OwQ==
X-Gm-Message-State: AOAM532faQw4bd5l/Jt3y3k3DY5IQfDqWKakIhkI6/X4GWOa6QRDqcoz
        4Pv4VoCGBdiMGwdsMQorLK4=
X-Google-Smtp-Source: ABdhPJxJh4QUwFH8wHPbNF8tMjdUCD5gyssjXXFcxorVwJYn3lyMIQ1ZQRSE8oRaHlCJIt1pkHjpuQ==
X-Received: by 2002:a62:52cd:0:b0:49f:a7b8:69ad with SMTP id g196-20020a6252cd000000b0049fa7b869admr38845938pfb.3.1637043341208;
        Mon, 15 Nov 2021 22:15:41 -0800 (PST)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id y130sm17041944pfg.202.2021.11.15.22.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 22:15:41 -0800 (PST)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     pmladek@suse.com
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH V2] watchdog: ignore nohz_full cores in new cpumask
Date:   Tue, 16 Nov 2021 14:15:36 +0800
Message-Id: <20211116061536.16293-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the nohz_full is enabled, when update watchdog_mask, the
nohz_full cores should be ignored.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 v1->v2:
 if watchdog_cpumask became empty, set housekeeping_cpumask.

 kernel/watchdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..6f0c5528b399 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -628,7 +628,9 @@ void lockup_detector_soft_poweroff(void)
 static void proc_watchdog_update(void)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
-	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
+	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER));
+	if (cpumask_empty(&watchdog_cpumask))
+		cpumask_copy(&watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER));
 	lockup_detector_reconfigure();
 }
 
-- 
2.17.1

