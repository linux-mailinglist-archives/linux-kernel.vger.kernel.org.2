Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE033790C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbhEJO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:29:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:19196 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233430AbhEJOX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:23:57 -0400
IronPort-SDR: sBILr2agu6CkLeGn0N+ahXYPU4XyUkNhLWYaKdneBUJF7DA52x4hB0xtjDxrbe7i5+Vvx6PLHb
 H2RlUiMA9ELA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197219818"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="197219818"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:13:20 -0700
IronPort-SDR: 8q69t8T4cd7Pz9kBtIzR0hiOEIAY2sWWrQYiZe4Y7dO2oo7IIjibHqXevhGAWAxGCjIdDPX9+q
 7Ealoa2ujhgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="408365690"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2021 07:13:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1492D142; Mon, 10 May 2021 17:13:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrej Picej <andpicej@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hwmon: (lm70) Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 17:13:31 +0300
Message-Id: <20210510141331.56736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPI_MODE_X_MASK instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/lm70.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 40eab3349904..cdf23a59a203 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -184,7 +184,7 @@ static int lm70_probe(struct spi_device *spi)
 
 
 	/* signaling is SPI_MODE_0 */
-	if (spi->mode & (SPI_CPOL | SPI_CPHA))
+	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
 		return -EINVAL;
 
 	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
-- 
2.30.2

