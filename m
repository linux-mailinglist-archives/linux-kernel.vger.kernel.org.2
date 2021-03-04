Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AD32D509
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhCDOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:10:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:53561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhCDOKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:10:17 -0500
IronPort-SDR: 7HWuy3FHYCL79UGPh/JbllUv6gXJGYXFomCoL51a1IojsZSMDefXeUSAOV2JoQHOyVGf+VbZpm
 BfmF0bbfBkqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="184047580"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="184047580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 06:08:31 -0800
IronPort-SDR: 02+rxAD9CzE71lZ5ajR74ZwXJM1eBqPqdf+tv2E3DmuYynN9BlsmKsR+OmK/EczcVRBxLPBIJw
 H26alurPbbOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="368193323"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2021 06:08:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1E641F1; Thu,  4 Mar 2021 16:08:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] mtd: spi-nor: intel-spi: Move platform data header to x85 subfolder
Date:   Thu,  4 Mar 2021 16:08:20 +0200
Message-Id: <20210304140820.56692-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to group x86 related platform data move intel-spi.h to x85 folder.

While at it, remove duplicate inclusion in C file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c       | 1 -
 drivers/mtd/spi-nor/controllers/intel-spi.h       | 2 +-
 include/linux/mfd/lpc_ich.h                       | 2 +-
 include/linux/platform_data/{ => x86}/intel-spi.h | 0
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename include/linux/platform_data/{ => x86}/intel-spi.h (100%)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index b54a56a68100..a413892ff449 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -15,7 +15,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
-#include <linux/platform_data/intel-spi.h>
 
 #include "intel-spi.h"
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
index e2f41b8827bf..f2871179fd34 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.h
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.h
@@ -9,7 +9,7 @@
 #ifndef INTEL_SPI_H
 #define INTEL_SPI_H
 
-#include <linux/platform_data/intel-spi.h>
+#include <linux/platform_data/x86/intel-spi.h>
 
 struct intel_spi;
 struct resource;
diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index 6ddca2bbb3a8..39967a5eca6d 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -8,7 +8,7 @@
 #ifndef LPC_ICH_H
 #define LPC_ICH_H
 
-#include <linux/platform_data/intel-spi.h>
+#include <linux/platform_data/x86/intel-spi.h>
 
 /* GPIO resources */
 #define ICH_RES_GPIO	0
diff --git a/include/linux/platform_data/intel-spi.h b/include/linux/platform_data/x86/intel-spi.h
similarity index 100%
rename from include/linux/platform_data/intel-spi.h
rename to include/linux/platform_data/x86/intel-spi.h
-- 
2.30.1

