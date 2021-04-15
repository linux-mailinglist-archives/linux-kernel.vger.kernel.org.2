Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E0360BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhDOOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:36:09 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60421 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232759AbhDOOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:36:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FEWU1M032290;
        Thu, 15 Apr 2021 16:35:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dd8MLNMxo70LEUwacsNT/EmSpkArncu11OuNGUbGgZ8=;
 b=L5XlhZ7sGVykh0fltQSnNx98qVaWO+8yPJ1HYHKsoRJfeoBammc9QL+aaLp15Gim21FD
 BTDDZ2Pc0TLJdDE8SA4fTtEqngMKj747ePu3OCJ+wcB2O9JDHbWw03CjQHBWrW3CgqJ1
 waxl6GL1kGib5XTiwmeRny6h7v9VF/PPkz63jjyhaccVyR34nk53D4iEZAIaaAD30nm3
 NwU7fgjjoqLBCP7ny+SvBnDP/nU4p5Je+nxn2m3q9VfY40I71dVOdlKKT41c1nRwjeNP
 +2ygpHdVuDdTvcge82wNYTj582BxWNYVYTp/F/fNgMCdQfMeKIXSoU/fDYepJle2R+ai ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xg6w3854-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 16:35:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72EC010002A;
        Thu, 15 Apr 2021 16:35:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36130241571;
        Thu, 15 Apr 2021 16:35:27 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr
 2021 16:35:26 +0200
Subject: Re: [PATCH 11/13] ARM: dts: stm32: fix LTDC port node on STM32 MCU ad
 MPU
To:     Marek Vasut <marex@denx.de>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-12-alexandre.torgue@foss.st.com>
 <3b39908b-a263-a5d4-f6ac-ac30ffb06269@denx.de>
 <36e9f0df-dfdb-e2f5-3d6e-ac32a1b8156e@foss.st.com>
 <fa3885df-8977-9540-f2af-d4095f519483@denx.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <3961c9ae-41cc-5a15-2704-ffc0832f0fe8@foss.st.com>
Date:   Thu, 15 Apr 2021 16:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fa3885df-8977-9540-f2af-d4095f519483@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_06:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/21 4:30 PM, Marek Vasut wrote:
> On 4/15/21 3:34 PM, Alexandre TORGUE wrote:
>> Hi Marek
> 
> Hello Alexandre,
> 
>>>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts 
>>>> b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>> index 2bc92ef3aeb9..19ef475a48fc 100644
>>>> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>> @@ -82,9 +82,15 @@
>>>>   };
>>>>   &ltdc {
>>>> -    status = "okay";
>>>> -
>>>>       port {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        ltdc_ep0_out: endpoint@0 {
>>>> +            reg = <0>;
>>>> +            remote-endpoint = <&sii9022_in>;
>>>> +        };
>>>> +
>>>>           ltdc_ep1_out: endpoint@1 {
>>>>               reg = <1>;
>>>>               remote-endpoint = <&dsi_in>;
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi 
>>>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>> index 64dca5b7f748..e7f10975cacf 100644
>>>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>> @@ -277,11 +277,7 @@
>>>>       status = "okay";
>>>>       port {
>>>> -        #address-cells = <1>;
>>>> -        #size-cells = <0>;
>>>> -
>>>> -        ltdc_ep0_out: endpoint@0 {
>>>> -            reg = <0>;
>>>> +        ltdc_ep0_out: endpoint {
>>>>               remote-endpoint = <&adv7513_in>;
>>>>           };
>>>>       };
>>>
>>> I think this is wrong, the AV96 can have two displays connected to 
>>> two ports of the LTDC, just like DK2 for example.
>>
>> As for dk2 address/size cells are added only if there are 2 endpoints. 
>> It is for this reason I moved endpoint0 definition from 
>> stm32mp15xx-dkx to stm32mp151a-dk1.dts (dk1 has only one endpoint).
>>
>> Here it's the same, if you have second endpoint then adress/size will 
>> have to be added.
> 
> That's a bit problematic. Consider either the use case of DTO which adds 
> the other display, or even a custom board DTS. Without your patch, this 
> works:
> 
> arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> &ltdc {
>    ...
>    ports {
>      ltdc_ep0_out: endpoint@0 {
>        remote-endpoint = <&adv7513_in>;
>      };
>    };
> };
> 
> board-with-display.dts or board-overlay.dts
> &ltdc {
>    ports {
>      endpoint@1 { // just add another endpoint@1, no problem
>        remote-endpoint = <&display>;
>      };
>    };
> };
> 
> With your patch, the DTS would have to modify the "endpoint" node to be 
> "endpoint@0" probably with a whole lot of /detele-node/ etc. magic (DTO 
> cannot do that, so that's a problem, and I do use DTOs on AV96 
> extensively for the various expansion cards) and then add the 
> endpoint@1. That becomes real complicated in custom board DT, and 
> impossible with DTO.

Yes I agree that it'll be problematic. So maybe so solution would be to 
not detect a warning for the initial case (only one endpoint with a reg)
