Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3144CC96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhKJWZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:25:39 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36298 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233642AbhKJWZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:25:26 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77C561A119E;
        Wed, 10 Nov 2021 23:22:37 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 168711A1196;
        Wed, 10 Nov 2021 23:22:37 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7588B40BCF;
        Wed, 10 Nov 2021 15:22:36 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 09/11] arm64: dts: lx2160a: add pcie EP mode nodes
Date:   Wed, 10 Nov 2021 16:21:58 -0600
Message-Id: <20211110222200.6780-10-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211110222200.6780-1-leoyang.li@nxp.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

The LX2160A PCIe EP mode nodes based on controller used on lx2160a rev2.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 05a3d403fe0c..7835ad42da04 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1115,6 +1115,16 @@ pcie1: pcie@3400000 {
 			status = "disabled";
 		};
 
+		pcie_ep1: pcie_ep@3400000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x80 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <8>;
+			num-ib-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie2: pcie@3500000 {
 			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -1143,6 +1153,16 @@ pcie2: pcie@3500000 {
 			status = "disabled";
 		};
 
+		pcie_ep2: pcie_ep@3500000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x88 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <8>;
+			num-ib-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie3: pcie@3600000 {
 			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -1171,6 +1191,16 @@ pcie3: pcie@3600000 {
 			status = "disabled";
 		};
 
+		pcie_ep3: pcie_ep@3600000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+			       0x90 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <256>;
+			num-ib-windows = <24>;
+			status = "disabled";
+		};
+
 		pcie4: pcie@3700000 {
 			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
@@ -1199,6 +1229,16 @@ pcie4: pcie@3700000 {
 			status = "disabled";
 		};
 
+		pcie_ep4: pcie_ep@3700000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03700000 0x0 0x00100000
+			       0x98 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <8>;
+			num-ib-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie5: pcie@3800000 {
 			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
@@ -1227,6 +1267,16 @@ pcie5: pcie@3800000 {
 			status = "disabled";
 		};
 
+		pcie_ep5: pcie_ep@3800000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03800000 0x0 0x00100000
+			       0xa0 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <256>;
+			num-ib-windows = <24>;
+			status = "disabled";
+		};
+
 		pcie6: pcie@3900000 {
 			compatible = "fsl,ls2088a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
@@ -1255,6 +1305,16 @@ pcie6: pcie@3900000 {
 			status = "disabled";
 		};
 
+		pcie_ep6: pcie_ep@3900000 {
+			compatible = "fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03900000 0x0 0x00100000
+			       0xa8 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ob-windows = <8>;
+			num-ib-windows = <8>;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.25.1

