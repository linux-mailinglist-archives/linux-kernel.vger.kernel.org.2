Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43F41BA06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbhI1WRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:17:07 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54321 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbhI1WQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:16:53 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 248731C0004;
        Tue, 28 Sep 2021 22:15:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/8] mtd: rawnand: Let callers use the bare Hamming helpers
Date:   Wed, 29 Sep 2021 00:15:01 +0200
Message-Id: <20210928221507.199198-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928221507.199198-1-miquel.raynal@bootlin.com>
References: <20210928221507.199198-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Enhancing the implementation of the rawnand_ecc_sw_* helpers to support
both cases, when the ECC object is instantiated and when it is not is a
quite elegant way to solve this situation. This way, we can still use
the existing and exported rawnand helpers while avoiding the need for
each driver to declare its own helper.

Following this change, most of the fixes sent in [2] can now be safely
reverted. Only the fsmc fix will need to be kept because there is
actually something specific to the driver to do in its ->correct()
helper.

[1] https://lore.kernel.org/lkml/CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com/
[2] https://lore.kernel.org/linux-mtd/20210413161840.345208-1-miquel.raynal@bootlin.com/

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc-sw-hamming.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/ecc-sw-hamming.c b/drivers/mtd/nand/ecc-sw-hamming.c
index a7655b668f32..254db2e7f8bb 100644
--- a/drivers/mtd/nand/ecc-sw-hamming.c
+++ b/drivers/mtd/nand/ecc-sw-hamming.c
@@ -364,9 +364,9 @@ int nand_ecc_sw_hamming_calculate(struct nand_device *nand,
 {
 	struct nand_ecc_sw_hamming_conf *engine_conf = nand->ecc.ctx.priv;
 	unsigned int step_size = nand->ecc.ctx.conf.step_size;
+	bool sm_order = engine_conf ? engine_conf->sm_order : false;
 
-	return ecc_sw_hamming_calculate(buf, step_size, code,
-					engine_conf->sm_order);
+	return ecc_sw_hamming_calculate(buf, step_size, code, sm_order);
 }
 EXPORT_SYMBOL(nand_ecc_sw_hamming_calculate);
 
@@ -457,9 +457,10 @@ int nand_ecc_sw_hamming_correct(struct nand_device *nand, unsigned char *buf,
 {
 	struct nand_ecc_sw_hamming_conf *engine_conf = nand->ecc.ctx.priv;
 	unsigned int step_size = nand->ecc.ctx.conf.step_size;
+	bool sm_order = engine_conf ? engine_conf->sm_order : false;
 
 	return ecc_sw_hamming_correct(buf, read_ecc, calc_ecc, step_size,
-				      engine_conf->sm_order);
+				      sm_order);
 }
 EXPORT_SYMBOL(nand_ecc_sw_hamming_correct);
 
-- 
2.27.0

