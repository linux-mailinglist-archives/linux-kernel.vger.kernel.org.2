Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7219428BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhJKL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28419 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhJKL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951664; x=1665487664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5FJhovyOTtqbY6WdesSmAErjuu4q8fe8jGDarYU7kM=;
  b=HEl+H86SpqdwDL/vtQCunD58+4r9ZGON4S4t9QTo7c8cpvwTQwcJMKBX
   JIn/ni/Y6ianiEjq5Da96QECTmA3mQN3I3hjobHRHZ4vDAb5HNgfIDhC/
   66Yj9PdNvZ4yBBUDp6Zj0jn9/Uxjh3gLhc5lBIo6PgUg/btG9FuHH8hG9
   r4gAG0Rp/NgONANsQ3LDHNWui7uixnykprCIl1r/M9oy8deJJeWHMHGF/
   7IU7Asvd1X/H4GxhHY6dqen6HKazx6ehc5xJBG/Qu+QG6dYiPXNX3TFM4
   7V4xUTO0kkDURP/P1x9BVFxiA8sEmbVtRu6O0j8wTTnVVuGMaYT0C7FVT
   w==;
IronPort-SDR: xIxejSzAnsmHP/8hcNtLwEMygawH3SGQQIyGkC7fZDmCkasDZU8Cu0I2hBNOpLgtHB03JAyA6W
 KlndLPGdx4aAFysFTbfu9ylpz5nG2uSK0j3b6yRBIh/+O3iW2MWhy27JL0UunhFpyAmOABd7Hq
 Om+tt/3N/bgczicK/Fo7CSJvg0eTFfyAGvkTszOiWVywL7u9ib2Qd32k/CcKUXhEnkscxJ79pM
 WyD8ym7zGmNv23RK2eyhIDCgBlSW/2OF5dVf5q8JE2UdFMVoMAchGmdHyh/miII40mP4gjZxqD
 YAyvbFmRuXXwu/dDlP7ijkQb
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="72491069"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:42 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:40 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 05/15] clk: at91: clk-master: improve readability by using local variables
Date:   Mon, 11 Oct 2021 14:27:09 +0300
Message-ID: <20211011112719.3951784-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
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

