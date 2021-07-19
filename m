Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D183CCF05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhGSIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:07:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21492 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhGSIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626681829; x=1658217829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMU2Keona05uhnlgelXuEon2J2aPu42xdGB3C86PBpM=;
  b=QTd+/HpD561jpMx2aXROGeCe4T2ViLiK8X+CVa/4xqbVdJkEfcOTeeTB
   78YEvZNGfwApddRkrfRf1t2oFuj0VfYz7R3NVXG4nIuFMTbfb5vNYuXCf
   QN4wBAXWXUPg58K0xXNB7Ev36wl5Su2MZG1HqHBMgm21CP/nvjrdltapt
   1IqYZ4X/05olCLJEVXL/9pSmcfcai18BJL1p0eJzLUCuojT7WizatDNqT
   PTuSNm/+Nzl9z34D4F6YNTrMIFAJBt9czd1aqfQXBZ1EpY5xBPL1GVQls
   xc6ZAM7G6+7YnezstcOv3oXI2vhoNJEOwxPCEYu2jpRnHqzBgxjViWWvL
   g==;
IronPort-SDR: T+HQZZ1TD7sFwhhDpkk+1lOzUDIv67WFpXFr4VUrqs++SiulZ7yKHgiQunuUv7QXouz1DB8vbB
 XyFA2tssN9tChqTJXnyUxAlIMoUAT4aZPebSG+TkjE63whZnhoS42Y1FYjdUMbtN7M4N4RfugK
 pf6H4yj9w/MpUAdIwfIin5taVcuVefRnKCaZ1uMsE4MXMxjao4lQoVQLVvsmneC2t5gGrWIchv
 Su7wEtH93U07QpGlT4TUgW/36vdITrW/dF1/FRgSVQx967pm24EnCYAPlLeT/rq439QVzxYzj8
 8l/XmTPBHFzNJhmZuy34GDHt
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="125054061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 01:03:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 01:03:45 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 01:03:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: at91: fix link error
Date:   Mon, 19 Jul 2021 11:03:16 +0300
Message-ID: <20210719080317.1045832-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM support for SAMA7G5 has been submitted to mailing list before SAMA7G5
soc support thus the SAMA7G5 was not present in AT91 Kconfig file at
that moment. SoC support for SAMA7G5 hasn't added the proper PM flags to
Kconfig thus the link error bellow:

arch/arm/mach-at91/sama7.o: In function `sama7_dt_device_init':
sama7.c:(.init.text+0x18): undefined reference to `sama7_pm_init'
make: *** [Makefile:1176: vmlinux] Error 1

Add proper flags to AT91 Kconfig file to solve the issue.

Fixes: 5617a08dd9e1 ("ARM: at91: pm: add pm support for SAMA7G5")
Fixes: 18d694ecd91e ("ARM: at91: add new SoC sama7g5") 
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index f52b46bccd85..b09bb2279f7f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -204,6 +204,9 @@ config ATMEL_PM
 config SOC_SAMA7
 	bool
 	select ARM_GIC
+	select ATMEL_PM if PM
+	select ATMEL_SDRAMC
 	select MEMORY
 	select SOC_SAM_V7
+	select SRAM if PM
 endif
-- 
2.25.1

