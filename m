Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA11C41BA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbhI1WRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:17:24 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48779 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbhI1WQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:16:55 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A9FF91C000B;
        Tue, 28 Sep 2021 22:15:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6/8] Revert "mtd: rawnand: ndfc: Fix external use of SW Hamming ECC helper"
Date:   Wed, 29 Sep 2021 00:15:05 +0200
Message-Id: <20210928221507.199198-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928221507.199198-1-miquel.raynal@bootlin.com>
References: <20210928221507.199198-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3e09c0252501829b14b10f14e1982aaab77d0b80.

Before the introduction of the ECC framework infrastructure, many
drivers used the ->calculate/correct() Hamming helpers directly. The
point of this framework was to avoid this kind of hackish calls and use a
proper and generic API but it is true that in certain cases, drivers
still need to use these helpers in order to do ECC computations on
behalf of their limited hardware.

Right after the introduction of the ECC engine core introduction, it was
spotted that it was not possible to use the shiny rawnand software ECC
helpers so easily because an ECC engine object should have been
allocated and initialized first. While this works well in most cases,
for these drivers just leveraging the power of a single helper in
conjunction with some pretty old and limited hardware, it did not fit.

The idea back then was to declare intermediate helpers which would make
use of the exported software ECC engine bare functions while keeping the
rawnand layer compatibility. As there was already functions with the
rawnand_sw_hamming_ prefix it was decided to declare new local helpers
for this purpose in each driver needing one.

Besides being far from optimal, this design choice was blamed by Linus
when he pulled the "fixes" pull request [1] so that is why now it is
time to clean this mess up.

The implementation of the rawnand_ecc_sw_* helpers has now been enhanced
to support both cases, when the ECC object is instantiated and when it is
not. This way, we can still use the existing and exported rawnand
helpers while avoiding the need for each driver to declare its own
helper, thus this fix from [2] can now be safely reverted.

[1] https://lore.kernel.org/lkml/CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com/
[2] https://lore.kernel.org/linux-mtd/20210413161840.345208-1-miquel.raynal@bootlin.com

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/ndfc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 98d5a94c3a24..338d6b1a189e 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -22,7 +22,6 @@
 #include <linux/mtd/ndfc.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/nand-ecc-sw-hamming.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <asm/io.h>
@@ -101,15 +100,6 @@ static int ndfc_calculate_ecc(struct nand_chip *chip,
 	return 0;
 }
 
-static int ndfc_correct_ecc(struct nand_chip *chip,
-			    unsigned char *buf,
-			    unsigned char *read_ecc,
-			    unsigned char *calc_ecc)
-{
-	return ecc_sw_hamming_correct(buf, read_ecc, calc_ecc,
-				      chip->ecc.size, false);
-}
-
 /*
  * Speedups for buffer read/write/verify
  *
@@ -155,7 +145,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->controller = &ndfc->ndfc_control;
 	chip->legacy.read_buf = ndfc_read_buf;
 	chip->legacy.write_buf = ndfc_write_buf;
-	chip->ecc.correct = ndfc_correct_ecc;
+	chip->ecc.correct = rawnand_sw_hamming_correct;
 	chip->ecc.hwctl = ndfc_enable_hwecc;
 	chip->ecc.calculate = ndfc_calculate_ecc;
 	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
-- 
2.27.0

