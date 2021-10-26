Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9152943AFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhJZKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhJZKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:33 -0400
Date:   Tue, 26 Oct 2021 10:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i23nlSuMd/kjYazLPwmncgxBdvaV8HvjZHLg/CJZrFo=;
        b=P+xMjrdoOqXqyipnSatoTllj3SmHlRMMmL2Q53qrYmWzPKlVNqrjtqjH3kEv3ruhal+VHt
        eMg78gvhvs1AsYTMb4PqSL2P4NN/IG/9aOZVdre5phlgGq8mjJtkst159jeBHDsqOSvSVg
        fTRylmMxHCRZDUs0X4A8qnLwZ3P1aY41d/rTQUy0aElPcG425vHhSixU3Bh3ZHqXUeIGSK
        zc6I8cZ0oNxpD/HRLJfyapPQq2aLjUzBfnQbuhg57t+qdlBbL4tm00SAK0ogdFSS8I3FII
        SGOFdx1pGdBInoTfwLhCffkmI8inEkq8WFdRvg83IxOgvxu+8VIz0T1mhiHhAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i23nlSuMd/kjYazLPwmncgxBdvaV8HvjZHLg/CJZrFo=;
        b=QSr1YHzlEb1ER9QDmDzzbl5UWmbKWPImkxv9zDiiqsocAXLGtrEsS9QANYmH67F9R9ZFDc
        N+CnvylPSkT5cuAA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: simplify handle_domain_{irq,nmi}()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336754.626.1195109765645504561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d21e64027ce4d4df0c46d527b96f12d3811cd08d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d21e64027ce4d4df0c46d527b96f12d3811cd08d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 19 Oct 2021 10:40:45 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:09 +01:00

irq: simplify handle_domain_{irq,nmi}()

There's no need for handle_domain_{irq,nmi}() to open-code the NULL
check performed by handle_irq_desc(), nor the resolution of the desc
performed by generic_handle_domain_irq().

Use generic_handle_domain_irq() directly, as this is functioanlly
equivalent and clearer. At the same time, delete the stale comments,
which are no longer helpful.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29b..b07d0e1 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -690,17 +690,11 @@ int handle_domain_irq(struct irq_domain *domain,
 		      unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret;
 
 	irq_enter();
 
-	/* The irqdomain code provides boundary checks */
-	desc = irq_resolve_mapping(domain, hwirq);
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret = -EINVAL;
+	ret = generic_handle_domain_irq(domain, hwirq);
 
 	irq_exit();
 	set_irq_regs(old_regs);
@@ -721,24 +715,14 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * NMI context needs to be setup earlier in order to deal with tracing.
 	 */
 	WARN_ON(!in_nmi());
 
-	desc = irq_resolve_mapping(domain, hwirq);
-
-	/*
-	 * ack_bad_irq is not NMI-safe, just report
-	 * an invalid interrupt.
-	 */
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret = -EINVAL;
+	ret = generic_handle_domain_irq(domain, hwirq);
 
 	set_irq_regs(old_regs);
 	return ret;
