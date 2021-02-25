Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645723256B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBYTbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhBYT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:26:09 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F79C06121D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so4471280pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UEDw7hub9O5FdRrcuOTG3Nt7HEZCPDzv5ic2BSyKn0=;
        b=VhVhgDe7UQXfynuHWENeb6fQuPg4MA5dr13BxnPivsYD/v4jY0XknruWreEXwRZ7y5
         hsRt/ODIZ7zuCWsenB0pBBKjhqIn0ffTmTtZ7KpxhpZ6BjK/gsjWN9M9v7YWSSK+k1FS
         fp0ZDd34fLlXBZFGEgEf4VDBuCF2YwjMGFIuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UEDw7hub9O5FdRrcuOTG3Nt7HEZCPDzv5ic2BSyKn0=;
        b=ZxoYonP+D3mvSbQvPdsywP+mQCm5ZcvMYu8ReHv2oO/uHEAsTffpP9lUo1Vv+QGbWN
         uDxxiJrg/yGV7bk2lIiONzpl63fdL6lW0DLtzA/xHfRNtIR6mV7bGi/vw8ekNdyEpYcc
         sCdkejLmW1Ipt2rF022+752vIL1NeB/QPKCWq7sMWvXW/Xy80nceEAaTZEz+Rb5ghRuf
         myaVOdK32EvT2D7VHu5XTNtB4+BiizaOGSu0tqrp+cov5vvsOka7pS6RwXGQ0PnxxgkU
         /JcZRQmDXP3yCs4cDynN20lzO1BwBMW+DP4DhPMXaC+p/l5Lw0h26K/SY5XByKPc+Pfk
         3aYQ==
X-Gm-Message-State: AOAM533mV6OpRsv1fkqg0Wsn/Nx1MrFWqlTfWN4uoF/MCOxyH6K0y+6Y
        phuAUfmZ8f/qTO9EDVQoDfMf2A==
X-Google-Smtp-Source: ABdhPJzQmxmfC2K+xKxKbk1jGMxikxQ4Qe0BwWaq9rMLQt2/0KzIWOQu7QqsHYWjeJY3WSb7nOk5Bw==
X-Received: by 2002:a62:62c2:0:b029:1ee:1e3f:1b68 with SMTP id w185-20020a6262c20000b02901ee1e3f1b68mr2890758pfb.25.1614281129041;
        Thu, 25 Feb 2021 11:25:29 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id c78sm7025787pfc.212.2021.02.25.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:25:28 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: [PATCH v4 5/5] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
Date:   Fri, 26 Feb 2021 00:54:04 +0530
Message-Id: <20210225192404.262453-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225192404.262453-1-jagan@amarulasolutions.com>
References: <20210225192404.262453-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board.

Genaral features:
- LCD 7" C.Touch
- microSD slot
- Ethernet 1Gb
- Wifi/BT
- 2x LVDS Full HD interfaces
- 3x USB 2.0
- 1x USB 3.0
- HDMI Out
- Mini PCIe
- MIPI CSI
- 2x CAN
- Audio Out

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.

i.Core MX8M Mini needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.

PCIe, DSI, CSI nodes will add it into imx8mm-engicam-edimm2.2.dtsi once
Mainline Linux supported.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- don't create carrier board dtsi, move changes in final dts.
Changes for v3:
- don't maintain common nodes and include it, if no feature diff
Changes for v2:
- enabled fec1 node
- updated commit message
- dropped engicam from filename since it aligned with imx6 engicam
  dts files naming conventions.
- add i2c nodes
- fixed v1 comments

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts | 97 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 3b5957ff1606..d68ffa77b761 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
new file mode 100644
index 000000000000..a4a2ada14835
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "imx8mm.dtsi"
+#include "imx8mm-icore-mx8mm.dtsi"
+
+/ {
+	model = "Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit";
+	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* SD */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	no-1-8-v;
+	pm-ignore-notify;
+	keep-power-in-suspend;
+	status = "okay";
+};
-- 
2.25.1

