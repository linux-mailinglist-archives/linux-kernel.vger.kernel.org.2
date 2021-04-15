Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6485A360DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhDOPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:08:13 -0400
Received: from phobos.denx.de ([85.214.62.61]:55638 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234869AbhDOPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:00:05 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C55F181FE1;
        Thu, 15 Apr 2021 16:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1618498780;
        bh=Kw07LkJdKop/yJQQqAUybaOom8omiDfjimVgY6INlKM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qG3vJnacjJH2T6/LHSUKQqKJUBWrcEN7r6NhcGCSdBtN4nss3tWZ0nO/Ises27Xvc
         VJGziRkn7XGX6HeJNFZ3NKxgJfYbo1qxsVRITxF5utVsu0V855wi9W/o5nOiAsG4j4
         LzmcixCWz41r3/bCwgBpZpWa7aJMXgqoXHnAz/0L093+4TBflUjIMWQCZR0RFKlVXg
         k47GEkzZmKdFN1i6BrfQukuubfOoZ8NLj6HD4D23S0QhGYD27jXWwe+QQ52WES1B9h
         aS32TR1XAlYbdiafXGiMDKeW4MksrP+jd/DapR7g7HXa8+g0bzZaaTBKJcCvdhW4+c
         +FMQpDAlr3Yfg==
Subject: Re: [PATCH 11/13] ARM: dts: stm32: fix LTDC port node on STM32 MCU ad
 MPU
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, jagan@amarulasolutions.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kuba@kernel.org
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-12-alexandre.torgue@foss.st.com>
 <3b39908b-a263-a5d4-f6ac-ac30ffb06269@denx.de>
 <36e9f0df-dfdb-e2f5-3d6e-ac32a1b8156e@foss.st.com>
 <fa3885df-8977-9540-f2af-d4095f519483@denx.de>
 <3961c9ae-41cc-5a15-2704-ffc0832f0fe8@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <57a7f4bf-42e9-56fb-e898-2c5749f53c60@denx.de>
Date:   Thu, 15 Apr 2021 16:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3961c9ae-41cc-5a15-2704-ffc0832f0fe8@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 4:35 PM, Alexandre TORGUE wrote:
> 
> 
> On 4/15/21 4:30 PM, Marek Vasut wrote:
>> On 4/15/21 3:34 PM, Alexandre TORGUE wrote:
>>> Hi Marek
>>
>> Hello Alexandre,
>>
>>>>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts 
>>>>> b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>>> index 2bc92ef3aeb9..19ef475a48fc 100644
>>>>> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>>>> @@ -82,9 +82,15 @@
>>>>>   };
>>>>>   &ltdc {
>>>>> -    status = "okay";
>>>>> -
>>>>>       port {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        ltdc_ep0_out: endpoint@0 {
>>>>> +            reg = <0>;
>>>>> +            remote-endpoint = <&sii9022_in>;
>>>>> +        };
>>>>> +
>>>>>           ltdc_ep1_out: endpoint@1 {
>>>>>               reg = <1>;
>>>>>               remote-endpoint = <&dsi_in>;
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi 
>>>>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>>> index 64dca5b7f748..e7f10975cacf 100644
>>>>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>>>> @@ -277,11 +277,7 @@
>>>>>       status = "okay";
>>>>>       port {
>>>>> -        #address-cells = <1>;
>>>>> -        #size-cells = <0>;
>>>>> -
>>>>> -        ltdc_ep0_out: endpoint@0 {
>>>>> -            reg = <0>;
>>>>> +        ltdc_ep0_out: endpoint {
>>>>>               remote-endpoint = <&adv7513_in>;
>>>>>           };
>>>>>       };
>>>>
>>>> I think this is wrong, the AV96 can have two displays connected to 
>>>> two ports of the LTDC, just like DK2 for example.
>>>
>>> As for dk2 address/size cells are added only if there are 2 
>>> endpoints. It is for this reason I moved endpoint0 definition from 
>>> stm32mp15xx-dkx to stm32mp151a-dk1.dts (dk1 has only one endpoint).
>>>
>>> Here it's the same, if you have second endpoint then adress/size will 
>>> have to be added.
>>
>> That's a bit problematic. Consider either the use case of DTO which 
>> adds the other display, or even a custom board DTS. Without your 
>> patch, this works:
>>
>> arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>> &ltdc {
>>    ...
>>    ports {
>>      ltdc_ep0_out: endpoint@0 {
>>        remote-endpoint = <&adv7513_in>;
>>      };
>>    };
>> };
>>
>> board-with-display.dts or board-overlay.dts
>> &ltdc {
>>    ports {
>>      endpoint@1 { // just add another endpoint@1, no problem
>>        remote-endpoint = <&display>;
>>      };
>>    };
>> };
>>
>> With your patch, the DTS would have to modify the "endpoint" node to 
>> be "endpoint@0" probably with a whole lot of /detele-node/ etc. magic 
>> (DTO cannot do that, so that's a problem, and I do use DTOs on AV96 
>> extensively for the various expansion cards) and then add the 
>> endpoint@1. That becomes real complicated in custom board DT, and 
>> impossible with DTO.
> 
> Yes I agree that it'll be problematic. So maybe so solution would be to 
> not detect a warning for the initial case (only one endpoint with a reg)

That looks OK. Or even better, if the checker warned only on IPs which 
cannot have more than one endpoint, but have endpoint@N in DT (where N 
in 0..+inf) . On IPs which can have one or more endpoints, the warning 
should not be emitted.
