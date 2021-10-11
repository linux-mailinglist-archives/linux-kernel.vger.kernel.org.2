Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0954428C06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhJKLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhJKL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951673; x=1665487673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClMLzX2uOK3w3CaP5eMh1OuzGjwkLzpd+EABVYi3mwo=;
  b=NjKxCP7P6BE7yHtnrTftKiJbdWhDdWmLmStWpDWlntb0cmEQ2QVeflVR
   8siQ4rLMldPi484w6p/fB2KvUHpEbyv7xBAyeIlkThYlHuBAqI3P6snao
   UQLsFCufoMlbK+k7Aewep2UZ//JpmWXp0Y9DWyBrami8FKSMa1gufKEJ9
   W8aujMym+DM6C5c1z4Dv8A6OPNfqFjfZ3Me5w5hYac59Fo7x/tzyGZdTA
   e/7/I4Pr8qvnGAkpNWDonRbSUyYAPLWHo7Yatfg1amdv1GrrkclDaBaa1
   En4vtNI5shn/TE4Pm8fyq0FQO6ARDlTbUnt1J6zFQT79u0pglP+oAJicw
   A==;
IronPort-SDR: tJcksOtSMWt0wl6ykOjA8n9WbjnCI61pecus2CtLH01QgRo1xg+UI7ksixqh193gYsgAaJT6PH
 JcAEBMVddmNnApymB+dTmprNGzsCZKkeXiD2aO+XpYb7p5dBHEhjglu/x8WDiGAchJbPNIX7BH
 vgRWghrKBAM9RK757ZDG56Xs0CilPRsCSv323JaXlT4xzpbiDSdbGPqGosfTzdbHhytkXUivAS
 bylh9w/bKYN2GjeknXGhKIRcw/L/ie9OS8EXdi+s4ZW88v8jfcTJpGFaiBNGJuPIoKWf6F/mbt
 5QnMfXSfA6ypignymaXIONxP
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:52 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 09/15] clk: at91: clk-master: mask mckr against layout->mask
Date:   Mon, 11 Oct 2021 14:27:13 +0300
Message-ID: <20211011112719.3951784-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
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

