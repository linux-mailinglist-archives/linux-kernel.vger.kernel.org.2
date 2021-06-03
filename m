Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9739A17A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFCMwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:52:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51378 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFCMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:52:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153CoTkS104575;
        Thu, 3 Jun 2021 07:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622724629;
        bh=h9C2n/VlNZCi9PUnX2EYZvtfKmNL4oaXPQwhygxxbYk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mUNVLybk+WH0FVUlBBPoc4c1AhnaDQv0+/0bsOpTrmn25xppm9+WoT8PsMqwRo0cg
         P7ISJS5yJ8Mxg3nps0QnCe9g0Yft4SpRyQMpjAS1ZmDSyeLyIcC4YsGEBSjPlC2yXc
         PE97z7+3O4C9XFa17mD8rovBL+Qwfcoz0tAQWmJY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153CoT0p052781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 07:50:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 07:50:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 07:50:29 -0500
Received: from [10.250.235.48] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153CoPsD040559;
        Thu, 3 Jun 2021 07:50:26 -0500
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-am64-main: Add SERDES DT node
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210526142921.12127-1-kishon@ti.com>
 <20210526142921.12127-2-kishon@ti.com>
 <20210526184427.wvn4kveus6vgedcs@polio>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <501d2474-ba4e-afc3-c85f-7747f4c71a2f@ti.com>
Date:   Thu, 3 Jun 2021 18:20:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210526184427.wvn4kveus6vgedcs@polio>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 27/05/21 12:14 am, Nishanth Menon wrote:
> On 19:59-20210526, Kishon Vijay Abraham I wrote:
>> AM64 has one SERDES 10G instance. Add SERDES DT node for it.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 56 ++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index b2bcbf23eefd..a67f10406a8e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -5,6 +5,17 @@
>>   * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
>>   */
>>  
>> +#include <dt-bindings/phy/phy-cadence.h>
>> +#include <dt-bindings/phy/phy-ti.h>
>> +
>> +/ {
>> +	serdes_refclk: clock {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <0>;
>> +	};
>> +};
>> +
>>  &cbass_main {
>>  	oc_sram: sram@70000000 {
>>  		compatible = "mmio-sram";
>> @@ -18,6 +29,20 @@
>>  		};
>>  	};
>>  
>> +	main_conf: syscon@43000000 {
>> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +		reg = <0x0 0x43000000 0x0 0x20000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x43000000 0x20000>;
>> +
>> +		serdes_ln_ctrl: mux-controller {
>> +			compatible = "mmio-mux";
> 
> Any idea where the mmio-mux binding is and status?
> I'd rather not pick up a new warning against linux-next

Rob has posted mmio-mux binding.
http://lore.kernel.org/r/20210526184839.2937899-1-robh@kernel.org

Thanks
Kishon
> 
>> +			#mux-control-cells = <1>;
>> +			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
>> +		};
>> +	};
>> +
>>  	gic500: interrupt-controller@1800000 {
>>  		compatible = "arm,gic-v3";
>>  		#address-cells = <2>;
>> @@ -672,4 +697,35 @@
>>  		ti,mbox-num-users = <4>;
>>  		ti,mbox-num-fifos = <16>;
>>  	};
>> +
>> +	serdes_wiz0: wiz@f000000 {
>> +		compatible = "ti,am64-wiz-10g";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&serdes_refclk>;
>> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>> +		num-lanes = <1>;
>> +		#reset-cells = <1>;
>> +		#clock-cells = <1>;
>> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
>> +
>> +		assigned-clocks = <&k3_clks 162 1>;
>> +		assigned-clock-parents = <&k3_clks 162 5>;
>> +
>> +		serdes0: serdes@f000000 {
>> +			compatible = "ti,j721e-serdes-10g";
>> +			reg = <0x0f000000 0x00010000>;
>> +			reg-names = "torrent_phy";
>> +			resets = <&serdes_wiz0 0>;
>> +			reset-names = "torrent_reset";
>> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>, <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
>> +			clock-names = "refclk", "phy_en_refclk";
>> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>, <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>, <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
>> +			assigned-clock-parents = <&k3_clks 162 1>, <&k3_clks 162 1>, <&k3_clks 162 1>;
> 
> Could we line these up to < 100 chars?
> 
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			#clock-cells = <1>;
>> +		};
>> +	};
>>  };
>> -- 
>> 2.17.1
>>
> 
