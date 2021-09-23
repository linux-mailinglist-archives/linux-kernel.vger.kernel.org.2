Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B837C415F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhIWNXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42910 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbhIWNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403289; x=1663939289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClMLzX2uOK3w3CaP5eMh1OuzGjwkLzpd+EABVYi3mwo=;
  b=Rj1zz9IpiK7IrU5nhMJ1VlPz9wp2u1H1qwZpl7G//rdPu+MLyOPXkjgF
   YJEmqHqUQiPO6J+2o4xXc1peG8LNFjj9L+HQ9id+rkv3x/X8YCjo2qjVw
   3zVxLY6dXOTY7Syg1i8gLkMoW/PXD6FZ5Zl90vFxMykYJfrza8yuTf0t7
   0kBV5sGFCpYcCPWiolZrbY4da/SG0e8e8oL/AhbmxVIUM21S29Ab8UNii
   +lm6qNu9iAM7M3CK+W+ExVzEVGWR+DT5X4S75TxRUTDbk4HI6bieEtyew
   e6G1r6amba2KbVokk5jVHhVxdjRNI+91gam1HMonQ5dzlPLNegoiudK9+
   g==;
IronPort-SDR: d9dOfSi97uQWiiFADTB3c/pqluyi+jEFRCdRanda+hrt5KE/l/Fi3WX4fPsT3T5efAD2riKwCO
 bZiHf8jm2zIBDvvrBTuNg3ujJXhFha8/OKXWo4UD6oOwlGHuc3toeE9aXLoeEvi+CcHablJE/b
 1r/4Q0xmJvt4xfP3AUNg+3qbeATFLDYk4Mb6pmU43E/nt6e3KJigk12laSmlmJtSFfmvBVOMde
 5Q3r5pVgtCV4NcxjlOhbYxMjQmWM3XVXpEGcS0/EoBUgIeUlyVswudaBYZeambFjw8WBJCMBZp
 V8pzyhPwxtwTAHjv2Al73cMC
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="137664846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:23 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 09/17] clk: at91: clk-master: mask mckr against layout->mask
Date:   Thu, 23 Sep 2021 16:20:38 +0300
Message-ID: <20210923132046.1860549-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask values read/written from/to MCKR against layout->mask as this
mask may be different b/w PMC versions.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 2093e13b5068..6da9ae34313a 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -186,8 +186,8 @@ static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret)
 		goto unlock;
 
-	tmp = mckr & master->layout->mask;
-	tmp = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+	mckr &= master->layout->mask;
+	tmp = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
 	if (tmp == div)
 		goto unlock;
 
@@ -384,6 +384,7 @@ static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
 	regmap_read(master->regmap, master->layout->offset, &val);
 	spin_unlock_irqrestore(master->lock, flags);
 
+	val &= master->layout->mask;
 	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
 	if (pres == 3 && characteristics->have_div3_pres)
 		pres = 3;
@@ -403,6 +404,8 @@ static u8 clk_master_pres_get_parent(struct clk_hw *hw)
 	regmap_read(master->regmap, master->layout->offset, &mckr);
 	spin_unlock_irqrestore(master->lock, flags);
 
+	mckr &= master->layout->mask;
+
 	return mckr & AT91_PMC_CSS;
 }
 
-- 
2.25.1

