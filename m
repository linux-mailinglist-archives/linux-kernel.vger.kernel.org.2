Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38545DAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354447AbhKYNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355137AbhKYNEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:04:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2E4060C49;
        Thu, 25 Nov 2021 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637845282;
        bh=6Rgn/uumnB+zIy7XvreND7vpK4sRvHa5kqbq/KxeWk8=;
        h=From:To:Cc:Subject:Date:From;
        b=PmB4haGaSRSgZYbi1N8+zk+GFRmD5aQ7wVyQiDZTm342n8LL6jSx+YNtOdBiBJNaO
         mQeX/z+CmpJ54UOp6bj2eEWQyS753AxGc1JAx6qzm2zyHhEvrncaRrHqPGrSVEss+V
         weTkns1UX5lv3a/VLcksBVXM+gYDw6+rFrBFk56oWzB5IPSEvQcPOeL4uGJgZLkUqa
         wo9pLHxOpqrfo5CgSQNkbfU7CeVpmuRw6maQpr3Jl+OyBV3aYXW20OXfokKKe07ZS9
         ElPekFN1l7EfTYPjg6b3kgrSK85TJgPTqadNrAYUfi2oDu10RKkuq7WYNOhADcbW6V
         XpzhTjPVYuhfg==
Received: by pali.im (Postfix)
        id 5D5BC67E; Thu, 25 Nov 2021 14:01:17 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
Date:   Thu, 25 Nov 2021 14:00:56 +0100
Message-Id: <20211125130057.26705-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ domain alloc function should return zero on success. Non-zero value
indicates failure.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: fcc392d501bd ("irqchip/armada-370-xp: Use the generic MSI infrastructure")
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 80906bfec845..41ad745cf343 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -250,7 +250,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 				    NULL, NULL);
 	}
 
-	return hwirq;
+	return 0;
 }
 
 static void armada_370_xp_msi_free(struct irq_domain *domain,
-- 
2.20.1

