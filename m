Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142E03B5D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhF1MIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:08:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56194 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhF1MHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624881924; x=1656417924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PaCSetCKwvtQGvTBWH5h3ispeHDjsJzITohck8b3c5g=;
  b=tQTR69XmNB1NG8i/pu0JgpQzKZcQjJMIYvybyGqsAUyV4oIZmzDgLr/g
   n4MPYYTe7kt2pG3kK0RcKBcT0xPOTd6GGiYqnvcqQn6PCO7TbPmIz/Wav
   +yJ+e+iFDfkkRVmSPtZbnhseelbE6eULAz9S3wBD2GQhASOsQzl+sbLGB
   6esUQVbebS4KCmifgqNjliGgC8rsdRq75RUQh+fQ387bj1jBCX3B7jWLF
   ECNCTaCeSg5FBlH0OX+nPfnyYR3k+WUrgNgptucBGajef3DNituZdZWvW
   /3brr7VDiVaHRDyLOzPdceXFW8Xg1w8Oi7L4OjF7rw+MDD96cNUe2XcwJ
   w==;
IronPort-SDR: 865UmXT1tBOZdFTzj2Jqa5XZNwZJ7NSDaQGuWC1NOSUe+2x6cMU/sjYRw5X9KLyiMYtABawFkX
 IfXpLEtFlv8coBHawKARQ3/XaUDFMVjU+FcStJPBZWbb0PlbiBmLs0dOsaglYtkg0hm3wOGhKE
 HsowOKoaGtZqTCnuGOGEr6Me3Qo00LbL94t/AZyKwYDnCnN9M5i5ih4PgTgt/9a4+YwZLiLTxb
 91HohmnQ5sjAhl2X4WrY5/EiFBqjePSzrd0zNwNbt2TN5PSqewykDlJw686Mq3pv+jNrpQ3ZMh
 Yhk=
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="60442228"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2021 05:05:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 05:05:23 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 28 Jun 2021 05:05:20 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <codrin.ciubotariu@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 4/4] ARM: multi_v7_defconfig: add sama7g5 SoC
Date:   Mon, 28 Jun 2021 15:04:52 +0300
Message-ID: <20210628120452.74408-4-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628120452.74408-1-eugen.hristev@microchip.com>
References: <20210628120452.74408-1-eugen.hristev@microchip.com>
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
index 52a0400fdd92..4a02c102128d 100644
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

