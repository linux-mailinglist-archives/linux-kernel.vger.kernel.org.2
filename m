Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD85F360BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhDOObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:31:15 -0400
Received: from phobos.denx.de ([85.214.62.61]:40646 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233341AbhDOObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:31:12 -0400
X-Greylist: delayed 4155 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 10:31:11 EDT
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 31C6B81FD5;
        Thu, 15 Apr 2021 16:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1618497045;
        bh=QCFlP+DjDQQ/peWcEBQFC8IoSA2aoys0PklnNs1hhLw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hg5s2vAe5leyJERNEtnaXGvcHS2i5r2lX942XGx3T7rPZx1Lddv495O0ezzI3YJEe
         274OkqHdDLEBNFVviWcCwoQGQ8Xv2Y/JrM0TNLi8jsC2Tt2fl2/hs0p+l2a4TPHwko
         6Euo2siHp9C6s0HuameFet8tjz0DJsBgk1tEt0tp0JvcLTYPvyj8FPeV95YH7FIfud
         xMazhhb7XSzjBgpYzrN8RHaSY+QYWgHdub6eRo5UB16NVVsgCRSsXLHntW7G0fJvL0
         F54soBKqD3w7kY8+s0dYzbslIVCyO8Y23VkDSJDeiRoBjVsa/HnY9CH7t+8okXEv16
         efWSkQJG/d5QA==
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
From:   Marek Vasut <marex@denx.de>
Message-ID: <fa3885df-8977-9540-f2af-d4095f519483@denx.de>
Date:   Thu, 15 Apr 2021 16:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <36e9f0df-dfdb-e2f5-3d6e-ac32a1b8156e@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 3:34 PM, Alexandre TORGUE wrote:
> Hi Marek

Hello Alexandre,

>>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts 
>>> b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>> index 2bc92ef3aeb9..19ef475a48fc 100644
>>> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
>>> @@ -82,9 +82,15 @@
>>>   };
>>>   &ltdc {
>>> -    status = "okay";
>>> -
>>>       port {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        ltdc_ep0_out: endpoint@0 {
>>> +            reg = <0>;
>>> +            remote-endpoint = <&sii9022_in>;
>>> +        };
>>> +
>>>           ltdc_ep1_out: endpoint@1 {
>>>               reg = <1>;
>>>               remote-endpoint = <&dsi_in>;
>>
>> [...]
>>
>>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi 
>>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>> index 64dca5b7f748..e7f10975cacf 100644
>>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
>>> @@ -277,11 +277,7 @@
>>>       status = "okay";
>>>       port {
>>> -        #address-cells = <1>;
>>> -        #size-cells = <0>;
>>> -
>>> -        ltdc_ep0_out: endpoint@0 {
>>> -            reg = <0>;
>>> +        ltdc_ep0_out: endpoint {
>>>               remote-endpoint = <&adv7513_in>;
>>>           };
>>>       };
>>
>> I think this is wrong, the AV96 can have two displays connected to two 
>> ports of the LTDC, just like DK2 for example.
> 
> As for dk2 address/size cells are added only if there are 2 endpoints. 
> It is for this reason I moved endpoint0 definition from stm32mp15xx-dkx 
> to stm32mp151a-dk1.dts (dk1 has only one endpoint).
> 
> Here it's the same, if you have second endpoint then adress/size will 
> have to be added.

That's a bit problematic. Consider either the use case of DTO which adds 
the other display, or even a custom board DTS. Without your patch, this 
works:

arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
&ltdc {
   ...
   ports {
     ltdc_ep0_out: endpoint@0 {
       remote-endpoint = <&adv7513_in>;
     };
   };
};

board-with-display.dts or board-overlay.dts
&ltdc {
   ports {
     endpoint@1 { // just add another endpoint@1, no problem
       remote-endpoint = <&display>;
     };
   };
};

With your patch, the DTS would have to modify the "endpoint" node to be 
"endpoint@0" probably with a whole lot of /detele-node/ etc. magic (DTO 
cannot do that, so that's a problem, and I do use DTOs on AV96 
extensively for the various expansion cards) and then add the 
endpoint@1. That becomes real complicated in custom board DT, and 
impossible with DTO.
