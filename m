Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8543E632
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ1QiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:38:03 -0400
Received: from mail.zeus.flokli.de ([88.198.15.28]:48148 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229565AbhJ1QiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:38:02 -0400
Received: from localhost (ip-84-119-226-0.unity-media.net [84.119.226.0])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 1DB9E11E160A;
        Thu, 28 Oct 2021 16:35:33 +0000 (UTC)
Date:   Thu, 28 Oct 2021 18:35:32 +0200
From:   Florian Klink <flokli@flokli.de>
To:     Dennis Gilmore <dgilmore@redhat.com>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: helios64: define usb hub and
 2.5GbE nic
Message-ID: <20211028163532.xhcvlxi4e2wuuisz@tp>
References: <20211026150751.70115-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211026150751.70115-1-dgilmore@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-26 10:07:47, Dennis Gilmore wrote:
>Add the 4 ports on the internal hub and define and turn on the 2.5GbE
>nic.
>
>Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>

Tested-by: Florian Klink <flokli@flokli.de>

>---
> .../dts/rockchip/rk3399-kobol-helios64.dts    | 55 +++++++++++++++++++
> 1 file changed, 55 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>index 26d45cf7ce00..1ffddf860375 100644
>--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
>@@ -125,6 +125,18 @@ pcie_power: pcie-power {
> 		vin-supply = <&vcc5v0_perdev>;
> 	};
>
>+	usblan_power: usblan-power {
>+		compatible = "regulator-fixed";
>+		enable-active-high;
>+		gpio = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
>+		pinctrl-names = "default";
>+		pinctrl-0 = <&usb_lan_en>;
>+		regulator-name = "usblan_power";
>+		regulator-always-on;
>+		regulator-boot-on;
>+		vin-supply = <&vcc5v0_usb>;
>+	};
>+
> 	vcc1v8_sys_s0: vcc1v8-sys-s0 {
> 		compatible = "regulator-fixed";
> 		regulator-name = "vcc1v8_sys_s0";
>@@ -465,6 +477,11 @@ hdd_b_power_en: hdd-b-power-en {
> 		vcc5v0_usb_en: vcc5v0-usb-en {
> 			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> 		};
>+
>+		usb_lan_en: usb-lan-en {
>+			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
>+		};
>+
> 	};
>
> 	vcc3v0-sd {
>@@ -563,5 +580,43 @@ &usbdrd3_1 {
> 	usb@fe900000 {
> 		dr_mode = "host";
> 		status = "okay";
>+
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		hub@1 {
>+			compatible = "usb2109,0815";
>+			reg = <1>;
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+
>+			port@1 {
>+				reg = <1>;
>+				#trigger-source-cells = <0>;
>+			};
>+
>+			port@2 {
>+				reg = <2>;
>+				#trigger-source-cells = <0>;
>+			};
>+
>+			port@3 {
>+				reg = <3>;
>+				#trigger-source-cells = <0>;
>+			};
>+
>+			device@4 {
>+				compatible = "usbbda,8156";
>+				reg = <4>;
>+
>+				#address-cells = <2>;
>+				#size-cells = <0>;
>+
>+				interface@0 {	/* interface 0 of configuration 1 */
>+					compatible = "usbbda,8156.config1.0";
>+					reg = <0 1>;
>+				};
>+			};
>+		};
> 	};
> };
>-- 
>2.32.0
