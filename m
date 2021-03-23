Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A79345CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhCWLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:30:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14434 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCWLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:30:16 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4Tdc6ZCbzkdTm;
        Tue, 23 Mar 2021 19:28:36 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 19:30:03 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] tick: Use the wrapped function to clear the logic
Date:   Tue, 23 Mar 2021 11:27:43 +0000
Message-ID: <20210323112743.9493-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tick_check_replacement() is the combination of
tick_check_percpu() and tick_check_preferred(). It make the code easy to
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

