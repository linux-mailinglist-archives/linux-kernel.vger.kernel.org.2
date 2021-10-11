Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80716428C04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhJKL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53289 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhJKL3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951671; x=1665487671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2pBzduVdLBand+IYegWgUWMNB29c7JB6jeWuWWNdV0=;
  b=JJX0TaDuM7VI5mAqfdBEW5NowhfENHKd9YGfvDNgGNGf64v8U20iXRDt
   fkiATDcnDVupm28xDiwIJko9tcaElFAciVFfvQ+h25xr/Jwu4/s0do1T9
   EgiH+06jESyKlfltPlmTR3JYaHgvK5zJEc+ph+Tkv1vdflfZUrpO6Uk4E
   mWO0rAuuFwFc0ait9YcoLqWv2+R6duTmbOS3K3BmqFV5lG2/mHcqFfOEM
   y8MgquDLUa47FFddQOrgj+jX4X38XTxJvHtsw/cb2DMS+JABOcfHO1vAs
   DENEbI9yQ775o3xJscONkHpMqwUBElXWw4GqGuSnYjEVP4dg3KQ5CYtje
   w==;
IronPort-SDR: IANyGvuARxcOpnODQmCV3aI4kbca822stwCGCFf7nvrZ31w4i7eV7HR+vNpXBoBK4y2OYHDsr7
 apu50aek2rDoCcHIZPDKVJZlbGZPL1hOREKGQMCP5JMINsnmlrCs2MJSEkvoPHP9m0DPAznbfA
 F5T+XFfE5pJeZPxmRzweM1ohH6GzsEoraLB0lY35YMn0oInR/LT07shnsleehrR+E9fi/riC2A
 bkKZOn9IndSGEWZdsGwu+CUuL8PBRqsJKAvb2Nq2Tq1fVz5imx9/ZbXX+Ilfr/aaaugfpyP43T
 ztK7ZTyVcKpCldU8GALVnDa4
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="135067591"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:50 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 08/15] clk: at91: clk-master: check if div or pres is zero
Date:   Mon, 11 Oct 2021 14:27:12 +0300
Message-ID: <20211011112719.3951784-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if div or pres is zero before using it as argument for ffs().
In case div is zero ffs() will return 0 and thus substracting from
zero will lead to invalid values to be setup in registers.

Fixes: 7a110b9107ed8 ("clk: at91: clk-master: re-factor master clock")
Fixes: 75c88143f3b87 ("clk: at91: clk-master: add master clock support for SAMA7G5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 9a2c8e64cacf..2093e13b5068 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -344,7 +344,7 @@ static int clk_master_pres_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	else if (pres == 3)
 		pres = MASTER_PRES_MAX;
-	else
+	else if (pres)
 		pres = ffs(pres) - 1;
 
 	spin_lock_irqsave(master->lock, flags);
@@ -757,7 +757,7 @@ static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (div == 3)
 		div = MASTER_PRES_MAX;
-	else
+	else if (div)
 		div = ffs(div) - 1;
 
 	spin_lock_irqsave(master->lock, flags);
-- 
2.25.1

