Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7B37073A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhEAMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 08:41:48 -0400
Received: from dd20004.kasserver.com ([85.13.150.92]:44932 "EHLO
        dd20004.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhEAMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 08:41:47 -0400
Received: from timo-desktop.lan.xusig.net (i59F4D773.versanet.de [89.244.215.115])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id D30D5544DC00;
        Sat,  1 May 2021 14:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202012291009; t=1619872856;
        bh=OHjbJOgZC9lH9A5epG61N9yp14naYRxyoht5m0VTHWI=;
        h=From:To:Cc:Subject:Date:From;
        b=lIVpjwa8ThuKX8tZl5wayV9GigazbbnLffUUCuhtgTRFXrpUMvixVuHyRqy2XKXjj
         TSpZyjDwjFzExrJjHHTofcF5ndn91CxYWYr5wMhMoBpTmaR8en4aFjZC8AGWUP4m3l
         X8jSkpMneMEBXHtN5DTALbaDBY/k0LaWlm2NIMxPSRNGMXGspiyhl3VNR9v79D6frN
         pV7rMIod0G6X2HS6N9FmzjtiPp+A7AozvrvJY4bNZ1ab/zbrSJgrjfERgquS6bgqny
         LouM5+u5bP29CmTaWKCYxD0sOeCBvuUL0Gvd8ZYbwUVqYovfuNVqNs3no8BJT5UEg9
         199OdQGW9aq7g==
From:   Timo Sigurdsson <public_timo.s@silentcreek.de>
To:     axboe@kernel.dk, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, gregkh@linuxfoundation.org,
        oliver@schinagl.nl, Timo Sigurdsson <public_timo.s@silentcreek.de>
Subject: [PATCH v2] ata: ahci_sunxi: Disable DIPM
Date:   Sat,  1 May 2021 14:40:26 +0200
Message-Id: <20210501124026.8016-1-public_timo.s@silentcreek.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIPM is unsupported or broken on sunxi. Trying to enable the power
management policy med_power_with_dipm on an Allwinner A20 SoC based board
leads to immediate I/O errors and the attached SATA disk disappears from
the /dev filesystem. A reset (power cycle) is required to make the SATA
controller or disk work again. The A10 and A20 SoC data sheets and manuals
don't mention DIPM at all [1], so it's fair to assume that it's simply not
supported. But even if it was, it should be considered broken and best be
disabled in the ahci_sunxi driver.

[1] https://github.com/allwinner-zh/documents/tree/master/

Fixes: c5754b5220f0 ("ARM: sunxi: Add support for Allwinner SUNXi SoCs sata to ahci_platform")
Cc: stable@vger.kernel.org
Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
Tested-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
Changes since v1:

- Formal changes to the commit message as suggested by Greg Kroah-Hartman
  and Sergei Shtylyov (Fixes and Cc lines). No changes to the patch
  itself.
---
 drivers/ata/ahci_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index cb69b737cb49..56b695136977 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -200,7 +200,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 }
 
 static const struct ata_port_info ahci_sunxi_port_info = {
-	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ | ATA_FLAG_NO_DIPM,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_platform_ops,
-- 
2.26.2

