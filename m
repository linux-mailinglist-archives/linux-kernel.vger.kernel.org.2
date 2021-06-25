Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631F73B44A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhFYNjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhFYNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:39:23 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4169C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:37:02 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:1476:ce84:e216:add8])
        by michel.telenet-ops.be with bizsmtp
        id MRd02500i2B1U9906Rd1BR; Fri, 25 Jun 2021 15:37:01 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lwm0y-003U0X-Gg; Fri, 25 Jun 2021 15:37:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lwm0x-004tS7-RT; Fri, 25 Jun 2021 15:36:59 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: RESET_MCHP_SPARX5 should depend on ARCH_SPARX5
Date:   Fri, 25 Jun 2021 15:36:57 +0200
Message-Id: <6e08f6f46123d0712397e901716b48f13fa5dc48.1624627657.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Microchip Sparx5 switch reset block is only present on Microchip
Sparx5 SoCs.  Hence add a dependency on ARCH_SPARX5, to prevent asking
the user about this driver when configuring a kernel without Sparx5
support.

Fixes: 453ed4283bebd077 ("reset: mchp: sparx5: add switch reset driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1a0403927a99be42..e1f6a53cf688401e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -116,7 +116,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	bool "Microchip Sparx5 reset driver"
-	depends on HAS_IOMEM || COMPILE_TEST
+	depends on ARCH_SPARX5 || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
-- 
2.25.1

