Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018883ACE74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhFRPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:19:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:21712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhFRPS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:18:57 -0400
IronPort-SDR: vIgLUz6ppCFf1Im/HJmuE0P84vjIGLgS1JRmSNIWWXh98D4ztH2O1Y89IAK/dgfFrqdeKWGVol
 jAt02KjsuMHA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="292198270"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="292198270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:16:45 -0700
IronPort-SDR: MnDAIQ1s5CO6BrbYYxwt4okj6XfWmoA+g4scyFsxt8SUxSr57N/HIlASk6B9MiTcq7Txyg6yFX
 F2HLK5/PTqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="453180745"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2021 08:16:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5A9C2AA; Fri, 18 Jun 2021 18:17:07 +0300 (EEST)
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
Subject: [PATCH v1 1/7] irqchip: Switch to bitmap_zalloc()
Date:   Fri, 18 Jun 2021 18:16:51 +0300
Message-Id: <20210618151657.65305-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-partition-percpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 89c23a1566dc..8e76d2913e6b 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -215,8 +215,7 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 		goto out;
 	desc->domain = d;
 
-	desc->bitmap = kcalloc(BITS_TO_LONGS(nr_parts), sizeof(long),
-			       GFP_KERNEL);
+	desc->bitmap = bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
 		goto out;
 
-- 
2.30.2

