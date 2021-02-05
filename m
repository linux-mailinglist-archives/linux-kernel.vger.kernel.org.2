Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3CE3116C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhBEXM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:12:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3519 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhBEO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612541255; x=1644077255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OLn4M0r2vrgSzLF0TP7clOVzLQg8U8G8uVRipo7lKI0=;
  b=drSJFMVyN1Z0IzSFFvfq8iC4nwos/R3cMgB9+IHu8qggXDjdGG9ENDZf
   mOI8yfide5jY9sfbo4N4SXlRSoWe3urBYD7Wt0OYhTWXIBFhhtYeTjsGj
   xaFWIEvQmCeK2lbK9IqOzsELh/mDjLLOqZJOLJEwdeLuuTk0TnblY8cqP
   OtI3Jj2f+5NDx6kWB5dP9D9e0ziRxInAklTVjh8T+UZU6ozi8X794GcuO
   hPVK8wVGy10TaCiEG7GnmVX+MJ2uj2cmx+AkEDFJmwGgfgKuDEA0NM1Sn
   XaoEGTT/p5a3TOV5lNk0DLiNMbEHmNxSIquei/ekDdZWaZuO3LDFGybAF
   Q==;
IronPort-SDR: 6jlzvyu/x3x9OuBkhJib+0ix4S02ns5ZLlTOftfnU8PqChDSh4ylAjmjE1aUikzR4NEVuzPsAg
 RXAQD1t07ccefZXSUDl5R4JzX5hhXCdxer6DIzLqOxqnDsrM8SdjtPNrlhg2r4gSkH6RAgtxXa
 UncsWI/wSRyr9pwyvGNnsD5RfQMzmTkuTOTR8PLxQ0e1CcnPK3x3cpLDoDEcTT50DZWxSqwi2E
 UMkVe2GAwzNTyLW8QHzMG8867rylPzbq6uwZtrk/oC/o+PTPWQdTetYKeeAQxdwf7TJByFkyMv
 o68=
X-IronPort-AV: E=Sophos;i="5.81,155,1610434800"; 
   d="scan'208";a="113966365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 07:27:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 07:27:49 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 07:27:48 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: configs: at91_dt_defconfig: add ov7740 module
Date:   Fri, 5 Feb 2021 15:27:40 +0100
Message-ID: <20210205142740.48328-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add OV7740 as a module as it's useful testing camera sensors on
sam9x60ek for instance. Unify with sama5_defconfig as well.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 690c0c158a94..6403b064e8dc 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -134,6 +134,7 @@ CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ATMEL_ISI=y
 CONFIG_VIDEO_OV2640=m
+CONFIG_VIDEO_OV7740=m
 CONFIG_VIDEO_MT9V032=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
-- 
2.30.0

