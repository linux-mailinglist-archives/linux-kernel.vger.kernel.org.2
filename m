Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227B8357293
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354463AbhDGRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:01:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16661 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354452AbhDGRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617814871; x=1649350871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P53p+hsMUSce2BMB+00gNVpeoyJ5GCn012HCNuo4awY=;
  b=zjyF/0cYwwC7IHoKI1UTcUmA0lkQJqCPgQf0MlpFrzh/qYExb9M0uQUA
   aFzKC1PGrDIuRh2ExGiXZMDCewJUJMPqlGaUj50c5OSk7ZIfNEf6xeLZZ
   O3CaR7YomqNwUt3RDTO6J6xsdFmrJRgd6EcdWe8tQKhnGQijrSIf+v9uR
   +6R6Y4N04sjIsgfTp48Gh+cRarxk95PYJterl6WpibjZFE90TlE8sFFSx
   0dbpkWQqTodwL//IGwGfoC/St1gB+KRJzE5ZejdiQeup4yZ+9i97YZGFL
   sWfk8HFYxiuIh/oYKpEkSdVSByEEZzMdRr7/LLt/+7sPJLIFE6ALf6mDl
   g==;
IronPort-SDR: +1zmCOmA5X3A541UHHjA+GPJMo3Rp/ew3wqZyFHFRqsiWMOhu92Kh2N0RJHDuMoAnflRq0CN85
 3kvYCSoJwCEFVc+HYuwpuwRYjRusaC/Nh6Ef3pMEN0CJnZ33p+8q8p8Z7dy4HEn5z7IF93E3Gl
 c2gnyMl0aZJDP8vz2x6jb2AwalruRUJ5oYWV3Q35XoCWJ8I8jyp+Bfa+u1Ezav7/BnBq/oERU4
 c8cbtwlMyyEbrDe99eRnuaMGaV9QVPUSPJjXwLBdi+iGrVczuj1EZVjmUcwY19IQ6lE1WkO0fV
 PBk=
X-IronPort-AV: E=Sophos;i="5.82,203,1613458800"; 
   d="scan'208";a="110000676"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2021 10:01:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 10:01:11 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 7 Apr 2021 10:01:09 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 2/3] ARM: at91: debug: add sama7g5 low level debug uart
Date:   Wed, 7 Apr 2021 20:00:52 +0300
Message-ID: <20210407170053.298056-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407170053.298056-1-eugen.hristev@microchip.com>
References: <20210407170053.298056-1-eugen.hristev@microchip.com>
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

