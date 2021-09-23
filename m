Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB7415F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbhIWNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42952 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbhIWNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403290; x=1663939290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJKSBuOTBiBd8Y63je4r0LFxJcPueVYGL0ehIQ+Ul8U=;
  b=hKUim/Ox00tL4BXvCHCnX3Z2X2zI1xFhd+kAclFNlfK/62dT9FV/8n8B
   aoBbA2vSB1fjjOO8J+cCG74hyu9LThVQwTEN78eeinqGovnU4IqyaPvrr
   gvRMd36Ks0qhwf6PO+TsKbiSyqmYPvQuQXVydyamnKg37YC8eFFGJDaDP
   okBb0LbLTbayv04+rgMmLbxVBXQMc/01nXGOlgn52PvoCKO08LEcug8p6
   mFbWXr3byp3cgFPuk7zlqVHyBfQUkbzteOveGqnK3QE4seYHufPaX9va+
   8qdLwzPe/rhVqJthA6oNT858z5vIrNgmuNXcHGir8aF6JpdKsuFbOJ5aT
   g==;
IronPort-SDR: C7OZdUQTBHRDKdMYMD+2y1R2lcUNrOtvE7q4IyuotbHtgBg7AZ+DHGm1r3IeYp4FzJg2ZD3knQ
 uqIMZ/i635nILhzW9KFNuurk651DX33HVu+rhpYHDnlifIPPGmkX8N+uO4uOKPpy9dG/6IQO0i
 G8vDttM53uHttlnpbzDE35f2sjrdZT2LrxDeOP5NF1J9wC8oc6dVRyEZ24Ft2ei0rAkQOvFF2H
 9XS7W2nRt8Nn8UCcjK97Jooa9sVseZdVdl90r6KM9wyrpCLh5vpZvAD+ODdoBDWqtrh7F3Qr8h
 x81ZVqbZbBJgnaXOPyEW7nAc
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="137664851"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:26 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 10/17] clk: at91: clk-master: fix prescaler logic
Date:   Thu, 23 Sep 2021 16:20:39 +0300
Message-ID: <20210923132046.1860549-11-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
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

