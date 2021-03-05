Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87F832E357
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEIHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:07:40 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:33948 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCEIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:07:29 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id A17E9A8047;
        Fri,  5 Mar 2021 16:07:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19729T140185094313728S1614931620063598_;
        Fri, 05 Mar 2021 16:07:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dee109ebc5adcaa58bd83e5eced281a7>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: tglx@linutronix.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH] kernel/irq: export irq_gc_set_wake
Date:   Fri,  5 Mar 2021 16:06:58 +0800
Message-Id: <20210305080658.2422114-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module driver may use irq_gc_set_wake.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 kernel/irq/generic-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index a23ac2bbf433..f8f23af6ab0d 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -200,6 +200,7 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 	irq_gc_unlock(gc);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_gc_set_wake);
 
 static u32 irq_readl_be(void __iomem *addr)
 {
-- 
2.25.1



