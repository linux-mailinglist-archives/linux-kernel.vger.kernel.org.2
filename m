Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789583A4386
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFKN5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhFKN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:38 -0400
Date:   Fri, 11 Jun 2021 13:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O3X7fzqI04by8kxv08zvCtvn6iOmODmqT532Tkze600=;
        b=ZHZg5qUMfI4yulf0nGH7+THMVgVyq4iRimGPI+bHlsIrVlyKtR5HluyuWFgo/EukHV54jW
        9yt2q5l0Ni66ZoRbPcOOLmhANeyse3HEfTtBbE3094Hwqney2hWleV8VcKG5XFyHNoNSNl
        kmOpIG5IjhT5lGg9hQOvgiGxhZxqIH0OxE6jpKT0rk+NI2NV76Rea5Wb0PY//3UFBW1DwA
        TY6BU+xN8uyOSgjCHTCk6fCR3QSe93QrHihMJRp9+Qzs0DWGsnIUZYhXOX//HjQ61V/nIn
        XrBiGpduhPwX319puUmwAC0HNH+Fi07f+k2xp6Djo3x9rsVERg6dPMBbvtkzhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O3X7fzqI04by8kxv08zvCtvn6iOmODmqT532Tkze600=;
        b=/3QnxV5BE77A+lrwsFsKSphh14B+xwV6XJEegPrchSjIclx5oUxdR1Cgx/OzxOD2UWr/Z2
        eZgM1oD49PuOmbCA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Kill irq_domain_add_legacy_isa
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967995.19906.1311508573469554889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     405e94e9aed2a38bdcd22efe53c36c6cd53185a6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/405e94e9aed2a38bdcd22efe53c36c6cd53185a6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 10:42:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:17 +01:00

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
