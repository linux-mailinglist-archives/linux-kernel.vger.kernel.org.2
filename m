Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9540F741
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbhIQMJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65137 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbhIQMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880437; x=1663416437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJKSBuOTBiBd8Y63je4r0LFxJcPueVYGL0ehIQ+Ul8U=;
  b=194d4TVUNwkGc76lLt2EroXIof6hvj8uU+Va0RWQGD6pEPStUDPzrvfM
   M2GPlQYAKLkYQAPi0A6j53AfsprqnS2hVryvx38P4ZDGFTNqVNHh4w/t9
   44wJ9c+3YXV0dRQeMRS9kCB6PvLS0SsX3kGrMpZnapVRX/ikIpS4qjf/P
   36SMoZqLvO90FZ8AsdrkzLFwC4L3Utxz7FgbnLo8pqrgwA7hWKb7cpSRK
   AH9FN3zLSQP4UOqI3KS8b3xdbKyDqbYY9/gt2Q2TReOvADPCcsZwpCWAN
   s82OrHV+xED/mkncFp66AZRYQKAV66Wq7H9W7AQIzfQvRDqqjUsTP3nMG
   w==;
IronPort-SDR: 86a7+gZKgm+MF0xwruVDvpHlD+PyJtJTRBMsHFYY9SC/WXiSYAipPhWw0AdryS+cugFaJOyrV0
 SzpzrkMIUvEbxL+sVO0g0711kleeUIJ1L4TbqMV/y/GWNy0TMJEXTqYTZMdLfarXujdqlNKyzZ
 iBpkRo2TtFrod0N29k+9jKwyX+ojVW9FOiXa3hHKhTpSFIHQq//fKFY79SKvY+wkvV3BDgWJtC
 /DY8dPq+GcG93YDe1KOTtQrjm09zHiklYUcBs3QbAMybT6aJZuDAC8vJvqEt+EQndri0E1j8pu
 8hnUfOO/fbIl/dZnwamo4bQN
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="144535347"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:09 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 10/17] clk: at91: clk-master: fix prescaler logic
Date:   Fri, 17 Sep 2021 15:06:35 +0300
Message-ID: <20210917120642.8993-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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

