Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13B3A5DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhFNHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:37:45 -0400
Received: from dd20004.kasserver.com ([85.13.150.92]:43012 "EHLO
        dd20004.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhFNHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:37:42 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 03:37:42 EDT
Received: from timo-desktop.lan.xusig.net (i59F4DBF8.versanet.de [89.244.219.248])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id 80EBD544DC36;
        Mon, 14 Jun 2021 09:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202012291009; t=1623655553;
        bh=OHjbJOgZC9lH9A5epG61N9yp14naYRxyoht5m0VTHWI=;
        h=From:To:Cc:Subject:Date:From;
        b=WJj5DqKi3Zr3v5hMU/B/hcW1un+Ce8pqwsBmdMoLBp5tRg8q9LOHCDI8p8nc63xXV
         wLc5YHSvGXLpuwBQgw/WxmdJNUR1JImtsU6nNO8Xx8IxyLWl90di4OCiQB8Ch4LhbR
         jNMz/SMUPi4OOognGlPGdKrFwCrDrcUbuhxeOjp2lQKWgkOMDFOjRrCPxxqrfRjq8t
         VdV999w5z1Lh644UIUcMD9brsZA5VUN8phsKei5lQf763M/PPo2Mjd36+IFLfZCBru
         z+FmK3IONxe1lMnODWEUIifk5TnFC1XP2x8CmCJH3II3FFjtJUcHuFZIa/kVoobiWl
         UONMAyffUr+Cw==
From:   Timo Sigurdsson <public_timo.s@silentcreek.de>
To:     axboe@kernel.dk, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, gregkh@linuxfoundation.org,
        oliver@schinagl.nl, Timo Sigurdsson <public_timo.s@silentcreek.de>
Subject: [PATCH v2 RESEND] ata: ahci_sunxi: Disable DIPM
Date:   Mon, 14 Jun 2021 09:25:39 +0200
Message-Id: <20210614072539.3307-1-public_timo.s@silentcreek.de>
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

