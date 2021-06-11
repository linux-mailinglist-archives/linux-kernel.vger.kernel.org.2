Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6A3A436A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFKN4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFKN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:30 -0400
Date:   Fri, 11 Jun 2021 13:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afWtyssnmvvHvQJz15S1TwKd3dmrQoerIOJY9kzKRDw=;
        b=hpDOOuYUJlrW7WCBsmyHd5v9MaPpJTiWBaS6ROXifL12Z9ZrPbaWC3FFysdZMYDs777YPo
        hHBpRFAtGQ92xnNytFxbIl4kl2B9YuYJAMya4j8rKklNdILiiuZaq0d9rgWHPFRiWj3tyX
        aDJ3hC8m7bb5PObOdqdJOqEGatu56SBTx6Su2SzbYW33H5liJdohsjuyOshLtZzhmc4foG
        MfNudQfQfjIsBnQLguy1BzVi8MiHrycoR+bIx/rlYL1AaVUrRYzFZ1fZ9jYC0icbXtf+eq
        OA/yMSNhuI8b98rIPWEtV6cy5W2Uwb/Uzpe49TleTmciENl3cdhjGsmqKAXcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afWtyssnmvvHvQJz15S1TwKd3dmrQoerIOJY9kzKRDw=;
        b=uiM8soisutHpPLqlyyve4upCHbBLWW2WJqgDuU/Wv/AB9Uy/Mk8woWLKQHhkCasLFbaUp+
        C6fZnO9lKpi6JNCg==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-imx-gpcv2: Remove unnecessary
 oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609141150.14637-1-thunder.leizhen@huawei.com>
References: <20210609141150.14637-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967100.19906.16721921173614082879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     76fc40ec22b9947351f6f9d37a86d47e72af4e50
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/76fc40ec22b9947351f6f9d37a86d47e72af4e50
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:11:50 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:47 +01:00

irqchip/irq-imx-gpcv2: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609141150.14637-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-imx-gpcv2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 7031ef4..5b5a365 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -228,10 +228,8 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	}
 
 	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
-	if (!cd) {
-		pr_err("%pOF: kzalloc failed!\n", node);
+	if (!cd)
 		return -ENOMEM;
-	}
 
 	raw_spin_lock_init(&cd->rlock);
 
