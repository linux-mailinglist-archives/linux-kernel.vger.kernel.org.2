Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742D7316234
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhBJJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:28:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60220 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhBJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612948893; x=1644484893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EitwlEv438Vmd9Yz8+ODUmwaJpdWozhshK4xgZMEcb8=;
  b=uzd6CTjUCM9yY6cqS71Y2ZtRatyVPL/fdQ6nxSH5Lv5G7jOaJcJ1FRd3
   6F3kOGTSbUdNDoEOgk4uglTZfZeq37kBrz8jF269bEwHFFrrSwg9aFEyd
   UgwBsURNm8uQORshhBiaPrgH6YWjeHDstAChnyiQ1zgd5DuDDEExvv7V+
   X173ZJc5OuaAKUpuBJ/nki5FRKarcd2gQrgC5wDUDQrCkYIx6BQ14SXQ7
   WFneBE+MUhkbWk+MuUyGZAx0HJ50M0OyN0t3TBuHEPnki+mfLx2Qb45Eb
   lexswB6irzO3FIEutfb6qLxBBdzczCcndwllG/S1trDQTMAV2voAy3m2Q
   g==;
IronPort-SDR: uNJO79MzmtsEIPOMimILqv/S7zXmwRGLa8qu61ploBfYutwXXKx23U5EmNj5R3hGt+Vbj61VZq
 W+c9WFWAPKexmr2aAasRBQdaQWup8f1NImVKcJAaaEjX2/YSQ6Ly0FmkCXwcOqCwl5f7A817vz
 HrXeLtIZ0vScXdKcw54I6myvRl5Ty0/EPl4HS8ObP5itbB/SmUzje1WgcyDPUBi9UCOt/nbNc/
 ICylSPy9qD7ShEQueWA4EtOf9XPtyII5irbd7sHGMKFvuUe7x7zCdy0vCVChERQ7s8Ek8XaehF
 XMU=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="109186009"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 02:20:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 02:20:08 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 02:20:06 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Wed, 10 Feb 2021 10:19:52 +0100
Message-ID: <20210210091952.2013027-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210091952.2013027-1-steen.hegelund@microchip.com>
References: <20210210091952.2013027-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides reset driver support for the Microchip Sparx5 PCB134 and
PCB135 reference boards.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 380281f312d8..06ecaa9ac8aa 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -132,9 +132,12 @@ mux: mux-controller {
 			};
 		};
 
-		reset@611010008 {
-			compatible = "microchip,sparx5-chip-reset";
-			reg = <0x6 0x11010008 0x4>;
+		reset: reset-controller@0 {
+			compatible = "microchip,sparx5-switch-reset";
+			reg = <0x6 0x00000000 0xd0>,
+			      <0x6 0x11010000 0x10000>;
+			reg-names = "cpu", "gcb";
+			#reset-cells = <1>;
 		};
 
 		uart0: serial@600100000 {
-- 
2.30.0

