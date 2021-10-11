Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB8428C09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhJKLaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22891 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhJKL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951675; x=1665487675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJKSBuOTBiBd8Y63je4r0LFxJcPueVYGL0ehIQ+Ul8U=;
  b=YkxTRhLdBq81Ox4F4VdQUOavctNKzaAnZCIQCCCf3TWsHdAZQKtQ4NJt
   Mvqp4jyghWtpcE40X1rjGZ8ujPPnsq0LV2Qctex0ZxN6tTa+vz/nSFwwG
   t7ekbljw0vBhhBeA0GLH9l4w8RacEJYfZWZZV4N8XXtbD/3Zjz7xVpX4v
   PNIC+2NgP8Skc8F6HroUrDJV9+oxx72E7DHRmfoADlZLTy2ofmLoyISHI
   KouWjMAwRn78bnLGrkpFPK+K0M5VVyVO71SwUxLt5AKTsACi+Q/Eux9ix
   cmM0WD2IIzycStqU4B8IvCgchCeGsGTqOMZuoN/9QTVq4taOmXMI8kZJ+
   g==;
IronPort-SDR: VCoDX2ERDPkTIB5pgT35k71Q/tE7n2PVecXTvpSHn3uOeljstA19W3IlwvkhFYU5kOs+eRkhLi
 F+g/L3kwgPhTz21G59sapAONsw7b3BPpsUI2BNLQUJ76ENNZvC/usB0QXyoMVn8LcDtH1Ugr4G
 2XN+acxGt3mDzu6ZAT2lTmIVkuLKmYV0I4g9imefWUyOnZaGHhEm2SKDr0sYi9sAzezBoInAh2
 +jx2rMBalVhjPbLILow/krBxluvBtVeGBRVB/S0i09ADpTiz96sl7ppHLP7aKgOqvHZRgVdOBg
 V3gxqq7p4t20ETcMM5cqiRNn
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:55 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 10/15] clk: at91: clk-master: fix prescaler logic
Date:   Mon, 11 Oct 2021 14:27:14 +0300
Message-ID: <20211011112719.3951784-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When prescaler value read from register is MASTER_PRES_MAX it means
that the input clock will be divided by 3. Fix the code to reflect
this.

Fixes: 7a110b9107ed8 ("clk: at91: clk-master: re-factor master clock")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 6da9ae34313a..e67bcd03a827 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -386,7 +386,7 @@ static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
 
 	val &= master->layout->mask;
 	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
-	if (pres == 3 && characteristics->have_div3_pres)
+	if (pres == MASTER_PRES_MAX && characteristics->have_div3_pres)
 		pres = 3;
 	else
 		pres = (1 << pres);
-- 
2.25.1

