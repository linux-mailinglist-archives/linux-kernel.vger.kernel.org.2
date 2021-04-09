Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38059359D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhDILcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:32:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36523 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDILcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967911; x=1649503911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qf0GWmTnTvXth8jUl6Kj+vKLOijVCZtt8WTtPaL34Ik=;
  b=xh2HPbyWPo5XRSuneY0YMd+VgAQ7PUq/+U8xsL+EUJSGK00V+Q7vFe2o
   In+SOAwxCuakYDCnKifww7DmMR3sVNNcrq29w61hmeIZp01BDRLXdbkUZ
   zYdqyS7UtRkcHzlmiKTrauU4BppkevQsXy3BPUdDWQpdMQPyyx5ItgtMb
   YYyLAPrM9ZfNjN4fEvKJNqwMij6q81Q9kTMkLHQvHKOPpcCkUz0wDnkQa
   A3Ig3SWzp2TKT1yCzAj9og3ff24r2xjVWor2nIFxGdoV6kc02PAUKIWCh
   jdMGuj1hVBuK0u4CAh6iY2v+iDUnzv0nuYbJ/5qURop/gTHKtA9fzC9vY
   g==;
IronPort-SDR: 9MyR6Aj8d+Rv1XGbRWN9HwCsa3qtQj84qfg5Ha4oYvND9d1LwSqF7OX2J+cqcW1lHFdVZBa2/8
 XXHpOPmN9uW4mMnYCFEeCma0ToONQwGbE/XdMk9IFfML59BE9yzhTRmWHAIjs+IvI02L7WbsEg
 46nnRfv6RFOQ36b2DWB1eGuh9ZwhLrKxi3XJAurz9L1WRE5Ijf41f00Ikf9QXOosv4U8R0n7ma
 R7KjXxFWnj3hEhU69icjRKD/G7FY/QKEtzm1vWqQzbq0vw1nMRW8MoYshdTp59VcsIP7hKKW3S
 tpw=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="122421624"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:31:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:31:47 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:31:25 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] ARM: at91: add new SoC sama7g5
Date:   Fri, 9 Apr 2021 14:31:15 +0300
Message-ID: <20210409113116.482199-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SoC from at91 family : sama7g5

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: Select PLL, generic clock and UTMI support]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v2:
- squash previous patch
 [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and utmi support
into this one

 arch/arm/mach-at91/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index ccd7e80ce943..f52b46bccd85 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -57,6 +57,16 @@ config SOC_SAMA5D4
 	help
 	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
 
+config SOC_SAMA7G5
+	bool "SAMA7G5 family"
+	depends on ARCH_MULTI_V7
+	select HAVE_AT91_GENERATED_CLK
+	select HAVE_AT91_SAM9X60_PLL
+	select HAVE_AT91_UTMI
+	select SOC_SAMA7
+	help
+	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
+
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	depends on ARCH_MULTI_V4T
@@ -191,4 +201,9 @@ config SOC_SAMA5
 config ATMEL_PM
 	bool
 
+config SOC_SAMA7
+	bool
+	select ARM_GIC
+	select MEMORY
+	select SOC_SAM_V7
 endif
-- 
2.25.1

