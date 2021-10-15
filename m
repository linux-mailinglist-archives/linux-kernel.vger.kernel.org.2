Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3442EC85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhJOIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:39:00 -0400
Received: from comms.puri.sm ([159.203.221.185]:44830 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhJOIix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:38:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B9C49DFE13;
        Fri, 15 Oct 2021 01:36:17 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xqt9ArVCZVAv; Fri, 15 Oct 2021 01:36:17 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        krzk@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC PATCH v1 4/4] arm64: dts: imx8mq-librem5-r3.dtsi: describe selfie cam XSHUTDOWN pin
Date:   Fri, 15 Oct 2021 10:35:06 +0200
Message-Id: <20211015083506.4182875-5-martin.kepplinger@puri.sm>
In-Reply-To: <20211015083506.4182875-1-martin.kepplinger@puri.sm>
References: <20211015083506.4182875-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r3 and later revisions of the Librem 5 phone include an additional switch
to control the hi846 XSHUTDOWN pin. Describe it.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
index e872eb4b1cf9..e4f8b47cce4f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
@@ -27,6 +27,19 @@ &bq25895 {
 	ti,termination-current = <144000>;  /* uA */
 };
 
+&camera_front {
+	pinctrl-0 = <&pinctrl_csi1>, <&pinctrl_r3_camera_pwr>;
+	shutdown-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
+};
+
+&iomuxc {
+	pinctrl_r3_camera_pwr: r3camerapwrgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_RX_GPIO5_IO4		0x83
+		>;
+	};
+};
+
 &proximity {
 	proximity-near-level = <25>;
 };
-- 
2.30.2

