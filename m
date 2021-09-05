Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEC4010DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhIEQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhIEQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 12:26:28 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411BC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eGroZ4b7JLc1jvCPkCpU9GaEM2smL7GUPHcU1IK4k40=; b=xbF2rsBY1zoq8WhvYR8PXuAq+l
        eAGq8v4jBj+wRGmqgp85kuOJtl1Cs7NPqatHU66FpY7AjkuVpC4fFgC1WwEm7Sgoz9rsEMkzyMV6U
        Eck8jkE6VgjrNxZO7AMTy4wJXXty9aKb0LEwIws7Oh0QcebaGDQCrxqCPqN+btcwKI0QGkS6hXeSS
        lS/7aDoNqS3TqUiosKMVnxTU2D1+aIzk1DpncMH33q3UeAq2wv7JSu8mPp3buTyJvohuLq3sc0+6q
        blJ4YStOxR4GtlexSszFqvvr54UhLI5nVvhhNmcoAgrr3X6Lkl4hGK9ZKbjiWDwX1nhZogANjn7Oe
        N2XH7amQ==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMuxN-00G619-QW; Sun, 05 Sep 2021 16:25:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>
Subject: [PATCH] irqchip/irqchip-goldfish-pic: select GENERIC_IRQ_CHIP to fix build
Date:   Sun,  5 Sep 2021 09:25:19 -0700
Message-Id: <20210905162519.21507-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210903.orig/drivers/irqchip/Kconfig
+++ linux-next-20210903/drivers/irqchip/Kconfig
@@ -409,6 +409,7 @@ config MESON_IRQ_GPIO
 config GOLDFISH_PIC
        bool "Goldfish programmable interrupt controller"
        depends on MIPS && (GOLDFISH || COMPILE_TEST)
+       select GENERIC_IRQ_CHIP
        select IRQ_DOMAIN
        help
          Say yes here to enable Goldfish interrupt controller driver used
