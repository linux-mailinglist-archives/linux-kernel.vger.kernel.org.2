Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3868F3EA73F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhHLPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhHLPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:29 -0400
Date:   Thu, 12 Aug 2021 15:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9zD7qsU6xCiIp3ij/D4IVVbD/VnOOH/3efjUA33Y2w=;
        b=kztLoXQJQAzQ8SC+r3wWYaycqrrL5rx2XHYPSgKyHdEmcmYuEMOv1zCiDwF3hVQyp10j4o
        WGBJASRsXwXxYKKIDcw5gPLfL56fPccjOhGNGjk+fQZJFvKsC9rnuoyc5hqCpC3tlqBpxJ
        d1weDyznTsBfQ6rOIUGGZPtmMy1jf7mbm+WnMPrnxCY0Er1iUB/mLca8aPeOq2xoJzscHc
        ne8IUKHbx20NRUCtHxbimFDSTrOJxa63zl8PHCfJP7j5zAy6UdP1rLt3XTrKg23ibP3+py
        /40CdKU3iwYB4Iq/DeckF1x5rK3nZadXKkq0SZbwM+/WXhKyQgfzjOa6O+xOrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9zD7qsU6xCiIp3ij/D4IVVbD/VnOOH/3efjUA33Y2w=;
        b=Z9j1tXWU19Bb0XFbUeVQXRC8EV97qOb7kiS2oNcKC7CZ+/e92vA1H7rwnt1Lbt/NYrbkWl
        C9fN01uiBtaSnCAg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Let purely flow-masked ONESHOT
 irqs through unmask_threaded_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-6-valentin.schneider@arm.com>
References: <20210629125010.458872-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118220.395.5938591294324520076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a4ea2933cc4581e70203a48c60bc26b69a936eeb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a4ea2933cc4581e70203a48c60bc26b69a936eeb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:02 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq: Let purely flow-masked ONESHOT irqs through unmask_threaded_irq()

A subsequent patch will let IRQs end up in irq_finalize_oneshot() without
IRQD_IRQ_MASKED, but with IRQD_IRQ_FLOW_MASKED set instead. Let such IRQs
receive their final ->irq_eoi().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-6-valentin.schneider@arm.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef30b47..e6d6d32 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1107,7 +1107,7 @@ again:
 	desc->threads_oneshot &= ~action->thread_mask;
 
 	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data))
+	    (irqd_irq_masked(&desc->irq_data) | irqd_irq_flow_masked(&desc->irq_data)))
 		unmask_threaded_irq(desc);
 
 out_unlock:
