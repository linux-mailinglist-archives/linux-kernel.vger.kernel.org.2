Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705C33474F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhCXJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:45:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26789 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbhCXJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616579070; x=1648115070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfOEgfjd8QEOkQ9Fk23dlhdfzyBSdSzKAI0oLUpC+oY=;
  b=zQ0WT1kBe57sCSQBOLy+sQ9Xz3g7WJZOecdLy7khIeEF1mc/QbCnN/wg
   2VlQ8KHO14i6N5epfasso8FuHKY7zu8E9ZaQImgCMV9OtsnSiH+bl/XtK
   bqJiGSeUpN/dH63SbS5G/sDXQWJfNl5radaqkPWLlVityLy3mSecLLnCT
   VeW3p7Is1YNPBeCcbTaD6JmsC3Zch7R5mDB5u88hZ9akwgFQ6BPwvYiGn
   jTvz10HQlSgh1z6I2vSRhJa6N0yKCpfG2rP+H/KEKK3y+F8EFeAWqYg+v
   nKAdwcRuuqP8nF2++5eVifpngaO1av4H3bMsHglnHgb9ctzAZx0KoE+BF
   g==;
IronPort-SDR: BjMdheW71ch4rIBDBeeguEsXgE0P7k9V+DIyr+DqbDBq4NXE1+0LaHAwYE6cvTfWZagDd0dAmz
 7uz+DUg7//SF69qkC/x5KXKB3g5oI54k5Q0nKSKKWomS/5AMhav970zqPeIIfXprqL+dmQwGOC
 5WkAtApXAPizQsKjX6hPsidGaJiKyGHzprSSTAvMuJYKRVDgWS1UF3/m5A3QWFWv7ux+YF1JW2
 Qnt0oPrs8bZ+e/TIwzqDOlbq0cFy9qahqraL97DW2txbOhY954Rr0tX6Uwy5r3U3elShV8nfvN
 gRI=
X-IronPort-AV: E=Sophos;i="5.81,274,1610434800"; 
   d="scan'208";a="113941951"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2021 02:44:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 02:44:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Mar 2021 02:44:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH 3/5] clk: at91: sama7g5: add securam's peripheral clock
Date:   Wed, 24 Mar 2021 11:43:51 +0200
Message-ID: <20210324094353.1710114-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
References: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SECURAM's peripheral clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index a6e20b35960e..28e26fb90417 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -377,6 +377,7 @@ static const struct {
 	u8 id;
 } sama7g5_periphck[] = {
 	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
+	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
 	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
 	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
 	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
-- 
2.25.1

