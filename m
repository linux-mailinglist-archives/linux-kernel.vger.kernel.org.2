Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5A3FC873
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhHaNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:30 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36151 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhHaNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:23 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C124D22234;
        Tue, 31 Aug 2021 15:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Sz7aymJxB3vkUE84pcXTX7Xc0dvSN8CarSdMJ0aOKk=;
        b=WeflOgYTp+Q6I1DDfg7gPmMn3hspAzGEywGV/wLyw15lvxXZPV/QatYS1GZrCzs8+NdMGO
        bq6H6v735JnZJ/e0ElvJwLQqM0VIEuER/IVTiVVKolGzblRtVe9x9WJs5CwWSTOiHMFmBe
        O2fBgG7Is277iIF4DocUtkiiagFzACs=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 6/7] arm64: dts: ls1028a: move PHY nodes to MDIO controller
Date:   Tue, 31 Aug 2021 15:40:12 +0200
Message-Id: <20210831134013.1625527-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PHY nodes from the network controller to the dedicated MDIO
controller. According to Vladimir Oltean direct MDIO access via the PF,
that is when the PHY is put under the "mdio" subnode, is defeatured and
in fact the latest reference manual isn't mentioning it anymore.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../fsl-ls1028a-kontron-sl28-var1.dts         | 58 +++++++++----------
 .../fsl-ls1028a-kontron-sl28-var2.dts         | 17 ++----
 .../fsl-ls1028a-kontron-sl28-var4.dts         | 49 ++++++++--------
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 21 +++----
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 12 ++--
 5 files changed, 67 insertions(+), 90 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
index e8d31279b7a3..836a9b7d8263 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -8,7 +8,7 @@
  * None of the  four SerDes lanes are used by the module, instead they are
  * all led out to the carrier for customer use.
  *
- * Copyright (C) 2020 Michael Walle <michael@walle.cc>
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
  *
  */
 
@@ -21,43 +21,39 @@ / {
 	compatible = "kontron,sl28-var1", "kontron,sl28", "fsl,ls1028a";
 };
 
+&enetc_mdio_pf3 {
+	/* Delete unused phy node */
+	/delete-node/ ethernet-phy@5;
+
+	phy0: ethernet-phy@4 {
+		reg = <0x4>;
+		eee-broken-1000t;
+		eee-broken-100tx;
+		qca,clk-out-frequency = <125000000>;
+		qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
+		qca,keep-pll-enabled;
+		vddio-supply = <&vddio>;
+
+		vddio: vddio-regulator {
+			regulator-name = "VDDIO";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vddh: vddh-regulator {
+			regulator-name = "VDDH";
+		};
+	};
+};
+
 &enetc_port0 {
 	status = "disabled";
-	/*
-	 * Delete both the phy-handle to the old phy0 label as well as
-	 * the mdio node with the old phy node with the old phy0 label.
-	 */
+	/* Delete the phy-handle to the old phy0 label */
 	/delete-property/ phy-handle;
-	/delete-node/ mdio;
 };
 
 &enetc_port1 {
 	phy-handle = <&phy0>;
 	phy-connection-type = "rgmii-id";
 	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy0: ethernet-phy@4 {
-			reg = <0x4>;
-			eee-broken-1000t;
-			eee-broken-100tx;
-			qca,clk-out-frequency = <125000000>;
-			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-			qca,keep-pll-enabled;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-name = "VDDIO";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vddh: vddh-regulator {
-				regulator-name = "VDDH";
-			};
-		};
-	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
index f6a79c8080d1..330e34f933a3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -5,7 +5,7 @@
  * This is for the network variant 2 which has two ethernet ports. These
  * ports are connected to the internal switch.
  *
- * Copyright (C) 2020 Michael Walle <michael@walle.cc>
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
  *
  */
 
@@ -18,12 +18,6 @@ / {
 };
 
 &enetc_mdio_pf3 {
-	phy0: ethernet-phy@5 {
-		reg = <0x5>;
-		eee-broken-1000t;
-		eee-broken-100tx;
-	};
-
 	phy1: ethernet-phy@4 {
 		reg = <0x4>;
 		eee-broken-1000t;
@@ -34,14 +28,11 @@ phy1: ethernet-phy@4 {
 &enetc_port0 {
 	status = "disabled";
 	/*
-	 * In the base device tree the PHY was registered in the mdio
-	 * subnode as it is PHY for this port. On this module this PHY
-	 * is connected to a switch port instead and registered above.
-	 * Therefore, delete the mdio subnode as well as the phy-handle
-	 * property here.
+	 * In the base device tree the PHY at address 5 was assigned for
+	 * this port. On this module this PHY is connected to a switch
+	 * port instead. Therefore, delete the phy-handle property here.
 	 */
 	/delete-property/ phy-handle;
-	/delete-node/ mdio;
 };
 
 &enetc_port2 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index e65d1c477e2c..77ed0ebd2c75 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -5,7 +5,7 @@
  * This is for the network variant 4 which has two ethernet ports. It
  * extends the base and provides one more port connected via RGMII.
  *
- * Copyright (C) 2019 Michael Walle <michael@walle.cc>
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
  *
  */
 
@@ -18,33 +18,30 @@ / {
 	compatible = "kontron,sl28-var4", "kontron,sl28", "fsl,ls1028a";
 };
 
-&enetc_port1 {
-	phy-handle = <&phy1>;
-	phy-connection-type = "rgmii-id";
-	status = "okay";
+&enetc_mdio_pf3 {
+	phy1: ethernet-phy@4 {
+		reg = <0x4>;
+		eee-broken-1000t;
+		eee-broken-100tx;
+		qca,clk-out-frequency = <125000000>;
+		qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
+		qca,keep-pll-enabled;
+		vddio-supply = <&vddio>;
 
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy1: ethernet-phy@4 {
-			reg = <0x4>;
-			eee-broken-1000t;
-			eee-broken-100tx;
-			qca,clk-out-frequency = <125000000>;
-			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
-			qca,keep-pll-enabled;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-name = "VDDIO";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
+		vddio: vddio-regulator {
+			regulator-name = "VDDIO";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
 
-			vddh: vddh-regulator {
-				regulator-name = "VDDH";
-			};
+		vddh: vddh-regulator {
+			regulator-name = "VDDH";
 		};
 	};
 };
+
+&enetc_port1 {
+	phy-handle = <&phy1>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 2c6266991c38..b3e9c499e8b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree file for the Kontron SMARC-sAL28 board.
  *
- * Copyright (C) 2019 Michael Walle <michael@walle.cc>
+ * Copyright (C) 2021 Michael Walle <michael@walle.cc>
  *
  */
 
@@ -80,22 +80,19 @@ &duart1 {
 	status = "okay";
 };
 
+&enetc_mdio_pf3 {
+	phy0: ethernet-phy@5 {
+		reg = <0x5>;
+		eee-broken-1000t;
+		eee-broken-100tx;
+	};
+};
+
 &enetc_port0 {
 	phy-handle = <&phy0>;
 	phy-connection-type = "sgmii";
 	managed = "in-band-status";
 	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy0: ethernet-phy@5 {
-			reg = <0x5>;
-			eee-broken-1000t;
-			eee-broken-100tx;
-		};
-	};
 };
 
 &esdhc {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index b0967b987f8a..ea11b1eb01f8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -197,6 +197,10 @@ &duart1 {
 };
 
 &enetc_mdio_pf3 {
+	sgmii_phy0: ethernet-phy@2 {
+		reg = <0x2>;
+	};
+
 	/* VSC8514 QSGMII quad PHY */
 	qsgmii_phy0: ethernet-phy@10 {
 		reg = <0x10>;
@@ -220,14 +224,6 @@ &enetc_port0 {
 	phy-connection-type = "sgmii";
 	managed = "in-band-status";
 	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sgmii_phy0: ethernet-phy@2 {
-			reg = <0x2>;
-		};
-	};
 };
 
 &enetc_port2 {
-- 
2.30.2

