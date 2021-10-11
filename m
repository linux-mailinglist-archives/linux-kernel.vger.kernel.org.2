Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793A8428BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhJKL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22848 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhJKL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951658; x=1665487658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gm3Yx6VC8RmsDdjJLQsenFpWH675vHotkTTgQqR0D20=;
  b=zJaasGc9u0WlDtTb3MXJq3hF2xRc6j5AL8Jqq/LMS5Jlo2CgEZUN2p5G
   SzpyUmnHhNuQIQkzDi3Da2SGwf94+WrumOjaIngOZrpHt/9NouCc4Kfp6
   Lwk0HO0OtPHfqva1aRcfyRVZrwH6l1laluZ8HDsbWOx0npVU04zhXU8iV
   330qzXiQJ3Fzgq2bQjcF87Tjw5iokVtgVw5g32+gtgkMXXC59NtnF2m0d
   m2SyT1kCfJZLT7RY6QLhVubKu6lXcjwk8E67TNtIN9JE7nMVqdkJfebY6
   4RVkkDNOoTSE1Y/Xs5Is0e862qfIwgcF6yro88N2r0wQyTxL9rafu1YIN
   A==;
IronPort-SDR: AwZRPOedyY0lsiuk/PkzNtcwMJpETf5Xb8k1Ou+0sStXBLcMC6T/Px3a3p/305YUZ+T0sJP9ct
 JOApvZyfuwZiabSMOlFbjDM9zfl7ddfFUCk+CC3wPzA7OCpk+xEpDd8wYWXHOhKzVI/ElmIKVg
 seU6InPQs9vXhGS1k6kO4hnCKAsQss28mQb5zB1OagfWnxE7BPlgTp6S1DR8C7wsaAggzFpcwf
 BHBXdXqCPEb0Orck8D/8OAZniXxr0nai2Cjc6Zwo4fSA5BW3OJsqWYsQaowVv6MQdzGA5u+ijX
 inbmm3Gc7OLEBe5h8IwfL6fJ
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="147591026"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:37 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 03/15] clk: at91: sama7g5: add securam's peripheral clock
Date:   Mon, 11 Oct 2021 14:27:07 +0300
Message-ID: <20211011112719.3951784-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SECURAM's peripheral clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index cf8c079aa086..970135e19a75 100644
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

