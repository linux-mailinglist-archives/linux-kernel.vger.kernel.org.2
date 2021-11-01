Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB1441BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhKANsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhKANsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2E1260E78;
        Mon,  1 Nov 2021 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635774341;
        bh=Qs6BRVlENjpCGX7v1AaIMTEC9gowWyOq7WXsflnCmLk=;
        h=From:To:Cc:Subject:Date:From;
        b=nprrmRfUILbZ8Io435g+p/E2IbSjrzWJw9KUvH6Wxp9NtOWL6HG8wfoNfz2CCLyET
         Hf1jzCVCLPbSEkb0ALx/oYzkNsJ0cAWrNRylK91wBRkwatj7JLqgZqYPyeJbwPx6VT
         Fp8/SOfvLpSla7YW22cdjwIU6T8xDYObKakiVfa+NuI7aq4A1I/KODTuqtGwx/pVrr
         LBmj08jj5rQk/P90UKOKBFkp9CxLrOatKmcCsAtGcyRUnLmFu510ncRPtBgrYt8/ne
         76ncbn8bgX6QYEWQPZq9jIInjXM4qy4ehjN7twyckl7Tp9XdG1lxd0zQqFqP5OeP8W
         XYipB9gUdIzUw==
From:   guoren@kernel.org
To:     guoren@kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] irqchip/irq-csky-mpintc: Fixup mask/unmask un-implementation
Date:   Mon,  1 Nov 2021 21:45:34 +0800
Message-Id: <20211101134534.3804542-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The mask/unmask must be implemented, and enable/disable supplement
them if the HW requires something different at startup time. When
irq source is disabled by mask, mpintc could complete irq normally.

So just replace the with mask/unmask function.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Marc Zyngier <maz@kernel.org>

---

Changes since V2:
 - Correct Marc's email
 - Remove Tested-by
 - Rename the functions to match the fields
---
 drivers/irqchip/irq-csky-mpintc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a1534edef7fa..870dcb3486a8 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -78,7 +78,7 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
-static void csky_mpintc_enable(struct irq_data *d)
+static void csky_mpintc_unmask(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
@@ -87,7 +87,7 @@ static void csky_mpintc_enable(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
 
-static void csky_mpintc_disable(struct irq_data *d)
+static void csky_mpintc_mask(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
@@ -164,8 +164,8 @@ static int csky_irq_set_affinity(struct irq_data *d,
 static struct irq_chip csky_irq_chip = {
 	.name           = "C-SKY SMP Intc",
 	.irq_eoi	= csky_mpintc_eoi,
-	.irq_enable	= csky_mpintc_enable,
-	.irq_disable	= csky_mpintc_disable,
+	.irq_unmask	= csky_mpintc_unmask,
+	.irq_mask	= csky_mpintc_mask,
 	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
-- 
2.25.1

