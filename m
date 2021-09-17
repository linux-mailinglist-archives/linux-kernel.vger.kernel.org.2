Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5B40F730
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhIQMJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42418 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243710AbhIQMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880433; x=1663416433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClMLzX2uOK3w3CaP5eMh1OuzGjwkLzpd+EABVYi3mwo=;
  b=ATQI/vKTj1QqLTFqsq3RYX5pGo6goZ+bxsP4QNXioWFqcxFv7Ykpsxhx
   tYsWkjaqvDD3YP/l9FiBzqDLx3VmzH5yk6Q6f4SVzzbfZ2/ZFGQEcbuIt
   aXVAs/0d1BAudvd15FSKZAbwwNaZ8hd0E97f36N8NPTW0osqePxrr2j+g
   zk48AMQ3i9lBEOSCVlRmpYb8bC4Oz1BikKxRlX/JE0fTQE8diXvoDo0XE
   8V5LwXCXUth7GTHqkD4+kk5mFliOIlz8Uhv91HtJpbY0DLewNrcZDalfF
   XiuUu7n02ek8j/9K3UhME75z/qAWn+OsGBpmB9cu3RgwjlPkauKjT39pp
   w==;
IronPort-SDR: LqBTroHMbfEY5YBk+1ehpoWJjoeVxF4A4PdEM4uSIplMyU6BN3q/uxSJjq7znINrtM6yuRpuzK
 hiQl9Zw+XSyEA5YEQTu+23aQC5yxBXH8BtnFQClRmCkx8DyIteZh9s5vWxf3G+mHpCWMyhhOcN
 45/pvj7lPW0Jau2lGE5EFxScJO+dVx/1RnqeVPst2ajekiUBR7EvrVrZRnBNyeOgGJa45US83s
 pbRVlVgWN/zFm8qevlDYFMg33n98j9qehNyr+g6JQ1sYq3dtRiq73P5frxv1ucn+QWcQ2GM8Vs
 bIE/LD5Ie/vhRJZ6eM+9g4GY
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="69664815"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:07 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 09/17] clk: at91: clk-master: mask mckr against layout->mask
Date:   Fri, 17 Sep 2021 15:06:34 +0300
Message-ID: <20210917120642.8993-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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

