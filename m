Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4603ACE73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhFRPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:19:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:53192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234876AbhFRPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:18:55 -0400
IronPort-SDR: jGpCGrO63YXlUso0M5nKPHtmA3oy0m64GPr01DDx1gbkzK76uoYlEm0gropLwyw8OeAdKb3Olt
 bDHpZ9MCvOYw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="267713571"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="267713571"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:45 -0700
IronPort-SDR: FMZ/H460cl6HCD+Q5cecLc8TsIW79bsBdzpWK3cYkxs/+jO2P+6dP9d8d8Z95o5PZkYTP6XVgy
 jY6w1fnaX1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451423865"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2021 08:16:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E10D4431; Fri, 18 Jun 2021 18:17:07 +0300 (EEST)
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
Subject: [PATCH v1 3/7] irqchip/gic-v2m: Switch to bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:53 +0300
Message-Id: <20210618151657.65305-3-andriy.shevchenko@linux.intel.com>
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
 drivers/irqchip/irq-gic-v2m.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6fd6f8b..9349fc68b81a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -269,7 +269,7 @@ static void gicv2m_teardown(void)
 
 	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
 		list_del(&v2m->entry);
-		kfree(v2m->bm);
+		bitmap_free(v2m->bm);
 		iounmap(v2m->base);
 		of_node_put(to_of_node(v2m->fwnode));
 		if (is_fwnode_irqchip(v2m->fwnode))
@@ -386,8 +386,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 			break;
 		}
 	}
-	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
-			  GFP_KERNEL);
+	v2m->bm = bitmap_zalloc(v2m->nr_spis, GFP_KERNEL);
 	if (!v2m->bm) {
 		ret = -ENOMEM;
 		goto err_iounmap;
-- 
2.30.2

