Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8341C33E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbhI2LTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:19:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:9145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244819AbhI2LTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:19:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204405384"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="204405384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 04:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="479227106"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Sep 2021 04:17:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9CA529D; Wed, 29 Sep 2021 14:18:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/2] mmc: slot-gpio: Refactor mmc_gpio_alloc()
Date:   Wed, 29 Sep 2021 14:17:56 +0300
Message-Id: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor mmc_gpio_alloc() to drop unneeded indentation level
and double condition. This increases readability of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/slot-gpio.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 05e907451df9..e365d328f43c 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -39,24 +39,24 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 
 int mmc_gpio_alloc(struct mmc_host *host)
 {
-	struct mmc_gpio *ctx = devm_kzalloc(host->parent,
-					    sizeof(*ctx), GFP_KERNEL);
-
-	if (ctx) {
-		ctx->cd_debounce_delay_ms = 200;
-		ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL,
-				"%s cd", dev_name(host->parent));
-		if (!ctx->cd_label)
-			return -ENOMEM;
-		ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL,
-				"%s ro", dev_name(host->parent));
-		if (!ctx->ro_label)
-			return -ENOMEM;
-		host->slot.handler_priv = ctx;
-		host->slot.cd_irq = -EINVAL;
-	}
+	const char *devname = dev_name(host->parent);
+	struct mmc_gpio *ctx;
+
+	ctx = devm_kzalloc(host->parent, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->cd_debounce_delay_ms = 200;
+	ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL, "%s cd", devname);
+	if (!ctx->cd_label)
+		return -ENOMEM;
+	ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL, "%s ro", devname);
+	if (!ctx->ro_label)
+		return -ENOMEM;
+	host->slot.handler_priv = ctx;
+	host->slot.cd_irq = -EINVAL;
 
-	return ctx ? 0 : -ENOMEM;
+	return 0;
 }
 
 int mmc_gpio_get_ro(struct mmc_host *host)
-- 
2.33.0

