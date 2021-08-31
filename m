Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1953FC504
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhHaJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhHaJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 838E260F12;
        Tue, 31 Aug 2021 09:30:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 06/10] irqchip/loongson-htvec: Add suspend/resume support
Date:   Tue, 31 Aug 2021 17:27:12 +0800
Message-Id: <20210831092716.4145604-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210831092716.4145604-1-chenhuacai@loongson.cn>
References: <20210831092716.4145604-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for HTVEC irqchip, which is needed for
suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-htvec.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index f54c9ccbd69e..82adb2615013 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
@@ -30,6 +31,7 @@ struct htvec {
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
 	struct fwnode_handle	*domain_handle;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
 
 struct htvec *htvec_priv;
@@ -157,6 +159,29 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] = readl(htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+}
+
+static struct syscore_ops htvec_syscore_ops = {
+	.suspend = htvec_suspend,
+	.resume = htvec_resume,
+};
+
 static int htvec_init(phys_addr_t addr, unsigned long size,
 		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
@@ -190,6 +215,8 @@ static int htvec_init(phys_addr_t addr, unsigned long size,
 
 	htvec_priv = priv;
 
+	register_syscore_ops(&htvec_syscore_ops);
+
 	return 0;
 
 iounmap_base:
-- 
2.27.0

