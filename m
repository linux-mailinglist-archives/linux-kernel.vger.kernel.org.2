Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3112F3EA639
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhHLOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:08:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31383 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbhHLOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628777299; x=1660313299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pmcxOQ+Qr7k+X6ziNFRPuhucl2XjO3oV1ys2iXot8CU=;
  b=apVwOlfo17MBkSEjnqflJ7zvczRwHej1O6eQ2HD/zf9V2bN2EOULm5IC
   HZOeEVYYoHpJKIO4sg4fWqMRdTSfsqyJ38kV7MMqWMKxnZzFzkSsVWVyL
   mEnnpeMxSHXs2SbaGONW5WtI/M+2oo1VklRvQmUWGk7YkUSOnCOQ81AGA
   f2+SeLeTvUYwAlIwAK6Yhk8l2pdFi5goHr1nclj3V5nE8Urx/0j7pli8X
   IGFkdwm87TOLArIGTF3rmXdFOu2Iht2LLwG8Q6thaYHUc7eVNsaeTcKwW
   HU/56hP6MUtcobX+ipXRBZ5CgRVlWBM2+4ephKUZixto93U+GhteSUKYB
   g==;
IronPort-SDR: QKG8GjeuWu+w6TuKzq6jkt4EZH3vD8C2JHpM079IpL4zXw5QdmQikzbhax+RFmJ7Q0u1jcZKv3
 fsx0QBIG7uWSujs9jSNhbDIiuBf/zni3aIN++/VVAfLB6NM99cxxmKw0WxHVO0P8CB8eqZyZG5
 5l2hfdiYLrDZbmMK00AJK42pSO9wjLMbd3qdoo8illdRI4W3O49IMtlD2Kxuw8FVL3Yy5th7Fu
 ibHJCukIm/sU8HjR/mzD/7j7/MOIfH9TJecM278G8qbejU8J0s+WTRcTb7e0cyFaPGt0+zFJsH
 ptOTMuGhxPfsV++f6it0LjJv
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="65610479"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2021 07:08:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 07:08:15 -0700
Received: from che-lt-i63539u.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 12 Aug 2021 07:08:10 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH 2/2] ARM: at91: dts: at91-sama5d2_xplained: Add comments for sama5d29
Date:   Thu, 12 Aug 2021 19:37:58 +0530
Message-ID: <20210812140758.28273-2-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for the end user for modifying the DTS file for
instantiating the sama5d29 SoC.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 627b7bf88d83..faa30063d9a9 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -6,6 +6,11 @@
  *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
  */
 /dts-v1/;
+/*
+ * Replace the line below with "sama5d29.dtsi" in order to instantiate the
+ * sama5d29 SoC of the sama5d2 family.Otherwise, leave it unchanged when
+ * using sama5d27 SoC for instance.
+ */
 #include "sama5d2.dtsi"
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
-- 
2.17.1

