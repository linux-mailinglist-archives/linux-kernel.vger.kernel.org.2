Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D299A310B22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhBEMfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:35:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8377 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhBEM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612528186; x=1644064186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bJzoSY/ygQzw2VSmmIN4MIAoZ9nH3Rc8ITeWywneXRU=;
  b=Xw7DJ9e8Y8SY0+CBVO5BLkrQUP2Y2TRJal7B5hewtt7rKg7gqeARGzl+
   0QUEjYO22KAqf8rlwnGeTu6NPVDH5Sao3eR4ruFPgr4kpfW0bU3BlO9se
   4lTrpuhnTjHOaqjE1r5B/2yrqnpFYv0t7Q3w25FvTN/aKpj3Okrgsnjy1
   Fig8gfHf4RipZkkO0UQk0JYpspDKUqT8pl1F515FF0nunLNGcQSrTnZoi
   w50M1XU6pJKaL3H/jAUui8F83CXagJvXUSV40GY4piijG4ZypRXXecCrz
   MaF2MW27PmrSGX3ndM4rFVr1Xd5jGcqXQpWP/NKapJqb/+iyJeK3aBHqU
   w==;
IronPort-SDR: jpyOGeeSest0IdwMtZRgGcugfO2k3326RFQZKnI/dmySd5b3mrvYhYKfHmA7SwoLCqD+0bz2Uq
 aVm+3MB3ymMywKCdLP22tbFXMQ58XPfY55Yr3T8dgEBtI8q0dFs9HCi84r4Tjfhi5Tp0M+5WHy
 FgAIAnhhXX4Qknjd/9T9kpwrbkPUpyR0GOQfJ0vfPImPD2LiEXh8YYSwnW8QHzAi0B1otk8XKD
 swKETtSWnCvMUmqYbBfZML5bH4piuPf/TCNUhhZHuxSHuE6etqVKXtHAZqZ7z38y9nuOzMuVdk
 DKU=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="108151289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 05:28:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 05:28:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 05:28:05 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/3] ARM: configs: sama5_defconfig: update and remove unneeded options
Date:   Fri, 5 Feb 2021 13:27:54 +0100
Message-ID: <bc06f0943bd93dd8c7e2f763f792074ce79c5b64.1612528021.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Kconfig options are not present anymore or selected by default: remove
them from sama5_defconfig.
No change to kernel compilation expected.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index d3e0d4d79424..64573caa0ecd 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -19,10 +18,7 @@ CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
-CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
 CONFIG_KEXEC=y
@@ -41,13 +37,7 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
@@ -68,7 +58,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
-- 
2.30.0

