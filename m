Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC74351EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhDASq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:46:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46406 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhDASZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617301505; x=1648837505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KRDSPtavXfZSEi1+DG38az9zzkfxEOJUbAop1plVBhM=;
  b=HZjWUsWndiJAazBCAseHDH0KbBQTX5P5JcRqr5HMU1swcgJTY3yFRZtR
   KRH5gOJwW9E3EvYK6NvEHpnMTl1bYfD/zv7jvArjm5RGgAhOy+C8S4P6Z
   kb2Ec22wr37iU2Y38foSgMV0Gtn3czXVkkXEi59ryD9ook+GXFiJeMrDO
   v/ZFzfNgyOEUWhbqmKTTj3sEbPWWZX/788cgZw+G4w22H9YA6U7m0Svq5
   TPkZ7Hp/TEG8xYiXfSgY3ESfca0UxG/0FNb9MBGfus7Xmwbuknj1kLZsY
   8fXgwGZDrUwxyQHKANdc/VZ3onQ2y/y0RzKmFlMSafEkpuE3/mLTi8SiB
   w==;
IronPort-SDR: 5Et8IH4FOOYfLYdPYoOjzkwVKY8Z8s4mpVOr/g9tTquE7lNJ8991aHseAbTA1pvRszspoGqa2t
 aua3UO0OnaYPW+xHUnbdAGSV7xiILxbKVBBbj+oa30K/ziPaxfn4L/LdmkOf3aTQGmFVS3EnOh
 bvXPJb89qKgyW+qaVhyw8NILQYQsLy2XupyOGaah8gqPbXl7Oro3gu5KTOf8MwwPJ+4DILnyRU
 099brdqf0MevpbN57+NHJdl7VqTkUWL1W9F10Af7lbs/ztmHRnx6TPLiqRqCz8cebWieb9T3LO
 Aqo=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="121406278"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 05:27:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 05:27:48 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 05:27:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/6] clk: at91: clk-master: improve readability by using local variables
Date:   Thu, 1 Apr 2021 15:27:26 +0300
Message-ID: <20210401122726.28528-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401122726.28528-1-claudiu.beznea@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com>
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
index 1b2962289629..76b2467b32dc 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -720,6 +720,8 @@ static void clk_sama7g5_master_set(struct clk_master *master,
 	unsigned long flags;
 	unsigned int val, cparent;
 	unsigned int enable = status ? AT91_PMC_MCR_V2_EN : 0;
+	unsigned int parent = master->parent << PMC_MCR_CSS_SHIFT;
+	unsigned int div = master->div << MASTER_DIV_SHIFT;
 
 	spin_lock_irqsave(master->lock, flags);
 
@@ -729,9 +731,7 @@ static void clk_sama7g5_master_set(struct clk_master *master,
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

