Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E294D3A4DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFLJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:11:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9084 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFLJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:11:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G2Bdy1xLMzZcHN;
        Sat, 12 Jun 2021 17:06:14 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 12 Jun 2021 17:08:53 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 12 Jun 2021 17:08:53 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <patrice.chotard@foss.st.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] clocksource/drivers/arm_global_timer: Make symbol 'gt_clk_rate_change_nb' static
Date:   Sat, 12 Jun 2021 17:27:26 +0800
Message-ID: <1623490046-37972-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/clocksource/arm_global_timer.c:54:23: warning:
 symbol 'gt_clk_rate_change_nb' was not declared. Should it be static?

This symbol is not used outside of arm_global_timer.c, so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 60a8047..68b1d14 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -51,7 +51,7 @@
  * the units for all operations.
  */
 static void __iomem *gt_base;
-struct notifier_block gt_clk_rate_change_nb;
+static struct notifier_block gt_clk_rate_change_nb;
 static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
-- 
2.6.2

