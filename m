Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7E3CF3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhGTEhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:37:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47904 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhGTEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:36:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16K5GhDX016679;
        Tue, 20 Jul 2021 00:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626758203;
        bh=UplAe3t8SLLOOhAg9JAaaBmoK8p03dxzvhQatg+1xZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FcQUnV/JItYL16BZGJteMfBNbuCiytcNfGR59xUbIwcB7B5FtuItw+lcsUmKHbcJ6
         toxlS3j/r1oQDGJzL+r+RR7EXk0eMRYRbLlYXViRBw4MWhw4kQrv7x0OomzqqtD7JB
         wSFtOeT/s4+fMpfUSu31az3pOY/ZOPzLVgil9pJ4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16K5GhDD065983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 00:16:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 00:16:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 00:16:43 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16K5GeGk048116;
        Tue, 20 Jul 2021 00:16:41 -0500
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am642-sk: Add ecap0 node
To:     Nishanth Menon <nm@ti.com>
CC:     <kristo@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
 <20210719085402.28569-4-lokeshvutla@ti.com>
 <20210719152326.op7ii76nvk5sve2a@fringe>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d5d614f4-339b-59a1-bd29-6c78d09f2d89@ti.com>
Date:   Tue, 20 Jul 2021 10:46:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719152326.op7ii76nvk5sve2a@fringe>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/21 8:53 pm, Nishanth Menon wrote:
> On 14:24-20210719, Lokesh Vutla wrote:
>> ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
>> signal connected to Pin 1 of J3. Add support for adding this pinmux so
>> that pwm can be observed on pin 1 of Header J3
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> index d3aa2901e6fd..eb0d10e6e787 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
>> @@ -210,6 +210,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
>>  			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
>>  		>;
>>  	};
>> +
>> +	main_ecap0_pins_default: main-ecap0-pins-default {
>> +		pinctrl-single,pins = <
>> +			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
>> +		>;
>> +	};
>>  };
>>  
>>  &mcu_uart0 {
>> @@ -453,3 +459,9 @@ &pcie0_rc {
>>  &pcie0_ep {
>>  	status = "disabled";
>>  };
>> +
>> +&ecap0 {
>> +	/* PWM is available on Pin 1 of header J3 */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_ecap0_pins_default>;
>> +};
>> -- 
>> 2.30.0
>>
> 
> 
> Do the other ecap and pwm nodes need to be disabled since they may not
> be pinned out?

Sure, Ill mark other ecap and epwm nodes as disabled. After looking at
schematics, epwm4 and 5 is pinned out on RPI header. But the header will most
likely be used for other use-cases. Shall I mark epwm4 and epwm5 disabled as
well with a comment with this information?

Thanks and regards,
Lokesh

> 
