Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECD3ACE71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhFRPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:18:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:14914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234882AbhFRPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:18:55 -0400
IronPort-SDR: BWbsBahrcqGjPHJiR8f7BqtbbeTE6m4e5XjfrwYi/o03h0pPia6zu/QO2darlnec8LUFKlf4Rz
 hJ+g8tDXN53A==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206608291"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206608291"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:45 -0700
IronPort-SDR: UIfXERg0PegMnxreJLGLGSTeFjZWHu54VoWUtl+TkHnmFHqI7FWgA5fxnRjlFqziSiQGjyhYf6
 BIe+Lq4+sodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554764722"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2021 08:16:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDAEA65; Fri, 18 Jun 2021 18:17:07 +0300 (EEST)
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
Subject: [PATCH v1 2/7] irqchip/alpine-msi: Switch to bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:52 +0300
Message-Id: <20210618151657.65305-2-andriy.shevchenko@linux.intel.com>
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
 drivers/irqchip/irq-alpine-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index ede02dc2bcd0..5ddb8e578ac6 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -267,9 +267,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
+	priv->msi_map = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret = -ENOMEM;
 		goto err_priv;
@@ -285,7 +283,7 @@ static int alpine_msix_init(struct device_node *node,
 	return 0;
 
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;
-- 
2.30.2

