Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01BF33D05B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhCPJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:11:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15506 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhCPJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615885826; x=1647421826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Key+2iKL38M/BSOAh81U/K72xgggpmsGs3yXXt3WQE=;
  b=gzRLJiqwpRewYCpANX2QivgnvO2Adlc0x33Z3+zopAvUwugGQn5x5kuO
   OzifIOwTWN4VCNYIwKp8AFHELCxBI6j92vMa42J8RfSvmAyLzCGez1dgG
   nkEH5rPYN9EBF7E/vnEe6PUti2CBBX0ccj8fDB1n5bkCmuFPfk/x9t7F6
   cANKLFJsMbLrysxhdi6yO1e9/BL5PnKca5wkcwQS5uTWuM38gEc8o8kGa
   Ciq1rAlpl5jShlejG3d8AtdPEkkEmgcFY1e5njodWIIM4OOeNZQPljNWr
   J4diCk1pV9WCVIacOLfDJp0SCuH7bgGa1coI+jExO5Sm7KxgkCJeBBN7H
   A==;
IronPort-SDR: cPYFzHQH/xRbNznlMbvR00a9jgdOzuouB3dWYtHCEGiGh6Dhnj5/OIiOZuqokhrCvMGmEQNgsV
 M/QssLNFjsaNym+nfKMhuxToefhDNmpLFxDRjV0tEKckaWPYOujihiVTWq38ydm08OtNX/hWx6
 Px0FAlh7ytlQDoBMDSzek+1NOVTFuabUi5oqskz0Yp+c5+q5sRvo7AoCLpebJ0IuQ3h453zsWJ
 zqPz2H5GiB+PuBQWmvFUGZCUSj2IwUNLTEaXl5TEZC4H2j3EZ0JvLrAc9UGdVO6FcFaGuGIa4T
 xtA=
X-IronPort-AV: E=Sophos;i="5.81,251,1610434800"; 
   d="scan'208";a="47683728"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 02:08:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 02:08:56 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 02:08:54 -0700
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
Subject: [PATCH v8 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Tue, 16 Mar 2021 10:08:39 +0100
Message-ID: <20210316090839.3207930-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316090839.3207930-1-steen.hegelund@microchip.com>
References: <20210316090839.3207930-1-steen.hegelund@microchip.com>
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
2.30.2

