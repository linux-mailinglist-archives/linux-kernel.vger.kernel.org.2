Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE25312BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBHI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:27:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61798 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBHI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612772821; x=1644308821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4O9XH5saY2fqpcq0/ayO65f0ZdeuoVfrCXsWDgqJW/M=;
  b=VsBWdwgCU+iA7BN21b/uIdAeelo9VlX2ke1l6rmAvo2jysMzi+vHGvq0
   QuYEXI8cCBQGR8cD17f4VW8UQvnjXLsNk1AanEyQUcfhF9VYJldoE2JU8
   CsJZjNDHjsfxkQSO7PPWDIosRoE7QxNzepVOmPPO2b5MFDjIrF5Jw9ub3
   u5AKbnOWU9C7PqJLWGO7SgHWYowE8Vv2+v0ykIy4HLGXk6W+O61gpHWG7
   Lc0SLrzbK7ewui/YzUGutP2fDl52tb+GS6130le98gsx2McMON+v6gD/U
   ji6VWPmxg2JA0zmSQueYYB8I9xo3ImPKmoW5doi/FogXDitHJ3R6LIo4X
   g==;
IronPort-SDR: 37oBx8N0kdUMwfRGtrs+d0hZaPjuLdej7d3CAbSjk08DMsifORDdhdJWzDULayW38bIkq44haA
 RR/dYUr/Ni6ySCSgJ42L8lvLQ5RP7oybWF0Vea8Q4CwaG2bVaunUHxsNZvj7YpmIScrm8pokLq
 pXzD1swtr5Xb65fFzaXHHCc+nBgoYwfB+L6pbQ1W8qj4sgoA6+pLc1QX5SxYTMqde3M6APX3XI
 N6KPK13nsgYPYS4pCTF4dqPBN3/UkvByACyaQ7Vz9kX/No66dobZ/YGFhxEjl5xXECAKFCUzzw
 O64=
X-IronPort-AV: E=Sophos;i="5.81,161,1610434800"; 
   d="scan'208";a="114190358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 01:25:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 01:25:45 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 8 Feb 2021 01:25:43 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: configs: sama5_defconfig: add QSPI driver
Date:   Mon, 8 Feb 2021 09:21:40 +0100
Message-ID: <20210208082140.10995-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add Quad SPI driver to the sama5 defconfig. This driver is needed for
sama5d2 SoC.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index b72bd38a1c45..f4c3c0652432 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -121,6 +121,7 @@ CONFIG_I2C_AT91=y
 CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
+CONFIG_SPI_ATMEL_QUADSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_SAMA5D2_PIOBU=m
-- 
2.30.0

