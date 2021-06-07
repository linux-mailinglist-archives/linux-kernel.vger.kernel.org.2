Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381AC39E4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFGRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:07:23 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:33759 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhFGRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:07:19 -0400
Received: by mail-ej1-f52.google.com with SMTP id g20so27927485ejt.0;
        Mon, 07 Jun 2021 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrWddwWHw9uPgT90OED9mI59lJfe1xzoeVULMb6Xu3I=;
        b=vOMlssHEtFlFXMQxi2c6WwrCgLYjEIUc/VEJn4yGw0dPyPTLqjae3B1QdECCW8MJ6A
         sXWeU6ynNlqgvouzxPQk4qwQo61CM+ok+tYlkiuuJxewaCeVHfYMP4yrQn8lpueU2Ruf
         trk5MsyEKpEyZlMv1B5JtW3Icw59wFyd3VNGcDF6DyxkueJxHasR8JQ8Wqyqrm3uvrir
         D+7Be5dFY+KxUKdjmCagzQqFeILMq9+LxrzON3J38i0ktG+qIQm17/ezHDNZBe54IPYX
         fU/CTNkJKHCwkffOdzNCZsJOYoaHBhMG0QSI8FNXWN8+j5j5jXh9n/lMG777l9Iue+c8
         77PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrWddwWHw9uPgT90OED9mI59lJfe1xzoeVULMb6Xu3I=;
        b=kwk2YRll1+QSzPMJB/1r/jnq88T/u+LHwf8eW3fesD/Sfaida/ysInYguDu5B0u7z9
         kBKtM8j7J9Cljt5/i63bRIET40VUY7wJ8bH/YpQmg0inQuWibXBzhphouk84Bh4wOg0N
         3PdLDdEpIganFnWCecD9wDk93Qc30rvf4CFnaCBureOarbrwkUvrJlG3n6X/ch9t4OpQ
         iqSHrpJAPbCNmW9/1qTV0Zo9saxthOlprtf7RQ9BDOc0hRrhM+Gh//UlKjHrOOQq5ue5
         CbRLFnXEe1RLL6Zsc/9DPJbTiz9gQm/TBvqmeEBCVG078m+sbdU9+wpAMaqSer72OjGh
         OnKg==
X-Gm-Message-State: AOAM533pJlAz12pYATiK7LTdd9iOfxISwVMv999BsM76ooEkP3jy3AHx
        nuv/C2w9//eEbGVgKWhQWLVnrEtsjbfQtQ==
X-Google-Smtp-Source: ABdhPJwt055ZeOAcDRjhVFOzQkOYa90oEcJZ/OcMXCyPgqJpMV0jz1h4Fm3+oAc2i5cs5/Rz6JC8Pg==
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr10363749ejc.0.1623085466935;
        Mon, 07 Jun 2021 10:04:26 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x13sm6753581ejj.21.2021.06.07.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:04:26 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210607081727.4723-1-cnsztl@gmail.com>
 <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
 <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com>
 <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
 <CAOP2_TiHwYhLVLOEx-Vgx6k3XmHgNsiyR8CqrWyABnP0AidMBg@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <b5cc8e2b-10b6-de5d-38dd-5e5cfd84e984@gmail.com>
Date:   Mon, 7 Jun 2021 19:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAOP2_TiHwYhLVLOEx-Vgx6k3XmHgNsiyR8CqrWyABnP0AidMBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 6:01 PM, Tianling Shen wrote:
> Hi Johan,
> 
> On Mon, Jun 7, 2021 at 6:26 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Hi Chen-Yu,
>>
>> On 6/7/21 11:40 AM, Chen-Yu Tsai wrote:
>>> On Mon, Jun 7, 2021 at 5:31 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>>>
>>>> Hi Tianling,
>>>>
>>>> On 6/7/21 10:17 AM, Tianling Shen wrote:
>>>>> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
>>>>> stores the MAC address.
>>>>>
>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
>>>>>  1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>>>> index cef4d18b599d..4a82f50a07c5 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>>>> @@ -68,6 +68,15 @@
>>>>>       status = "disabled";
>>>>>  };
>>>>>
>>>>> +&i2c2 {
>>>>> +     eeprom@51 {
>>>>> +             compatible = "microchip,24c02", "atmel,24c02";
>>>>> +             reg = <0x51>;
>>>>> +             pagesize = <16>;
>>>>
>>>>> +             read-only; /* This holds our MAC */
>>>>
>>>> The mainline dts files should be generic I think.
>>>> Any comment about "use", partitions or write ability should be avoided.
>>>> It's up the user.
>>>
>>
>>> Per the datasheet for this specific EEPROM, the latter half (128 bytes)
>>> is read-only in hardware by design though.
>>
>> The 24AA02XEXX is programmed at the factory with a
>> globally unique node address stored in the upper half
>> of the array and permanently write-protected. The
>> remaining 1,024 bits are available for application use.
>>
> 

> In my opinion, as this contains data programmed by the factory, would
> it be okay to keep it read-only?

This chip is not completely read-only.
There might be users that like to try some other mac_address or store
something else in that lower part. Is this then still possible?
Generic DT describes hardware independent from what Linux drivers or
other OS are capable off.
This factory mac_addres is permanently write-protected, so no need to
keep the rest read-only.

     nvmem-cells = <&new_mac_address_in_lower_part>;
     nvmem-cells-names = "mac-address";

> 
>> Just a question...
>>
>>     nvmem-cells = <&mac_address>;
>>     nvmem-cells-names = "mac-address";
>>
>> Which part does this point to?
>>
>> Can we use the lower part to store/rewrite this too?
>>
>> ===
>>
>> From at24.yaml:
>>
>>             items:
>>               - pattern:
>> "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$"
>>               - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
>>
>> How does Microchip 24AA025E48 fit the regex?
>> What compatible would you advise?
> 
> It seems that 24AA025E48 is a variant of 24MAC402 [1], and
> `atmel,24c02` will be okay in this case.
> 1. https://lkml.org/lkml/2018/1/24/494

Ask Heiko. ;)

As long as it does not generate more notifications then we already have.

> 
> Thanks,
> Tianling.
> 
>>
>> ===
>>
>> Johan
>>
>>>
>>> ChenYu
>>>
