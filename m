Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F3414AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhIVNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhIVNl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:41:59 -0400
Date:   Wed, 22 Sep 2021 13:40:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQnfWAdFxeCqB/CyI+ozuSwegZiIw355/m0e/cKjrO8=;
        b=LmlNQfXLYrb4XRkMgRa25QccIzEEMovzLdSEShuqHvxvfAp/RletiRRfIM8X1OCAKUUCVk
        5j/PBMevCFJHHLMATASOkS6PltiD/6PwZzXS7H/bxpmet5ekyf1qIwRcYwJ+jqFjcY6b70
        dCkXeFjTDjXjtPWBhmOvobo2p2JvvCjy45d7uYC8sNGx/OqqG72BhMQuLkbWYxr0YHnSUn
        eaaQYpcycXHz6ieNtIui4nOSmWVr/r+Mt6JZ9Dd++q3ZhaURa7GnMFjNxtQraVzvdYMJ/o
        /DEMB75i+mlCmd7mQ0Ig3xQmdBXbrPPwvPxrHVsl1ruKeD/5ztZpsEKpYHWpPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQnfWAdFxeCqB/CyI+ozuSwegZiIw355/m0e/cKjrO8=;
        b=5pBjjERD3G//DKuIRJ9Is52KI8wwqMgEIpuD50njDnrAVuU6um3zLOLeLUht/CacIh9huc
        bN+lUa1zBBaoxEDg==
From:   "irqchip-bot for Bixuan Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqdomain: Change the type of 'size' in
 __irq_domain_add() to be consistent
Cc:     Bixuan Cui <cuibixuan@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210916025203.44841-1-cuibixuan@huawei.com>
References: <20210916025203.44841-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Message-ID: <163231802782.25758.1928034479951254695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     20c36ce2164f1774b487d443ece99b754bc6ad43
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/20c36ce2164f1774b487d443ece99b754bc6ad43
Author:        Bixuan Cui <cuibixuan@huawei.com>
AuthorDate:    Thu, 16 Sep 2021 10:52:03 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:29:32 +01:00

irqdomain: Change the type of 'size' in __irq_domain_add() to be consistent

The 'size' is used in struct_size(domain, revmap, size) and its input
parameter type is 'size_t'(unsigned int).
Changing the size to 'unsigned int' to make the type consistent.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210916025203.44841-1-cuibixuan@huawei.com
---
 include/linux/irqdomain.h | 2 +-
 kernel/irq/irqdomain.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 23e4ee5..9ee238a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -251,7 +251,7 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 62be161..bfa289e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
  * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
