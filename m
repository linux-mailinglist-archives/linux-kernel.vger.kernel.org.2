Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB334CD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhC2KBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28585 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhC2KBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012077; x=1648548077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3YJG1+xyN5ybwMCAILPKUxYDyeUNiFCDUAczM34qtA=;
  b=bO+x22X0KdYfdimGMGAn1aV44gRM3dME6KXUcYsd574GXZsobGCXf5b1
   eabd+D7Bjk4XEyyYpFPlyIp/lN6Mr+Zh067/K0+eHt40RnD6AdpVoRZuB
   fy2EM0XKqw+tDu7Tao3oAt7+/D76NdQIDacoPVABEZbZF4QUJaoRiA4a7
   DUOtI/Xv2JCa8pOaqa4gRdsuuvTOcL0skT+jeHdsqeAStx7ZtoEh1uTJC
   +CY6m56PJ+09jFHycL1VvWt7XdddPbXVoEOOQybggY8YLOwxWTqa0Ra8L
   eDoSnHoy7wLd/UPpPSBrz3R11jVgPWFq381/d6IlesYbdusSOnTeDyB3z
   w==;
IronPort-SDR: YPL/PlZuVXiSZZita2rwqzADdHebQ5SoAsuRuTXNdHi45LIdOYY0N5/oHOBiY+n/TuKovfqkhO
 UYq3UFANAHkPIrZrh8HIrQ1ERfPMDjuhxVTh17dEk9RkRFAiE/eJHug57P4DgIHpx1o8KOay1l
 d2rgAtcW99jEzVhf3jIARR028HWSYE7ugiLEYnX9Rc8jbF9U+FxnGAUwlRRrCtnfbRetzlaVVe
 5nY/qHjs3JGVTy2/LD4Y6zbeg8XuRa+XfXk7oqftc8xNdlJyg0GVYIiyE8JspI0OQ0L5aXXdsk
 954=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="108891885"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:14 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 6/7] ARM: configs: at91: Add USB Video webcam class
Date:   Mon, 29 Mar 2021 11:56:44 +0200
Message-ID: <48a22e1bdfbc59876f468fead502a5c27fe1289b.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

USB webcams are used during validation process, add them as modules.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 ++
 arch/arm/configs/sama5_defconfig   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a462d0ddaa2f..e033d08c9cda 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -132,6 +132,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISI=y
 CONFIG_VIDEO_OV2640=m
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index bb8c8000318b..99d167623940 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -147,6 +147,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISC=y
 CONFIG_VIDEO_ATMEL_ISI=y
-- 
2.31.1

