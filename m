Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8799742B0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhJMAIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33224 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhJMAIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23DFC202E3D;
        Wed, 13 Oct 2021 02:06:22 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E195B202E3B;
        Wed, 13 Oct 2021 02:06:21 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2913F40BF1;
        Tue, 12 Oct 2021 17:06:21 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 03/17] ARM: dts: ls1021a: change dma channels order to match schema
Date:   Tue, 12 Oct 2021 18:58:09 -0500
Message-Id: <20211012235824.31096-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the ordering of DMA channels was not relevant in the txt binding,
it is defined as ordered in the converted yaml schema.  Update the dts
to match the order.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 77f983b589fa..960de957f0b4 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -395,8 +395,8 @@ i2c0: i2c@2180000 {
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 39>, <&edma0 1 38>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 38>, <&edma0 1 39>;
 			status = "disabled";
 		};
 
@@ -407,8 +407,8 @@ i2c1: i2c@2190000 {
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 37>, <&edma0 1 36>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 36>, <&edma0 1 37>;
 			status = "disabled";
 		};
 
@@ -419,8 +419,8 @@ i2c2: i2c@21a0000 {
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 35>, <&edma0 1 34>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 34>, <&edma0 1 35>;
 			status = "disabled";
 		};
 
-- 
2.25.1

