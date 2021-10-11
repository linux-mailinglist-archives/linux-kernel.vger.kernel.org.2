Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650EB428C11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhJKLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:30:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53331 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbhJKLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951687; x=1665487687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RusdYrZLESoncLe3TEsjpmisjj7q2vbuzL1nryePEes=;
  b=XyU2Hg36VhdtIXN4Wy67ts1zpeZlBdNZu/CAWD+/qN6eGRxkbeI43rk+
   dj4994TfegAgyMm778ZLOMlmfl4PncrdgWw9GRCLTi8tqhvQj1/wbtR0A
   JDynApfdQskm64Wm0R/w1goRwqUStc2t5LHSqgRJ5DnjTyNs7oBzlxCJr
   aio9FIxYFRivu7YC7lmKJmVE56Wd7jpyoUlh7GcSWHHADkuNwe89AzMOa
   J3u9JepdqxsjAmB6ayu7Fmo+0zmV8cLmn2bJkVeoIohAKgNKrkfZFD0GM
   eBDnY0Go7BWZYBSe+V6Ks6lpMoQwr5vKjThrhrDfdN15y/8rVHiajleDd
   Q==;
IronPort-SDR: 9BqsCI4bnx6RrO3OZ4YuCi8sBJSLkss5Ni5dmUlQChAaAuNFkoSV5eUXLXnoHNc8e3fgTLRZG/
 xl+VO5oDWL+Lm7S69R3kHpQbJQGwYld15RQyYJHGtOvxos6BxR1sjbnRLEPPDIdeaqfs6dqijS
 21Z/RXOM8VA/4FQMIjg7RAV/whKNCI/5WP3qlFR4H24N1A/n0aK+aPKGSyiWyruwD2i7o+/lvE
 HbIs2flxbrfis9nMIUtLAWAFucQgzur3V9iiwu8Kq5ZUAVGuRrTangvarWNVqgwr9jz8KmJ+vx
 sz6Dj/UObRF6pLFkIe+1xSq3
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="135067630"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:28:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:28:04 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:28:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 14/15] clk: at91: sama7g5: set low limit for mck0 at 32KHz
Date:   Mon, 11 Oct 2021 14:27:18 +0300
Message-ID: <20211011112719.3951784-15-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCK0 could go as low as 32KHz. Set this limit.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index fd9d17eabf54..369dfafabbca 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -850,7 +850,7 @@ static const struct {
 
 /* MCK0 characteristics. */
 static const struct clk_master_characteristics mck0_characteristics = {
-	.output = { .min = 50000000, .max = 200000000 },
+	.output = { .min = 32768, .max = 200000000 },
 	.divisors = { 1, 2, 4, 3, 5 },
 	.have_div3_pres = 1,
 };
-- 
2.25.1

