Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6D359CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhDILO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:14:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31148 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhDILOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966881; x=1649502881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMydS6SpF+3ky5OFGHF+CX/2ifm7LJRo+KdwzVglFdE=;
  b=KvzqgTff1j1aBJKEJiLqTHmYR9qog3kqfE3E9kcy1yD0qoAaR0MUY9j1
   fC148tjiVZbsXpvBvKb5rr5oPTO9kKQxETjZ8ZrOneN4p3wgI7wpSHeVf
   hNudoDntPl+5kDUV3fUQdT8FtVZVuaXxhbTs2YjiHSZmJgSLDCdvxlg9u
   7r22QGZrJhEG6OX/4rpzFmW06wgc1IOlQwh1O8Kdz6Ib7GQ6zjcbr4dJd
   5pJusN6WoWodxkGs5ndQXb1pL86WEOpxZl1B82dmLqR//KEj0XF51UkwX
   5netsJJMI+wOs263oIqtJHNvgtcI+SKdBt7w/9tGvr/ae+0aKVhjE1F8V
   w==;
IronPort-SDR: M7lPMn1VuOQw1UFtQfbQSvqN5aZIduuBpxksRHuMASYPXN/vDdhWowpz8khG8uSlAyfZgyzdK4
 s0oT0g8l4fsSkm8KyL26S4E1cGV2KckEKn7zKd8zoDNCiVzQLM0MHxOI2CKOS2TGvCnPZ2Z0fM
 rxw0SNZdKdjRAnGFNEaxx0iSeukMkQDz1fSw2/+qURcBmjwZ/e4DRGO2V4uUeMcvdpS8zVvwJG
 vY5FoVZzNPuL5kT1yTgXY3Zyoz+aywpbc78WeKRuvS0ef62rQ1ixJJzLoP7sPdw45XQorR8ar/
 ZMA=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="116427460"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:14:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:14:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:14:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 02/24] ARM: at91: pm: move the setup of soc_pm.bu->suspended
Date:   Fri, 9 Apr 2021 14:13:23 +0300
Message-ID: <20210409111345.294472-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the setup of soc_pm.bu->suspended in platform_suspend::begin
function so that the PMC code in charge with clocks suspend/resume
to differentiate b/w standard PM mode and backup mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e13ceef7ac9a..3742a1fb76db 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -214,6 +214,8 @@ static int at91_sam9x60_config_pmc_ws(void __iomem *pmc, u32 mode, u32 polarity)
  */
 static int at91_pm_begin(suspend_state_t state)
 {
+	int ret;
+
 	switch (state) {
 	case PM_SUSPEND_MEM:
 		soc_pm.data.mode = soc_pm.data.suspend_mode;
@@ -227,7 +229,16 @@ static int at91_pm_begin(suspend_state_t state)
 		soc_pm.data.mode = -1;
 	}
 
-	return at91_pm_config_ws(soc_pm.data.mode, true);
+	ret = at91_pm_config_ws(soc_pm.data.mode, true);
+	if (ret)
+		return ret;
+
+	if (soc_pm.data.mode == AT91_PM_BACKUP)
+		soc_pm.bu->suspended = 1;
+	else if (soc_pm.bu)
+		soc_pm.bu->suspended = 0;
+
+	return 0;
 }
 
 /*
@@ -296,8 +307,6 @@ static int at91_suspend_finish(unsigned long val)
 static void at91_pm_suspend(suspend_state_t state)
 {
 	if (soc_pm.data.mode == AT91_PM_BACKUP) {
-		soc_pm.bu->suspended = 1;
-
 		cpu_suspend(0, at91_suspend_finish);
 
 		/* The SRAM is lost between suspend cycles */
-- 
2.25.1

