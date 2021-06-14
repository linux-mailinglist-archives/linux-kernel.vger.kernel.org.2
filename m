Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A22E3A6E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhFNSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:18:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46774 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhFNSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:18:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15EIGJoa120778;
        Mon, 14 Jun 2021 13:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623694579;
        bh=NxVCEcZrZwDO257WFQvJlJiBOGxX0k/7J+zSkCOgniQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tWgqGeYPjAxhzhMlz+fAsN3+eajQipSEvlWU0BZaJ7wIU4go/p0QFuF3ETM1NzVqR
         pEav75iLaL8Hyzf4p9xiiPDAMRB9tap09WNcVyBtkLHEY2oXEMPrcHlYGN4Lf1nT9q
         lMoBI6gW5OtOc2HiFGPzQT4w8WgtpvjR6AQnOg8g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15EIGJsM091771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jun 2021 13:16:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 14
 Jun 2021 13:16:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 14 Jun 2021 13:16:18 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15EIGIrH075089;
        Mon, 14 Jun 2021 13:16:18 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-main: Update the location of
 ATF in SRAM and increase its max size
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210607133806.18158-1-a-govindraju@ti.com>
 <e53458a9-e5f6-6507-f95c-2406b47b5576@ti.com>
 <b709d5a8-17dd-37e7-405a-35f39f84878b@ti.com>
 <50bb1f20-ccca-fe94-eac1-70ac83bc004d@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2c99ab11-96da-a74c-62d1-f14c686d0a0b@ti.com>
Date:   Mon, 14 Jun 2021 13:16:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <50bb1f20-ccca-fe94-eac1-70ac83bc004d@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 6/9/21 10:24 AM, Lokesh Vutla wrote:
> 
> 
> On 09/06/21 8:52 pm, Aswath Govindraju wrote:
>> Hi Lokesh,
>>
>> On 09/06/21 7:59 pm, Lokesh Vutla wrote:
>>>
>>>
>>> On 07/06/21 7:08 pm, Aswath Govindraju wrote:
>>>> Due to a limitation for USB DFU boot mode, SPL load address has to be less
>>>> than  or equal to 0x70001000. So, load address of SPL and ATF have been
>>>> moved to 0x70000000 and 0x701a0000 respectively.
>>>>
>>>> Also, the maximum size of ATF has been increased to 0x1c000 [1].
>>>>
>>>> Therefore, update ATF's location and maximum size accordingly in the device
>>>> tree file.
>>>>
>>>> [1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>>> index ca59d1f711f8..fcd12b6f10f6 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>>>> @@ -13,8 +13,8 @@
>>>>  		#size-cells = <1>;
>>>>  		ranges = <0x0 0x00 0x70000000 0x200000>;
>>>>  
>>>> -		atf-sram@0 {
>>>> -			reg = <0x0 0x1a000>;
>>>> +		atf-sram@1a0000 {
>>>> +			reg = <0x1a0000 0x1c000>;
>>>
>>> After thinking a bot more, isn't size be 0x20000?
>>> ATF is allocated with 125KB no? no point keeping the ~3 as hole IMO.
>>>
>>
>> The max size of ATF as defined above in [1] is 0x1c000 and as the
>> argument has to reflect it I have modified it to the same.
> 

I personally prefer that the size increase and address relocation are split up
into two separate patches for appropriate version compatibility. TFA 2.5 has
updated the size to 0x1c000, so I would like to see that as the first patch. We
should be able to merge that change right away. I see there is some on-going
discussion around the relocated address, so it can fall in line with the
corresponding SYSFW reservation patch.

regards
Suman

> ahh..Got it. Ignore my comment.
> 
> Thanks and regards,
> Lokesh
> 
>>
>> Thanks,
>> Aswath
>>
>>
>>> Thanks and regards,
>>> Lokesh
>>>
>>>>  		};
>>>>  	};
>>>>  
>>>>
>>

