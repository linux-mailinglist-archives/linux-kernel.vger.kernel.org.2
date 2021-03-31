Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4634FDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhCaJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhCaJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:40 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:59:40 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
        by xavier.telenet-ops.be with bizsmtp
        id mxzd240095W9KJv01xzdYP; Wed, 31 Mar 2021 11:59:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdQ-00BseR-K9; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRW4g-001Xah-7p; Wed, 31 Mar 2021 10:19:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: microchip: PHY_SPARX5_SERDES should depend on ARCH_SPARX5
Date:   Wed, 31 Mar 2021 10:19:37 +0200
Message-Id: <20210331081937.367408-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip Sparx5 SerDes PHY is present only Microchip Sparx5 SoCs.
Hence add a dependency on ARCH_SPARX5, to prevent asking the user about
this driver when configuring a kernel without support for Sparx5 SoCs.

Fixes: 2ff8a1eeb5aa8bb4 ("phy: Add Sparx5 ethernet serdes PHY driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/microchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
index 0b1a818e01b88cc5..3728a284bf643d48 100644
--- a/drivers/phy/microchip/Kconfig
+++ b/drivers/phy/microchip/Kconfig
@@ -6,6 +6,7 @@
 config PHY_SPARX5_SERDES
 	tristate "Microchip Sparx5 SerDes PHY driver"
 	select GENERIC_PHY
+	depends on ARCH_SPARX5 || COMPILE_TEST
 	depends on OF
 	depends on HAS_IOMEM
 	help
-- 
2.25.1

