Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00C63502E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhCaPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:00:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:16015 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235758AbhCaO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:59:29 -0400
IronPort-SDR: E5Cq8P32AScGRBHhoaoAiZPQv63oR1H3SSm4/CWuvbOYHWt5bz+iV3Q12JxLDM2Gpd0CaU2Xce
 NibaXYWqx8Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="189790367"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="189790367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 07:59:27 -0700
IronPort-SDR: GJPXOEHOAdm/8CThKFVkyZWknZq7eAgUwKeDG7Z0bRgYGNNyBGSv8P0fQfLziU3VbT0QPRmnsw
 3B3T9Q/0zYkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="438836826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2021 07:59:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1AC2A199; Wed, 31 Mar 2021 17:59:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: platform: Make clear error code used for missed IRQ
Date:   Wed, 31 Mar 2021 17:59:36 +0300
Message-Id: <20210331145937.35980-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have few code paths where same error code is assigned and
returned for missed IRQ. Unify that under single error path.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d82db3eabcd4..1e61fac64435 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -174,7 +174,7 @@ static int platform_do_get_irq(struct platform_device *dev, unsigned int num)
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		return -ENXIO;
+		goto out_not_found;
 	ret = dev->archdata.irqs[num];
 	goto out;
 #else
@@ -205,10 +205,8 @@ static int platform_do_get_irq(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd) {
-			ret = -ENXIO;
-			goto out;
-		}
+		if (!irqd)
+			goto out_not_found;
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
@@ -231,8 +229,9 @@ static int platform_do_get_irq(struct platform_device *dev, unsigned int num)
 			goto out;
 	}
 
-	ret = -ENXIO;
 #endif
+out_not_found:
+	ret = -ENXIO;
 out:
 	WARN(ret == 0, "0 is an invalid IRQ number\n");
 	return ret;
-- 
2.30.2

