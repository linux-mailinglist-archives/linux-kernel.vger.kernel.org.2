Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEE44E91A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhKLOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:42:34 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53897 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhKLOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:42:33 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 30CFF40005;
        Fri, 12 Nov 2021 14:39:41 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4/4] mtd: rawnand: fsmc: Fix timing computation
Date:   Fri, 12 Nov 2021 15:38:55 +0100
Message-Id: <20211112143855.2678989-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211112143855.2678989-1-herve.codina@bootlin.com>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timing setting were incorrect on some nands leading to a
fallback to mode 0 timing on some Micron nand or to incorrect
data reads on some Winbond NAND.

The timing computation did not take into account the following
constraint given in SPEAr3xx reference manual:
  twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL

This patch adds this constraint and fixes the issues on both
nands having the both nands working at mode 3 timing.
The change has no impact on slower timing mode such as mode 0.
Indeed, on mode 0 timing, computed values are the same with and
without the patch.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index bff09219ce3a..a3aa66f30869 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -278,7 +278,7 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 {
 	unsigned long hclk = clk_get_rate(host->clk);
 	unsigned long hclkn = NSEC_PER_SEC / hclk;
-	u32 thiz, thold, twait, tset;
+	u32 thiz, thold, twait, tset, tmp;
 
 	if (sdrt->tRC_min < 30000)
 		return -EOPNOTSUPP;
@@ -310,13 +310,6 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 	else if (tims->thold > FSMC_THOLD_MASK)
 		tims->thold = FSMC_THOLD_MASK;
 
-	twait = max(sdrt->tRP_min, sdrt->tWP_min);
-	tims->twait = DIV_ROUND_UP(twait / 1000, hclkn) - 1;
-	if (tims->twait == 0)
-		tims->twait = 1;
-	else if (tims->twait > FSMC_TWAIT_MASK)
-		tims->twait = FSMC_TWAIT_MASK;
-
 	tset = max(sdrt->tCS_min - sdrt->tWP_min,
 		   sdrt->tCEA_max - sdrt->tREA_max);
 	tims->tset = DIV_ROUND_UP(tset / 1000, hclkn) - 1;
@@ -325,6 +318,24 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 	else if (tims->tset > FSMC_TSET_MASK)
 		tims->tset = FSMC_TSET_MASK;
 
+	twait = max(sdrt->tRP_min, sdrt->tWP_min);
+
+	/* According to SPEAr300 Reference Manual (RM0082) which gives more
+	 * information related to FSMSC timings than the SPEAr600 one (RM0305),
+	 *   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL
+	 * With TOUTDEL = 7ns (Output delay from the flip-flops to the board)
+	 * and TINDEL = 5ns (Input delay from the board to the flipflop)
+	 */
+	tmp = sdrt->tCEA_max - (tims->tset + 1)*hclkn*1000 + 7000 + 5000;
+	if (twait < tmp)
+		twait = tmp;
+
+	tims->twait = DIV_ROUND_UP(twait / 1000, hclkn) - 1;
+	if (tims->twait == 0)
+		tims->twait = 1;
+	else if (tims->twait > FSMC_TWAIT_MASK)
+		tims->twait = FSMC_TWAIT_MASK;
+
 	return 0;
 }
 
-- 
2.31.1

