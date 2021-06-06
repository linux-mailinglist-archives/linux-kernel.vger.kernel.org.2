Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC739CF1E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFFMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFFMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:41 -0400
Date:   Sun, 06 Jun 2021 12:43:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pm1b5kA4OJxSDHYfDpi4h+WhrpTC0gqCl0mNWzcfkPg=;
        b=lhPLX3fZ0mBiaglroHUBVrJgd4Om0e95SlemGmfk9Kd9J6VhW2MLkBABxuTOqJlWo2+4D0
        wLOyUa5CO4dkyqMTapzsUFGQaRS2dyC7HhMNwD7v1py7VyE1GZWfbsyxc8x0dJaU+fiLQ/
        r8ZDoQDzVsQW0RKjNKfUDxdMWNd9vH9zf8NXAu0whKHPiVHgNhjjyXSF8+ZnjPxVpm+nn9
        zUkR1Wdq1qj8f6roAQxBIsW8gZVVlo+CTIPsC13jZhdHA7O51KXr6PGr4DVMWcXrtxNI7r
        FnwmLU+ARbyR+OMhMXRBcyDXH9zHsVqZEqC+OIR9dBkSo4JVGMF4O8/BuTOr+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pm1b5kA4OJxSDHYfDpi4h+WhrpTC0gqCl0mNWzcfkPg=;
        b=hsjyy3xQYUTtZP0aLMyFLnCNrBQOrOQAQl31HAIQtS0+Bc7wRBv0GTrGHu4/FYIo9fs80j
        FC+MKr2vENy1G6Bw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Kill irq_domain_add_legacy_isa
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343087.29796.2303741743539407585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bf541b2ef87c162c8129333c55d2357bab122d8e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bf541b2ef87c162c8129333c55d2357bab122d8e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 10:42:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

irqdomain: Kill irq_domain_add_legacy_isa

This helper doesn't have a user anymore, let's remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/core-api/irq/irq-domain.rst |  1 -
 include/linux/irqdomain.h                 | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 8214e21..53283b3 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -146,7 +146,6 @@ Legacy
 
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
-	irq_domain_add_legacy_isa()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 62a8e3d..9f884c9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -45,9 +45,6 @@ struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
 
-/* Number of irqs reserved for a legacy isa controller */
-#define NUM_ISA_INTERRUPTS	16
-
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
 /**
@@ -355,14 +352,6 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
 }
-static inline struct irq_domain *irq_domain_add_legacy_isa(
-				struct device_node *of_node,
-				const struct irq_domain_ops *ops,
-				void *host_data)
-{
-	return irq_domain_add_legacy(of_node, NUM_ISA_INTERRUPTS, 0, 0, ops,
-				     host_data);
-}
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
