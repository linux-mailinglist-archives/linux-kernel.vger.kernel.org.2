Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDE439218
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhJYJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhJYJOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:14:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B78F60E8F;
        Mon, 25 Oct 2021 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635153146;
        bh=UthJ29ilEEqKlZEydhUI+qhFYH7Ke4me3bETpEb4H7c=;
        h=From:To:Cc:Subject:Date:From;
        b=RU4Z/0eIWAAKl3FYvwLqGFxYYfKHwBcNWHMrg1ILqWoDy33JMAkTRmN/M3tmuVTOb
         Pjg90Hot/OGnqMuYYVil65W72E5bUwH31nttXRuoypPvr7mw1AGMmN6i+QK7j2We40
         0yDK8cQzjMNhIBoRhvoVBH97yrcyjdpbjjsAVSpftT8HccHzI3p33flk+U2ShKekHe
         PrZdlxf8hz18tGu3KahrBlx+jLeDc4h4hZOyywdAsITEdrUer0WsC2Eyl298f8uuem
         sq+iiB30PE/peh0r8TmBo9A3eNeemYL03DgKJ6md5oyYKAFPr3DJ4zEhxkUcufTTCI
         sjO4W/uZM61oQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] irqchip/irq-csky-mpintc: Fixup mask/unmask un-implementation
Date:   Mon, 25 Oct 2021 17:12:19 +0800
Message-Id: <20211025091219.3665576-1-guoren@kernel.org>
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

Tested-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a1534edef7fa..f169600dbde6 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -164,8 +164,8 @@ static int csky_irq_set_affinity(struct irq_data *d,
 static struct irq_chip csky_irq_chip = {
 	.name           = "C-SKY SMP Intc",
 	.irq_eoi	= csky_mpintc_eoi,
-	.irq_enable	= csky_mpintc_enable,
-	.irq_disable	= csky_mpintc_disable,
+	.irq_unmask	= csky_mpintc_enable,
+	.irq_mask	= csky_mpintc_disable,
 	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
-- 
2.25.1

