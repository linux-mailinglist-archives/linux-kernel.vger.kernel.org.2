Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83A3135D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhBHO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhBHO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:56:51 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612CDC061794
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:56:09 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id Sew72400P4C55Sk01ew7UE; Mon, 08 Feb 2021 15:56:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l97xO-004eF5-VA; Mon, 08 Feb 2021 15:56:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l97xO-001m2a-HP; Mon, 08 Feb 2021 15:56:06 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: IMX_INTMUX should not default to y, unconditionally
Date:   Mon,  8 Feb 2021 15:56:05 +0100
Message-Id: <20210208145605.422943-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
To fix this, restrict the automatic enabling of IMX_INTMUX to ARCH_MXC,
and ask the user in case of compile-testing.

Fixes: 66968d7dfc3f5451 ("irqchip: Add COMPILE_TEST support for IMX_INTMUX")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b147f22a78f48450..d7d1a0fab2c1aeb8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,7 +457,8 @@ config IMX_IRQSTEER
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
-	def_bool y if ARCH_MXC || COMPILE_TEST
+	bool "i.MX INTMUX support" if COMPILE_TEST
+	default y if ARCH_MXC
 	select IRQ_DOMAIN
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
-- 
2.25.1

