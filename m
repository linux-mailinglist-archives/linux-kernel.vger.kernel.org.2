Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFB3B72FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhF2NOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhF2NOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:14:42 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F57C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:12:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:7d95:f75f:5ece:4663])
        by andre.telenet-ops.be with bizsmtp
        id P1CC2500J4F6zkK011CCfk; Tue, 29 Jun 2021 15:12:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyDXA-004tWf-A5; Tue, 29 Jun 2021 15:12:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyDX9-009dGg-Lk; Tue, 29 Jun 2021 15:12:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm: Typo s/PCI_IXP4XX_LEGACY/IXP4XX_PCI_LEGACY/
Date:   Tue, 29 Jun 2021 15:12:10 +0200
Message-Id: <1b2fd6f2b2e87a7d483450c20f31366b7f17c997.1624972206.git.geert+renesas@glider.be>
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
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdb8925a47c54886..1267d2feacedffcc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -398,7 +398,7 @@ config ARCH_IXP4XX
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

