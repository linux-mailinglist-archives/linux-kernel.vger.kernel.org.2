Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735F83A6A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhFNP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhFNP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905BC061226
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cb9so47102570edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCP9eA254QyKuzfCdM77FPnXgS7ZMEl3OZfoXJEBe+A=;
        b=KSr0u01J62n6OOcY/cU/TwBVoZoFU9bC5pKtViR9uU3K38FsgXsPQz50Si+Gf7CdKS
         z78A2FfSiFrvnu0ybMgiKnhMKLT7gIg9ZcxZ4izG8lUv/nPDPUzSPg9aEM0LFuFVkYxF
         33wUxehih4Kwf0XT8YuL/rrTvMcA7UIbL3hXsHj2cGTBg4I/Wsp4hKyXVPrKiXcvhee1
         qx7JMZY/FhiDLYopmRi0JOVSiLaPZT9JGWXvexoqByM1JvCtQpiY1hl9BsbQFvNJemy0
         8EzTYBAqvK/QtOtJnjxnpgBSvh2BwZ9xyhQ/07/AGorTVbDLj5zCjr9Teg3DYJSsfDJt
         GUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TCP9eA254QyKuzfCdM77FPnXgS7ZMEl3OZfoXJEBe+A=;
        b=BlVSRFpR4234lddtMKp44d3t16zyG/DlI6F7OVcmtq2/NUA2VM4rW44yOWOdyOLHXv
         I282ojvyLmWyHFRZAXgFiKnlp9a4lGBcx30LsQq1SOSFy4XxK8KhOF9NdSDd0RB4liO4
         8QqTbhkInwRgLcdG6Ue2BUikDGBerD+IGAQ+br0B4keSnpOkJikK2FHzGiy8xNaG+ztV
         bs9X5cHjTZhGl6NgFFyuESE2C+Et09ptafdCdTXcxN4k5uctY2oaHuZ9crnQ5OVS1isy
         BEGTQRv9f9Mls53L1cv+bNhgbaFvOHB/cZr6dGEA7ZJ5P3S5mq7RCVhUuTcXAmU3OwJ+
         OPjw==
X-Gm-Message-State: AOAM532QI4qLGwzsKZqU27B1Do/GsnoRnxrURbjDGEEhnNLQWQ6jfJy/
        o5GdasTBNpcl4+nELWGM0gXWzL2fGaT+PuEL
X-Google-Smtp-Source: ABdhPJxmLrlDbCnDc5JeshgOMTpwzrMXUFcDgYrNyce7HRnAaKuA5xzMluh1CfSDdo7CneBQPQiKYQ==
X-Received: by 2002:aa7:d801:: with SMTP id v1mr17829963edq.349.1623684388508;
        Mon, 14 Jun 2021 08:26:28 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id l8sm9236179eds.79.2021.06.14.08.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:28 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 31/33] arm64: zynqmp: Enable xlnx,zynqmp-dwc3 driver for xilinx boards
Date:   Mon, 14 Jun 2021 17:25:39 +0200
Message-Id: <3a68b328a69a0db51948798216cf914c9073baf2.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
finally add proper support for Xilinx dwc3 driver. This patch is adding DT
description for it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- New patch in the series

 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  6 ++
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  7 ++
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 14 ++++
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 10 +++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  6 ++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 ++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  6 ++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  6 ++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  6 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 70 +++++++++++++++----
 10 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index d78439e891b9..c1cedc92e017 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -27,6 +27,7 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -404,7 +405,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index cd61550c52e5..938b76bd0527 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -26,6 +26,7 @@ aliases {
 		serial1 = &uart1;
 		spi0 = &spi0;
 		spi1 = &spi1;
+		usb0 = &usb1;
 	};
 
 	chosen {
@@ -479,7 +480,13 @@ &usb1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_default>;
+};
+
+&dwc3_1 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index ba7f1f21c579..4394ec3b6a23 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -24,6 +24,8 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -147,11 +149,23 @@ &uart1 {
 
 &usb0 {
 	status = "okay";
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
 };
 
 /* ULPI SMSC USB3320 */
 &usb1 {
 	status = "okay";
+};
+
+&dwc3_1 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 80415e202814..6d32bfac48b5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -30,6 +30,8 @@ aliases {
 		serial2 = &dcc;
 		spi0 = &spi0;
 		spi1 = &spi1;
+		usb0 = &usb0;
+		usb1 = &usb1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
@@ -537,6 +539,10 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "peripheral";
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
@@ -548,6 +554,10 @@ &usb1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_default>;
+};
+
+&dwc3_1 {
+	status = "okay";
 	dr_mode = "host";
 	phy-names = "usb3-phy";
 	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index becfc23a5610..b17677378ab5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -31,6 +31,7 @@ aliases {
 		serial1 = &uart1;
 		serial2 = &dcc;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -998,7 +999,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 86fff3632c7d..fb7a9f7907d9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -29,6 +29,7 @@ aliases {
 		serial1 = &uart1;
 		serial2 = &dcc;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -481,7 +482,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 2a872d439804..afc9b200a59b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -29,6 +29,7 @@ aliases {
 		serial1 = &uart1;
 		serial2 = &dcc;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -493,7 +494,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index d2219373580a..793740cbd791 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -31,6 +31,7 @@ aliases {
 		serial1 = &uart1;
 		serial2 = &dcc;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -991,7 +992,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index dac5ba67a160..a245250970c8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -30,6 +30,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
 		spi0 = &qspi;
+		usb0 = &usb0;
 	};
 
 	chosen {
@@ -828,7 +829,12 @@ &usb0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
+};
+
+&dwc3_0 {
+	status = "okay";
 	dr_mode = "host";
+	snps,usb3_lpm_capable;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	maximum-speed = "super-speed";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 6f0fcec28ae2..731b2d170344 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP
  *
- * (C) Copyright 2014 - 2019, Xilinx, Inc.
+ * (C) Copyright 2014 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  *
@@ -805,24 +805,68 @@ uart1: serial@ff010000 {
 			power-domains = <&zynqmp_firmware PD_UART_1>;
 		};
 
-		usb0: usb@fe200000 {
-			compatible = "snps,dwc3";
+		usb0: usb0@ff9d0000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
 			status = "disabled";
-			interrupt-parent = <&gic>;
-			interrupts = <0 65 4>;
-			reg = <0x0 0xfe200000 0x0 0x40000>;
-			clock-names = "clk_xin", "clk_ahb";
+			compatible = "xlnx,zynqmp-dwc3";
+			reg = <0x0 0xff9d0000 0x0 0x100>;
+			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
+			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
+			ranges;
+
+			dwc3_0: usb@fe200000 {
+				compatible = "snps,dwc3";
+				status = "disabled";
+				reg = <0x0 0xfe200000 0x0 0x40000>;
+				interrupt-parent = <&gic>;
+				interrupt-names = "dwc_usb3", "otg";
+				interrupts = <0 65 4>, <0 69 4>;
+				#stream-id-cells = <1>;
+				iommus = <&smmu 0x860>;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,refclk_fladj;
+				snps,enable_guctl1_resume_quirk;
+				snps,enable_guctl1_ipd_quirk;
+				snps,xhci-stream-quirk;
+				/* dma-coherent; */
+			};
 		};
 
-		usb1: usb@fe300000 {
-			compatible = "snps,dwc3";
+		usb1: usb1@ff9e0000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
 			status = "disabled";
-			interrupt-parent = <&gic>;
-			interrupts = <0 70 4>;
-			reg = <0x0 0xfe300000 0x0 0x40000>;
-			clock-names = "clk_xin", "clk_ahb";
+			compatible = "xlnx,zynqmp-dwc3";
+			reg = <0x0 0xff9e0000 0x0 0x100>;
+			clock-names = "bus_clk", "ref_clk";
 			power-domains = <&zynqmp_firmware PD_USB_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
+			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
+			ranges;
+
+			dwc3_1: usb@fe300000 {
+				compatible = "snps,dwc3";
+				status = "disabled";
+				reg = <0x0 0xfe300000 0x0 0x40000>;
+				interrupt-parent = <&gic>;
+				interrupt-names = "dwc_usb3", "otg";
+				interrupts = <0 70 4>, <0 74 4>;
+				#stream-id-cells = <1>;
+				iommus = <&smmu 0x861>;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,refclk_fladj;
+				snps,enable_guctl1_resume_quirk;
+				snps,enable_guctl1_ipd_quirk;
+				snps,xhci-stream-quirk;
+				/* dma-coherent; */
+			};
 		};
 
 		watchdog0: watchdog@fd4d0000 {
-- 
2.32.0

