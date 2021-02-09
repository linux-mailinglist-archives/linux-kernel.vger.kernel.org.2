Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC36A314C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhBIJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:47:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12158 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBIJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:45:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZdHD2X25zlHYF;
        Tue,  9 Feb 2021 17:43:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 17:44:39 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] drivers/perf: Replace spin_lock_irqsave to spin_lock
Date:   Tue, 9 Feb 2021 17:42:22 +0800
Message-ID: <1612863742-1551-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to do spin_lock_irqsave in context of hard IRQ, so
replace them with spin_lock.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm-cci.c   | 5 ++---
 drivers/perf/xgene_pmu.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index a75cf77..f81e2ec 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1026,12 +1026,11 @@ static void pmu_event_set_period(struct perf_event *event)

 static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 {
-	unsigned long flags;
 	struct cci_pmu *cci_pmu = dev;
 	struct cci_pmu_hw_events *events = &cci_pmu->hw_events;
 	int idx, handled = IRQ_NONE;

-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	raw_spin_lock(&events->pmu_lock);

 	/* Disable the PMU while we walk through the counters */
 	__cci_pmu_disable(cci_pmu);
@@ -1061,7 +1060,7 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)

 	/* Enable the PMU and sync possibly overflowed counters */
 	__cci_pmu_enable_sync(cci_pmu);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	raw_spin_unlock(&events->pmu_lock);

 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 633cf07..44faa51 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1234,10 +1234,9 @@ static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
 	u32 intr_mcu, intr_mcb, intr_l3c, intr_iob;
 	struct xgene_pmu_dev_ctx *ctx;
 	struct xgene_pmu *xgene_pmu = dev_id;
-	unsigned long flags;
 	u32 val;

-	raw_spin_lock_irqsave(&xgene_pmu->lock, flags);
+	raw_spin_lock(&xgene_pmu->lock);

 	/* Get Interrupt PMU source */
 	val = readl(xgene_pmu->pcppmu_csr + PCPPMU_INTSTATUS_REG);
@@ -1273,7 +1272,7 @@ static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
 		}
 	}

-	raw_spin_unlock_irqrestore(&xgene_pmu->lock, flags);
+	raw_spin_unlock(&xgene_pmu->lock);

 	return IRQ_HANDLED;
 }
--
2.8.1

