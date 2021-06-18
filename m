Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D363ACE76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhFRPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:19:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:14914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234909AbhFRPS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:18:59 -0400
IronPort-SDR: gDupM/xJrdjgGXrWXDTGfIwi5H/U+C58vZnz5Ua1zdh304oCeP8u1q1ONQpLbtZe1CFN/raxyC
 p/cX474R1GBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206608301"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206608301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:49 -0700
IronPort-SDR: wRUYq2tY94H9uf/fve+Yd18pcLRgHVg2dDTdtx+3HRfbonck/TIWds9vhn2Iha71nVrHduz5U9
 o42zTKb7TyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="489096683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2021 08:16:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0ED96580; Fri, 18 Jun 2021 18:17:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v1 6/7] irqchip/mvebu-gicp: Switch to devm_bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:56 +0300
Message-Id: <20210618151657.65305-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-mvebu-gicp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 3be5c5dba1da..fe88a782173d 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -210,9 +210,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		gicp->spi_cnt += gicp->spi_ranges[i].count;
 	}
 
-	gicp->spi_bitmap = devm_kcalloc(&pdev->dev,
-				BITS_TO_LONGS(gicp->spi_cnt), sizeof(long),
-				GFP_KERNEL);
+	gicp->spi_bitmap = devm_bitmap_zalloc(&pdev->dev, gicp->spi_cnt, GFP_KERNEL);
 	if (!gicp->spi_bitmap)
 		return -ENOMEM;
 
-- 
2.30.2

