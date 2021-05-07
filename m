Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440AA3767EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhEGP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:28:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49836 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhEGP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620401254; x=1651937254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPGXRvLS3AgmuOFiWdkF2ik+v8HO4jPIF0qnh3jhSVc=;
  b=yQZe01bJ7ZyOm3EUzCMavUKUTSI1v0tjj81Tfhb4m9qt1gXGWjZQQSGi
   7qdVuo9nXusDsI5lNwt++0IUjabzfK17d1lJqm3pxIc/8h9apgMKwtpJT
   /vq8esqLyvRH2+4ra3pFMiI24VgqKWb4sdHa/PuyJ7vjvFDuYNn8pY59L
   YBfjcmVrN/96yx75ak9erA6smf/mrPnPHWqA2VhEekLFTy42cBdK5NEq5
   a58JmFWF150AFmsqstsuH6v6Y17lbMEdHHmbb4YN8CGPi2WTDvbeSRj7F
   ffCy/WX84xeW6KVmpScC95bKHxreadMgLgYHRbglvb+J0GHQtsnieag9D
   w==;
IronPort-SDR: U6/7l8IY2o3t11dx78wj+wUksP9NxajQsG0xixKfIV7+OsOoLsgfZN9Q1wVEgQseisTA72wO4Y
 ZcqMxRnz4gox9a/qesS3ZRknFVM77nDfWnc4bbmHsojxmssQEa6TPd1c5MbSOlzyPV+vBz0c5c
 Jf+1u7U3ymaiwOsjwLq2hhMnYuHs2jrr9oMRN08RywcDZYd2Wd+A/IqSmgfU8tuswPFlRkrwja
 mLrMAHogrkXmmdTMCYtVSj1C5MYRlP3v3xDPE9jRy5KEVZGfgwoAZtB1sz7jjctD0EdT0UatiA
 Qrc=
X-IronPort-AV: E=Sophos;i="5.82,281,1613458800"; 
   d="scan'208";a="126179054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2021 08:27:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 08:27:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 7 May 2021 08:27:30 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: add sama7g5 SoC
Date:   Fri, 7 May 2021 18:26:55 +0300
Message-ID: <20210507152655.182558-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507152655.182558-1-eugen.hristev@microchip.com>
References: <20210507152655.182558-1-eugen.hristev@microchip.com>
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

