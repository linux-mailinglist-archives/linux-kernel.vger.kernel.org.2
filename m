Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7073941B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhE1LXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:23:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:12516 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhE1LW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:22:57 -0400
IronPort-SDR: dxcbUZnG3uqVXIFW6sB/i6uMupGiii5OdKIE/u7JdcWucUKpxeS5NugBVDNRPm3uUCB3ND8ATQ
 ytjAg0AvsEZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288533842"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="288533842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 04:21:15 -0700
IronPort-SDR: GR9HmPT2mOu9B0Ab4gomttduBoKfGYzBrPo8k9GtVllk+Q13e4U3wKtKnx7aZjDf6kivuYtxgw
 Cs4wHloFsQqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="443963847"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2021 04:21:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F5FB3B6; Fri, 28 May 2021 14:21:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mmc: mmc_spi: Imply container_of() to be no-op
Date:   Fri, 28 May 2021 14:21:27 +0300
Message-Id: <20210528112127.71738-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
References: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't use structure field layout randomization
the manual shuffling can affect some macros, in particular
container_of() against struct of_mmc_spi, which becomes
a no-op when pdata member is the first one in the structure.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/of_mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 9d480a05f655..3629550528b6 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -22,8 +22,8 @@
 MODULE_LICENSE("GPL");
 
 struct of_mmc_spi {
-	int detect_irq;
 	struct mmc_spi_platform_data pdata;
+	int detect_irq;
 };
 
 static struct of_mmc_spi *to_of_mmc_spi(struct device *dev)
-- 
2.30.2

