Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593330A900
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhBANpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhBANpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:45:16 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D50C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:44:35 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id PpkZ240064C55Sk01pkZ5E; Mon, 01 Feb 2021 14:44:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l6ZVI-002TCq-LI; Mon, 01 Feb 2021 14:44:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l6ZVI-002vxi-24; Mon, 01 Feb 2021 14:44:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Srujana Challa <schalla@marvell.com>,
        Suheil Chandran <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] crypto: marvell - CRYPTO_DEV_OCTEONTX2_CPT should depend on ARCH_THUNDER2
Date:   Mon,  1 Feb 2021 14:44:31 +0100
Message-Id: <20210201134431.699419-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell OcteonTX2 CPT physical function PCI device is present only
on OcteonTx2 SoC, and not available as an independent PCIe endpoint.
Hence add a dependency on ARCH_THUNDER2, to prevent asking the user
about this driver when configuring a kernel without OcteonTx2 platform
support.

Fixes: 5e8ce8334734c5f2 ("crypto: marvell - add Marvell OcteonTX2 CPT PF driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/marvell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/Kconfig b/drivers/crypto/marvell/Kconfig
index 2efbd79180ce4b22..d4c4433c8db8244a 100644
--- a/drivers/crypto/marvell/Kconfig
+++ b/drivers/crypto/marvell/Kconfig
@@ -38,7 +38,7 @@ config CRYPTO_DEV_OCTEONTX_CPT
 
 config CRYPTO_DEV_OCTEONTX2_CPT
 	tristate "Marvell OcteonTX2 CPT driver"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_THUNDER2 || COMPILE_TEST
 	depends on PCI_MSI && 64BIT
 	depends on CRYPTO_LIB_AES
 	select OCTEONTX2_MBOX
-- 
2.25.1

