Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9137A6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEKMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:36:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2698 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhEKMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:35:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfckN2gp1z1BKlZ;
        Tue, 11 May 2021 20:32:12 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 20:34:45 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <Jisheng.Zhang@synaptics.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] clocksource/drivers/arm_arch_timer: Remove the unused variable
Date:   Tue, 11 May 2021 20:51:45 +0800
Message-ID: <1620737505-14757-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is not used at all, so remove it.

Fixes: e2bf384d4329 ("clocksource/drivers/arm_arch_timer: Add __ro_after_init and __init")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe1a826..89a9e05 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -64,7 +64,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
-u32 arch_timer_rate1 __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
-- 
2.6.2

