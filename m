Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BA3A4371
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFKN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhFKN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:35 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zYcWHzbk63gnautfN3Y5Lq89t67T+F2EJsN7hNh6bU=;
        b=1W/1ZJyr5VlN4pU9vzuXfvJ5QKzjJwMxrA8CwCgD7b1alKrGm2BqGz8Hf4SHJkM126ODOO
        rYLPnhzhktAqHCEeTXRmwG4JE9FtBjrXe2yCPQ0XDKedA2ebH9idvz/Ccm6L/ONEhL2c9k
        ch6Cjbnp+cY7G+meZipGnl/DXI2wEQsLltiInWKJmGNpG9KK992j+FuQF9fDxKIjQvbXuZ
        k9BG7n198C6pUd2lIOImhk+gHF6tdu6HDlNbWvGArCbPMylNpnnRp1MrjZbVvtxI6Qqffi
        dXX16aqW5GiZNgLbMuSCPY7I+ObVC6Kvn0X5X1SqW0W2GdlT7mMF1/uI7c5Zjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zYcWHzbk63gnautfN3Y5Lq89t67T+F2EJsN7hNh6bU=;
        b=DswuVQCbyqSr0vPYMmmfx2jv5WK4MZk2Mueq1ygWJEUOZ8CRpnvDzT4yW6vhD96kpEFB/2
        zL4rfRoAfgHwL7BQ==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/exynos-combiner: Remove
 unnecessary oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609140335.14425-1-thunder.leizhen@huawei.com>
References: <20210609140335.14425-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967342.19906.14807156386837263382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     da30e6688dd64fabc3746e00e4a9b6f926efd5ca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/da30e6688dd64fabc3746e00e4a9b6f926efd5ca
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:03:35 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:27 +01:00

irqchip/exynos-combiner: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609140335.14425-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/exynos-combiner.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 0b85d9a..256ed73 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -179,10 +179,8 @@ static void __init combiner_init(void __iomem *combiner_base,
 	nr_irq = max_nr * IRQ_IN_COMBINER;
 
 	combiner_data = kcalloc(max_nr, sizeof (*combiner_data), GFP_KERNEL);
-	if (!combiner_data) {
-		pr_warn("%s: could not allocate combiner data\n", __func__);
+	if (!combiner_data)
 		return;
-	}
 
 	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
 				&combiner_irq_domain_ops, combiner_data);
