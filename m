Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86423C81AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhGNJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhGNJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:36:41 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E132C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:33:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by michel.telenet-ops.be with bizsmtp
        id UxZl2500H1ccfby06xZlEd; Wed, 14 Jul 2021 11:33:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bGz-0015V1-0Z; Wed, 14 Jul 2021 11:33:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3bGy-00A3Cq-Ay; Wed, 14 Jul 2021 11:33:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] arm: Typo s/PCI_IXP4XX_LEGACY/IXP4XX_PCI_LEGACY/
Date:   Wed, 14 Jul 2021 11:33:43 +0200
Message-Id: <82ce37c617293521f095a945a255456b9512769c.1626255077.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig symbol PCI_IXP4XX_LEGACY does not exist, but IXP4XX_PCI_LEGACY
does.

Fixes: d5d9f7ac58ea1041 ("ARM/ixp4xx: Make NEED_MACH_IO_H optional")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
  - Add Reviewed-by.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3ea1c417339ff6bb..82f908fa5676ac15 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -395,7 +395,7 @@ config ARCH_IXP4XX
 	select IXP4XX_IRQ
 	select IXP4XX_TIMER
 	# With the new PCI driver this is not needed
-	select NEED_MACH_IO_H if PCI_IXP4XX_LEGACY
+	select NEED_MACH_IO_H if IXP4XX_PCI_LEGACY
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	help
-- 
2.25.1

