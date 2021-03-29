Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4DD34C9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhC2Ibm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:31:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42218 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233374AbhC2IUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:20:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2AD61A0F5A;
        Mon, 29 Mar 2021 10:19:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 32CC41A26A8;
        Mon, 29 Mar 2021 10:19:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8C4DF402A8;
        Mon, 29 Mar 2021 10:19:53 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power up pcie phy
Date:   Mon, 29 Mar 2021 16:06:03 +0800
Message-Id: <1617005163-29824-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
the VREG_BYPASS bits of GPR registers should be cleared from default
value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
turned on.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 85b045253a0e..4d2035e3dd7c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -318,6 +318,7 @@
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
 		 <&pcie0_refclk>;
 	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	vph-supply = <&vgen5_reg>;
 	status = "okay";
 };
 
-- 
2.17.1

