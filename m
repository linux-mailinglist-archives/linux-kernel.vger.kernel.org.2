Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC91D44D5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhKKLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:19:26 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33972 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhKKLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:19:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68CFE201372;
        Thu, 11 Nov 2021 12:16:35 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BB7B20136F;
        Thu, 11 Nov 2021 12:16:35 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E25E62039A;
        Thu, 11 Nov 2021 12:16:34 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: freescale: imx8mq: Disable noc dts node
Date:   Thu, 11 Nov 2021 13:16:09 +0200
Message-Id: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding interconnect properties to the consumer nodes creates
a dependency on noc device. The imx-bus devfreq driver is not usable
without the full interconnect support. The interconnect is not yet
working on i.MX platforms. The devlink created on device_add makes
the lcdif and other nodes that have the interconnect properties
wait for the noc (imx-bus driver) to probe first.

To make sure the interconnect consumers (nodes that have interconnect
properties already added) will still probe, lets disable the noc node
for now. Once the interconnect on i.MX platforms is fully functional,
the status of the noc node can be changed.

Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect for lcdif")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 972766b67a15..f3182878f596 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1305,6 +1305,7 @@ noc: interconnect@32700000 {
 			fsl,ddrc = <&ddrc>;
 			#interconnect-cells = <1>;
 			operating-points-v2 = <&noc_opp_table>;
+			status = "disabled";
 
 			noc_opp_table: opp-table {
 				compatible = "operating-points-v2";
-- 
2.31.1

