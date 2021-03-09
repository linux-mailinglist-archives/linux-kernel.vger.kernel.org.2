Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE833215A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCIIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:52:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCIIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:51:43 -0500
Date:   Tue, 09 Mar 2021 08:51:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615279902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+B8oQrnGh5SDwa3oAYDgNFqM7Vu15DVCissE/Kjtps=;
        b=tca1Dte4h9n2V1QiAIWoBjd2FEI6m7kPQM43PiyQXR6RhgKiVyzBBUwhA9pGdPv7fFjPDo
        MSzTtJdyW7qk5jO4b+PJo0DS+Qoh04e+8dvzG8TAh79yt8udIpQc9tcLyByERSxerV+9AG
        Ou8kfX2uOtbmvLas3h8Gd+vq/wvpOi6mrONcc/ar7mhDygBKAo9KFZHlEGZPCcbSp+MQ9u
        hHmnjGqr9c8h5hKnUYpR6DrOpnuE99GEcPVbdESPKh0cLjACQTvPB2ispjbAGIYwj2gEsI
        /Hl665Q2330FMoxhSumhrlgefedb60ZBLLXzL1L9rD18A60FbuovSrHBPTUsSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615279902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+B8oQrnGh5SDwa3oAYDgNFqM7Vu15DVCissE/Kjtps=;
        b=rlEfyrb/bjopXu4HqEy8Xm0StD7sbe5d1ydibleXkfeh6mnPwQzz0UTNSRdadgIbals/8C
        ijwzy7HZVCfLkTCQ==
From:   "irqchip-bot for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ingenic: Add support for the JZ4760
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210307172014.73481-2-paul@crapouillou.net>
References: <20210307172014.73481-2-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <161527990169.398.7707810641057163899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5fbecd2389f48e1415799c63130d0cdce1cf3f60
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5fbecd2389f48e1415799c63130d0cdce1cf3f60
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Sun, 07 Mar 2021 17:20:14 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 09 Mar 2021 08:45:17 

irqchip/ingenic: Add support for the JZ4760

Add support for the interrupt controller found in the JZ4760 SoC, which
works exactly like the one in the JZ4770.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210307172014.73481-2-paul@crapouillou.net
---
 drivers/irqchip/irq-ingenic-tcu.c | 1 +
 drivers/irqchip/irq-ingenic.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 7a7222d..b938d1d 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -179,5 +179,6 @@ err_free_tcu:
 }
 IRQCHIP_DECLARE(jz4740_tcu_irq, "ingenic,jz4740-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4725b_tcu_irq, "ingenic,jz4725b-tcu", ingenic_tcu_irq_init);
+IRQCHIP_DECLARE(jz4760_tcu_irq, "ingenic,jz4760-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4770_tcu_irq, "ingenic,jz4770-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(x1000_tcu_irq, "ingenic,x1000-tcu", ingenic_tcu_irq_init);
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index b61a890..ea36bb0 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -155,6 +155,7 @@ static int __init intc_2chip_of_init(struct device_node *node,
 {
 	return ingenic_intc_of_init(node, 2);
 }
+IRQCHIP_DECLARE(jz4760_intc, "ingenic,jz4760-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
