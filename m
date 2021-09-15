Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE040BDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhIOC0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:26:19 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46563 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhIOC0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:26:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=kaige.fu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UoQRrCG_1631672698;
Received: from localhost(mailfrom:kaige.fu@linux.alibaba.com fp:SMTPD_---0UoQRrCG_1631672698)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 10:24:58 +0800
From:   Kaige Fu <kaige.fu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, shannon.zhao@linux.alibaba.com,
        Kaige Fu <kaige.fu@linux.alibaba.com>
Subject: [PATCH] irqchip/gic-v3-its: Fix potential vpe leak
Date:   Wed, 15 Sep 2021 10:20:55 +0800
Message-Id: <d9e36dee512e63670287ed9eff884a5d8d6d27f2.1631672311.git.kaige.fu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its_vpe_irq_domain_alloc, when there is error calling its_vpe_init
with vm->vpes[i], it says that the number of vpes which has been
initialized are 'i'. So, the correct value passed to
its_vpe_irq_domain_free should be 'i' instead of 'i - 1' because
its_vpe_irq_domain_free takes nr_irqs as its third parameter.

If we pass the 'i - 1' to its_vpe_irq_domain_free, the vpe[i - 1] will
be leaked. This patch fixes it.

Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
Signed-off-by: Kaige Fu <kaige.fu@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7f40dca8cda5..eb0882d15366 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4501,7 +4501,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 	if (err) {
 		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i - 1);
+			its_vpe_irq_domain_free(domain, virq, i);
 
 		its_lpi_free(bitmap, base, nr_ids);
 		its_free_prop_table(vprop_page);
-- 
1.8.3.1

