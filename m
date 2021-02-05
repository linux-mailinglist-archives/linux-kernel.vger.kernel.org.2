Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC7310B19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhBEMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:32:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3965 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBEM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612528184; x=1644064184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0kWxxcVv4kcT8niyNS1qwXRYKRUzxYLFRyd4jXLjKaY=;
  b=yW8Ov6ndA2ZvhaiXMxEAhuDMjw2QPZloFhws5uY7MZTilxkUEC0ouemJ
   iTsnBYaDIkBjk7SXsOs+vZZrNx1URCZTh7aY714+CNXRmDbib0dXIsjUa
   btTpsXvab77l94o8TbQzPBhxP8p+5TDMyxsMq77HKS4cS21wgFxxRcaH5
   Mf9vzheVJ5v47pTTJmsA2ts0e2/fTZTbp5TE+/PS/YYZ25QDF8Nvyo/w/
   25ea86+/gWtktRJzIh2gVV0gpupqxpnuaDz919cN2nMJ2j5geS8jPyFQw
   W9p4fo6q/WfWZKfrfTgkEo/b4ZLZcIAmq+vGCp+OeJSbzzsXg5GUh1kCx
   A==;
IronPort-SDR: xaZy+dDHvyw196kUyP3BiCaznSJOgjAQGd74c9Uyw7cv1jQyd1TGXjFELsLJG0Y9LW0f7WuRMo
 X75oTEBsY7DcJMXgTgql8gpPwqU3nnfMTA9YEiW5ga4+z3oE2iP5//YtEtAsT5PXxoPfBHVn7E
 lpcG1i7M/lxPxOnnsSjl4bn++28FO3XeJ6icYUZG/p3tiNQXTLeN8OP9eKJHToOcYzhti+eEdZ
 4nzrYf0qgo1c7D04udBcEYhidGY2CFtEIx9dH3cqTlIH7QnBREBNWkwV5NHfqhvQCCjngKWCZs
 seA=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="43066912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 05:28:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 05:28:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 05:28:07 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/3] ARM: configs: at91: DT/ATAG defconfig modifications
Date:   Fri, 5 Feb 2021 13:27:55 +0100
Message-ID: <c0b80a6247a3ab33d728e572f771bcefbef497c0.1612528021.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <bc06f0943bd93dd8c7e2f763f792074ce79c5b64.1612528021.git.nicolas.ferre@microchip.com>
References: <bc06f0943bd93dd8c7e2f763f792074ce79c5b64.1612528021.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

As all AT91 platforms are converted to DT for a long time, adapt the
defconfigs by:
- removing legacy CONFIG_ATAGS as a DT will always be provided;
- removing the CONFIG_ARM_APPENDED_DTB option on SAMA5 devices as the
  vast majority of systems will use a DT-aware bootloader on these
  devices.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 arch/arm/configs/sama5_defconfig   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e274f8c492d2..3e4adbd30a53 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -17,6 +17,7 @@ CONFIG_SOC_SAM9X60=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
+# CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 64573caa0ecd..b72bd38a1c45 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -19,7 +19,7 @@ CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_ARM_APPENDED_DTB=y
+# CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
 CONFIG_KEXEC=y
 CONFIG_VFP=y
-- 
2.30.0

