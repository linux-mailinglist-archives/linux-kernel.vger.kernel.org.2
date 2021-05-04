Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94303372760
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEDIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhEDIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:37:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CA8613C0;
        Tue,  4 May 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620117385;
        bh=wDdTO8tC8Zdg5fvkSijmtyx/2c1fdbnwL+BFdPq35v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nz6peFjPqrrphuzcV4JUJPy0nDAOSH1h3PtxT10nllAGyQ/XDU+x6uDBRxaYK3daM
         jHiVkXyUNrnvkwC22dF7nXXenRvLH8bwupoGiyYmcqCKGVyWKh5vqKZwmrFUinnUEG
         zN3AWY6dxB5s4jKJ4/0AWE44nrh2eKoC9GYwu+RxOrWo5Kn4TqeH+PuRyASNo/BsEr
         DFIynW+U7qCKNLoKssZaHuwn47aj6SkHmJNIrvRYLxYIS7htKnZYGTHAmhRlOyyR/F
         mSq0HZHgANpaeqrFpPdPBXfnPckj1NLr4J56P/QsUUXd2akbcBUNu8A7WyGYXmoq0G
         AI8qnvjl6knNg==
Received: by wens.tw (Postfix, from userid 1000)
        id 473345FCC8; Tue,  4 May 2021 16:36:23 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: rk3328: Enable USB3 Ethernet on NanoPi R2S
Date:   Tue,  4 May 2021 16:36:16 +0800
Message-Id: <20210504083616.9654-5-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083616.9654-1-wens@kernel.org>
References: <20210504083616.9654-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The NanoPi R2S has a Realtek RTL8153B USB 3.0 Ethernet chip connected
to the USB 3.0 pins of the RK3328 SoC. Power to the chip is controlled
by a GPIO line toggled transistor switch, which is not a full-blown
voltage regulator.

At least in Linux, the USB 3.0 XHCI controller has two ports: the first
port is for legacy USB 2.0 and slower, while the second port is for USB
3.0. Since the Ethernet chip supports USB 3.0, it should be described
as connected to the second port.

Add the device nodes for the power switch and Ethernet chip, and enable
the USB 3.0 controller. The USB device node follows the standard USB
device binding.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index f807bc066ccb..64cf07ee3d10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
 
 	aliases {
+		ethernet1 = &rtl8153;
 		mmc0 = &sdmmc;
 	};
 
@@ -101,6 +102,18 @@ vdd_5v: vdd-5v {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	vdd_5v_lan: vdd-5v-lan {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&lan_vdd_pin>;
+		pinctrl-names = "default";
+		regulator-name = "vdd_5v_lan";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vdd_5v>;
+	};
 };
 
 &cpu0 {
@@ -309,6 +322,12 @@ wan_led_pin: wan-led-pin {
 		};
 	};
 
+	lan {
+		lan_vdd_pin: lan-vdd-pin {
+			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -368,6 +387,19 @@ &usb20_otg {
 	dr_mode = "host";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* Second port is for USB 3.0 */
+	rtl8153: device@2 {
+		compatible = "usbbda,8153";
+		reg = <2>;
+	};
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.31.1

