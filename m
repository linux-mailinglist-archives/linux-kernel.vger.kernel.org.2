Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39176359D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhDILSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49765 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhDILSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967085; x=1649503085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kI0413I2spxGJDHxPyI3JVC2W8j7DJTYYAyAAjaxbY=;
  b=zQWGNw+Ag/LU+s7Pt/BcFriT6V39w/5o9AlP8WyRA4DtDW8kYnLUz/f2
   TBbSlfWmhWkCs3WMMoOajMG218wAdQtuvGfKGfhiRSm2YvQdjmd6YPDLL
   NBryvRFdjgEIvdG89TpM4vA6sZ83WI6bboMoPvCfd3w9lO3uXbyS2+4ix
   uZwHsYNJnXVTjO9N6cz7esl8Bivzap84Tx4YUA+fLupFR+XcgJoITLWI3
   os7PBhth2fJ+vhMIchm4/iebE1OXg9ZsfUwDGyWrcSVG5dTEFcNbgLbUI
   ej79D66UMjw9mbwZyNWHBKsNLshwMes7NegnJ9U4JzJ1FAR9DwUC5Gsj6
   A==;
IronPort-SDR: tISAtzFxeN+SfUoz7cdKS+MXP/Sla6HL32EkS7KFbQWoZb5qeYD66ih64TjD48C0BUNA2GXAIB
 M6G9/faxahYem0jTiw/QtP8W+Eb//XyaeWIE0KnW7IyMlENms4fgNmwwionzUjN+Wa/C/igsfX
 XF3gGNmg5oitGscI8ubIhJylUgwspoIPZFVJiHTbkw13LpQXa8zlpdFKw5IeFULredaPS3LHuG
 A2jY47RtaXv7uZja5iUh98Mp0aJUL4LLy7NfSyXkeixqI+0U3Pfae79MjuDKNX1Ar+G94sos6C
 kLY=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022668"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:18:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:59 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:17:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 21/24] ARM: at91: pm: add sama7g5's pmc
Date:   Fri, 9 Apr 2021 14:13:42 +0300
Message-ID: <20210409111345.294472-22-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5's PMC to compatible list.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index fcb20272d65d..f4e66a7c7d18 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -897,6 +897,11 @@ static const struct pmc_info pmc_infos[] __initconst = {
 		.mckr = 0x28,
 		.version = AT91_PMC_V2,
 	},
+	{
+		.mckr = 0x28,
+		.version = AT91_PMC_V2,
+	},
+
 };
 
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
@@ -912,6 +917,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
 
-- 
2.25.1

