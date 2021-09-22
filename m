Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78747414A09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhIVNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:03:42 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:16302 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhIVNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315727; x=1663851727;
  h=from:to:cc:subject:date:message-id;
  bh=fgR1P7fMypMDV82haLdAlKXE1MzNIjyTj4mRCbMNxWc=;
  b=bqShPqpdWEugmmdOg5rxvhyEpr+q0JjQftqvazREaa/HnGncHK0S8a6L
   4XH5YvI9+N+a1dJQknNzCLaiFD/US3UXjb40v9I0C+zonW58xLmzCbxu5
   pBQUYGKRd2D2ciPJMRy0mFqq0xAR6HB949CpgEXCdDrGiqvzT+4OmCVQ2
   Puu7fYDN6XMa7iIX/Q5Kt0L3MTGQyipFDdppGAKw+KQR+2zoByvYrwtDW
   OK8aKUDg9l20A9FYPewkqTeFCNDCIFlVc8kwLltyBpNyA6RwpyDlvXV5r
   mULbbbL6c5Bgrs6XmvB1/YXtDJIorXZbofJddsVNbWR+50m4Qgn7bfbqr
   w==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19650010"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Sep 2021 15:01:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 22 Sep 2021 15:01:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 22 Sep 2021 15:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315700; x=1663851700;
  h=from:to:cc:subject:date:message-id;
  bh=fgR1P7fMypMDV82haLdAlKXE1MzNIjyTj4mRCbMNxWc=;
  b=k4BwJ4k+aEXJGrO3OYzJsI27FQIzyE19zQtV4IeRHcZiYaNXx8OfQIT5
   1LynqcPzqgWsI9kSJ6TYikO5TC1tlCVGy3NzApa6xkgbbfIB8FVmPdgBh
   Bc0tFgmo62QTdHT93WWADInwVe8gkxZDMgq2EHezVCEhMK1B84yo7gCq+
   rwgjRbR2fY4253bAMFHLEF181zR/i4FC1feGZWKrHWWMNM0JLUSZk06tz
   K/4vVakds80y0GugTzrwI8JEAX5lmkZt3a1CHFcZKONhtmzq+eedpn75m
   k7YKRq++oM7pix06eVG3ClwIvae0HfuptD1JwuIcowgZuLhZx/gVhpgNK
   g==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19649855"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Sep 2021 15:01:02 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id CACFA280075;
        Wed, 22 Sep 2021 15:01:01 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/3] ARM: dts: imx7-tqma7: add SPI-NOR flash
Date:   Wed, 22 Sep 2021 15:00:53 +0200
Message-Id: <11e30a17b8798800207b773b7793003d70d30420.1632314390.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
References: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
References: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI-NOR flash on the SoM was missing from the device tree.

The TQMa7 as a designated QSPI_RESET# pin, however depending on the
hardware configuration the pin may be unconnected, or be used for a
different purpose. With this in mind, we mux the pin as a pullup and
define an input hog for it, but keep it a separate pin group, so that it
is easy for dependent Device Trees to modify the configuration.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: - Add input hog for reset pin and move to separate pin group,
      explain in commit message.
    - Update flash node for modern "partitions" specification


 arch/arm/boot/dts/imx7-tqma7.dtsi | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
index 065e1668e280..fe42b0a46831 100644
--- a/arch/arm/boot/dts/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7-tqma7.dtsi
@@ -19,6 +19,16 @@
 	cpu-supply = <&sw1a_reg>;
 };
 
+&gpio2 {
+	/* Configured as pullup by QSPI pin group */
+	qspi-reset-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "qspi-reset";
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -160,6 +170,25 @@
 		>;
 	};
 
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0	0x5A
+			MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1	0x5A
+			MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2	0x5A
+			MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3	0x5A
+			MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK	0x11
+			MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B	0x54
+			MX7D_PAD_EPDC_DATA07__QSPI_A_SS1_B	0x54
+		>;
+	};
+
+	pinctrl_qspi_reset: qspi_resetgrp {
+		fsl,pins = <
+			/* #QSPI_RESET */
+			MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x52
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
@@ -217,6 +246,20 @@
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi &pinctrl_qspi_reset>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <29000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
 &sdma {
 	status = "okay";
 };
-- 
2.17.1

