Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8F45DAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354987AbhKYNGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355141AbhKYNEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:04:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 429F6601FA;
        Thu, 25 Nov 2021 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637845284;
        bh=rHQc8cLZj3iHYiqYAudA4oR15/U/EZooZ80bhH8XqpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=By8v/GtPwcABogTHrsibYKuiSF7UWVfpNIbM3ZxjNOfarPVYmESOf50RzeKg2vqIK
         YIyEpTWtbAGG+eLhYqYp6/I5lX5s0OyGsYwRn31HrK1i5K0aUMCSZ3gzUSZjPN1I5j
         wjsrzpFVpx6XqHnGnYIPzvji9FK6CWdG1uaZ/vV9YfIFfBCDq0PkWJ0IJFYr8e+/jE
         RlRzcaDtDqj8Hp97EH3wuDfffhPVfVS6kkpLa122Xg1Bd7+QM4j/HbcLTcTiJrQd1f
         vpvHP0fazwqLZ0GgWybe9QvaPMDa/Ep8d8VWgPxIkruP/ql0wA+MveSDEr9yingjf1
         hKnr2kRiaT3Lg==
Received: by pali.im (Postfix)
        id A89C8EDE; Thu, 25 Nov 2021 14:01:18 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] irqchip/armada-370-xp: Fix support for Multi-MSI interrupts
Date:   Thu, 25 Nov 2021 14:00:57 +0100
Message-Id: <20211125130057.26705-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125130057.26705-1-pali@kernel.org>
References: <20211125130057.26705-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq-armada-370-xp driver already sets MSI_FLAG_MULTI_PCI_MSI flag into
msi_domain_info structure. But allocated interrupt numbers for Multi-MSI
needs to be properly aligned otherwise devices send MSI interrupt with
wrong number.

Fix this issue by using function bitmap_find_free_region() instead of
bitmap_find_next_zero_area() to allocate aligned interrupt numbers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: a71b9412c90c ("irqchip/armada-370-xp: Allow allocation of multiple MSIs")
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 41ad745cf343..5b8d571c041d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -232,16 +232,12 @@ static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 	int hwirq, i;
 
 	mutex_lock(&msi_used_lock);
+	hwirq = bitmap_find_free_region(msi_used, PCI_MSI_DOORBELL_NR,
+					order_base_2(nr_irqs));
+	mutex_unlock(&msi_used_lock);
 
-	hwirq = bitmap_find_next_zero_area(msi_used, PCI_MSI_DOORBELL_NR,
-					   0, nr_irqs, 0);
-	if (hwirq >= PCI_MSI_DOORBELL_NR) {
-		mutex_unlock(&msi_used_lock);
+	if (hwirq < 0)
 		return -ENOSPC;
-	}
-
-	bitmap_set(msi_used, hwirq, nr_irqs);
-	mutex_unlock(&msi_used_lock);
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -259,7 +255,7 @@ static void armada_370_xp_msi_free(struct irq_domain *domain,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 
 	mutex_lock(&msi_used_lock);
-	bitmap_clear(msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&msi_used_lock);
 }
 
-- 
2.20.1

