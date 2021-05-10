Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C503790C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhEJOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:30:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:23270 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238879AbhEJOZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:25:34 -0400
IronPort-SDR: vpMqDYCCXk3v1WDiD5HkJPlxp7iHuAcB+438ihgH1nOdVtYSUnedjgWgyj9FuOaK7I3oqph0K3
 IKDvsc3A06rQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199274797"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199274797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:13:35 -0700
IronPort-SDR: ltyKADyv74sqKrk8pGvheocmbjUB7aNZEfOIcMJovcY7sl2QrkPQT5cbebQDDxNRdIFUOA6ePH
 UDkpw80MBNEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="541231325"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2021 07:13:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 628D0142; Mon, 10 May 2021 17:13:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: spi-nor: Use SPI_MODE_X_MASK
Date:   Mon, 10 May 2021 17:13:43 +0300
Message-Id: <20210510141343.56805-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPI_MODE_X_MASK instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/spi-nor/controllers/nxp-spifi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
index 5703e8313980..2635c80231bb 100644
--- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -326,7 +326,7 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
 		ctrl |= SPIFI_CTRL_DUAL;
 	}
 
-	switch (mode & (SPI_CPHA | SPI_CPOL)) {
+	switch (mode & SPI_MODE_X_MASK) {
 	case SPI_MODE_0:
 		ctrl &= ~SPIFI_CTRL_MODE3;
 		break;
-- 
2.30.2

