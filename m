Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A071430D57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbhJRBOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344947AbhJRBOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:14:33 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249FBC061769
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 18:12:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4725A891B0;
        Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1634519534;
        bh=O2UYL2vwwrFX+xVYrMAyYBcqHgKcOdHT45FDP++g4Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SCHxk1QCDgiN3ArAQF0bVGLskU52pq/Fl8wt4sel5e09N+czgx0uac1zllfbbWvvf
         uhfsHwuxfErTO0ho473pYki1BVcgsL0SfO/EaG5xpwcbwggmPgleZqa73a5aOyRp+6
         +Ssdtq8mM9+NxVeyTfr8QAfIAOQdDkKgCRGE6UrgEC4a9Y+1X7SBjzTMg0RdKwThhj
         T6p4RE3qggZeag06kqWxvWMnMaA7RN99qpAsz3Vem0aMsuugBWBabj2yUKph0M8AvP
         5z5p98KJ9UfRLf/R20kODzKF+7QtVV+kof0tAGXB7aXLyQYSFgFOXG3saJ1uoQx6jl
         ibBthkcGHWRow==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B616cc9ee0002>; Mon, 18 Oct 2021 14:12:14 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 2F49013ED1E;
        Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2D8E82A0B00; Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device tree
Date:   Mon, 18 Oct 2021 14:12:11 +1300
Message-Id: <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=RPquEeSGPLc92inKvdoA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CN9130-CRB boards have a MV88E6393X switch connected to eth0. Add
the necessary dts nodes and properties for this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
This is based on the Marvell SDK. I've re-ordered the port entries to
be in ascending order renamed the wan ports and connected the SFP+.

Changes in v2:
- Remove unused port0
- Label all ports "pN"
- Add interrupt connections
- Add SFP

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 129 ++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index 0885c6339d1b..d600422afd6c 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -73,6 +73,16 @@ cp0_reg_sd_vcc: cp0_sd_vcc@0 {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	sfp: sfp {
+		compatible =3D "sff,sfp";
+		i2c-bus =3D <&cp0_i2c1>;
+		mod-def0-gpios =3D <&expander0 3 GPIO_ACTIVE_LOW>;
+		los-gpio =3D <&expander0 15 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpio =3D <&expander0 2 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio =3D <&cp0_gpio1 24 GPIO_ACTIVE_HIGH>;
+		status =3D "okay";
+	};
 };
=20
 &uart0 {
@@ -195,6 +205,125 @@ &cp0_mdio {
 	phy0: ethernet-phy@0 {
 		reg =3D <0>;
 	};
+
+	switch6: switch0@6 {
+		/* Actual device is MV88E6393X */
+		compatible =3D "marvell,mv88e6190";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		reg =3D <6>;
+		interrupt-parent =3D <&cp0_gpio1>;
+		interrupts =3D <28 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+
+		dsa,member =3D <0 0>;
+
+		ports {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			port@1 {
+				reg =3D <1>;
+				label =3D "p1";
+				phy-handle =3D <&switch0phy1>;
+			};
+
+			port@2 {
+				reg =3D <2>;
+				label =3D "p2";
+				phy-handle =3D <&switch0phy2>;
+			};
+
+			port@3 {
+				reg =3D <3>;
+				label =3D "p3";
+				phy-handle =3D <&switch0phy3>;
+			};
+
+			port@4 {
+				reg =3D <4>;
+				label =3D "p4";
+				phy-handle =3D <&switch0phy4>;
+			};
+
+			port@5 {
+				reg =3D <5>;
+				label =3D "p5";
+				phy-handle =3D <&switch0phy5>;
+			};
+
+			port@6 {
+				reg =3D <6>;
+				label =3D "p6";
+				phy-handle =3D <&switch0phy6>;
+			};
+
+			port@7 {
+				reg =3D <7>;
+				label =3D "p7";
+				phy-handle =3D <&switch0phy7>;
+			};
+
+			port@8 {
+				reg =3D <8>;
+				label =3D "p8";
+				phy-handle =3D <&switch0phy8>;
+			};
+
+			port@9 {
+				reg =3D <9>;
+				label =3D "p9";
+				phy-mode =3D "10gbase-r";
+				sfp =3D <&sfp>;
+				managed =3D "in-band-status";
+			};
+
+			port@10 {
+				reg =3D <10>;
+				label =3D "cpu";
+				ethernet =3D <&cp0_eth0>;
+			};
+
+		};
+
+		mdio {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			switch0phy1: switch0phy1@1 {
+				reg =3D <0x1>;
+			};
+
+			switch0phy2: switch0phy2@2 {
+				reg =3D <0x2>;
+			};
+
+			switch0phy3: switch0phy3@3 {
+				reg =3D <0x3>;
+			};
+
+			switch0phy4: switch0phy4@4 {
+				reg =3D <0x4>;
+			};
+
+			switch0phy5: switch0phy5@5 {
+				reg =3D <0x5>;
+			};
+
+			switch0phy6: switch0phy6@6 {
+				reg =3D <0x6>;
+			};
+
+			switch0phy7: switch0phy7@7 {
+				reg =3D <0x7>;
+			};
+
+			switch0phy8: switch0phy8@8 {
+				reg =3D <0x8>;
+			};
+		};
+	};
 };
=20
 &cp0_xmdio {
--=20
2.33.0

