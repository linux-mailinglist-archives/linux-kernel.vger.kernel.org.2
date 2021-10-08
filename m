Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D7426E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhJHQYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:24:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59123 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhJHQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:24:32 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CFF2024000B;
        Fri,  8 Oct 2021 16:22:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RFC PATCH 01/10] mtd: spinand: Fix comment
Date:   Fri,  8 Oct 2021 18:22:19 +0200
Message-Id: <20211008162228.1753083-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a copy paste error, checking the ECC status finishes a page read
here, not a page write.

Fixes: 945845b54c9c ("mtd: spinand: Instantiate a SPI-NAND on-die ECC engine")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index dd903d61c7c0..9655b3ef7cc2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -307,7 +307,7 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 	if (req->type == NAND_PAGE_WRITE)
 		return 0;
 
-	/* Finish a page write: check the status, report errors/bitflips */
+	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, engine_conf->status);
 	if (ret == -EBADMSG)
 		mtd->ecc_stats.failed++;
-- 
2.27.0

