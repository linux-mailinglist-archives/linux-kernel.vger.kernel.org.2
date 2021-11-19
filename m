Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55C456AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhKSHma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:42:30 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39073 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhKSHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:42:28 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPA id DC69A20009;
        Fri, 19 Nov 2021 07:39:24 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/4] mtd: rawnand: fsmc: Fix timing computation
Date:   Fri, 19 Nov 2021 08:39:09 +0100
Message-Id: <20211119073909.1492538-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119073909.1492538-1-herve.codina@bootlin.com>
References: <20211119073909.1492538-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain circumstances, the timing settings calculated by
the FSMC NAND controller driver were inaccurate.
These settings lead to incorrect data reads or fallback to
mode 0 timings depending on NAND chip used.

The timing computation did not take into account the following
constraint given in SPEAr3xx reference manual:
  twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL

Enhance the timings calculation by taking into account this
additional constraint.

The change has no impact on slow timing mode such as mode 0.
Indeed, on mode 0 timing, computed values are the same with and
without the patch.

The NAND that previously used the mode 0 fallback timing is
working in mode 3 timing.
The read/writes accesses performances (flash_speed tool result)
are the following:
                        mode0       mode3
eraseblock write speed  3220 KiB/s  4511 KiB/s
eraseblock read speed   4491 KiB/s  7529 KiB/s

The NAND where data reads were previously incorrect are correct
and this NAND is also working at mode 3 timing.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 to v2:
- Commit log reword
- Added performance details in commit log
- Used #define for TOUTDEL and TINDEL and
  Fixed coding style
- Used max3()

 drivers/mtd/nand/raw/fsmc_nand.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 0a6c9ef0ea8b..56b9da252346 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -94,6 +94,14 @@
 
 #define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
 
+/*
+ * According to SPEAr300 Reference Manual (RM0082)
+ *  TOUDEL = 7ns (Output delay from the flip-flops to the board)
+ *  TINDEL = 5ns (Input delay from the board to the flipflop)
+ */
+#define TOUTDEL	7000
+#define TINDEL	5000
+
 struct fsmc_nand_timings {
 	u8 tclr;
 	u8 tar;
@@ -278,7 +286,7 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 {
 	unsigned long hclk = clk_get_rate(host->clk);
 	unsigned long hclkn = NSEC_PER_SEC / hclk;
-	u32 thiz, thold, twait, tset;
+	u32 thiz, thold, twait, tset, twait_min;
 
 	if (sdrt->tRC_min < 30000)
 		return -EOPNOTSUPP;
@@ -310,13 +318,6 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
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
@@ -325,6 +326,21 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
 	else if (tims->tset > FSMC_TSET_MASK)
 		tims->tset = FSMC_TSET_MASK;
 
+	/*
+	 * According to SPEAr300 Reference Manual (RM0082) which gives more
+	 * information related to FSMSC timings than the SPEAr600 one (RM0305),
+	 *   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL
+	 */
+	twait_min = sdrt->tCEA_max - ((tims->tset + 1) * hclkn * 1000)
+		    + TOUTDEL + TINDEL;
+	twait = max3(sdrt->tRP_min, sdrt->tWP_min, twait_min);
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

