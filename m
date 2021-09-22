Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADC9414AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhIVNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55686 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhIVNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:41:56 -0400
Date:   Wed, 22 Sep 2021 13:40:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GBvGXwHHmyrLLvUkrwcJlCs+5JVkJHte1Em2KD2hbk=;
        b=vOz1Q0gkJkkCxpBiqBAAeVLz8WhZprAHP0u9jrE+t4LlTr3moCy3yCaHcSB4zJj/FdJmGt
        pfUJeyNH3i+L2nvYUF7DEBJtxtC1I4AcS1TYKodsuHnmy30nZepMz9Bcve3s86xyI8kl/I
        0NnZESpBA5ByCX5G4j9xKfpcYOXkQ+VRVA+lqizczuUShvPbYC8gkJAE2hqw/ngV9frCYc
        0Sxg7DUW4Q+zIdlXncbH2MGrT3kgEjnZUP4bqzU2BwYcf0acQsNOdI26e7MN0PqatLM3JK
        8sCG7J1OuHsKsr08CLPmYS1RCYukPbIYzTIuEm4TDgN96tjLKx+ElQGw7aIkVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GBvGXwHHmyrLLvUkrwcJlCs+5JVkJHte1Em2KD2hbk=;
        b=eVDbQFfB8xevx+DK/TLPdLsl28AGExeYyv4hfnEt5f6zBYUr+/CnjLsBl3LLa6S8HfEve8
        9Hc6rvEm+2KdVCCA==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/renesas-rza1: Use semicolons
 instead of commas
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cb1710bb6ea5faa7a7fe74404adb0beb951e0bf8c=2E16316?=
 =?utf-8?q?99160=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cb1710bb6ea5faa7a7fe74404adb0beb951e0bf8c=2E163169?=
 =?utf-8?q?9160=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <163231802401.25758.1119841944882855224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     3ce8c70ecedb4e1f1d36301afb0281be40390f13
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3ce8c70ecedb4e1f1d36301afb0281be40390f13
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 15 Sep 2021 11:47:30 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:37:59 +01:00

irqchip/renesas-rza1: Use semicolons instead of commas

This code works, but it is cleaner to use semicolons at the end of
statements instead of commas.

Extracted from a big anonymous patch by Julia Lawall
<julia.lawall@inria.fr>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/b1710bb6ea5faa7a7fe74404adb0beb951e0bf8c.1631699160.git.geert+renesas@glider.be
---
 drivers/irqchip/irq-renesas-rza1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index b0d46ac..72c06e8 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -223,12 +223,12 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 		goto out_put_node;
 	}
 
-	priv->chip.name = "rza1-irqc",
-	priv->chip.irq_mask = irq_chip_mask_parent,
-	priv->chip.irq_unmask = irq_chip_unmask_parent,
-	priv->chip.irq_eoi = rza1_irqc_eoi,
-	priv->chip.irq_retrigger = irq_chip_retrigger_hierarchy,
-	priv->chip.irq_set_type = rza1_irqc_set_type,
+	priv->chip.name = "rza1-irqc";
+	priv->chip.irq_mask = irq_chip_mask_parent;
+	priv->chip.irq_unmask = irq_chip_unmask_parent;
+	priv->chip.irq_eoi = rza1_irqc_eoi;
+	priv->chip.irq_retrigger = irq_chip_retrigger_hierarchy;
+	priv->chip.irq_set_type = rza1_irqc_set_type;
 	priv->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
 
 	priv->irq_domain = irq_domain_add_hierarchy(parent, 0, IRQC_NUM_IRQ,
