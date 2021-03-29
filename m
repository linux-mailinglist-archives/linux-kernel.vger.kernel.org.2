Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E12C34CCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhC2JGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:06:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14179 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhC2IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:52:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F85qZ4R4CzmbHZ;
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
Subject: [RFC PATCH 2/3] irqchip/gic-v3: Implement gic_ipi_send_single()
Date:   Mon, 29 Mar 2021 16:52:09 +0800
Message-ID: <20210329085210.11524-3-wangjingyi11@huawei.com>
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

We implement gic_ipi_send_single() to make single ipi injection
easier.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8ecc1b274ea8..5c44e1e719d6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1124,6 +1124,26 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
+static void gic_ipi_send_single(struct irq_data *d, unsigned int cpu)
+{
+	unsigned long mpidr;
+	u64 cluster_id;
+	u16 tlist;
+
+	if (WARN_ON(d->hwirq >= 16))
+		return;
+
+	wmb();
+
+	mpidr = cpu_logical_map(cpu);
+	cluster_id = MPIDR_TO_SGI_CLUSTER_ID(mpidr);
+	tlist = 1 << (mpidr & 0xf);
+
+	gic_send_sgi(cluster_id, tlist, d->hwirq);
+
+	isb();
+}
+
 static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
@@ -1279,6 +1299,7 @@ static struct irq_chip gic_chip = {
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.ipi_send_mask		= gic_ipi_send_mask,
+	.ipi_send_single	= gic_ipi_send_single,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1298,6 +1319,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.ipi_send_mask		= gic_ipi_send_mask,
+	.ipi_send_single	= gic_ipi_send_single,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
-- 
2.19.1

