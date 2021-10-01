Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7B41E54F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbhJAAGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:06:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60620 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350806AbhJAAGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D4371A0D85;
        Fri,  1 Oct 2021 02:04:23 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 64C741A0B57;
        Fri,  1 Oct 2021 02:04:23 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DE51B40BCF;
        Thu, 30 Sep 2021 17:04:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 05/16] ARM: dts: ls1021a: update pcie nodes for dt-schema check
Date:   Thu, 30 Sep 2021 19:04:06 -0500
Message-Id: <20211001000417.15334-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000417.15334-1-leoyang.li@nxp.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break up long values to pass dt-schema checks.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 1168ce677341..c37495eaf0b0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -842,8 +842,8 @@ usb3: usb@3100000 {
 
 		pcie@3400000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
-			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03400000 0x0 0x00010000>, /* controller registers */
+			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
 			fsl,pcie-scfg = <&scfg 0>;
@@ -852,8 +852,8 @@ pcie@3400000 {
 			device_type = "pci";
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
-				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -866,8 +866,8 @@ pcie@3400000 {
 
 		pcie@3500000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
-			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03500000 0x0 0x00010000>, /* controller registers */
+			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,pcie-scfg = <&scfg 1>;
@@ -876,8 +876,8 @@ pcie@3500000 {
 			device_type = "pci";
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
-				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
-- 
2.25.1

