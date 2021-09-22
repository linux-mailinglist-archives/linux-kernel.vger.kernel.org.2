Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0A414AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhIVNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhIVNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:41:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36119C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:40:28 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:40:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvhYE46fjIpuCdGM0OSZX9SZqbTgjtKrolFYW0Az54E=;
        b=H7pY7BxzkIGXRy005QSppZafHRCadxw71zD9Z0xqj66r1rry2Nue9hLO0WoBCOKpzMafZV
        xMPhLsy5qxOqy3dIomGGHphFWZYsx0H1gj7AqYABdmx4z/i1bHmgowJGYT70olYzwLKTfd
        dPmWTaEqDV+CkuoQbkMByi8uJ9L1iUbgkjr7TD4KWzTQpkcJehez1oyhieW84TbCWIWWBf
        W6boZAIskPX5mZryaQnoC3c0TEmUwNCuPzdgLaqqo1tQOuZelg/zAt1aj1V3J3+s/Vcvrl
        3ID+9Xztxp1VzN4XzYtK9jfvI5Zm6NW5CuzC70Oi0Is4l8GZAOgjanYG8y2W0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvhYE46fjIpuCdGM0OSZX9SZqbTgjtKrolFYW0Az54E=;
        b=SVoLuO+Z+N0/brdZ1vhZ33fwZECeLOOMYkJe+f2hTvV/QEBG/192Gxp3kxd74Ox9GQFv7a
        z7oMRvs6cqLlXuBg==
From:   "irqchip-bot for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/goldfish-pic: Select
 GENERIC_IRQ_CHIP to fix build
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>
In-Reply-To: <20210905162519.21507-1-rdunlap@infradead.org>
References: <20210905162519.21507-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <163231802604.25758.1149955481801818672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     969ac78db78c723a24e9410666b457cc1b0cb3c3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/969ac78db78c723a24e9410666b457cc1b0cb3c3
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 05 Sep 2021 09:25:19 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:33:09 +01:00

irqchip/goldfish-pic: Select GENERIC_IRQ_CHIP to fix build

irq-goldfish-pic uses GENERIC_IRQ_CHIP interfaces so select that symbol
to fix build errors.

Fixes these build errors:

mips-linux-ld: drivers/irqchip/irq-goldfish-pic.o: in function `goldfish_pic_of_init':
irq-goldfish-pic.c:(.init.text+0xc0): undefined reference to `irq_alloc_generic_chip'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0xf4): undefined reference to `irq_gc_unmask_enable_reg'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0xf8): undefined reference to `irq_gc_unmask_enable_reg'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0x100): undefined reference to `irq_gc_mask_disable_reg'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0x104): undefined reference to `irq_gc_mask_disable_reg'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0x11c): undefined reference to `irq_setup_generic_chip'
mips-linux-ld: irq-goldfish-pic.c:(.init.text+0x168): undefined reference to `irq_remove_generic_chip'

Fixes: 4235ff50cf98 ("irqchip/irq-goldfish-pic: Add Goldfish PIC driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210905162519.21507-1-rdunlap@infradead.org
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d5924e..aca7b59 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -409,6 +409,7 @@ config MESON_IRQ_GPIO
 config GOLDFISH_PIC
        bool "Goldfish programmable interrupt controller"
        depends on MIPS && (GOLDFISH || COMPILE_TEST)
+       select GENERIC_IRQ_CHIP
        select IRQ_DOMAIN
        help
          Say yes here to enable Goldfish interrupt controller driver used
