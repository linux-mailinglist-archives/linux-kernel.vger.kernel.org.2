Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C87305FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbhA0Pc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:32:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57376 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhA0P1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:27:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RFQcW1059487;
        Wed, 27 Jan 2021 09:26:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611761198;
        bh=R1DxFpcPAnVTb0T18okNye5fs9IvqOnBIgZ/7ETCjnQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iyMgJSU1U+WNlZLmUPLe8oLVZHsNiNt8+GcoitvGKyaIF8fKmdC8fr1zysQXX9KFD
         aKL7lMUKwtLQoPyDLBUyiAieI8Z+WMaIeojdjgwCC8QtEKaoH6kx00qX3Clnkjj10n
         hLCx0qnlXGkNkzccvbKJCZ+kx06GyQ22ZJtEiTag=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RFQcXA115207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:26:38 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:26:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:26:37 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RFQXbu129714;
        Wed, 27 Jan 2021 09:26:34 -0600
Subject: Re: [PATCH v3 1/2] dts: ti: k3-j7200-main: Add support for zeroth
 instance of GPIO subsystem
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210127150815.16991-1-a-govindraju@ti.com>
 <20210127150815.16991-2-a-govindraju@ti.com>
 <20210127151256.tgbhpngy6fi43edj@create>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9308ad5d-48bd-ebd2-2ea3-9775b8c11163@ti.com>
Date:   Wed, 27 Jan 2021 20:56:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127151256.tgbhpngy6fi43edj@create>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 27/01/21 8:42 pm, Nishanth Menon wrote:
> On 20:38-20210127, Aswath Govindraju wrote:
>> Add support for the zeroth instance of GPIO subsystem in the main domain.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> 
> 
> I really dont want to pick up one patch per node instance. It is hard
> to scale and just creates a lot of noise.
> 

As the main goal of the patch series was to add support for higher speed
modes in MMC, I added only the required ones. If required I will send a
follow up patch to add the remaining GPIO nodes.

Thanks,
Aswath

>> ---
>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index 4cc2e9094d0e..75dffbb26d52 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -294,6 +294,23 @@
>>  		pinctrl-single,function-mask = <0xffffffff>;
>>  	};
>>  
>> +	main_gpio0: gpio@600000 {
>> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
>> +		reg = <0x0 0x00600000 0x0 0x100>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-parent = <&main_gpio_intr>;
>> +		interrupts = <145>, <146>, <147>, <148>,
>> +			     <149>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		ti,ngpio = <69>;
>> +		ti,davinci-gpio-unbanked = <0>;
>> +		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 105 0>;
>> +		clock-names = "gpio";
>> +	};
>> +
>>  	main_uart0: serial@2800000 {
>>  		compatible = "ti,j721e-uart", "ti,am654-uart";
>>  		reg = <0x00 0x02800000 0x00 0x100>;
>> -- 
>> 2.17.1
>>
> 

