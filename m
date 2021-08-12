Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4D3EA634
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhHLOId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:08:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7727 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhHLOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628777287; x=1660313287;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p0EZrYR3bmKudOTePlI57y+XvEl2pslcz4rbLPhHVW0=;
  b=T/YUscArP2chnoPBBdVUeUGkC5ZWBQl3/+g3vrYqeLtk6drYfGNWNGf2
   VSPG2nQcx47cn5OzBikMRcGOmZ/RlghEGpnZnB1vF+n8MwdVsjm/c+BG2
   LikNkHaS+tBufKU5GK90PsB4LwVXscg/FlE5jv4HRUk+HsFTc2Gt7uLrv
   xK7fec7mWdo9j6rZN9ioYLshqxc4xx3W4seu9G1/fyQk1h7pafm3Alnm8
   tpD1Xlj9EPzVUQvONX6x3lWEs8KNINuwRRFppMJummZWMH1Jd8QITptg4
   6ohC9IIlqCekWJarDMgIo78PjYMhBv/LwfYQiZzsjoMd82r72nMZ2gIYo
   Q==;
IronPort-SDR: INc926UWL/x9IkCie/fyCB58bKtFh1I/jq1RbOcE0m8Cunty/Xbw4eRd6mcEZRRmywDPHRsNiC
 wXvP0LjRRaKcTBNmYptCdws4cegarndo/bMM3/V8/4MhHs5oUYVd1V8NLdVb10QeEVBRL7wc4z
 Vq7tRhmqbC/Kp9sdwWVIqXcCGj/6UTl+asoF84cF+l5IlZmlkmnX3gcj39WQsfZ7BaX7OKaP3h
 58OQ/d+5Mhw+Pr6CWS/kIkICL0tZ0EujrEMGnQHiuDrvdnbbeRt+PRs+Kk3qg3K14vLHP4ZSh5
 XM9BtpJAbYHJEpgVVIqaQpJ/
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="139830325"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2021 07:08:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 07:08:05 -0700
Received: from che-lt-i63539u.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 12 Aug 2021 07:08:01 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH 1/2] ARM: at91: dts: sama5d29: Add dtsi file for sama5d29
Date:   Thu, 12 Aug 2021 19:37:57 +0530
Message-ID: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new dtsi file for sama5d29 SoC is added which basically inherits the sama5d2
dtsi with the mac controller compatible property updated.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/sama5d29.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm/boot/dts/sama5d29.dtsi

diff --git a/arch/arm/boot/dts/sama5d29.dtsi b/arch/arm/boot/dts/sama5d29.dtsi
new file mode 100644
index 000000000000..e8cc73c0619f
--- /dev/null
+++ b/arch/arm/boot/dts/sama5d29.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * sama5d29.dtsi - Device Tree Include file for SAMA5D29 SoC of the SAMA5D2
+ * family.
+ *
+ *  Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ *  Author: Hari Prasath <Hari.PrasathGE@microchip.com>
+ *
+ */
+
+#include "sama5d2.dtsi"
+
+&macb0 {
+compatible = "atmel,sama5d29-gem";
+};
-- 
2.17.1

