Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C4C3136A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBHPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhBHPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:03:43 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835EC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:02:56 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id Sf2u2400r4C55Sk06f2ubN; Mon, 08 Feb 2021 16:02:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l983y-004eM9-9M; Mon, 08 Feb 2021 16:02:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l983x-001mUr-Dg; Mon, 08 Feb 2021 16:02:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: marvell: ARMADA375_USBCLUSTER_PHY should not default to y, unconditionally
Date:   Mon,  8 Feb 2021 16:02:52 +0100
Message-Id: <20210208150252.424706-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
To fix this, restrict the automatic enabling of ARMADA375_USBCLUSTER_PHY
to MACH_ARMADA_375, and ask the user in case of compile-testing.

Fixes: eee47538ec1f2619 ("phy: add support for USB cluster on the Armada 375 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/phy/marvell/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 6c96f2bf52665789..c8ee23fc3a83d360 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -3,8 +3,8 @@
 # Phy drivers for Marvell platforms
 #
 config ARMADA375_USBCLUSTER_PHY
-	def_bool y
-	depends on MACH_ARMADA_375 || COMPILE_TEST
+	bool "Armada 375 USB cluster PHY support" if COMPILE_TEST
+	default y if MACH_ARMADA_375
 	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
 
-- 
2.25.1

