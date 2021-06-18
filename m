Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11C03ACE77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhFRPTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:19:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:43908 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234920AbhFRPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:19:03 -0400
IronPort-SDR: /3jSNezd0wL0zAb2PA1OCN8ndt06+tqXOIerH1Wp8mUVZ9ZTNNV96y1iee6fGNQAjqV/v8g2tc
 oxfHuAHJdaTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203545112"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="203545112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:46 -0700
IronPort-SDR: 5xNIyIt+KVgy6vf8LLlD2o/7eztn5hWSJlPn67HksO+ShYXYRgk3m7E63O9iX+i25TReGNrqHl
 XUMt/FBWvtRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="416470862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2021 08:16:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03553516; Fri, 18 Jun 2021 18:17:07 +0300 (EEST)
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
Subject: [PATCH v1 5/7] irqchip/ls-scfg-msi: Switch to devm_bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:55 +0300
Message-Id: <20210618151657.65305-5-andriy.shevchenko@linux.intel.com>
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
 drivers/irqchip/irq-ls-scfg-msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 55322da51c56..b4927e425f7b 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -362,10 +362,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->irqs_num = MSI_IRQS_PER_MSIR *
 			     (1 << msi_data->cfg->ibs_shift);
-	msi_data->used = devm_kcalloc(&pdev->dev,
-				    BITS_TO_LONGS(msi_data->irqs_num),
-				    sizeof(*msi_data->used),
-				    GFP_KERNEL);
+	msi_data->used = devm_bitmap_zalloc(&pdev->dev, msi_data->irqs_num, GFP_KERNEL);
 	if (!msi_data->used)
 		return -ENOMEM;
 	/*
-- 
2.30.2

