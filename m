Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872E73A437E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhFKN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhFKN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:37 -0400
Date:   Fri, 11 Jun 2021 13:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3qaWuX9/K7OZlv72peY1UQvh5wrNM7zlD1yWf8JZjV4=;
        b=eSfkCjUR2h2B5hUpgV+dV8pW41nkLDXcxzE6K7P8ihl9Jv4lGenCPaESGZsp68SZud60Vn
        Hi1GKsRUtMaJXF+D3q7HFdXVDqGQaxEYpPfB+IAIYtloUsHt4GwfT93O/1PJX6EX6r04vf
        aU6TR9GSZkGpH6ZEwBCXvb1EkQsY01a6D74z0gNirQwwocGUAReJZ+40mtMi7IQANLPeag
        4sRpa9NXExIuLX3h9wCck2RsjcVJXz1ihpGcAMzyxMGyijKDFoBYyXWTgrl8n/cY5DhzKp
        rSwZ9yeL5fc+264bAWjVdsUYqLKa/Nu5mBB2T/Wme0niledlTD8B1Ca3kMGDCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3qaWuX9/K7OZlv72peY1UQvh5wrNM7zlD1yWf8JZjV4=;
        b=KMAl2hPT2+BDO0l6r51seDv2gX9+kGA9UGTi7fUYzJbgZWICUM1aWhksSHqKDoJjvjHV5T
        anXGn5yQx21RH6CA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Use struct_size() helper when
 allocating irqdomain
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967792.19906.9023367566774457383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     426fa316148bccabf48f9c91a13c387ee911eadc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/426fa316148bccabf48f9c91a13c387ee911eadc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:30:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:17 +01:00

irqdomain: Use struct_size() helper when allocating irqdomain

Instead of open-coding the size computation of struct irqdomain,
use the struct_size() helper instead.

This is going to be handy as we change the type of the revmap
array.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index fa94c86..cdcb198 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -150,7 +150,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
 		return NULL;
 
-	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
+	domain = kzalloc_node(struct_size(domain, revmap, size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
