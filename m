Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FB3CB97F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhGPPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:17:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10473 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbhGPPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626448492; x=1657984492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H6boYkWlhsAu7WXG/TxMXn1WD1kzgkb9Xlb2J+3zAzU=;
  b=z1ay9NV19yLCySoMdcCLmqfTLc1zIIcFO2TNMk7g3xxU+O9fX3GbEFpY
   CXbmRtFyoWmnhtdlH4188oAfpW8iIZz717QhRglAhbrQq1VGg1jVniX7T
   9AD/b4IBT5j0UY9CRs4Yb3QEdDfCCIOsWNYsCvGLlwAcIR5AMwkbSoS1W
   AWb+dyiFn9ETre9pJBC1YmXAdSdHDgCK4OJ8Y6GAd+rDfMNISufzydj2K
   +AgBx+6sY/tyd/KbsZA52bNPDw7cs5Tc9LQ3Rvh7jc1z7EcgS9LZ8UhYp
   8y1opLTb2cNJOtJEmAzVKU9in9qwdhABhYwfMHgGX63VUhV2n/O6j4p+J
   A==;
IronPort-SDR: KoG+8DEWeY54Mve1Jcm9DfuNV71usBzReH8ZF10KcQWsUQ6yU8U94XNV0Yjqzy0hW78x02mJhX
 ql/RX/HYN1LKaE4W/RSQNPh2o+TUvuGs2iCGLGenbXjhp3rZW2kIZflUqo8Z+hgD8AgcWwHgKl
 rgF5ljd3FjpAPoRV8Nk+i6iFYDzyBf5scuJSbkweYOXIgtQB8185VcIdfeEuVjAs2OApVmGcti
 vnUpWFV8CpTgAJCNOgMwyqghcw1GH5WStMpxFt/AsAgDTMUbBucCnP8iT8aig7Qz+82m+S6m5z
 lQetqvmuyccDOnl2I/8xXtY4
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="122322340"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 08:14:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:14:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Jul 2021 08:14:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <emil.velikov@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] ARM: configs: at91: sama5: Use make savedefconfig and clean leftovers
Date:   Fri, 16 Jul 2021 18:14:46 +0300
Message-ID: <20210716151447.833967-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even since the addition CONFIG_VIDEO_HANTRO was set to n because
it did not respect the dependency chain. It doesn't respect it now
either, remove it.

Fixes: a0e6830c95b7 ("ARM: configs: at91: sama5: enable the Hantro G1 engine")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 17db3b3e2dd3..1ccf84091dd7 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -207,7 +207,6 @@ CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
-CONFIG_VIDEO_HANTRO=m
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.25.1

