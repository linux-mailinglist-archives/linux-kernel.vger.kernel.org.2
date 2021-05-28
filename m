Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB23941B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhE1LW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:22:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:10564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhE1LWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:22:54 -0400
IronPort-SDR: oEpJFh/xL2ynRSulXTbMkh/8omfRfEZiC02XrKvJjPrlu4SMm3D/iVP0+1xkeAoeupN4VLGEn/
 7e3P3slQ2Gqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="190309419"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="190309419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 04:21:12 -0700
IronPort-SDR: GwBp7j8AA09JggSbtLsNAJ8msgeQLY/f7WuKXrA5lHaWsoGmWbdkAOVREhA+mgjX35mdWolj8m
 DyJ+K5w+csyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="547955919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2021 04:21:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9E6D33B6; Fri, 28 May 2021 14:21:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mmc: mmc_spi: Drop duplicate 'mmc_spi' in the debug messages
Date:   Fri, 28 May 2021 14:21:26 +0300
Message-Id: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_dbg() in any case prints the device and driver name, no need
to repeat this in (some) messages. Drop duplicates for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 9776a03a10f5..65c65bb5737f 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -504,7 +504,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
 		/* else:  R1 (most commands) */
 	}
 
-	dev_dbg(&host->spi->dev, "  mmc_spi: CMD%d, resp %s\n",
+	dev_dbg(&host->spi->dev, "  CMD%d, resp %s\n",
 		cmd->opcode, maptype(cmd));
 
 	/* send command, leaving chipselect active */
@@ -928,8 +928,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		while (length) {
 			t->len = min(length, blk_size);
 
-			dev_dbg(&host->spi->dev,
-				"    mmc_spi: %s block, %d bytes\n",
+			dev_dbg(&host->spi->dev, "    %s block, %d bytes\n",
 				(direction == DMA_TO_DEVICE) ? "write" : "read",
 				t->len);
 
@@ -974,7 +973,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		int		tmp;
 		const unsigned	statlen = sizeof(scratch->status);
 
-		dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
+		dev_dbg(&spi->dev, "    STOP_TRAN\n");
 
 		/* Tweak the per-block message we set up earlier by morphing
 		 * it to hold single buffer with the token followed by some
@@ -1175,7 +1174,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		canpower = host->pdata && host->pdata->setpower;
 
-		dev_dbg(&host->spi->dev, "mmc_spi: power %s (%d)%s\n",
+		dev_dbg(&host->spi->dev, "power %s (%d)%s\n",
 				mmc_powerstring(ios->power_mode),
 				ios->vdd,
 				canpower ? ", can switch" : "");
@@ -1248,8 +1247,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		host->spi->max_speed_hz = ios->clock;
 		status = spi_setup(host->spi);
-		dev_dbg(&host->spi->dev,
-			"mmc_spi:  clock to %d Hz, %d\n",
+		dev_dbg(&host->spi->dev, "  clock to %d Hz, %d\n",
 			host->spi->max_speed_hz, status);
 	}
 }
-- 
2.30.2

