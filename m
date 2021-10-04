Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6942099C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhJDLBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:01:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56966 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhJDLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633345185; x=1664881185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rtrF3dE5T1JupP+II5FooSn/PEiSPnB7QEEoXt9n6zc=;
  b=uhzTgujCgtlLKv2iXPXpCdz0b2d1fIxWsFYs/OuZksBw2XVBUV4JpShR
   7GnYRH/7NDqglPgonq7hxazx3xYYZll3JulYiX+krMriQnQaraByHh8fW
   ZWu9gXZpUb7h2MiF5rSb2VqFAMUsx/JaCP46edLaHlCBccHt7Sf20QEc3
   /tizsrTtdzrKU39+NULCDHDcN3fd0ZQDHo8m9rsVlbZ+HK1UmEeeZE+sr
   YfWcznn1ejlO1pesu1zfJWjq8NrbrebQ0sxqXajiDHgHiwkyu0RKq/Uk7
   Fi2oty3EbnPq9UCITwRAylsvcjSGEilz3z4/z1qWK7NCONLAfYsPtKlCL
   A==;
IronPort-SDR: q7WtBxTtHOSv7PjYIk0FNZMN6tJbmF/G18js3dWmmggVsJgFWOhsKk608XVLZzJBsvdrbhTRbd
 4bXTb+EuMy8Cyandquhm82LZw4h2EsvPWPgyaO7RvVjK2R/l7z0rRnNoRS3FGs5pusPrf4lGJO
 eYSEfyhVJ856CoNX56IQx4CXehdy16B7QSlNUcQJ7g0pW8WN4QeoFgbGpAqhhHEXK9RonPLDJV
 CMzuO9NcX+Wx09fvAWk11vkokerjvIVOqiUWbsWw91nhSB3tsP2LcksNAgttP9wigaUF0SP2/Z
 5EdQW0cbJLam3sj0AhvhSR4s
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="134163866"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:59:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:59:43 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 03:59:39 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 1/4] ARM: at91: Kconfig: use only one name SOC_LAN966 and merge options
Date:   Mon, 4 Oct 2021 16:29:23 +0530
Message-ID: <20211004105926.5696-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use only one name SOC_LAN966 and merge options into it.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5d3b08e4ca1d..096475f0a4fd 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -67,13 +67,15 @@ config SOC_SAMA7G5
 	help
 	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
 
-config SOC_LAN966X
-	bool "ARMv7 based Microchip LAN966X SoC family"
+config SOC_LAN966
+	bool "ARMv7 based Microchip LAN966 SoC family"
 	depends on ARCH_MULTI_V7
 	select SOC_LAN966
 	select DW_APB_TIMER_OF
+	select ARM_GIC
+	select MEMORY
 	help
-	  This enables support for ARMv7 based Microchip LAN966X SoC family.
+	  This enables support for ARMv7 based Microchip LAN966 SoC family.
 
 config SOC_AT91RM9200
 	bool "AT91RM9200"
@@ -218,8 +220,4 @@ config SOC_SAMA7
 	select SOC_SAM_V7
 	select SRAM if PM
 
-config SOC_LAN966
-	bool
-	select ARM_GIC
-	select MEMORY
 endif
-- 
2.17.1

