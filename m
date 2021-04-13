Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0073E35DE90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbhDMMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhDMMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:22:28 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:22:08 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ed15:b7e9:afd7:f062])
        by xavier.telenet-ops.be with bizsmtp
        id sCN42400F1dBBzp01CN4h7; Tue, 13 Apr 2021 14:22:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lWI3P-00FJHU-TZ; Tue, 13 Apr 2021 14:22:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lWI3P-002kNZ-EJ; Tue, 13 Apr 2021 14:22:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: APPLE_AIC should depend on ARCH_APPLE
Date:   Tue, 13 Apr 2021 14:21:58 +0200
Message-Id: <f37e8daea37d50651d2164b0b3dad90780188548.1618316398.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple Interrupt Controller is only present on Apple Silicon SoCs.
Hence add a dependency on ARCH_APPLE, to prevent asking the user about
this driver when configuring a kernel without Apple Silicon SoC support.

Drop the default, as ARCH_APPLE already selects APPLE_AIC.

Fixes: 76cde26394114f6a ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d3a14f304ec80caa..b165b3285d9b0555 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -580,7 +580,7 @@ config MST_IRQ
 config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
-	default ARCH_APPLE
+	depends on ARCH_APPLE || COMPILE_TEST
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
-- 
2.25.1

