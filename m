Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0B415F83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhIWNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:23:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30296 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbhIWNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403300; x=1663939300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZMQb4xEm45MpshvWcAzyLo2pqQa5xUnhBFD0WqA9bk=;
  b=VUux1Co5X4U0nXwSlnvioJXkMgBkfM2MqRErPQQAJXBtZNo4QDXnt484
   7awEJIwoPmVhKA1SxLsCc8BTDsKdpkDreiya1UHMVtJIg6SLI068ja8+n
   RBVZEkRAuKny5M6mX6n12AozCOWSQghGa9C+LS5pU0nU26s59JE/8xawq
   vJ8wwECskxTCd5YSUtfICUDyHAwrnDe5650J3l/9LR065TBzlqXlr8K/q
   E1N1Z0iFthgvNpcL/DO3uknw5xoD/fquzSabKfFiKhouyyNi4/xPqXrFN
   h12pWYJWNx3M3SNi0eVoXqUI9P7zW3Lg9LZqWMKnv7644vWsqTfeotICb
   g==;
IronPort-SDR: 2No5aWUIa1YZwUWob8WMea0H0kVLSx80Ds2wGRQAY5TrF6QPWGReNQWdFP9onm0zq8j4MUq9Lm
 1IBUzU9hgESPJcEP0cP5a6TWYq7V+VtskGSygFZxPplOEV8rzhd3WywVDJ/Gx9QZsk5VNR5V5D
 uXHmbuUVLLm/6j2VgbpEchPKqN0obHiiKayrs3Dm5TYEOqeV1xnKxRpErTRrUnCcXTlyKXsNt6
 tBQR0SMbNuWO17483uqTbReSyU3h8M5BUUu+yRUQ9m90QGTqNS6UkfMkBDaDig4K5c1ee0r+4s
 AW89rryx5rluc/+lypRa8deh
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="130352847"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:39 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 15/17] clk: use clk_core_get_rate_recalc() in clk_rate_get()
Date:   Thu, 23 Sep 2021 16:20:44 +0300
Message-ID: <20210923132046.1860549-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case clock flags contains CLK_GET_RATE_NOCACHE the clk_rate_get()
will return the cached rate. Thus, use clk_core_get_rate_recalc() which
takes proper action when clock flags contains CLK_GET_RATE_NOCACHE.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..64838754cdef 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3108,7 +3108,7 @@ static int clk_rate_get(void *data, u64 *val)
 {
 	struct clk_core *core = data;
 
-	*val = core->rate;
+	*val = clk_core_get_rate_recalc(core);
 	return 0;
 }
 
-- 
2.25.1

