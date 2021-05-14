Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE173809E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhENMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhENMw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:52:27 -0400
X-Greylist: delayed 8675 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 May 2021 05:51:16 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18225C061574;
        Fri, 14 May 2021 05:51:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 83FE022253A;
        Fri, 14 May 2021 14:51:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dat1wKKJdGXb; Fri, 14 May 2021 14:51:10 +0200 (CEST)
To:     Johan Jonker <jbx6244@gmail.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210514102734.2091238-1-t.schramm@manjaro.org>
 <20210514102734.2091238-5-t.schramm@manjaro.org>
 <01388394-603e-6a43-2044-ae1e93eb0ff3@gmail.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add USB support to RK3308 dts
Message-ID: <e0545fee-70db-ce38-1bd4-6520dc585bad@manjaro.org>
Date:   Fri, 14 May 2021 14:52:47 +0200
MIME-Version: 1.0
In-Reply-To: <01388394-603e-6a43-2044-ae1e93eb0ff3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Hi Johan,

Am 14.05.21 um 14:09 schrieb Johan Jonker:
> Hi Tobias,
> 
> Just sent a patch for grf.yaml and rockchip-usb-phy.yaml conversion myself.
> 
Ah wonderful, thanks! I was not quite happy with touching the old .txt 
documentation anyway. I'll adjust my next version to depend on your 
patches then.
> Added { .compatible = "rockchip,rk3308-usb2phy", .data =
> &rk3308_phy_cfgs }, to phy-rockchip-inno-usb2.c
> 
> Added is "rockchip,rk3308-usb-phy" to rockchip-usb-phy.txt
> 
> compatible = "rockchip,rk3308-usb2phy"; is used in this patch.
> 
> Maybe try phy-rockchip-inno-usb2.yaml?
> 
Right. Somehow ended up in the wrong file there. Will fix it in the next 
version.
> "rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd" document missing.
> 
> Could someone recheck the reg memory size?
> Is this still correct then?
> 
> ===
> compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
> reg = <0x0 0xff000000 0x0 0x10000>;
> 
> Do we still need "0x0 0x10000" here?
The technical reference manual specifies it as 64k in size. However, 
since the dts has separate nodes for the other grfs it should probably 
be "0x0 0x8000" at max. Technical reference manual indicates there is 
nothing beyond 0x0803 in the main grf.
> ===
> compatible = "rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd";
> reg = <0x0 0xff008000 0x0 0x4000>;
> ===
> compatible = "rockchip,rk3308-detect-grf", "syscon", "simple-mfd";
> reg = <0x0 0xff00b000 0x0 0x1000>;
> ===
> compatible = "rockchip,rk3308-core-grf", "syscon", "simple-mfd";
> reg = <0x0 0xff00c000 0x0 0x1000>;
> ===
> 
> Johan
> 
> On 5/14/21 12:27 PM, Tobias Schramm wrote:
>> The Rockchip RK3308 features an integrated USB 2.0 phy, an USB OTG
>> controller and OHCI/EHCI interfaces.
>> This patch adds all of those to the RK3308 dtsi and thereby enables USB
>> support on the RK3308.
>>
>> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 75 ++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> index 0c5fa9801e6f..80fd802d6c15 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> @@ -177,6 +177,43 @@ reboot-mode {
>>   		};
>>   	};
>>   
>> +	usb2phy_grf: syscon@ff008000 {
>> +		compatible = "rockchip,rk3308-usb2phy-grf", "syscon",
>> +			     "simple-mfd";
>> +		reg = <0x0 0xff008000 0x0 0x4000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		u2phy: usb2-phy@100 {
> 
>> +			compatible = "rockchip,rk3308-usb2phy";
>> +			reg = <0x100 0x10>;
>> +			clocks = <&cru SCLK_USBPHY_REF>;
>> +			clock-names = "phyclk";
>> +			clock-output-names = "usb480m_phy";
>> +			#clock-cells = <0>;
>> +			assigned-clocks = <&cru USB480M>;
>> +			assigned-clock-parents = <&u2phy>;
>> +			status = "disabled";
>> +
> 
> Looks like
> 
>> +			u2phy_otg: otg-port {
>> +				#phy-cells = <0>;
>> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>> +				interrupt-names = "otg-bvalid", "otg-id",
>> +						  "linestate";
>> +				status = "disabled";
>> +			};
>> +
>> +			u2phy_host: host-port {
>> +				#phy-cells = <0>;
>> +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>> +				interrupt-names = "linestate";
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>> +
>>   	detect_grf: syscon@ff00b000 {
>>   		compatible = "rockchip,rk3308-detect-grf", "syscon", "simple-mfd";
>>   		reg = <0x0 0xff00b000 0x0 0x1000>;
>> @@ -579,6 +616,44 @@ spdif_tx: spdif-tx@ff3a0000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	usb20_otg: usb@ff400000 {
>> +		compatible = "rockchip,rk3308-usb", "rockchip,rk3066-usb",
>> +			     "snps,dwc2";
>> +		reg = <0x0 0xff400000 0x0 0x40000>;
>> +		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_OTG>;
>> +		clock-names = "otg";
>> +		dr_mode = "otg";
>> +		g-np-tx-fifo-size = <16>;
>> +		g-rx-fifo-size = <280>;
>> +		g-tx-fifo-size = <256 128 128 64 32 16>;
>> +		phys = <&u2phy_otg>;
>> +		phy-names = "usb2-phy";
>> +		status = "disabled";
>> +	};
>> +
>> +	usb_host_ehci: usb@ff440000 {
>> +		compatible = "generic-ehci";
>> +		reg = <0x0 0xff440000 0x0 0x10000>;
>> +		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
>> +		clock-names = "usbhost", "arbiter", "utmi";
>> +		phys = <&u2phy_host>;
>> +		phy-names = "usb";
>> +		status = "disabled";
>> +	};
>> +
>> +	usb_host_ohci: usb@ff450000 {
>> +		compatible = "generic-ohci";
>> +		reg = <0x0 0xff450000 0x0 0x10000>;
>> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
>> +		clock-names = "usbhost", "arbiter", "utmi";
>> +		phys = <&u2phy_host>;
>> +		phy-names = "usb";
>> +		status = "disabled";
>> +	};
>> +
>>   	sdmmc: mmc@ff480000 {
>>   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
>>   		reg = <0x0 0xff480000 0x0 0x4000>;
>>
