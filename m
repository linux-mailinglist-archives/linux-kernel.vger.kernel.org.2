Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D350D3A4376
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFKN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhFKN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:34 -0400
Date:   Fri, 11 Jun 2021 13:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TO95KRI0kNxU0tBcZSjA+iqSQSgDG0rI9JUniLAjjVA=;
        b=ML5i0xAZcfBfe86LoGKoEbwGVM440w5gqphqTmrQar5F3cDfth6gevstCZbIVNhUyapmHx
        l3101Jpahoef+IPDmW5eLK9xxkOB7zCiv35cKGYtLFCtVUzyKbkM297MhypMTU5kcqUMna
        J2l+p4Gcxd9jVqwShexTFflbKz48RVrD5WtfO3M19o4kKPKiih8nIHRjIt91VJyNKGouKG
        9nLROx0xGnQ6btxfkJVTe3/QUsFj1HhMdEkgBAU223ueUGVcE/e+dCpL+aKRpOc9e9coNc
        I5sfJEEbHXlHSjvK2vvZggtVtG8hGAb7/H36v0nC7vhK/HHb+yTDsRoVK2rjcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TO95KRI0kNxU0tBcZSjA+iqSQSgDG0rI9JUniLAjjVA=;
        b=7pqAXnxU+PzdK5Za57pJQdWuq3rpoBfiR7yd+DLJPafvutVMlqZ3kbjFE27NNiw59ftb0J
        1xPGHLamdqx2vNBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdesc: Fix __handle_domain_irq() comment
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967565.19906.9511742585680692106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9626d18a20e166a864e8d1f6ed6bbb84a0fa4989
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9626d18a20e166a864e8d1f6ed6bbb84a0fa4989
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:33:24 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00

irqdesc: Fix __handle_domain_irq() comment

It appears that the comment about a NULL domain meaning anything
has always been wrong. Fix it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index cdd1cf8..2971eb7 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -165,8 +165,7 @@ int generic_handle_irq(unsigned int irq);
 /*
  * Convert a HW interrupt number to a logical one using a IRQ domain,
  * and handle the result interrupt number. Return -EINVAL if
- * conversion failed. Providing a NULL domain indicates that the
- * conversion has already been done.
+ * conversion failed.
  */
 int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs);
