Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385945D94B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhKYLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhKYLey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:34:54 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E878C0613DD;
        Thu, 25 Nov 2021 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qUti78e3jsyzO7x29q3kqbuHe+yUYDFAU5I9L/Tz3As=; b=aKnH1EzIQjbVU717jKyRCHcYkc
        mcHbvOJjCyP/1D+A3NriVQ/K1ws9RM/h54p9QBf1a7AGCxG1Pac5EDUmb/dWJdyvbgvi7wX0leZ8T
        hU+2gODXqIcQQ1nXNYjeh5/MKw7sGtyVSUcs8Q8aTRdlyxoiTFQPIqdmmAdGqrc7n4rE=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqCbW-0002ws-Mq; Thu, 25 Nov 2021 12:07:50 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     john@phrozen.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v4 10/12] ARM: dts: Add PCIe support for Airoha EN7523
Date:   Thu, 25 Nov 2021 12:07:36 +0100
Message-Id: <20211125110738.41028-11-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211125110738.41028-1-nbd@nbd.name>
References: <20211125110738.41028-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the MediaTek MT7622 PCIe driver, since the PCIe IP block is nearly
identical to the one in MT7622

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/boot/dts/en7523-evb.dts | 12 +++++++
 arch/arm/boot/dts/en7523.dtsi    | 60 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
index e8e5c034cee7..af1a8dd40a41 100644
--- a/arch/arm/boot/dts/en7523-evb.dts
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -25,3 +25,15 @@ memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
+
+&pcie {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index eabf3fdb3d52..d9bdb51614b5 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -119,4 +119,64 @@ uart1: serial@1fbf0000 {
 		clock-frequency = <1843200>;
 		status = "okay";
 	};
+
+	pcie: pcie@1a140000 {
+		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
+		device_type = "pci";
+		reg = <0x1fa91000 0x1000>,
+		      <0x1fa92000 0x1000>;
+		reg-names = "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scu EN7523_CLK_PCIE>,
+			 <&scu EN7523_CLK_PCIE>;
+		clock-names = "sys_ck0", "sys_ck1";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x20000000  0 0x10000000>;
+		status = "disabled";
+
+		pcie0: pcie@0,0 {
+			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1,0 {
+			device_type = "pci";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
 };
-- 
2.30.1

