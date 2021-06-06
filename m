Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20AC39D101
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhFFT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:28:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFFT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:28:26 -0400
Date:   Sun, 06 Jun 2021 19:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623007595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uuNWC+0JS9Rs4gJw19RxkXh+fnBKhtDQToY+7sNKX7s=;
        b=qmajRXiJrZ6K2Ktqp6ld6nnyY4eGIfiC7wPqZM60xkMSYyz7ZCoAaDzVrvNquWU5P91YNj
        0Oqe811CItrOEhSNfcktKJ2yP1A84gQwxFVEgVTwsQPOyfspuqUBsBHS4zYVkVUaC8GPtT
        W1XyJYPrFixF4A7A90+3wjj8HPfsfZgGvs7h8urAvdsznJpT/8N36nTkqz46n4A53I/eO8
        mYU07WQ4m7CLgXUnM/5Fi39UXe9IfAdUcXHf2wCHNKoJn5T6jeljkhDTrZSuz7LbhSU8KL
        ZRsrA8tWihWgaYm/ahqy46rjpk4n/0wc5qtxD6mtaUcU5GlJPEhaaD4ZoTrFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623007595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uuNWC+0JS9Rs4gJw19RxkXh+fnBKhtDQToY+7sNKX7s=;
        b=qUGiXMDRG7X9xcTiYizfRiRi9QUdE0Wje6yNtwh9HO+nNjn4s9a+bfY6BiBadyR/ymRA6K
        Qf11oy2w12sTZtBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] fixup! irqdomain: Introduce irq_resolve_mapping()
Cc:     maz@kernel.org, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162300759493.29796.1505215571172770905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     09816d49a254b5616e313dfef720322393129c29
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/09816d49a254b5616e313dfef720322393129c29
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 06 Jun 2021 15:38:17 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 15:38:17 +01:00

fixup! irqdomain: Introduce irq_resolve_mapping()
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 012d6bf..f27db50 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -876,7 +876,7 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_resolve_mapping() - Find a linux irq from a hw irq number.
+ * __irq_resolve_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  * @irq: optional pointer to return the Linux irq if required
