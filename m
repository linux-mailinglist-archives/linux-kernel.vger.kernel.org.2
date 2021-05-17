Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3D383AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhEQRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241631AbhEQRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6942611CC;
        Mon, 17 May 2021 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271545;
        bh=cyY22xFqexKdxXp/ll0BXA6m1dHYnk2rXQrVX8p7Kz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIOOKy0oBUydLraNFdkcl4f+rOXM1flq6BCIsOXaa1tx25jT5KEMKPkkakNlAtrvz
         7uRH95b7TQCSSr0XcRiIjph63RVzF+kLstkBPnvrVmaqLXtP3mINbXNsQXBIVWQbj2
         g82xGY0WsuXSvKhJkbrsV08pxcCg6JhB1TYVJ2QC9kU+16eY72UEZDTbt1noibldns
         eshVdhvUzPqDJeOzl2yDnTDloXxU+4n4o8I6nyecJMOinZMFaea6s47MVPdlif2EIw
         lDJC+jnfpnv2EESRHWeY8n1jYUdUK75VIlbqtCA+/t/5dtXgDqjI4fHLqiR40x76Mp
         LXJUIaiJplFeQ==
From:   abelvesa@kernel.org
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 6/7] arm64: dts: freescale: Add lsio subsys dtsi for imx8dxl
Date:   Mon, 17 May 2021 20:12:04 +0300
Message-Id: <20210517171205.1581938-7-abelvesa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517171205.1581938-1-abelvesa@kernel.org>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

On i.MX8DXL, the LSIO subsystem includes below devices:

1x Inline Encryption Engine (IEE)
1x FlexSPI
4x Pulse Width Modulator (PWM)
5x General Purpose Timer (GPT)
8x GPIO
14x Message Unit (MU)
256KB On-Chip Memory (OCRAM)

compared to the common imx8-ss-lsio dtsi, some nodes' interrupt
property need to be updated.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
new file mode 100644
index 000000000000..7496a38694df
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019-2021 NXP
+ */
+&lsio_gpio0 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio1 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio2 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio3 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio4 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio5 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio6 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_gpio7 {
+	compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
+	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_mu0 {
+	compatible = "fsl,imx8dxl-mu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_mu1 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_mu2 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_mu3 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lsio_mu4 {
+	compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.31.1

