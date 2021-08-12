Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E773EA31D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhHLKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:49:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhHLKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:30 -0400
Date:   Thu, 12 Aug 2021 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgEU+8k7vqzrqgWQ7FOXxBfwZr1RTmVAIt0tIUZbqsI=;
        b=1bKltviP9DennNsnF3C1ZeiX9S1dqbKDmOE2TJPpai+jp1lK46xJoLHG+GB61vClX5YGvG
        uPpjXsJ4k8Rwp1Esxy0+bTHp+fkubhr5ibmGSZSI899X+v6e0oG/VwpmTmjxjo1BQRxmhB
        66RR3lIcOENWUggS+qC8vudxLi9Yckowma5sjBCzkjLy/uQiDe580NQD3/QaPuQNaamtyu
        /pLFatG+Lahuk0ohswXgk9MJPLneP1iK8Fu/Y+o5wmws/P47I4E7mlOOV9fc6ouGww8qrk
        qGCkH635hTWAoLrG3anoOeZYnfZ8ZWeIQzSAin8HX5iCWEYGCq0R1I+NAADtXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgEU+8k7vqzrqgWQ7FOXxBfwZr1RTmVAIt0tIUZbqsI=;
        b=35sjn56Ht1qkitzQ9d94PJ1rYYG+KZJ7M14xaGm2z4l9hmFxAjHGUQ6flPueQZZ0gIxhBM
        Ehn6x63Ubn7tCcBA==
From:   "irqchip-bot for Markus Schneider-Pargmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mtk-sysirq: Skip setting irq-wake
Cc:     "Markus Schneider-Pargmann" <msp@baylibre.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210707062004.782787-1-msp@baylibre.com>
References: <20210707062004.782787-1-msp@baylibre.com>
MIME-Version: 1.0
Message-ID: <162876522465.395.17056442665568771059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c775626fb3379f0c7c21925743104aeae6d2f8b1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c775626fb3379f0c7c21925743104aeae6d2f8b1
Author:        Markus Schneider-Pargmann <msp@baylibre.com>
AuthorDate:    Wed, 07 Jul 2021 08:20:04 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 08:15:15 +01:00

irqchip/mtk-sysirq: Skip setting irq-wake

mtk-sysirq doesn't require specific logic to work with wakeup IRQs. To
allow registered IRQs to be used as a wakeup-source, add the flag
IRQCHIP_SKIP_SET_WAKE.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210707062004.782787-1-msp@baylibre.com
---
 drivers/irqchip/irq-mtk-sysirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 6ff98b8..586e52d 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -65,6 +65,7 @@ static struct irq_chip mtk_sysirq_chip = {
 	.irq_set_type		= mtk_sysirq_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int mtk_sysirq_domain_translate(struct irq_domain *d,
