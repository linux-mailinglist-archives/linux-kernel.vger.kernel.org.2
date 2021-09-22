Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56655414A07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhIVNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:03:38 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:16292 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhIVNDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315726; x=1663851726;
  h=from:to:cc:subject:date:message-id;
  bh=Zk18MfnwZsuiqJS3BzcWavsFpz6rAWNTwbA7wI3jQoE=;
  b=R/TbwxTsJ8YjoY115L82W41jU48TizJPHHt5FnHYhOHzwT2uFBsYyk4T
   GEjiEyvnwOUFbtDpJPmFSMSctrXutGAM6LA6KmgJt+/v/xfvMVhKs3lw5
   P2k/G5GQAvmjNXlCzajy2rJw0TVpaLX66NmvvslthZWTiuI0cBtFxeEGI
   jMTgZ6AnJ4IcxW9AjHRCrDFdaFYTC5w1dZuturSDoInryOLGasq6lR8tq
   o6xNNeqQGgtmZC+H4sKhU4BjHp5syiU2K1qV5yZMBG0ZEYJeykmUbB6P4
   si6MQGWVpb0S8jzJPPDOPrUk9OgICryLba6mr0q2Mml9NqnhpqA3nXiMx
   A==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19650007"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Sep 2021 15:01:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 22 Sep 2021 15:01:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 22 Sep 2021 15:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315699; x=1663851699;
  h=from:to:cc:subject:date:message-id;
  bh=Zk18MfnwZsuiqJS3BzcWavsFpz6rAWNTwbA7wI3jQoE=;
  b=ashR9uv3B8jwwHfxP4Pd6oYicO1DuNR5GkCFxuSZeLaEDnE922G716Y9
   n2IRR38EQE6VvmhgCx+6bMz5nEAB4sLQTdD0OOsdi8NSLOG+EJkJbzCnd
   rAzvgSRhGlmCvGWojYDVwPtnD4seqTtxOrejxJesE1pJTyzubQEgUEU0W
   kX0gZo/UxjbisVZxRiIxeBvZPe+BQc1W+5LM6/zl89Kb751fQSwGSK+NW
   vL3VWVsM+v1SGjd7JYevJ0Yq6bMn/UBFRpSkB0U/yHXPb0TF2KCjHlBnh
   Akyk9jCVvsOb90AQiV3bTRg5ePUbLxvTAoX5xayeAvh10NNCuz0Q6/LNw
   w==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19649858"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Sep 2021 15:01:02 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id F2542280078;
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
Subject: [PATCH v2 3/3] ARM: dts: imx7-mba7: add default SPI-NOR flash partition layout
Date:   Wed, 22 Sep 2021 15:00:54 +0200
Message-Id: <429c83781ef9a32aacb8128de917194404298914.1632314390.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
References: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
References: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the partition layout also used by the bootloader.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: Update with modern "partitions" specification

 arch/arm/boot/dts/imx7-mba7.dtsi | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 0212962b2189..49086c6b6a0a 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -236,6 +236,44 @@
 	};
 };
 
+&flash0 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uboot@0 {
+			label = "U-Boot";
+			reg = <0x0 0xd0000>;
+		};
+
+		env1@d0000 {
+			label = "ENV1";
+			reg = <0xd0000 0x10000>;
+		};
+
+		env2@e0000 {
+			label = "ENV2";
+			reg = <0xe0000 0x10000>;
+		};
+
+		dtb@f0000 {
+			label = "DTB";
+			reg = <0xf0000 0x10000>;
+		};
+
+		linux@100000 {
+			label = "Linux";
+			reg = <0x100000 0x700000>;
+		};
+
+		rootfs@800000 {
+			label = "RootFS";
+			reg = <0x800000 0x3800000>;
+		};
+	};
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-- 
2.17.1

