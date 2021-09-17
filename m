Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF75440F727
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbhIQMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25689 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbhIQMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880419; x=1663416419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5FJhovyOTtqbY6WdesSmAErjuu4q8fe8jGDarYU7kM=;
  b=O2P9/AcoGH9UEjxNfQ1OKUZrt3fydoemWEBCI5VTGkgjupJL8icuwova
   /rpYmv8jcALcX2bgQt+bVRJxbdvkXO1ggIjnY3B7MS2qbHEwZ6JBJYhFU
   edp8IJ5WgihsT6tMQEzJmxGAGLYhUPIB2lenpKH/xwOeeHfsfZbKzEKg1
   qu5R+L/XB8EjBbLJiEZn+ebeZAo/CeUuP7JT9ihdrqdFqxGdF0BWlfuzI
   A27ce/bNT7HsWhsF/J3gJ3FqErIBoLNbOf9NUhqmjVTnuIVFbP7jDfrVc
   7SsWmtkxbKgrNuQtE6yN0cvLGtSp5uANJ8ub3sNaQ4YjMLqlnQtHNo2oO
   w==;
IronPort-SDR: LML5BFFWqDlY1y+RNjKbLJ2lw6lSTp6wfSE051HE5MMtzKCcNO3GfKtXz3yZ2GQ5MLXFwUuC7d
 W5CJCRQj9P/g4/Wgnz1dSp+JOgdUmoDp/Gs7Wew2Tibelr7ZCHnPHQsF9XK5inmYb4B6ca75Qt
 neaJx3cxIL3AfN0heEq46oRGIS2j6ULW7YYekoiV6ObLZeZbesfqxETwqKe0O3bB+CKgAFhB+3
 wsV0IFJ5MBSmCWMbDg4z2vYyG+MJDw04vrk6TW1mIQOBc9VhN8rt+teM3XSgPR8/lV91ueSH0N
 7wSL7KxXiDwLb9CeK6i1WP4/
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="144535307"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:06:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:06:58 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 05/17] clk: at91: clk-master: improve readability by using local variables
Date:   Fri, 17 Sep 2021 15:06:30 +0300
Message-ID: <20210917120642.8993-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability in clk_sama7g5_master_set() by using local
variables.

Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 88f7af1bfff6..9a2c8e64cacf 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -680,6 +680,8 @@ static void clk_sama7g5_master_set(struct clk_master *master,
 	unsigned long flags;
 	unsigned int val, cparent;
 	unsigned int enable = status ? AT91_PMC_MCR_V2_EN : 0;
+	unsigned int parent = master->parent << PMC_MCR_CSS_SHIFT;
+	unsigned int div = master->div << MASTER_DIV_SHIFT;
 
 	spin_lock_irqsave(master->lock, flags);
 
@@ -689,9 +691,7 @@ static void clk_sama7g5_master_set(struct clk_master *master,
 	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
 			   enable | AT91_PMC_MCR_V2_CSS | AT91_PMC_MCR_V2_DIV |
 			   AT91_PMC_MCR_V2_CMD | AT91_PMC_MCR_V2_ID_MSK,
-			   enable | (master->parent << PMC_MCR_CSS_SHIFT) |
-			   (master->div << MASTER_DIV_SHIFT) |
-			   AT91_PMC_MCR_V2_CMD |
+			   enable | parent | div | AT91_PMC_MCR_V2_CMD |
 			   AT91_PMC_MCR_V2_ID(master->id));
 
 	cparent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
-- 
2.25.1

