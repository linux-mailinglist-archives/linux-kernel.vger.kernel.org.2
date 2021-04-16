Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2C361BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhDPIll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:41:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4861 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbhDPIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618562466; x=1650098466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xboU3TO7GJRPpG7WTJfaV2IWSqO0VeAzKYAu121oemk=;
  b=YydCYjO5OLgNMX8h2lAx20sJjGWoVg+EorRIbLKTrbhpBAybXhp6shrX
   pDl6wOT8E/XAOm88/EPPhy4vJh1CQu6fYK+XLXWWbh/m7D0hu49/ITzGC
   GepcWEGxenG2UDxzAovEjUzKWOAvMr38Xna2XdZgMZHdoPhDRKj/HSysv
   vEqVAgqSi+5BcAj0DEnLfZijW3uEt+1Fft5X67J4tJwPBy+eKr4WKP2Kq
   gg6YT1cfUZejEOO9zFzA3RbS3WOxAoHi6mIIJT/HkEiLFdfvxRnKCE7NG
   QgKtSbgv3yS2HBDWtWB1jPaa0uYieQsjWCovGpRnGhSg0uZqx7rcVFiEy
   Q==;
IronPort-SDR: JSWFwF3awOSEQ3akSCeSKD45X3NpLH0YyknPPOgcJR94ZsEiggTU/oFclO8tV5jmD4QJOL/dBF
 ALUbxnZ3FHK4CUzoEz7e1PSD6gaWFmcItkdb+SJ/nXHa37i7oFynx9gHwVn1YNFd/yk+i1Obfy
 H2BJIa7m3agPeQ29C+L6QWnA4Qo3jdDDgSlUrDxE/ueqKsr94szIX2lF0c6d9JsM+Tdvskahn4
 XyMyAXJIDdruThOtWv53o1yncMH9M8tNFUV7AjMYX35QkO8UAzC5xMPVIOu2k/6wb+lsI1ffCr
 fwU=
X-IronPort-AV: E=Sophos;i="5.82,226,1613458800"; 
   d="scan'208";a="111062406"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Apr 2021 01:41:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 01:41:06 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Apr 2021 01:41:03 -0700
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
Subject: [PATCH v9 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Fri, 16 Apr 2021 10:40:54 +0200
Message-ID: <20210416084054.2922327-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416084054.2922327-1-steen.hegelund@microchip.com>
References: <20210416084054.2922327-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides reset driver support for the Microchip Sparx5 PCB134 and
PCB135 reference boards.

The Sparx5 Switch will no longer use the Ocelot Chip Reset Driver (with the
compatible string "microchip,sparx5-chip-reset"), but use a separate driver
that exposes a reset controller interface and has the compatiple string
"microchip,sparx5-switch-reset".

Eventually the Sparx5 reset support will be removed from the Ocelot chip
reset driver.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 380281f312d8..dc3ada5cf9fc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -132,9 +132,12 @@ mux: mux-controller {
 			};
 		};
 
-		reset@611010008 {
-			compatible = "microchip,sparx5-chip-reset";
+		reset: reset-controller@611010008 {
+			compatible = "microchip,sparx5-switch-reset";
 			reg = <0x6 0x11010008 0x4>;
+			reg-names = "gcb";
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
 		};
 
 		uart0: serial@600100000 {
-- 
2.31.1

