Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6040F72B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbhIQMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16029 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbhIQMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880426; x=1663416426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2pBzduVdLBand+IYegWgUWMNB29c7JB6jeWuWWNdV0=;
  b=uo1Xp1j0ncAbNorSk/+O/hHlR6m4OAduRGAUkd1PsS2ud03p0zgRtFHj
   DKg43D5cjQPlxjdnPcIRU62SxSFqOQbsrWlefYdxNQ8MwtcRDKaWSMlvu
   G5gtMMhx+5iTSxAwzNucgA2ZGNBLJhX7ok/3YQDATKNQAsfRhjcK7tgHT
   s02GS9RIunx0ItPOkwCqFuoUUHD8ep6DOgpo6QTrxv90PqXDHbriA4krv
   16KH2sCDQrHSz0Q78mKJJv62/Tz1nY7mojMYFg9bp8zhjAxefVF8F7nEX
   4FF+q4qfUb4RL3b2qpqFGiOeOYz43lcNvc/qfe+8/Lw25kqU9tQU5y4J0
   g==;
IronPort-SDR: 1nNifu9LJLOxWKnyepGqqWC2u2ISxYQrmCXq41NexwlaETXPjGt24xVL+h4OEhYxbnqcDjr6VS
 7Y7/r+V16meT07/vwPx0Eo/Pm111jkO2bh4XMNq9Gxr31X4O8aJX71xVbJSiDzdINR6D0O6EXL
 hUC6iE5rCjPPKjHxsu5j4+IHZov3zjuR0lrxuCq873MqfkWSWcGgqXjkJsCeVC+DoLU+eXyTl2
 FtWEeUrJ1rFhzDV8ikdAnBbyidwEtVveHN59xxieA1yULBu3njXWmz+kssuUbtWiY+wyZbE+1x
 T+2RZFd722MKesdeB0zmr3nk
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136356768"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:05 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/17] clk: at91: clk-master: check if div or pres is zero
Date:   Fri, 17 Sep 2021 15:06:33 +0300
Message-ID: <20210917120642.8993-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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

