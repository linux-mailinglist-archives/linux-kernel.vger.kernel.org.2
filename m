Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BD3681EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhDVNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:53:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:53:52 -0400
Date:   Thu, 22 Apr 2021 13:53:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0fBnvjlTgVMy3ucsyDyuQe8nTtAOrtZUUq5weGt3Hs=;
        b=TIVglDkU0tCkLpPDLr6hOGeaSpLGyij/R9nFlQsK5VlLO97q6y4CypvCsBY3OASqDhGNUU
        anFDjN8hlXWWS1SkRFW5UD4ScD6b2kiNj4u4IxPr3/3qitEm9kMXcyr15mg1SYfVKaFNvG
        5CUMksiPrrLZmM9cC4OYCSOX8ZQv/w0dgGgxKNLptqBlU9m42KYooKV/5z2LI0Nye9D7Nw
        VtdZy5urZOod+Kx6EdzMGCfrnw/yVJKPv87FtDgWI1JrE8/FSp1ADkvUPoiokFYE50aBQO
        KS8QvXJV/PeYaVQuavPfFUtj3f118Q/xBswiuelsmx/F9io9RT5o5bTymksstQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0fBnvjlTgVMy3ucsyDyuQe8nTtAOrtZUUq5weGt3Hs=;
        b=jUx4hwPC1forGjVnVlgD8LBnq4dlf/j08iz1EgX4+MVj7fMoRNYad5DMFYUpe0OrHCGtOU
        D2VZFk4sdlPxHBDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Drop references to recusive
 irqdomain setup
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210406093557.1073423-8-maz@kernel.org>
References: <20210406093557.1073423-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161909959620.29796.5525022888424660077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b6d513c7c1467ed9213badb74911a8ee9d88b7be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b6d513c7c1467ed9213badb74911a8ee9d88b7be
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 10:35:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 14:48:49 +01:00

irqdomain: Drop references to recusive irqdomain setup

It was never completely implemented, and was removed a long time
ago. Adjust the documentation to reflect this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406093557.1073423-8-maz@kernel.org
---
 kernel/irq/irqdomain.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 24a3cef..6ab428f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1659,12 +1659,10 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
+ * @domain:	Domain below which interrupts must be allocated
  * @irq_base:	Base IRQ number
  * @nr_irqs:	Number of IRQs to allocate
  * @arg:	Allocation data (arch/domain specific)
- *
- * Check whether the domain has been setup recursive. If not allocate
- * through the parent domain.
  */
 int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
 				 unsigned int irq_base, unsigned int nr_irqs,
@@ -1680,11 +1678,9 @@ EXPORT_SYMBOL_GPL(irq_domain_alloc_irqs_parent);
 
 /**
  * irq_domain_free_irqs_parent - Free interrupts from parent domain
+ * @domain:	Domain below which interrupts must be freed
  * @irq_base:	Base IRQ number
  * @nr_irqs:	Number of IRQs to free
- *
- * Check whether the domain has been setup recursive. If not free
- * through the parent domain.
  */
 void irq_domain_free_irqs_parent(struct irq_domain *domain,
 				 unsigned int irq_base, unsigned int nr_irqs)
