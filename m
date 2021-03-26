Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C77349FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCZC0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:26:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCZC0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:26:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F65PB0XRQzPmQq;
        Fri, 26 Mar 2021 10:23:26 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 10:25:53 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH] tick: Use the wrapped function to clear the logic
Date:   Fri, 26 Mar 2021 02:23:28 +0000
Message-ID: <20210326022328.3266-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tick_check_replacement() is the combination of
tick_check_percpu() and tick_check_preferred(). It make the code easier to
understand to use the self-described one function.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 kernel/time/tick-common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9d3a225..e15bc0e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -348,12 +348,7 @@ void tick_check_new_device(struct clock_event_device *newdev)
 	td = &per_cpu(tick_cpu_device, cpu);
 	curdev = td->evtdev;
 
-	/* cpu local device ? */
-	if (!tick_check_percpu(curdev, newdev, cpu))
-		goto out_bc;
-
-	/* Preference decision */
-	if (!tick_check_preferred(curdev, newdev))
+	if (!tick_check_replacement(curdev, newdev))
 		goto out_bc;
 
 	if (!try_module_get(newdev->owner))
-- 
2.9.4

