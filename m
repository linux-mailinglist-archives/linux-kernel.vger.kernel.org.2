Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D073379FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEKGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:30:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKGag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:30:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfScn5vZFz1BK27;
        Tue, 11 May 2021 14:26:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:29:21 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] clocksource/drivers/arm_arch_timer: Make symbol 'arch_timer_rate1' static
Date:   Tue, 11 May 2021 14:46:23 +0800
Message-ID: <1620715583-107670-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/clocksource/arm_arch_timer.c:67:5: warning:
 symbol 'arch_timer_rate1' was not declared. Should it be static?

This symbol is not used outside of arm_arch_timer.c, so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe1a826..800aaa9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -64,7 +64,7 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
-u32 arch_timer_rate1 __ro_after_init;
+static u32 arch_timer_rate1 __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
-- 
2.6.2

