Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB33EA318
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhHLKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:48:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhHLKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:27 -0400
Date:   Thu, 12 Aug 2021 10:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b/FUdFZrumX9ShBm+sFGFf+sQu4kF/gI3MCMCfIBuhY=;
        b=bdFZJScj0+2ssqb5bnbjlbhv1ujx7cSTcTRIVopJQMS14rByYazZkH4WHLgmlXqT42nknD
        3nGQ90KpsS5YPVAQulwHywfkKZAAltEahaJUW+WzD5R+e+z31R6QLwxhxVp+dako3bIv7e
        hvm/de1XvFdukZ5wrUjHzG5iKl8Hy8+ok+Y7QTVb1fnNxTPIdyMcQi4ztesXQA/oH6TVKW
        gGPzHCXRJuMw5l5fjEHnUKgCmn8ZuWmsDS+tlTGE3TXdB1Gbl5TqedqlkJBhznYWR3ynVl
        aX0kRlSK7mu3Bwmg7leWBFK8PLVDgQmsJ2r5PhjAQd1X542F7lTLMsITXJoXsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b/FUdFZrumX9ShBm+sFGFf+sQu4kF/gI3MCMCfIBuhY=;
        b=B7RhSnQhdL8vftJJ7DOSFLwEhexQTcmhdWwEPxJ40sWpVVkY1MPDHIiqnzdOwput+kF/8v
        ug6KwZsv8dhVSYAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arc: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Vineet Gupta <vgupta@synopsys.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522119.395.11110425073961753670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c9604ddd8ad4cca644d00e455c3fd42393adf119
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c9604ddd8ad4cca644d00e455c3fd42393adf119
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:39 +01:00

arc: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arc/kernel/mcip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index abf9398..f9fdb55 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -352,7 +352,7 @@ static void idu_cascade_isr(struct irq_desc *desc)
 	irq_hw_number_t idu_hwirq = core_hwirq - FIRST_EXT_IRQ;
 
 	chained_irq_enter(core_chip, desc);
-	generic_handle_irq(irq_find_mapping(idu_domain, idu_hwirq));
+	generic_handle_domain_irq(idu_domain, idu_hwirq);
 	chained_irq_exit(core_chip, desc);
 }
 
