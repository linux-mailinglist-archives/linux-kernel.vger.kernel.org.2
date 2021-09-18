Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2434C41048E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhIRHCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:02:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9747 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhIRHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:02:54 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HBMCX1pXDzVfkF;
        Sat, 18 Sep 2021 15:00:24 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 18 Sep 2021 15:01:28 +0800
Message-ID: <61458EC8.2000702@hisilicon.com>
Date:   Sat, 18 Sep 2021 15:01:28 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: hisilicon: Add support for Hikey 970
 USB3 PHY
References: <cover.1630583382.git.mchehab+huawei@kernel.org> <569dc85d8058e2884d76ab36c6c46d36e7ad8555.1630583382.git.mchehab+huawei@kernel.org>
In-Reply-To: <569dc85d8058e2884d76ab36c6c46d36e7ad8555.1630583382.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/9/2 19:55, Mauro Carvalho Chehab wrote:
> Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 83 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 56 +++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> index 7c32f5fd5cc5..60594db07041 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> @@ -430,3 +430,86 @@ &uart6 {
>  	label = "LS-UART1";
>  	status = "okay";
>  };
> +
> +&usb_phy {
> +	phy-supply = <&ldo17>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";
> +		reg = <0x4e>;
> +		status = "okay";
> +		interrupt-parent = <&gpio27>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@1 {
> +					reg = <1>;
> +					usb_con_ss: endpoint {
> +						remote-endpoint = <&dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&hikey_usb_ep1>;

The 'hikey_usb_ep1' is not defined yet.

> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	/* USB HUB is on this bus at address 0x44 */
> +	status = "okay";
> +};
> +
> +&dwc3 { /* USB */
> +	dr_mode = "otg";
> +	maximum-speed = "super-speed";
> +	phy_type = "utmi";
> +	snps,dis-del-phy-power-chg-quirk;
> +	snps,dis_u2_susphy_quirk;
> +	snps,dis_u3_susphy_quirk;
> +	snps,tx_de_emphasis_quirk;
> +	snps,tx_de_emphasis = <1>;
> +	snps,dis-split-quirk;
> +	snps,gctl-reset-quirk;
> +	usb-role-switch;
> +	role-switch-default-mode = "host";
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dwc3_role_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&hikey_usb_ep0>;

Ditto. The 'hikey_usb_ep0' is not defined yet.

> +		};
> +
> +		dwc3_ss: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usb_con_ss>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 636c8817df7e..782e1487666d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -8,6 +8,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/hi3670-clock.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	compatible = "hisilicon,hi3670";
> @@ -785,5 +786,60 @@ i2c4: i2c@fdf0d000 {
>  			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
>  			status = "disabled";
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +			usb_phy: usbphy {
> +				compatible = "hisilicon,hi3670-usb-phy";
> +				#phy-cells = <0>;
> +				hisilicon,pericrg-syscon = <&crg_ctrl>;
> +				hisilicon,pctrl-syscon = <&pctrl>;
> +				hisilicon,sctrl-syscon = <&sctrl>;
> +				hisilicon,eye-diagram-param = <0xFDFEE4>;
> +				hisilicon,tx-vboost-lvl = <0x5>;
> +			};
> +		};
> +
> +		usb31_misc_rst: usb31_misc_rst_controller {
> +			compatible = "hisilicon,hi3660-reset";
> +			#reset-cells = <2>;
> +			hisi,rst-syscon = <&usb3_otg_bc>;
> +		};
> +
> +		usb3: hisi_dwc3 {
> +			compatible = "hisilicon,hi3670-dwc3";

Is it OK to add the 'hi3670-dwc3' into the devicetree binding document?
Thanks!

Best Regards,
Wei

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
> +				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
> +				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
> +				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
> +			clock-names = "clk_gate_abb_usb",
> +				      "hclk_gate_usb3otg",
> +				      "clk_gate_usb3otg_ref",
> +				      "aclk_gate_usb3dvfs";
> +
> +			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
> +			assigned-clock-rates = <238000000>;
> +			resets = <&crg_rst 0x90 6>,
> +				 <&crg_rst 0x90 7>,
> +				 <&usb31_misc_rst 0xA0 8>,
> +				 <&usb31_misc_rst 0xA0 9>;
> +
> +			dwc3: usb@ff100000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xff100000 0x0 0x100000>;
> +
> +				interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
> +					    <0 161 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				phys = <&usb_phy>;
> +				phy-names = "usb3-phy";
> +			};
> +		};
>  	};
>  };
> 
