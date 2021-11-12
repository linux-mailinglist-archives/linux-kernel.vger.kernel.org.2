Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497344EB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhKLQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:17:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhKLQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:17:52 -0500
Date:   Fri, 12 Nov 2021 16:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636733700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l90LO5llCX8Bh7im2HmsY+FQub0ze20mOyvZ++jqtQ=;
        b=Z5WXthc3FI5ciUIhO6g9AwvpXJ3Cs0tFaQj+3GJiou5MtDB3JHUOi68/yy4eEsHk8V5wvn
        eT7XA/frLbxgllFesmh7OwXC/glJr0O3gUOlB3rUg8NL6TEu34Jz7nI3CpPvIMtwPasQwY
        2CG9jtE2OrR/3xu2pbsJqP3C0VYjrbk6CP5Pxqb1ccOwwvNlijvNnYRXUOZqOKhR6IzeKM
        hAEM0UP42F/8Pl4RUrOf3+/Sjf6LabPov3GBfB2USQWtleoWj/2FMl1LAfru2fbGxQvc12
        x1JYZ3IH+54cgnGb9tJmPZldFnPvrE9wh03NDfDRp9fBb37ZTdxB6eqTQ4CNyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636733700;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l90LO5llCX8Bh7im2HmsY+FQub0ze20mOyvZ++jqtQ=;
        b=VyOiEtBE66BroP32QqLcVxsz1lvV8e+iW9MDN6HLiuwyILxzfzXVKHIPLROrHG5qrGwJ9o
        atF9n4blaQUyZzBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] of/irq: Don't ignore
 interrupt-controller when interrupt-map failed
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de
In-Reply-To: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
MIME-Version: 1.0
Message-ID: <163673369942.414.1904889779968931526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     10a20b34d735fb4a4af067919b9c0a1c870dac99
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/10a20b34d735fb4a4af067919b9c0a1c870dac99
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 12 Nov 2021 14:10:39 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 12 Nov 2021 16:10:00 

of/irq: Don't ignore interrupt-controller when interrupt-map failed

Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"), the irq code favors using an interrupt-map
over a interrupt-controller property if both are available, while the
earlier behaviour was to ignore the interrupt-map altogether.

However, we now end-up with the opposite behaviour, which is to
ignore the interrupt-controller property even if the interrupt-map
fails to match its input. This new behaviour breaks the AmigaOne
X1000 machine, which ships with an extremely "creative" (read:
broken) device tree.

Fix this by allowing the interrupt-controller property to be selected
when interrupt-map fails to match anything.

Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
Link: https://lore.kernel.org/r/20211112143644.434995-1-maz@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/of/irq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 32be5a0..b10f015 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * if it is then we are done, unless there is an
 		 * interrupt-map which takes precedence.
 		 */
+		bool intc = of_property_read_bool(ipar, "interrupt-controller");
+
 		imap = of_get_property(ipar, "interrupt-map", &imaplen);
-		if (imap == NULL &&
-		    of_property_read_bool(ipar, "interrupt-controller")) {
+		if (imap == NULL && intc) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
@@ -244,8 +245,20 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 			pr_debug(" -> imaplen=%d\n", imaplen);
 		}
-		if (!match)
+		if (!match) {
+			if (intc) {
+				/*
+				 * The PASEMI Nemo is a known offender, so
+				 * let's only warn for anyone else.
+				 */
+				WARN(!IS_ENABLED(CONFIG_PPC_PASEMI),
+				     "%pOF interrupt-map failed, using interrupt-controller\n",
+				     ipar);
+				return 0;
+			}
+
 			goto fail;
+		}
 
 		/*
 		 * Successfully parsed an interrrupt-map translation; copy new
