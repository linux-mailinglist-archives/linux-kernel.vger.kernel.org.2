Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5C456B00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhKSHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:42:25 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33641 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhKSHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:42:23 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPA id 6AF6A2000D;
        Fri, 19 Nov 2021 07:39:20 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/4] mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface
Date:   Fri, 19 Nov 2021 08:39:07 +0100
Message-Id: <20211119073909.1492538-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119073909.1492538-1-herve.codina@bootlin.com>
References: <20211119073909.1492538-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the NV-DDR interface is not supported by the NAND chip,
the value of onfi->nvddr_timing_modes is 0. In this case,
the best_mode variable value in nand_choose_best_nvddr_timings()
is -1. The last for-loop is skipped and the function returns an
uninitialized value.
If this returned value is 0, the nand_choose_best_sdr_timings()
is not executed and no 'best timing' are set. This leads the host
controller and the NAND chip working at default mode 0 timing
even if a better timing can be used.

Fix this uninitialzed returned value.

nand_choose_best_sdr_timings() is pretty similar to
nand_choose_best_nvddr_timings(). Even if onfi->sdr_timing_modes
should never be seen as 0, nand_choose_best_sdr_timings() returned
value is fixed.

Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 to v2:
- New patch in v2 series

 drivers/mtd/nand/raw/nand_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 5c6b065837ef..a130320de412 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -926,7 +926,7 @@ int nand_choose_best_sdr_timings(struct nand_chip *chip,
 				 struct nand_sdr_timings *spec_timings)
 {
 	const struct nand_controller_ops *ops = chip->controller->ops;
-	int best_mode = 0, mode, ret;
+	int best_mode = 0, mode, ret = -EOPNOTSUPP;
 
 	iface->type = NAND_SDR_IFACE;
 
@@ -977,7 +977,7 @@ int nand_choose_best_nvddr_timings(struct nand_chip *chip,
 				   struct nand_nvddr_timings *spec_timings)
 {
 	const struct nand_controller_ops *ops = chip->controller->ops;
-	int best_mode = 0, mode, ret;
+	int best_mode = 0, mode, ret = -EOPNOTSUPP;
 
 	iface->type = NAND_NVDDR_IFACE;
 
-- 
2.31.1

