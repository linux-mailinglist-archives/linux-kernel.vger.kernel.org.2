Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D132311A06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBFD2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:28:48 -0500
Received: from inva020.nxp.com ([92.121.34.13]:49130 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhBFCni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:43:38 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E66E11A179A;
        Sat,  6 Feb 2021 00:50:51 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 960EF1A023C;
        Sat,  6 Feb 2021 00:50:51 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0B0B740A63;
        Fri,  5 Feb 2021 16:50:51 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 06/15] ARM: dts: ls1021a: update pcie nodes for dt-schema check
Date:   Fri,  5 Feb 2021 17:47:25 -0600
Message-Id: <20210205234734.3397-7-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
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
index 4bf6320c85d9..959a3c85b83e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -842,8 +842,8 @@
 
 		pcie@3400000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
-			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03400000 0x0 0x00010000>, /* controller registers */
+			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
 			fsl,pcie-scfg = <&scfg 0>;
@@ -852,8 +852,8 @@
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
@@ -866,8 +866,8 @@
 
 		pcie@3500000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
-			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03500000 0x0 0x00010000>, /* controller registers */
+			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,pcie-scfg = <&scfg 1>;
@@ -876,8 +876,8 @@
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
2.17.1

