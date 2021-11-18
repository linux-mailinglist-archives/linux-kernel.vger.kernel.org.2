Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03A9455325
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbhKRDN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbhKRDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:13:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34657C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:10:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so6965732pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HZhNaj1zb/jXice+UIHy/9JYO1KOcEwz8mr+T3bRCek=;
        b=WoPNm99Ae/EYe/1rQT8rVwRFHKIMC/PehFnQfLOoYInh4puyZGBaAudVt8zB3UWE94
         QZvFSaasnkw1zyd0xqWpchYf312YrR26JH9ERcvLwkVbjL/jsweksTtdekHaZiKHTzZf
         CSgIw4A3Xuav7eROeVgjGQmpFGI/oozA6aNdhy/fBkz3q6Mp2i4NF5sFvjTyrYKIbCAp
         0WBREcS/kV36KV8DBPDVSXIVkVVkkf1EkY9fGDJpyNLERNfjrO0yf1iVANd74jvm/wd5
         gCuYVaGQ/B5JcpPEqESYTG4asPLZz33ebstZjgDZy4SgokotJ6aOFeH+ug4x39hZymcB
         9UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HZhNaj1zb/jXice+UIHy/9JYO1KOcEwz8mr+T3bRCek=;
        b=ahp8dxzIlO7UDg5Z3mcYeQcvg+8FkNR9ZX2fTnvN7yhG+d2ulcSbbDunh2w5eG1Puz
         XReramdSBlxv/L4z2YRxMc8cvq8NoKSvg4Y3ubcNHktOB7APoTMSL8FYrvcu4x0J7WCf
         bTuoLTsmyUOJptIM6OZpJQAoJbXcg5lNIZHKGR31R/rZxCE9GyxtKaTBIXCvUJFMZPMn
         fl+XJIgANxdYQ/PHnTCxtXD6SNiUOcn7OiJlChJIKbxFqhJq3Xc0xGMfr18KqMLDUHBT
         PFED4jjiXXgSR7rK9+7XA8anTjtkfUkPa+asyU+Z6DzVLFDhK5g1SFoSNm5hBYI2HNex
         VBKA==
X-Gm-Message-State: AOAM531/wqf/s8w3SCvZCjfic1ylJFzGIwuSFfN4lfmlSOQBVjaFrEAK
        83nbgj3uBzv/BBiBOWj+VYo=
X-Google-Smtp-Source: ABdhPJwmcd68zWf7Xh743EDRoIcMkRtB9dwp2wqn98KxvCPz5TWiC7tE2B0EvZkJwWWE1n9cj1lXqg==
X-Received: by 2002:a17:90b:11c1:: with SMTP id gv1mr6074349pjb.208.1637205050770;
        Wed, 17 Nov 2021 19:10:50 -0800 (PST)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id b4sm1053360pfl.60.2021.11.17.19.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 19:10:50 -0800 (PST)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     frederic@kernel.org, pmladek@suse.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3] watchdog: Add warning message when the newcpumask contains nohz_full cores
Date:   Thu, 18 Nov 2021 11:10:46 +0800
Message-Id: <20211118031046.32632-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog default is disabled on nohz_full cores, however when
override the cpumask, if new cpumask contains nohz_full cores,
add warning message.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 v1->v2:
 if watchdog_cpumask became empty, set housekeeping_cpumask.
 v2->v3:
 only print a warning when a nohz_full CPU is included in new cpumask.

 kernel/watchdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ad912511a0c0..37a978d8ff06 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -629,6 +629,7 @@ static void proc_watchdog_update(void)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
 	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
+	WARN_ONCE(!cpumask_subset(&watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER)), "Enabling watchdog on nohz_full cores\n");
 	lockup_detector_reconfigure();
 }
 
-- 
2.17.1

