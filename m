Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A893EA315
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhHLKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbhHLKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488AC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 03:47:01 -0700 (PDT)
Date:   Thu, 12 Aug 2021 10:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPnbcf4f/frqGDGGs6dx97SY2sMHaTRevrKE78XtFoI=;
        b=CH26ekZ50oit/r/vqC8S6h7gtW3bhjdyVCcyCVjAO2/G3SY5oiEn1ZICVbZ6zqVJocMhUl
        oJz+avr2Bjit/jatwr4R3w1h6kAVgKMfISGjcMUcOKa4FYl/r19sTNfK8TffnnAbLbKiZD
        uqs0GqBCds7D0iF/5zrkb5QLWy+/Lbhf3I4vWQE7ZuHOUAHtPJ4UeCgTE8SNBMQYnErWLJ
        1p0psLFQ792cNReNtOwd6+N5Nh2Nv4gV7PCnsy5Eu68xVUL/oAeZEQclvxHvCAFTuQlh9d
        ZtZyEGdWlGEDbjFrmhKPudx0GWhz3O8PhWoppKST4dy7+RfnBTPWJw23ldTt7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPnbcf4f/frqGDGGs6dx97SY2sMHaTRevrKE78XtFoI=;
        b=5/kfumwEGWySpgqvFHRsO39UOGwEb1JjwIh9Y/b6PQMUZ12OgHeRrEBnWQNs3IpP+RJtGM
        cANTOCs2IpeSCrAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] xtensa: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876521897.395.14570866238854036109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d3c149b768fb54fdea8ce4edbc768fe7e72a22ca
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d3c149b768fb54fdea8ce4edbc768fe7e72a22ca
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:41 +01:00

xtensa: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/xtensa/kernel/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index a48bf2d..764b54b 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -33,8 +33,6 @@ DECLARE_PER_CPU(unsigned long, nmi_count);
 
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
-	int irq = irq_find_mapping(NULL, hwirq);
-
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -48,7 +46,7 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 			       sp - sizeof(struct thread_info));
 	}
 #endif
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(NULL, hwirq);
 }
 
 int arch_show_interrupts(struct seq_file *p, int prec)
