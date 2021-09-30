Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94241DDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbhI3PoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:44:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31909 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbhI3PoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633016555; x=1664552555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvsqvIz8zOr3ivUKTHHuuOf1oT832h6IMldyet80HTk=;
  b=pMAS2BNPJr0inPLOUTKOFYJmpne41L4TTot8iPcUo4desEkJWjY5/2X8
   bERUe4MAdD2VjRheVryRe5Q9wo0BmPapt4gIplqyM8Ep+ED/wVyZ0xqu1
   fie5R5b0HuZLY43CvLM0qvYIdO8bxiskNAO6yB863ub6dIm1xHJ/UJNpN
   gM2ZTITKHqpN+1o56khjUNWX7U+RuNVyXeSbIcUxw8lMqMHxWTCs0nXVj
   KPYGpWZ8neQbLjdrG24txV2L4lzJpthnuX5om3sQs8KOjI9vvcpWIjpMj
   d3mox48sTq+5b66mUXhiX00eBUD5M0E2DUtwdYPytJyGbg7++Jh1L/mgd
   w==;
IronPort-SDR: He4AGs6TBfLNhhRWSRnSITdHUBd5ULwn6tBz0OJ5W/LiLM63q0h44AgMX/h7/WXgx3jz7piu/O
 5Tp5PTgZ8qSMP2GZJiQCNhW9dx59fUGgT6Ebvu12zZpZDY9ByU3TbicTTPWg4XoeTgIzks9qi3
 THrtenN5dcOrP47yxCGt+ztNKX/j67zhuT3tG3RHfA5yik0g1wAC+l9pFbZNMCegu9xhp1boOL
 kD8wsGLYt4JBposllnnZ+183orqb6lY3DYbBZj3OmbhndyjlmyKdKAaN4HC9Y3hkNZbGt413kz
 UNXlE1keEfN4byzDzY7ggHpi
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="146284152"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 08:42:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 08:42:34 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 08:42:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/3] ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
Date:   Thu, 30 Sep 2021 18:42:17 +0300
Message-ID: <20210930154219.2214051-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
References: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5-EK board has DDR3L type of memory soldered. This needs 1.35V. The
1.35V for DDR3L rail at run-time is selected by the proper configuration
on SELV2 pin (for 1.35V it needs to be in high-z state). When suspended
the MCP16502 PMIC soldered on SAMA7G5-EK will use different sets of
configuration registers to provide proper voltages on its rail. Run-time
configuration registers could be configured differently than suspend
configuration register for MCP16502 (VSEL2 affects only run-time
configuration). In suspend states the DDR3L memory soldered on SAMA7G5-EK
switches to self-refresh. Even on self-refresh it needs to be powered by
a 1.35V rail. Thus, make sure the PMIC is configured properly when system
is suspended.

Fixes: 7540629e2fc7 (ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 4e6bcb7fdfd4..be905eb1da31 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -206,11 +206,13 @@ vddioddr: VDD_DDR {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
+						regulator-suspend-microvolt = <1350000>;
 						regulator-mode = <4>;
 					};
 
 					regulator-state-mem {
 						regulator-on-in-suspend;
+						regulator-suspend-microvolt = <1350000>;
 						regulator-mode = <4>;
 					};
 				};
-- 
2.25.1

