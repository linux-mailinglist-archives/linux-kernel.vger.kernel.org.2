Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB041AACC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhI1IpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:45:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59247 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbhI1Iow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632818593; x=1664354593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvsqvIz8zOr3ivUKTHHuuOf1oT832h6IMldyet80HTk=;
  b=UhUAsFk/7ApYgISq6OzedkzBGEYU+JexIwLCgvFhov+oCnc2r9+/ugHJ
   v17nLUdZtaLKBGuLXtXG1ww+gZI+i0f6bh9bUgfXTKfN6KR3/+JCEvY8G
   mzu1YZsLgpq4/oteLHXQcqFdOKqlXP44KYk1yyweHWXZ1TnoXx6Fpb2ag
   uInn+6NAnozqvMcdmVAKweD95pJAfal9zuERB08ddCphUeP7VlEtla21h
   KY1QLq61XV8Iy6ct2xaVzf2us9JOsDxSzdpf79RK6rDuHQTFJp0bP46RC
   cMaOv9tFXYTqQBN5bZFIObM/pjZx0DyNOFWRo7DQI0y61XAcduNZRIvSy
   w==;
IronPort-SDR: i36tkYAydb6Qyx0pWKDoUlWxa087eANuG50jHtCZzZWiXdh84gTInLQTCn9YqRMv779t9unDEo
 +OYCIU8kY/Rl6bt7+a6xJ9DBDKJR1JtfFSP9/DY+1Tq03vD2hQKnFRkWbsJmR4mn0O7UdVS8Cr
 /fZIW16BHR+SZ30qyelZPP0Nsw4gFNzrVIdz6cvhKuAz4Y1s17pUzI5im25L2CPOwN5f84KT5j
 J5V2wr916v1DN/ITtR85fpRd5/yZYT3EG/4PH5aOpdLrlUQar2isNaUHs0j83qs/J5zynyNJT+
 aRUlEOF2xrOJ8iUV6E4rKy+K
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="70895818"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 01:43:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 01:43:11 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 28 Sep 2021 01:43:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
Date:   Tue, 28 Sep 2021 11:42:55 +0300
Message-ID: <20210928084257.2188017-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
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

