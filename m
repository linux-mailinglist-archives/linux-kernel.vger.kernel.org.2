Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792703F94D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbhH0HGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:06:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59696 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244388AbhH0HGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:06:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FE771A1B29;
        Fri, 27 Aug 2021 09:05:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 087111A1B12;
        Fri, 27 Aug 2021 09:05:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EECB7180222A;
        Fri, 27 Aug 2021 15:05:13 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
Date:   Fri, 27 Aug 2021 14:43:00 +0800
Message-Id: <1630046580-19282-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, but the ranges should be grouped by region.
Otherwise, schema dtbs_check would report the following errors.

"/linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
        /linux-imx/arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: pcie@33800000: ranges: 'oneOf' conditional failed, one must be fixed:
                [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152]] is not of type 'boolean'
                True was expected
                [[2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152]] is not of type 'null'
        [2164260864, 0, 0, 536346624, 0, 65536, 2181038080, 0, 402653184, 402653184, 0, 133169152] is too long
        From schema: //linux-imx/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml"

Refer to commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows").
The num-viewport is not required anymore, remove them totally.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..c6dba9b92edd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1364,10 +1364,9 @@ pcie0: pcie@33800000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
-			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			num-viewport = <4>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
@@ -1402,10 +1401,9 @@ pcie1: pcie@33c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
-				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000>, /* downstream I/O 64KB */
+				  <0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			num-viewport = <4>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
-- 
2.25.1

