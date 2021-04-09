Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381AB359D99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhDILmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:42:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:33537 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDILmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617968517; x=1649504517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P53p+hsMUSce2BMB+00gNVpeoyJ5GCn012HCNuo4awY=;
  b=hr7YgoFSYq3XD+lhnLLY0P/+qk+/ze3d60m2mrvvOz42ct9/6qHlrEXo
   D8oN50Xd0CSRng+x599e5mCsmZCaMBylN+S85wRA8JgxQlBpyQil5ujaQ
   8EbV+5iYvh0tjXDGIsUJKnCqpQFttyIgyuIjXlugul+WcFrTCNw0a/hx1
   0fDCvGFu1Zcvg5Z21Kew0f65Y/kXp5OzF4MWzVVL3qgjhclF1wDDteqXW
   I5br6EZBUL5wefY3IHMMFWVJSFeUig17H9eTJ3FhY6xpkCJGqZtl3eZoF
   1TxVqDXM1V6j0Ryak1RHzpoa7Htyc9qVN4CNe07+VAuB04Hq2Vd0qCVai
   Q==;
IronPort-SDR: E7gi1DDaD241biSWBJ+QOKogbDATiCHAP6zYi8Qixz3Cg0GdQCS66cdLpsnGcUvy3rq0L79iKG
 iS/cKBEwvLnpFksWmLWzt0JHSa+YtMLW1jBFHpirotBwJnq88UYMSD/zbNhrVXQW7LwncFreBS
 pcUplTLuKrDendXe6Rsrh0PPlUmf8DhPBjxcPlDneYe/WiKZfg4mkaBowQ8yi5p+AVKr2YZpL3
 algUeXzb+DdxCNCraX4BOoNUUF2p8U8oeMaOU44r+ttQWIJe1UJUC+w6reRlJHuwT0m8xJIrUr
 8uQ=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="122422120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:41:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:31:56 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:31:51 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 2/2] ARM: at91: debug: add sama7g5 low level debug uart
Date:   Fri, 9 Apr 2021 14:31:16 +0300
Message-ID: <20210409113116.482199-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409113116.482199-1-eugen.hristev@microchip.com>
References: <20210409113116.482199-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sama7g5 SoC debug uart on Flexcom3. This is the UART that the
ROM bootloader uses.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9e0b5e7f12af..7598624ce6dd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -191,6 +191,14 @@ choice
 		  their output to the USART1 port on SAMV7 based
 		  machines.
 
+	config DEBUG_AT91_SAMA7G5_FLEXCOM3
+		bool "Kernel low-level debugging on SAMA7G5 FLEXCOM3"
+		select DEBUG_AT91_UART
+		depends on SOC_SAMA7G5
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on the FLEXCOM3 port of SAMA7G5.
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V6
@@ -1657,6 +1665,7 @@ config DEBUG_UART_PHYS
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if DEBUG_SPEAR13XX
+	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
 	default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
@@ -1718,6 +1727,7 @@ config DEBUG_UART_VIRT
 	default 0xc8821000 if DEBUG_RV1108_UART1
 	default 0xc8912000 if DEBUG_RV1108_UART0
 	default 0xe0010fe0 if ARCH_RPC
+	default 0xe0824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xf0010000 if DEBUG_ASM9260_UART
 	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
-- 
2.25.1

