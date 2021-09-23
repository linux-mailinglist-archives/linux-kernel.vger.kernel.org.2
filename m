Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6C415F80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhIWNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:7775 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbhIWNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403295; x=1663939295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DuQKvhiqXfXrHuhwHeTUUUr9/+kf63QT9hDdoVT44A=;
  b=VHfSCRlK2em7tUc2t5tkqvJwvFR10BUwZFsP3SE6DrqDG1EEdJ8lYEtU
   VtJzVh/OpiXDOzLtQWl4Khrc82UWTIjijEhah9mtpNfPvfT/Hml0U4wKN
   e2SKN4Yi3uAc9a1BgLEappDQC+brYXEQluli5zO0eSqsE6FpqFmuzIZIc
   xfuIew44M+dHwMbc8qnTBd6pJWmH3/wYckcqJGmpg+BGQmr51M5cgyeN9
   962pJ5aF054cZQoompwEmLl7ca+wayZyxVrunM8XM7rezDTjbJLPR5CUd
   ngVgIOULCjuK3fmRgwlSDhY+2iFqZuKIPJ5vPvX0VFok/DeKkSRKPHtz5
   Q==;
IronPort-SDR: xtXOt4SAePchpCzBhiyY+3sVvmsy2/DsYgxyQNl9D2/gpdzQhMhST8SdWuEVPftQ61/hfZ303X
 yHR/t+NJgVJrWRt5z1hjxyOWP6HTSARuo0Buf/CnelY/hTnCcvoh3zH8t02fs7v+32pjbcojkS
 tSiHzZbcdCw8epFyBO1hSBzAgPTAZTjhWnrGeiQMjxW93ryCP3wifB222uxww8m9aSyv3OWPOo
 gjKIJq7FncfsjVh/sT8iSLntacnSpvqtC1TGefANyhLOl2o5ekdvEUhmWSzTRBlx0WbyLCEaZq
 e+HqXFiVYN4jvtg72kby5bFK
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="70327428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:34 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 13/17] clk: at91: sama7g5: remove prescaler part of master clock
Date:   Thu, 23 Sep 2021 16:20:42 +0300
Message-ID: <20210923132046.1860549-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 the prescaler part of master clock has been implemented as a
changeable one. Everytime the prescaler is changed the PMC_SR.MCKRDY bit
must be polled. Value 1 for PMC_SR.MCKRDY means the prescaler update is
done. Driver polls for this bit until it becomes 1. On SAMA7G5 it has
been discovered that in some conditions the PMC_SR.MCKRDY is not rising
but the rate it provides it's stable. The workaround is to add a timeout
when polling for PMC_SR.MCKRDY. At the moment, for SAMA7G5, the prescaler
will be removed from Linux clock tree as all the frequencies for CPU could
be obtained from PLL and also there will be less overhead when changing
frequency via DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index c66bde6f7b47..fd9d17eabf54 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -992,16 +992,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	}
 
 	parent_names[0] = "cpupll_divpmcck";
-	hw = at91_clk_register_master_pres(regmap, "cpuck", 1, parent_names,
-					   &mck0_layout, &mck0_characteristics,
-					   &pmc_mck0_lock,
-					   CLK_SET_RATE_PARENT, 0);
-	if (IS_ERR(hw))
-		goto err_free;
-
-	sama7g5_pmc->chws[PMC_CPU] = hw;
-
-	hw = at91_clk_register_master_div(regmap, "mck0", "cpuck",
+	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck",
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
-- 
2.25.1

