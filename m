Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069A37A078
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhEKHOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:14:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23246 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhEKHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620717205; x=1652253205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPGXRvLS3AgmuOFiWdkF2ik+v8HO4jPIF0qnh3jhSVc=;
  b=ePkN+MsyqVhHqVTAkhaT96KKTky6F2OTyhWW9y/toqAaXrbT9CGmBjsn
   q5Bv5OIK52vc5O+S3qFjA2XpeRrKwwbH0eA9yzsXUstH88Ke6Qhmpt+XQ
   oEQo83R56RQnIduD3yIGOiIEIzh8oGDCh1Png/ICHQ8Ei0pHVHwwKtIxm
   Fs7H6d6JqikluqRHQH9CpVA9QXjjxOIyn5TsAgzfif0zOIpbBgkmBx347
   3eM+97JzC9i/fNkaXz/8Gluweo/c5MMgYfwkmV+3hG96zTVyFJX3uOKKn
   YHkcnZ27X0yibVOx95q8EsdzC5dldlz0gHneJdsjCNcQK4JRlh/O96qNK
   g==;
IronPort-SDR: XMxXAyrLS3ldPSaQWeJEu77H9TVVKmwM/AQs1Z0ydD/qLX2BnKFbMeMXSNao5u+vx49/aYz/I8
 Dq90JI3+fVChdKL/camTqLLjmQVGk6JxGCv+1jRBLd76e7T9e3W2fai9tJ7w7f8CrH3fzKfQ1E
 yJ7v9dwvAtjlKUmGmntNhEL8qiZeSbf/25rHsSql24xXsTuEd/D+i/OlJ9Zew6uF0O5/MzAWyA
 /zKpu2iHDf4QFwzoF2cFgChTsGH5PBdnlW23V5esJBZ9ZGgRkTqEfVh4T1j5pdupRzJpvHdANQ
 VaY=
X-IronPort-AV: E=Sophos;i="5.82,290,1613458800"; 
   d="scan'208";a="55126095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2021 00:13:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 00:13:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 00:13:13 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: add sama7g5 SoC
Date:   Tue, 11 May 2021 10:12:23 +0300
Message-ID: <20210511071223.71379-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511071223.71379-1-eugen.hristev@microchip.com>
References: <20210511071223.71379-1-eugen.hristev@microchip.com>
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

