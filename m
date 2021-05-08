Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E494437700A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhEHGWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:22:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17481 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:22:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FccZQ03YNzkWRc;
        Sat,  8 May 2021 14:18:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 14:20:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] genirq/timings: Fix error return code in irq_timings_test_irqs()
Date:   Sat, 8 May 2021 14:20:43 +0800
Message-ID: <20210508062043.2524-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: f52da98d900e ("genirq/timings: Add selftest for irqs circular buffer")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/irq/timings.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index d309d6fbf5bd..12893be1199a 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -794,12 +794,14 @@ static int __init irq_timings_test_irqs(struct timings_intervals *ti)
 
 		__irq_timings_store(irq, irqs, ti->intervals[i]);
 		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
+			ret = -EFAULT;
 			pr_err("Failed to store in the circular buffer\n");
 			goto out;
 		}
 	}
 
 	if (irqs->count != ti->count) {
+		ret = -EFAULT;
 		pr_err("Count differs\n");
 		goto out;
 	}
-- 
2.25.1


