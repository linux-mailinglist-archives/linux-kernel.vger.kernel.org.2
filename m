Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004284367F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJUQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:38:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33000 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhJUQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:38:12 -0400
Date:   Thu, 21 Oct 2021 16:35:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634834155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fB+Qbqc1ux+FEZZKT8jn7/n2apW+NKmnCq81wwWjrnc=;
        b=m5yMSnBbJ/on9kmPxRjhDLCcXM2UrmivVrsA3VfB0Q8OBJgWqTfULhXT9Z47e5d4iOQe/w
        mxWa4ckA2yXTMflMIFXyHbfkW0yTB+nA9Zf3HxvYysnw/IUuLuFBxefbvOcGGw7QU0La4S
        ioxfT6s3jbwiKKNRDY8wCaMCBw++VM6Jsc+LanTVKLNDpWFPTXcVSXLc5MIviBuwn2VN5Y
        UlGNeJ4s5GxGKv23La6JeijOYW0W4e2+jSE1Wgdco43WwFry/I/UN5hkCtZY1Dw526wn9C
        kXe2sUwetpD7pP2IMRvQ4QjNlAa7EcBUH4muLr7oKt7PMEp2pbrVKIQWgpxOgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634834155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fB+Qbqc1ux+FEZZKT8jn7/n2apW+NKmnCq81wwWjrnc=;
        b=ww4k491+TkG5xaC16Ao7b+VK5h9gzNVVaaZk0/0T9o5NqRucOhD5xhWdaxiPM9jnVC/VGI
        Qo90uoBy4TiZcNDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/meson-gpio: Drop build-breaking
 COMPILE_TEST
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org>
References: <bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org>
MIME-Version: 1.0
Message-ID: <163483415388.25758.3766823698887341709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2e0fd58181a2614e1f41e434476f3f21c39b4669
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2e0fd58181a2614e1f41e434476f3f21c39b4669
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 21 Oct 2021 17:25:22 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 21 Oct 2021 17:28:15 +01:00

irqchip/meson-gpio: Drop build-breaking COMPILE_TEST

This driver advertises COMPILE_TEST, and yet fails to link due
to broken dependencies.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/bfc6fc7b-2bc3-b2b6-d65b-04805fbeb59d@infradead.org
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b2f483b..42d01bc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -407,7 +407,7 @@ config IRQ_UNIPHIER_AIDET
 
 config MESON_IRQ_GPIO
        tristate "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON || COMPILE_TEST
+       depends on ARCH_MESON
        default ARCH_MESON
        select IRQ_DOMAIN_HIERARCHY
        help
