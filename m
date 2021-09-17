Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAB40F740
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbhIQMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52276 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbhIQMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880438; x=1663416438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iXltDkXvh2jy7PtzeaDUpgist6Ml3VC30h+vQtcSdcE=;
  b=OSZXhEXfUtLZ/eqHX0Xojvx3HHzszUvaXZ1fmh3I2g1aMN5kCeo8xDIB
   MluSRQoJFmCECjdaeiLoY+/2x9Zc5cIFAySz8hHLJTBYtOExXNBHRDUR7
   4ebahHbfGJslShuF0w8162O409GG9KldBdkf8B3mRDin5qZvGYlNcXUJW
   65HPGPnXTkeORbJjZK+JRXb5dE9kwHZ/dF6O+YVoUnhbxaWjTxBTRL8GV
   vgkrFJJZc+F3U0uUi8ZIYZ9nYsEetKMrF7H3thFQrbSZU99vpD/MGlzee
   /fyk1OQ13mVPtnhDJtdz8YZCC4xIQaSkpgUCKIv/PMVhJmFnN4TRB2reP
   A==;
IronPort-SDR: nvr+fXFpQ9/mYjlcXU/KXjXFyAznLhh68RAEVEu1DiHPVctUCceeaCK2+sot2IRwuK5i/Pslw+
 06amHajD1wmsLcGdP0NJv64FAIbgWl9VgfipIm75vkCSuLcAgQFnh2B0/Y68PVwGltF1ShrIFq
 yeBKUOJu+DZAkkaWgP2ID/5DVX/k2MAB1AD7BAS9ze5mPq7tZUtx2yNaWAy/TS0OLymoCAMEEF
 2wKeBnDzm9nvHEdqK1GyVRnjp12wgMMTMDICBx1h0pC6AgvEeoG7nBbvVRUrVdLF0qlW4t9l6K
 8rCjw6edhQ5dAQfJ1jIC3GZp
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="132201104"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:07:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:07:17 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:07:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 13/17] clk: at91: sama7g5: remove prescaler part of master clock
Date:   Fri, 17 Sep 2021 15:06:38 +0300
Message-ID: <20210917120642.8993-14-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210917120642.8993-1-claudiu.beznea@microchip.com>
References: <20210917120642.8993-1-claudiu.beznea@microchip.com>
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
index c72886681d74..aaa5769a8df1 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1021,16 +1021,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
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

