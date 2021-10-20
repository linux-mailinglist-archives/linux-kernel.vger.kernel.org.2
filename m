Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40F435507
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhJTVOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:28 -0400
Date:   Wed, 20 Oct 2021 21:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2r3YJPERYy+uxfdB3DtsuAcjnvmLZ9z7Bf1/WoOuu84=;
        b=LuANVsywbUog2Gzs+baOfoN5towOSZzRweMBPlmIWnrvfd+SnyxOpjIlXRPxk3/c+EwXNe
        ct12opmzfKkBz3QEG7oXpVPg0dgrkBA5rvczaRe0t63kbB29yOZQJNtJvr4nZKD/GJQAQh
        UHVknC5T06JF6zo11NuV9N0QstuRx7xBJwNe1YnGzjykFiVQOSaQ/KX0YMRvsj9/p+S8Jb
        6JePivdqX6SdLNjhipU1RW5RbwYOnVVg1/pAbjSj0NRvfA6o/wT4D56yOwzhSgvGlJoDni
        drdpCNKGfW2M3U3bWTeb86wfNPlDK0js2n/O7I/tIDFngdLL/u4wRIL0GLVEaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2r3YJPERYy+uxfdB3DtsuAcjnvmLZ9z7Bf1/WoOuu84=;
        b=PhU63DC5ewIohNSvD4D8qHqNNoafajmyLN6cqGAqqLPTsmr1TRuFvgiSXHD17OOZ8OuQe8
        quDbUa5+BMvzhoAw==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Export irq_gc_noop()
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-10-f.fainelli@gmail.com>
References: <20211020184859.2705451-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433187.25758.4882871038805997223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     945486bf1ee3362068d95b5e1b5d4a7779ea0aaf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/945486bf1ee3362068d95b5e1b5d4a7779ea0aaf
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:55 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:33 +01:00

genirq: Export irq_gc_noop()

In order to build drivers/irqchip/irq-bcm7120-l2.c as a module which
references irq_gc_noop(), we need to export it towards modules.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-10-f.fainelli@gmail.com
---
 kernel/irq/generic-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 4c011c2..6f29bf4 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -25,6 +25,7 @@ static DEFINE_RAW_SPINLOCK(gc_lock);
 void irq_gc_noop(struct irq_data *d)
 {
 }
+EXPORT_SYMBOL_GPL(irq_gc_noop);
 
 /**
  * irq_gc_mask_disable_reg - Mask chip via disable register
