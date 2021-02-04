Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1068D30FAA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhBDSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbhBDSDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:03:01 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE5C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:02:20 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id R62J2400E4C55Sk0162Jxs; Thu, 04 Feb 2021 19:02:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l7im7-003Fgj-Jt; Thu, 04 Feb 2021 18:50:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l7del-006syv-Mo; Thu, 04 Feb 2021 13:22:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH resend v2] ahci: qoriq: Add platform dependencies
Date:   Thu,  4 Feb 2021 13:22:42 +0100
Message-Id: <20210204122242.1641273-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale QorIQ AHCI SATA controller is only present on Freescale
Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
symbol, to avoid asking the user about it when configuring a kernel
without Layerscape support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
v2:
  - Add Acked-by.
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 030cb32da980fc47..9ec6bce27c91511b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -264,6 +264,7 @@ config AHCI_XGENE
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
 	depends on OF
+	depends on SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
-- 
2.25.1

