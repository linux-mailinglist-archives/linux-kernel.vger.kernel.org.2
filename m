Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575A737F808
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhEMMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:36:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58130 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhEMMgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:36:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14DCZCeD112244;
        Thu, 13 May 2021 07:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620909312;
        bh=6hkZN1ufAaRZSekrRI6opIq0EU23mi/iUO/k+A69uZo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eQlrpVtLmJqw9nG7x3gpEoL6lXwkCHKDxWG7CLAHSGyChYOAL7lalG4o5mO8shlkB
         rjjfzJcau9eSco+o9ZuWC3E+QvAnjQMeQLIL4SJmTBxusY3VjEBTJxk0fWrjmU+ATy
         MVOFxkGjre/Oaqt9FQ/G5RlDhlyGmcpPia3Oncuo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14DCZCIx080340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 May 2021 07:35:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 13
 May 2021 07:35:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 13 May 2021 07:35:11 -0500
Received: from [10.250.232.183] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14DCZ7gP130234;
        Thu, 13 May 2021 07:35:09 -0500
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed
 HOST port
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
References: <20210512150107.26793-1-kishon@ti.com>
 <20210512150107.26793-5-kishon@ti.com>
 <20210512194022.27h53llpxmvg3eoe@splurge>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <595af264-a962-cf3f-81ae-6398bc1e5d20@ti.com>
Date:   Thu, 13 May 2021 18:05:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512194022.27h53llpxmvg3eoe@splurge>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 13/05/21 1:10 am, Nishanth Menon wrote:
> On 20:31-20210512, Kishon Vijay Abraham I wrote:
>> Enable USB Super-Speed HOST port.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 39 ++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> index 8424cd071955..056c1b2df559 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> @@ -5,6 +5,8 @@
>>  
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/mux/ti-serdes.h>
>> +#include <dt-bindings/phy/phy.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/net/ti-dp83867.h>
>>  #include "k3-am642.dtsi"
>> @@ -85,6 +87,12 @@
>>  		>;
>>  	};
>>  
>> +	main_usb0_pins_default: main-usb0-pins-default {
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
>> +		>;
>> +	};
>> +
>>  	main_i2c1_pins_default: main-i2c1-pins-default {
>>  		pinctrl-single,pins = <
>>  			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
>> @@ -235,6 +243,37 @@
>>  	disable-wp;
>>  };
>>  
>> +&serdes_ln_ctrl {
>> +	idle-states = <AM64_SERDES0_LANE0_USB>;
>> +};
>> +
>> +&serdes_wiz0 {
>> +	status = "okay";
> 
> 
> not sure I understand why default of okay needs to be explicitly stated
> as okay in board dts.

hmm, not required. Will remove it.

Thanks
Kishon
