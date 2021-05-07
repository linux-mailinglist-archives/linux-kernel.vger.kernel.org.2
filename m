Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A478637615B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhEGHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:46:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18007 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhEGHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:46:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fc2Ts5fkxzQkCg;
        Fri,  7 May 2021 15:42:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 15:45:35 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] arm64: arch_timer: Remove redundant initialization
Date:   Fri, 7 May 2021 15:45:36 +0800
Message-ID: <1620373536-29154-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'irq' and 'ret' will be initialized and cleanup the redundant
initialization.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe1a82627d57..892871b48865 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1430,7 +1430,7 @@ static int __init
 arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 {
 	void __iomem *base;
-	int ret, irq = 0;
+	int ret, irq;
 
 	if (arch_timer_mem_use_virtual)
 		irq = frame->virt_irq;
@@ -1574,7 +1574,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 {
 	struct arch_timer_mem *timers, *timer;
 	struct arch_timer_mem_frame *frame, *best_frame = NULL;
-	int timer_count, i, ret = 0;
+	int timer_count, i, ret;
 
 	timers = kcalloc(platform_timer_count, sizeof(*timers),
 			    GFP_KERNEL);
-- 
2.7.4

