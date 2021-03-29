Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1A34CCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhC2JGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:06:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14180 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhC2IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:52:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F85qZ4dcbzmbHd;
        Mon, 29 Mar 2021 16:49:46 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.192) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:52:16 +0800
From:   Jingyi Wang <wangjingyi11@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <wangjingyi11@huawei.com>,
        <yuzenghui@huawei.com>, <zhukeqian1@huawei.com>
Subject: [RFC PATCH 1/3] irqchip/gic-v3: Make use of ICC_SGI1R IRM bit
Date:   Mon, 29 Mar 2021 16:52:08 +0800
Message-ID: <20210329085210.11524-2-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20210329085210.11524-1-wangjingyi11@huawei.com>
References: <20210329085210.11524-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRM, bit[40] in ICC_SGI1R, determines how the generated SGIs
are distributed to PEs. If the bit is set, interrupts are routed
to all PEs in the system excluding "self". We use cpumask to
determine if this bit should be set and make use of that.

This will reduce vm trap when broadcast IPIs are sent.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eb0ee356a629..8ecc1b274ea8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1127,6 +1127,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
+	cpumask_t tmp;
 
 	if (WARN_ON(d->hwirq >= 16))
 		return;
@@ -1137,6 +1138,17 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 */
 	wmb();
 
+	if (!cpumask_and(&tmp, mask, cpumask_of(smp_processor_id()))) {
+		/* Set Interrupt Routing Mode bit */
+		u64 val;
+		val = (d->hwirq) << ICC_SGI1R_SGI_ID_SHIFT;
+		val |= BIT_ULL(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
+		gic_write_sgi1r(val);
+
+		isb();
+		return;
+	}
+
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
 		u16 tlist;
-- 
2.19.1

