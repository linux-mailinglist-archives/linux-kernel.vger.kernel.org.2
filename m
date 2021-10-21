Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBC436802
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhJUQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhJUQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:38:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE9C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:35:58 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634834155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+L7Sx3lwopZcUErY2rkJDBJLskxZ/VypQrvz60eL6E=;
        b=4puGJuCosLPagXWVGrIEYFrkkoxkqNjMI6L0rfJ0Rv3OOct/3N+xrZdebH6VfXLfRqta56
        9Q0w3BJEgy2V+ZzwOzebeYNJ+nz84x6s0eN7RusE4sbXX6Ft8VlmorrUX/03ruQ1T+yn8s
        k3bMy6xst4/S0BAsukpFUd9Z6p5WkT9UWAeWypNaqzkX2sp3T3D5iXwUc5MpN+C8vuLQCN
        +3Q78kF91fk1D2HldeUgk0bj0Lrw0aaJXVhl2EfOu1FLk+sh656tehBMm+NG68ViN5Rpkt
        Na1cEEf+EqTxFhu09jOhVMKG0QZIM9dlOq206ggUjzBLZ/auU+pxK9uZZh1aTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634834155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+L7Sx3lwopZcUErY2rkJDBJLskxZ/VypQrvz60eL6E=;
        b=XpWUok/Tdn+NVD0DzFn7MyyRzKfYJVFjzlHvUHKFv7FznpjZvdZFg6a82+p1If4VDGFLrQ
        CsmMchAyKKIBpqCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mchp-eic: Drop build-breaking
 COMPILE_TEST
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org>
References: <bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org>
MIME-Version: 1.0
Message-ID: <163483415498.25758.3306069467532191935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2aee149dd9ba374b426b9dd6192bf2a8a715e63a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2aee149dd9ba374b426b9dd6192bf2a8a715e63a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 21 Oct 2021 17:25:22 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 21 Oct 2021 17:25:22 +01:00

irqchip/mchp-eic: Drop build-breaking COMPILE_TEST

This driver advertises COMPILE_TEST, and yet fails to link due
to broken dependencies.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8df8ffb..6e58838 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -604,7 +604,7 @@ config APPLE_AIC
 
 config MCHP_EIC
 	bool "Microchip External Interrupt Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	help
