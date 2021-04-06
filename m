Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73E235562D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbhDFONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:13:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10060 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbhDFONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617718422; x=1649254422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ASsW+aJfUalRmKKki771cP73pjrlGqdHN4S13TrQncQ=;
  b=2JSGxgSiNkBVUngk7CndEENMECgt0Ah1yDgi+LWdOqu2dTgWVP5tZo6P
   SFj10MTPimknz9g3WLFpPqEvs+UgEcK3j69mFNW+SPXloME8fZrzGkOMm
   KmOh4UubPHmtJROXzAxAR2dzAZSyPGJxudeZU2DlozJ8vPw2sIchyNqZ0
   A4t1V2/eAiIIn0wsCvQ/pGI3i9jLL4zKgicSTKUEbafpXSwZ/fNBPq6wl
   WdrGE4PZb6ECegC93eRQzxiMYzHZAZeT2aExWScfnYbBbgPL/mT+oJ+R3
   3YpkDETLgJZJnvCRKhdXcoR1Vv8jqjxFX1Pppa5BZBVkT7voj4VANE8ds
   g==;
IronPort-SDR: ozP3Vnf+9Yw8nYqGvV16BS6Q3lXVErV6Wr54R3sxsPGEy0LE3Nyir4l1ynmbmfSeCfzJb7ak6F
 2tzLo9ksLEUax0NfCBmeAwJC0yzqf4nkIVyIPxPQYisqVE04WM5qmk5mdlJuDThxD5gPH4UdFj
 9Dl3H3Rbt797WAdl93XqrVyqbNZOhdHlp47zhmqlz2JONVxMcNAyxSZ9Ux64GTpr5ASo+1DfkL
 oFpqOU+6UwYjN6EYn15cm6GaisfKXS8vZ/63UjqBsGrj+izXxG1SRid7oivnooT+9L5pvcziFP
 x50=
X-IronPort-AV: E=Sophos;i="5.81,309,1610434800"; 
   d="scan'208";a="50147518"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2021 07:12:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 07:12:07 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 6 Apr 2021 07:12:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: configs: at91_dt_defconfig: configs for sam9x60
Date:   Tue, 6 Apr 2021 17:11:52 +0300
Message-ID: <20210406141152.10706-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_NO_HZ_IDLE and CONFIG_HIGH_RES_TIMERS=y to be used
in conjunction with PIT64B present on SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6403b064e8dc..bd749977b566 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -1,6 +1,8 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-- 
2.25.1

