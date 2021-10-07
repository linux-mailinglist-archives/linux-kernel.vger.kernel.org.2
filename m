Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6342602D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhJGXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:08:22 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33146 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhJGXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:08:20 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ED60E83651;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1633647981;
        bh=uUekCejAnirxuenb1bdmJTf1s5Qm7uQA4xDwgWAaD7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=1ICtPeKnDlZlbzwHsYzrtpkb5KzqqlANVZS8VfLCXDCruVlT+wR92+vNExVX3rMB1
         z/fQLsRhpjKZGBRmpEmP5fzuqlv1YKdWkZScTW2AVYlcJ+xRvppByg0TnuqlqyxIwo
         5hak2uu/6CFLD5ycipFP9U3qgGglBGNc+04bkHxfGnEIx89siNFWUwm/cRe2WKpLNH
         xrgCSrGDpxdVIsWYRq6iThEVWhgFfilDYfE9I7ABShZDwRb8CYx3vCir/KCfa2k9pS
         IMlcjYehWHTQPBolltEY/nxWiweHoGFEuGaDu0PqvfbB/jqmApniDgpljEN/S0e+UV
         sIG4acUnpxaTQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B615f7d6d0002>; Fri, 08 Oct 2021 12:06:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id BFCEA13EE39;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BE7112A0B00; Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device tree
Date:   Fri,  8 Oct 2021 12:06:19 +1300
Message-Id: <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fKRHIqSe c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=IKpnBzii7tR9GoWT8zoA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CN9130-CRB boards have a MV88E6393X switch connected to eth0.  Add
the necessary dts nodes and properties for this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

This is taken from the Marvell SDK. I've re-ordered the port entries to
be in ascending order.

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 125 ++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index e7918f325646..171f7394948e 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -185,6 +185,131 @@ &cp0_mdio {
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
+
+		dsa,member =3D <0 0>;
+
+		ports {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			port@0 {
+				reg =3D <0>;
+				label =3D "notused-port0";
+				phy-mode =3D "10gbase-kr";
+				status =3D "disabled";
+
+			};
+
+			port@1 {
+				reg =3D <1>;
+				label =3D "wan1";
+				phy-handle =3D <&switch0phy1>;
+			};
+
+			port@2 {
+				reg =3D <2>;
+				label =3D "lan2";
+				phy-handle =3D <&switch0phy2>;
+			};
+
+			port@3 {
+				reg =3D <3>;
+				label =3D "lan3";
+				phy-handle =3D <&switch0phy3>;
+			};
+
+			port@4 {
+				reg =3D <4>;
+				label =3D "lan4";
+				phy-handle =3D <&switch0phy4>;
+			};
+
+			port@5 {
+				reg =3D <5>;
+				label =3D "lan5";
+				phy-handle =3D <&switch0phy5>;
+			};
+
+			port@6 {
+				reg =3D <6>;
+				label =3D "lan6";
+				phy-handle =3D <&switch0phy6>;
+			};
+
+			port@7 {
+				reg =3D <7>;
+				label =3D "lan7";
+				phy-handle =3D <&switch0phy7>;
+			};
+
+			port@8 {
+				reg =3D <8>;
+				label =3D "lan8";
+				phy-handle =3D <&switch0phy8>;
+			};
+
+			port@9 {
+				reg =3D <9>;
+				label =3D "wanp9";
+				phy-mode =3D "10gbase-kr";
+				fixed-link {
+					speed =3D <10000>;
+					full-duplex;
+				};
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

