Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DC4389D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJXPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:31:05 -0400
Received: from bbox.sascha.silbe.org ([46.38.230.149]:43987 "EHLO
        bbox.sascha.silbe.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJXPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:31:04 -0400
Received: from brick.sascha.silbe.org (brick.sascha.silbe.org [192.168.1.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "brick.sascha.silbe.org", Issuer "stunnel Pseudo-CA" (verified OK))
        by bbox.sascha.silbe.org (Postfix) with ESMTPS id D111F60F18;
        Sun, 24 Oct 2021 17:28:41 +0200 (CEST)
Received: (nullmailer pid 649825 invoked by uid 71000);
        Sun, 24 Oct 2021 15:28:41 -0000
From:   Sascha Silbe <x-linux@se-silbe.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: add defines for IOMUXC_SW_PAD_CTL register values
Date:   Sun, 24 Oct 2021 17:28:32 +0200
Message-Id: <20211024152832.649738-1-x-linux@se-silbe.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMUXC_SW_PAD_CTL_* registers on i.MX8M Dual/QuadLite/Quad all
have the same basic structure. Add defines for a common subset
supported by most of the registers. They can be used in Device Tree
source files instead of magic values, making the sources a lot more
readable and easier to write as well.

Signed-off-by: Sascha Silbe <x-linux@se-silbe.de>
---
 .../arm64/boot/dts/freescale/imx8mq-pinfunc.h | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

The board I'm using this for is an out-of-tree prototype. If there's
interest I can convert the in-tree DTS files. I have don't have any of
those boards but comparing the built DTBs before vs. after the change
should be sufficient.


diff --git a/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
index 68e8fa1729741..384ceb5422761 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
@@ -7,6 +7,34 @@
 #ifndef __DTS_IMX8MQ_PINFUNC_H
 #define __DTS_IMX8MQ_PINFUNC_H
 
+/* Software Input On bit from IOMUXC_SW_MUX_CTL_PAD_* registers. Magic
+ * value defined in
+ * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+ */
+#define PAD_SION (1 << 30)
+/* input high/low thresholds, 0 = LVCMOS, 1 = LVTTL */
+#define PAD_LVTTL (1 << 8)
+/* Schmitt-Trigger, 0 = disabled, 1 = enabled */
+#define PAD_HYS (1 << 7)
+/* Internal pull-up resistor, 0 = disabled, 1 = enabled */
+#define PAD_PUE (1 << 6)
+/* Open Drain, 0 = push-pull, 1 = open drain */
+#define PAD_ODE (1 << 5)
+/* Slew Rate, 50/100/150/200 MHz */
+#define PAD_SRE_50MHZ 0
+#define PAD_SRE_100MHZ (1 << 3)
+#define PAD_SRE_150MHZ (2 << 3)
+#define PAD_SRE_200MHZ (3 << 3)
+/* Drive Strength; names are based on nominal impedance at 3.3V */
+#define PAD_DSE_HIZ 0
+#define PAD_DSE_255OHM 1
+#define PAD_DSE_105OHM 2
+#define PAD_DSE_75OHM 3
+#define PAD_DSE_85OHM 4
+#define PAD_DSE_65OHM 5
+#define PAD_DSE_45OHM 6
+#define PAD_DSE_40OHM 7
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

base-commit: 9c0c4d24ac000e52d55348961d3a3ba42065e0cf
prerequisite-patch-id: d2d09cbe2907cd6c1ece0fcc6b576faf1ef8dd37
prerequisite-patch-id: 42e69450ab3e60fd3705232ae05fa1c8acfb467b
prerequisite-patch-id: 9360e270fb7fbccc22d2a66c41830746bdb80784
-- 
2.30.2

