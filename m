Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23219383ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhEQRNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240274AbhEQRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:13:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 173B66128E;
        Mon, 17 May 2021 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271543;
        bh=on0H7PFAwJ9gP7BMtF10GYr1ZwfLRpy2++Apw/2mnOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nstp49HsHWy8xPy/k5CO6CQrGKtkcfHo8LLZME/pNDA8DM+KBv6/YCrX7W3ULqm+C
         /LmYKq/FZ8QfYe1o953ENxE1Lo/NSi0ClbqpYr3LxbK+HCElvYracnuCIqpWTXVXVm
         a+m3eGAqtswU5L3HkwbyH6+t45qvkh5Q/1LczDTQYapDK+U7cO63F8vcej/gGak0jU
         pfQp3jnh6E788QhtZZtQvbPL0R9mCmajyh0vee3sWvvhUZumCLOaaNq//2BpnwScWo
         gZwNWJAAVLsapRyLua5xQXpPjimjrWWxk+6NJS5ECbDXVrRPjpLkvbx+i/PrxQTCWp
         4Klul4GwnAj/g==
From:   abelvesa@kernel.org
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 5/7] arm64: dts: freescale: Add ddr subsys dtsi for imx8dxl
Date:   Mon, 17 May 2021 20:12:03 +0300
Message-Id: <20210517171205.1581938-6-abelvesa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517171205.1581938-1-abelvesa@kernel.org>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add the ddr subsys dtsi for i.MX8DXL. Additional db pmu is added
compared to i.MX8QXP.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
new file mode 100644
index 000000000000..640b43f5ae97
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 NXP
+ */
+
+&ddr_subsys {
+	db_ipg_clk: clock-db-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <456000000>;
+		clock-output-names = "db_ipg_clk";
+	};
+
+	db_pmu0: db-pmu@5ca40000 {
+		compatible = "fsl,imx8dxl-db-pmu";
+		reg = <0x5ca40000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&db_pmu0_lpcg 1>, <&db_pmu0_lpcg 0>;
+		clock-names = "ipg", "cnt";
+		power-domains = <&pd IMX_SC_R_PERF>;
+	};
+
+	db_pmu0_lpcg: clock-controller@5cae0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5cae0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&db_ipg_clk>, <&db_ipg_clk>;
+		bit-offset = <0 16>;
+		clock-output-names = "perf_lpcg_cnt_clk",
+				     "perf_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_PERF>;
+	};
+};
-- 
2.31.1

