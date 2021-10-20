Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0065D434839
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJTJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:49:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58600 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJTJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723236; x=1666259236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URipOdsLH8qC+kXFhsmFA9PY9uWuO/jRnDNcvGWY+Ng=;
  b=RmEoepO3Zxb7440Z+I2NMzcyYJ6T/yol5TEUVADkGsWQFuz5faH82LGf
   Uk4qqN/f5vWL6JcZNarEHY7hkZ8V0yotmfI2oMflXz2L6MHGJmR/t+edP
   cKPTv6CcNTQRiyjm2bXirZYQRVXVtBeiS4wy0wFXFLy2z1opyXGAQRzHj
   a6lTeDorV97UcfmMGmAdrlJqFQIeSEDGSQBRkmAuOmra6mYh9UFGBcsvw
   qn6mp8JfgJy5rsgPqpYHpSHjYVygmVxnymgk1LGYZeUduCGkT8DmrlHMU
   /FPQxRbNrs0x7pEVzgFTJDfENpEmSVK8dMK0BjtYZ9HEV9pkbDnb8b7RR
   w==;
IronPort-SDR: 0Ivpew15024BrrpqJAYuw8rPcBRubCaQkm5Sw4bOf4H23UDixpvPun/51Up5kMDoH1DNt5Nt3Q
 wOKYFvbxedr25kdOL9V6bY2j+C5dRJiq4Aw7rzRaEKF7k2M+0D/fSaeMlaHTgZcLHqvCK5I/QC
 X5v6m4pgt3eF3v22b+NBcGpv6IkKFEx2osFh2vRl+HUlBN26x0DQfWSO5Dm/KaGSWrRZ7f/D6t
 2L5GuNNhRGKRTDzweVqV03+5NQBWnGi0FEdB3QAYO/vibL4DgvOIeF2b5rYz4XJMCoeaYd8/3W
 0TtNyE4I9978ULTKEU7Aj5ap
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="133739628"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:47:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:47:14 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:47:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: sama7g5-ek: use blocks 0 and 1 of TCB0 as cs and ce
Date:   Wed, 20 Oct 2021 12:46:56 +0300
Message-ID: <20211020094656.3343242-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
References: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use blocks 0 and 1 of TCB0 for clocksource and clockevent functionality.
PIT64B is already enabled on SAMA7G5 targets for this but TCB0 will be
used as a fallback only in case PIT64B will fail to probe.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 0f53b2db28a2..0e1975c6812e 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -687,6 +687,18 @@ &spdiftx {
 	status = "okay";
 };
 
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
 &trng {
 	status = "okay";
 };
-- 
2.25.1

