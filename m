Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626933ACE72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhFRPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:18:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:53199 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234897AbhFRPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:18:55 -0400
IronPort-SDR: 5abcgMKnha8WjCz/UR8q6bBVkeH6+RtasFpE8csmZml4x6XlxY1QHbOHi4HtMTBFeJMPnQEcBJ
 IHOvnZpMXJFg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="267713573"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="267713573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:45 -0700
IronPort-SDR: bUWn2aZ+KSWpqGLPniPUe4ytW8LWunC0LMYg7GeZzOY+uZJ6s1xAlopJsW03gj+ZFxbdxB1zFN
 JAUSB3pDdGQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451423868"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2021 08:16:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EBEA450E; Fri, 18 Jun 2021 18:17:07 +0300 (EEST)
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
Subject: [PATCH v1 4/7] irqchip/gic-v3: Switch to bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:54 +0300
Message-Id: <20210618151657.65305-4-andriy.shevchenko@linux.intel.com>
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
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++-----
 drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ba39668c3e08..daa5b1c968f0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2140,7 +2140,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
+	bitmap = bitmap_zalloc(nr_irqs, GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
@@ -2156,7 +2156,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
-	kfree(bitmap);
+	bitmap_free(bitmap);
 }
 
 static void gic_reset_prop_table(void *va)
@@ -3376,8 +3376,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
-			col_map = kcalloc(nr_lpis, sizeof(*col_map),
-					  GFP_KERNEL);
+			col_map = kcalloc(nr_lpis, sizeof(*col_map), GFP_KERNEL);
 	} else {
 		col_map = kcalloc(nr_ites, sizeof(*col_map), GFP_KERNEL);
 		nr_lpis = 0;
@@ -3387,7 +3386,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
 		kfree(dev);
 		kfree(itt);
-		kfree(lpi_map);
+		bitmap_free(lpi_map);
 		kfree(col_map);
 		return NULL;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e81e89a81cb5..b84c9c2eccdc 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -290,8 +290,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 		if (ret)
 			goto err_free_mbi;
 
-		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
-					   sizeof(long), GFP_KERNEL);
+		mbi_ranges[n].bm = bitmap_zalloc(mbi_ranges[n].nr_spis, GFP_KERNEL);
 		if (!mbi_ranges[n].bm) {
 			ret = -ENOMEM;
 			goto err_free_mbi;
@@ -329,7 +328,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 err_free_mbi:
 	if (mbi_ranges) {
 		for (n = 0; n < mbi_range_nr; n++)
-			kfree(mbi_ranges[n].bm);
+			bitmap_free(mbi_ranges[n].bm);
 		kfree(mbi_ranges);
 	}
 
-- 
2.30.2

