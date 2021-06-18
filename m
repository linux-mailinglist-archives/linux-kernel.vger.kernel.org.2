Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E543ACE78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhFRPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:19:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:43908 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234925AbhFRPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:19:03 -0400
IronPort-SDR: OA/tR/XljH3S3KuoI3dZ+F27stmNUrd3J0W2zl/ph0e/9opcivtx/mFTI2K6VDyCSNgs5fGVNP
 CqBM2eD+5EeQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203545123"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="203545123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:49 -0700
IronPort-SDR: l88ugZuCTd4LwDkS8RN7RX9Z/0a1zHb350z8eo2TeAkQJZJbyupWEnUHf0+3eui2WV1N1GTK5K
 DEKir6tpoI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="416470877"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2021 08:16:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A0A45B5; Fri, 18 Jun 2021 18:17:08 +0300 (EEST)
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
Subject: [PATCH v1 7/7] irqchip/mvebu-odmi: Switch to bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:57 +0300
Message-Id: <20210618151657.65305-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-mvebu-odmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index b4d367868dbb..dc4145abdd6f 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -171,8 +171,7 @@ static int __init mvebu_odmi_init(struct device_node *node,
 	if (!odmis)
 		return -ENOMEM;
 
-	odmis_bm = kcalloc(BITS_TO_LONGS(odmis_count * NODMIS_PER_FRAME),
-			   sizeof(long), GFP_KERNEL);
+	odmis_bm = bitmap_zalloc(odmis_count * NODMIS_PER_FRAME, GFP_KERNEL);
 	if (!odmis_bm) {
 		ret = -ENOMEM;
 		goto err_alloc;
@@ -227,7 +226,7 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		if (odmi->base && !IS_ERR(odmi->base))
 			iounmap(odmis[i].base);
 	}
-	kfree(odmis_bm);
+	bitmap_free(odmis_bm);
 err_alloc:
 	kfree(odmis);
 	return ret;
-- 
2.30.2

