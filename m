Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72E3F46FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhHWI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhHWI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF535C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:56:00 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:55:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629708959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+DFi5B+89yL7qeiCrqdeU/3axcweDbD7pjzeKguYjk=;
        b=eFH3ED7qKUG+AMKWl7Y+rIsu2AedbiLzoadcZrpPPT77PjFSTwYHL1Qhl3DZ6Uop7Eu5uR
        4neXLbMHtffpC38+i6VZdGF2tEdVNbUD1AyQjtR9eroUkif8jWKvMvK54WeZ0Fij/4tRDB
        1f05k7bvFVn4/AVzfdhw09GbSFYKVhHh5UbSZ963Wq4IYl2k3CYPNHlr1+HsqRj3GmXPFF
        /tPpsV/tZVVgDQHkZCPinI997+O76IWQVyCUEqFubEvm4R6Pnasy+RWcBurXPWX64yA/lt
        +n7m5n+SVAC5tT1J+3H22PDTPm1FT69x7Lg0K3lM/rr51O0DtNroUB5E4Ct3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629708959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+DFi5B+89yL7qeiCrqdeU/3axcweDbD7pjzeKguYjk=;
        b=4NGi64oVRDYZGEAQvNoFTjRgvMKkh0g7Tf3ClZ4bMGnlnPO1ieBXVwaDD/Bp2AGKVO0Xrf
        cwCWNAlhImX8ErAw==
From:   "irqchip-bot for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Export
 irq_domain_disconnect_hierarchy()
Cc:     Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1629705880-27877-2-git-send-email-mkshah@codeaurora.org>
References: <1629705880-27877-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <162970895865.25758.16015911717536063973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     131d326ba969847daa43d708ac11c27978d78566
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/131d326ba969847daa43d708ac11c27978d78566
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 23 Aug 2021 13:34:39 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 23 Aug 2021 09:24:57 +01:00

irqdomain: Export irq_domain_disconnect_hierarchy()

Export irq_domain_disconnect_hierarchy() so irqchip module drivers
can use it.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1629705880-27877-2-git-send-email-mkshah@codeaurora.org
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 51c483c..62be161 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1215,6 +1215,7 @@ int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
 	irqd->chip = ERR_PTR(-ENOTCONN);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_domain_disconnect_hierarchy);
 
 static int irq_domain_trim_hierarchy(unsigned int virq)
 {
