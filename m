Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE042B0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhJMAId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33256 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234157AbhJMAIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE474202E32;
        Wed, 13 Oct 2021 02:06:22 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82E79202E39;
        Wed, 13 Oct 2021 02:06:22 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 11C4F40BD3;
        Tue, 12 Oct 2021 17:06:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 06/17] ARM: dts: ls1021a: update pcie nodes for dt-schema check
Date:   Tue, 12 Oct 2021 18:58:12 -0500
Message-Id: <20211012235824.31096-7-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
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
index 2f9ea0beac7a..fa4adfdf4abd 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -839,8 +839,8 @@ usb3: usb@3100000 {
 
 		pcie@3400000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
-			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03400000 0x0 0x00010000>, /* controller registers */
+			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
 			fsl,pcie-scfg = <&scfg 0>;
@@ -849,8 +849,8 @@ pcie@3400000 {
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
@@ -863,8 +863,8 @@ pcie@3400000 {
 
 		pcie@3500000 {
 			compatible = "fsl,ls1021a-pcie";
-			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
-			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg = <0x00 0x03500000 0x0 0x00010000>, /* controller registers */
+			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,pcie-scfg = <&scfg 1>;
@@ -873,8 +873,8 @@ pcie@3500000 {
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

