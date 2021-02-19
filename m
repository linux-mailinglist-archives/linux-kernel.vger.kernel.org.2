Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4631FCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBSQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:06:59 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36944 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBSQCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 179861A03A9;
        Fri, 19 Feb 2021 17:01:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07F951A039C;
        Fri, 19 Feb 2021 17:01:09 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 655CA2042F;
        Fri, 19 Feb 2021 17:01:08 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 17/19] arm64: dts: imx8mq: Add interconnect properties to icc consumer nodes
Date:   Fri, 19 Feb 2021 18:00:14 +0200
Message-Id: <1613750416-11901-18-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add all the properties necessary to control the interconnect
based on the required rates all the way from consumers to the dram.
The fsl,icc-rate specifies the minimum required rate the consumer needs
in order to operate.
For now, only the fec, usdhc1 and usdhc2 are added as consumers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a64b4bf31f5..43760316052f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1112,6 +1112,9 @@ usdhc1: mmc@30b40000 {
 				             "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_USDHC1 &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <266666>;
 				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
@@ -1127,6 +1130,9 @@ usdhc2: mmc@30b50000 {
 				             "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_USDHC2 &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <266666>;
 				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
 				         <&clk IMX8MQ_CLK_USDHC2_ROOT>;
@@ -1169,6 +1175,9 @@ fec1: ethernet@30be0000 {
 				             <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&icc IMX8MQ_ICM_ENET &icc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "path";
+				fsl,icc-rate = <800000>;
 				clocks = <&clk IMX8MQ_CLK_ENET1_ROOT>,
 				         <&clk IMX8MQ_CLK_ENET1_ROOT>,
 				         <&clk IMX8MQ_CLK_ENET_TIMER>,
-- 
2.29.2

