Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9313F4B94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhHWNUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:20:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43102 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhHWNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629724769; x=1661260769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GfCpqfwty9G95EZgsnU3OM+Vn0Fn3zNv5DURgJ4uTms=;
  b=x/O83CYbpT73YqvD9La3gXJQkjduyEvcAALHDXf8WI1gQr1gX0TjvqLg
   TtW/eKJ1wAU/FVP/Pm7Z3aHQ/dtREcyIPbGctAT3EkaN3BRAuqfzNUUrX
   pMOXhtmm2Fe1mWKCW8waSTSR+G+zfSvYzsrp/n0XFgiBCF4HcnGgL9xXF
   ahINLIJjS5CsOjVjiDd8tQT+u17SA7q/TMVs6upx1sJ0EI3xO9dwRHbXa
   K11Q5D2z3qjSJ16McfOXwtg9mEaDkW7hAPNJhO5JeZwb3TcfpFjqZ+tZy
   3GcKnbGRlJcEUKwIQ5L6r/aczMbbCYs8bECSL0zHhi0K11rdchy1WJxYx
   Q==;
IronPort-SDR: igVBdNFePGPVYkV2RAbHC7IIXkVO3lfU//duS+5uB5EZ63JVQouAdxSHkEhzfL3WW+CK+q3Xn4
 ofmUHnSwgy+vUfHBw7Kvu8YHis5lqZOHy431xJifleY4TSIAZ2XFNQYLbKMFcCRAhcYzz4WU/h
 Cx42jO5eB2d8EpC+0JrmhS2LCEKjL4ESLOe1DJzLg3AXmxzTgnR9AvPR14A+qdVKi1m3D4x6e6
 VjwOyRaz8RuFQ0unhGpBZwS9Pvd4D+aEED4TsXoLG1d5Kr1+xbTYJqtU5cTG6bXCzIjy266jgx
 rmL6ewbAjoL3JA5lv/oPZSXA
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="129239608"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 06:19:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 06:19:28 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 06:19:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/4] ARM: dts: at91: sama7g5: add ram controllers
Date:   Mon, 23 Aug 2021 16:19:13 +0300
Message-ID: <20210823131915.23857-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823131915.23857-1-claudiu.beznea@microchip.com>
References: <20210823131915.23857-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RAM and RAMC PHY controllers. These are necessary for platform
specific power management code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index cc6be6db7b80..ecabab4343b6 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -515,6 +515,18 @@ spi11: spi@400 {
 			};
 		};
 
+		uddrc: uddrc@e3800000 {
+			compatible = "microchip,sama7g5-uddrc";
+			reg = <0xe3800000 0x4000>;
+			status = "okay";
+		};
+
+		ddr3phy: ddr3phy@e3804000 {
+			compatible = "microchip,sama7g5-ddr3phy";
+			reg = <0xe3804000 0x1000>;
+			status = "okay";
+		};
+
 		gic: interrupt-controller@e8c11000 {
 			compatible = "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
-- 
2.25.1

