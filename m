Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D533A415F73
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhIWNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64403 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbhIWNWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403279; x=1663939279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbgvOX8odhhcgQRbsWErZdBKALu82PPpkMqqT+eQSGM=;
  b=Mr9cO3NKfaC2whcrrYPNnGNUsbTlVQ6+J+8IT1HrYrFpB6D7ZZq/d4IY
   ZUDQW2Xd++lxRnI0raCuMRufyQzxqCz57QkV8XFGJEw6ep860zB3n3cC7
   n1SaiteISoBN0La5n5yEQzDUZblVjYGiPNDpaXrveDS3DRqgieuzt+AB7
   T/WeIlLiU2ZTNfLe5S0k2+I0Ns8EtzLQgpnZZ0HjDHsFC6wZQzWrgUyGN
   PJoLD9J8R+rdC4GW5KkczOleyz7GSLdUC3pTxzwFoLOCZTLMSKTmTLi1W
   LuZGZXXu+MIfJDGwCAolPP0WZmOEejz9+C7JKDqtbrM9JVDNIb6O2ZHLG
   g==;
IronPort-SDR: o+trM+tlELZt7qoaLRH51vpi3MyEJppw7qodEHiu3lzjCCzLoRvbOlryYXAnPXZx79JR//fjzZ
 ia2CwFaVReOPa00H4Q9pEbSgK6bIprJ40+7pt50NYW3LGZLH8owsjWYQmG/xChyPU7eZY6F+iP
 r5oT0vNiM33o2EGsqKhztRcDYRqepdcEe0x74YZblDYX0lsGtnwv33JpGTVa5U+Oh5j7OrG20N
 pqA9vGtXq/MEBLh6I7u/E2To4AZu6a5n9/9e0qonZUu5LgjeGPdN/If3u8Kkjmgbw8g5YBvZ2h
 Yf6GGg781tl9FfeL2ITAkwun
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="145305443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:18 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 07/17] clk: at91: sam9x60-pll: use DIV_ROUND_CLOSEST_ULL
Date:   Thu, 23 Sep 2021 16:20:36 +0300
Message-ID: <20210923132046.1860549-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DIV_ROUND_CLOSEST_ULL() to avoid any inconsistency b/w the rate
computed in sam9x60_frac_pll_recalc_rate() and the one computed in
sam9x60_frac_pll_compute_mul_frac().

Fixes: 43b1bb4a9b3e1 ("clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 7020d3bf6e13..a73d7c96ce1d 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -73,8 +73,8 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
 
-	return (parent_rate * (frac->mul + 1) +
-		((u64)parent_rate * frac->frac >> 22));
+	return parent_rate * (frac->mul + 1) +
+		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
 }
 
 static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
-- 
2.25.1

