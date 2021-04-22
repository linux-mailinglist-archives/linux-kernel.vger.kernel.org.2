Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A150E3681F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhDVNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhDVNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:53:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BADC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:53:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvi2uE09s7SSq0kWesq4YptciMNkgL2eULW85wFagBg=;
        b=fYgAxGCIdDxQDkIHAyVXp/qwJvJrqu2M70k3WiFXf2NswXdKt4W5NmndGpcO54AdXu6lbo
        b3GSAujR/+XKmk2xpYZgk+U669cl89Mvfy0lqLV1wFF/A+vNArfefadEzbQugZZYztEFL6
        FbmJCvngpbO5Mfu+RvW7tyJAOnkiwmJYYCjMXU8rpVia57bgXmk+8FygvS5Lhw+nntx+so
        7cbrgZJvzbJTE++E9OnpKR2Pp2/4p5MCXbFJV+M5lEhWqLBqjzV9DB/afBy6cNDjhxocYb
        EXn6OVNwhzBNPfdKxURWTSf5eSSaaXPfQRenWsHwET+iCQOyMmZD3vt3XGbrng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvi2uE09s7SSq0kWesq4YptciMNkgL2eULW85wFagBg=;
        b=lgoapvUhNYJOeEZUYeKY0/ad4GrCFJqTNTlnF+AFUPmDaUN6uPiwhWV6Rx57W8zh6tYtv2
        IETqMBzaASDKsJCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/jcore-aic: Kill use of
 irq_create_strict_mappings()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210406093557.1073423-4-maz@kernel.org>
References: <20210406093557.1073423-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161909959709.29796.3675847138244013920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     304a7d135a62721f7eaff119c55686d99e9d7d4b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/304a7d135a62721f7eaff119c55686d99e9d7d4b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 10:35:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 14:47:37 +01:00

irqchip/jcore-aic: Kill use of irq_create_strict_mappings()

irq_create_strict_mappings() is a poor way to allow the use of
a linear IRQ domain as a legacy one. Let's be upfront about it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406093557.1073423-4-maz@kernel.org
---
 drivers/irqchip/irq-jcore-aic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 033bccb..5f47d8e 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -100,11 +100,11 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
-	domain = irq_domain_add_linear(node, dom_sz, &jcore_aic_irqdomain_ops,
+	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
+				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
 	if (!domain)
 		return -ENOMEM;
-	irq_create_strict_mappings(domain, min_irq, min_irq, dom_sz - min_irq);
 
 	return 0;
 }
