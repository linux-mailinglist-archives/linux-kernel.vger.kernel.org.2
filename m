Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B391B434899
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJTKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:10:51 -0400
Received: from mail.zeus.flokli.de ([88.198.15.28]:42790 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhJTKKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:10:46 -0400
Received: from localhost (ip-84-119-226-0.unity-media.net [84.119.226.0])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 2F6E211D2BD9;
        Wed, 20 Oct 2021 10:00:05 +0000 (UTC)
From:   Florian Klink <flokli@flokli.de>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     Florian Klink <flokli@flokli.de>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable HDD power on helios64
Date:   Wed, 20 Oct 2021 11:59:22 +0200
Message-Id: <20211020095926.735938-1-flokli@flokli.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the hdd_{a,b}_power blocks present in the armbian helios64
dts. [1]

Without those powered up, no HDDs will appear (except one connected via
the m.2 slot).

From https://wiki.kobol.io/helios64/sata/#hdd-power:

> The power delivery of the HDDs is divided into two group:
>
>     HDD Rail A (Max. 3x Drives)
>     HDD Rail B (Max. 2x Drives)
>
> Helios64 implements a power staggering approach where HDD Rail A will be
> powered up first, then few seconds later HDD Rail B will be powered up.
> This power control scenario is performed to reduce the inrush current
> during disk spin-up.

In practice, this power staggering approach will be included in the
bootloader (not in the kernel), as we might want to boot from a SATA
drive.

From my experiments, if the bootloader doesn't implement the power
staggering, only one HDD will get recognized (probably cause the others
didn't boot due to few power).

Still, it makes sense to expose this block in the device-tree, so the
kernel can ensure both rails are on (and this can be shared with
u-boot).

[1] https://github.com/armbian/build/blob/744ea89a589d62cb6f409baab60fc6664520bc39/patch/kernel/archive/rockchip64-5.14/add-board-helios64.patch

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index 738cfd21df3e..93745dcc2af6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -82,6 +82,30 @@ led-1 {
 		};
 	};
 
+	hdd_a_power: hdd-a-power {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&hdd_a_power_en>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "hdd_a_power";
+		startup-delay-us = <2000000>;
+	};
+
+	hdd_b_power: hdd-b-power {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&hdd_b_power_en>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "hdd_b_power";
+		startup-delay-us = <2000000>;
+	};
+
 	pcie_power: pcie-power {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -422,6 +446,14 @@ pmic_int_l: pmic-int-l {
 	};
 
 	power {
+		hdd_a_power_en: hdd-a-power-en {
+			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		hdd_b_power_en: hdd-b-power-en {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		vcc5v0_usb_en: vcc5v0-usb-en {
 			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.33.0

