Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39990380520
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhENIYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:24:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16297 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhENIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620980577; x=1652516577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPGXRvLS3AgmuOFiWdkF2ik+v8HO4jPIF0qnh3jhSVc=;
  b=rh2vgQYkqsIq4ePwDIEM8UkL2k62+xLaX9qKkJwAI6QYWhik+LAKbwaK
   Kc93OzJ4a5pudbGf57bcp8CmDdY0XeE1LbsM/ZpJPVRuX1qh8Lt46NQYy
   2l4m9DT7gOO/Shdrj1BaM1OFrFmE6h2HV+PYFFnfC9teUiXkhOzZAwC35
   KzxYjnrsfXchsA+pVjI+4ihjOroI/DlfXFgzhmUwTdynIF/i0G80MoyzN
   md4zHCixgEyobgTxU3INE8C9WfeTdmITsSVM9gh4OKfHxAAZYjdA8kQXj
   YvkN2CnkH0u0qFuq12WRq1YR/EqQzNQgH+CE1Abcb6DbTkMvXzLAnyAFo
   w==;
IronPort-SDR: u4UE5UOXQfY44f7yKsGNKLrT3uBCPvUWWwWuECIcY5Bc59XNVrQNbgWCbUBakI2cTtcsAHwuq9
 /P8AUCI7DSHF3Qui7hpamDiROxeQ5k6NHvrjFZiE6tH4cDG6a+7pFzTEfocww9UBneHF+Qxs5q
 wi2PggfGToNxBMUBmKEaFggPA0K+e1+aNGoGNExS+LMHsM0Bl1H3vjd7fH2LF9ULvQ+1du6fTw
 +Vn0+QFeovs+tohSGuor6JFhFarGQo0wSPTIGyyNRctSQ+aQtt0lzUT0AkKVsK7E96EEdIa6YM
 sOw=
X-IronPort-AV: E=Sophos;i="5.82,299,1613458800"; 
   d="scan'208";a="115307201"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 May 2021 01:22:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 01:22:56 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 14 May 2021 01:22:53 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <tudor.ambarus@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 4/4] ARM: multi_v7_defconfig: add sama7g5 SoC
Date:   Fri, 14 May 2021 11:21:51 +0300
Message-ID: <20210514082151.178571-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514082151.178571-1-eugen.hristev@microchip.com>
References: <20210514082151.178571-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Microchip SAMA7G5 ARM v7 Cortex-A7 based SoC to multi_v7_defconfig.
Also add it's clock timer, the PIT64B.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3823da605430..d77872e62fe7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -16,6 +16,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
+CONFIG_SOC_SAMA7G5=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
 CONFIG_ARCH_BCM_HR2=y
@@ -996,6 +997,7 @@ CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
+CONFIG_MICROCHIP_PIT64B=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
-- 
2.25.1

