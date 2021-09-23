Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB6415F72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhIWNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42910 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbhIWNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403278; x=1663939278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5FJhovyOTtqbY6WdesSmAErjuu4q8fe8jGDarYU7kM=;
  b=ViyAbTOjWzdWCJ4NYNJom+7dQePADWPlqtRhP/zfS/qftvL0YjBhWY9R
   v1fDf+Ie97j2Yisbot+fKqwxw2YfvTN1TLG0iCF5/DuYtX8R9IUo2dt6Z
   1lfaiiMMVr6yhOc6jS103CmpNDgaS4/mscCuEM0URe7zTNbxmv8+nv4wM
   +2T1QJji1hNV3XyS3bWPkhmMUYvysoM/Y3KJ2JSo+2HK3LqTCMnmktcpM
   Wpdh/p8d7cahCiqnK4JD3qWnK+UCDxIwsKxmnmp6ztcTJt+8ESZ/9+D6f
   R5xuFIgqxcUS1A1qIDFBRe0o0cFYFjWQMhbrjsdEA+sOXDYhJ9b03hQuq
   Q==;
IronPort-SDR: aUNIoPko/XvWxIRTuTOBZ3Hoc3z93fhoSZj4TdmpWCzuxP2xbJmYZtbBAskMvTuHWNc31uknAc
 wbym5S0CoblBAlYCiRofwL38vhNCASD59R9zcdunnhaQqLgnX4tYQ1Koyi8K+O7X2VJsHjjQNE
 8v+W3XoUT/eMbalotcq17y4mzdU+t04Cy2BzIUdUUdIFhScZz4T2qj8kXTa6XNQzXS4+aImX8e
 iPs1P9bpmRLvYKLPsc4Pfy7odMfUf3ZdqKGOPNvfqwCa6S+m+hmu3mKzMVxP7CG4XoHUHXO/VD
 smrnnhdFCDDUheET1tz4spM5
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="137664810"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:13 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 05/17] clk: at91: clk-master: improve readability by using local variables
Date:   Thu, 23 Sep 2021 16:20:34 +0300
Message-ID: <20210923132046.1860549-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
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

