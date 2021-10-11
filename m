Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92914428C01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhJKL3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhJKL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951668; x=1665487668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbgvOX8odhhcgQRbsWErZdBKALu82PPpkMqqT+eQSGM=;
  b=XokKAVtKgC71mVscS+qvoXrZQbSAvDej7A6XmPudxb5tKyvL2XoODdM+
   z6THcPP5NIwR76p3niC05roUEX5exjD2G51HBCmptNKUKSytCi6QMpTrE
   FRsvSYTyuDOTSr6v8pL8+8aRVSJTvhuzMs4eR9gVqbtKlYFbJMv2OB5Yv
   8fNwsg/ZE5cWjjp0hiDNzdOFSOVxbOcsnac0v+9yBwrLNAumm+GmzOy58
   ckXCp23+zDWl+RY8RnxT+EkB6LT5vYJhKQ1hWz3dh6z716V1xEMtsd3dD
   NdrZYPaosf5L64uiZqosGkJAwD/Da846/7mgvNxVcNgagcw4K4PK2wD41
   Q==;
IronPort-SDR: Hssd7a5Dam4Ue21pMKZ3ijrw6rxWZeohXafN2V80kB6mQrpompQjg/6bXuOFXbcSKcYfyC7955
 NqAVYd62YhUuvLW+lUGddTQwD5AjCdIBLZqKFGAePMZUddyRgDMd1gP+JdBgdijhxKS1Nj5GJe
 cIwgddNxcgsCL4hOCjEUiI9JHew/VGRfgqh0VPEs7CXPQJyNDbemyRjG6VZ5xHJ8f9/UrqNBGw
 FDYIxfz/QFQ4ZdMOUcqqk3VujQTSVI8lbiyjqiMdSwNXGkOH6intwjakWK18L0F884ZCAVGvlm
 mEDlEmUiWYcoif08Bmyc0xPm
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591038"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:47 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 07/15] clk: at91: sam9x60-pll: use DIV_ROUND_CLOSEST_ULL
Date:   Mon, 11 Oct 2021 14:27:11 +0300
Message-ID: <20211011112719.3951784-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
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

