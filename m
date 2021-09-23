Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3999A415F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhIWNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:22:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50307 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbhIWNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403270; x=1663939270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gm3Yx6VC8RmsDdjJLQsenFpWH675vHotkTTgQqR0D20=;
  b=Pfc2BHQZTa1LDa894vi8TRbAzLdghjy0j3/9phhbMIM0gS16Lg0RW1Dm
   3r7ABTjoMh+MwHik3kvgYgriULHqz9piA+Vx9l54MoRamSlGl6OIsbBt7
   bvmpvZ8/9FtxYUO/if9e2YvGmMAC9sw3eBHOXma7vUQIszHjfirI5tFjy
   bTcr33rBEroyA3M8KpzFiQwVKSMAt8iA+4MxCHgoRcFYqveAyUzrw4kGR
   s8mPAV+2qdWa64lyQQLTOVlzsORAEEwdsWMpi12eAgO0uRwSJeWHZ2Kwo
   yI1yaiohMXWCZs+rHvB0nyh81KcPRj1e44tfJa0+fg3hZjwQWDF+BdFZY
   Q==;
IronPort-SDR: qUp03s/po17elwRMBeA/6mpaNkJAlcSlvCrQDM6TuDsWeC0cK6zKbv4zY2revw0dbLAuzFkNHL
 4PCBfX4qC4+fr0/0sMlSjwpjvpUw8b78W+5WBktZ8yu43ulooFh5ZUFoddeGdV4EbaOUYFijHs
 sLu0P7w5QNMh/vb0YaeD9vr190I5Za/YspYPhRs55Su6YwAi5vlS4upAypHAEEOGtAxpdGpNZC
 AZDzIXfW+7B9nKakfwQoCun5nAxqruq3pKRTu+rBUVtZk0ojLqfBN+jtbmTztxSHuvAJPjNQms
 1QS9RaAy1yKuP8xbeU71eYxY
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="137071457"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:08 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:21:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 03/17] clk: at91: sama7g5: add securam's peripheral clock
Date:   Thu, 23 Sep 2021 16:20:32 +0300
Message-ID: <20210923132046.1860549-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
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

