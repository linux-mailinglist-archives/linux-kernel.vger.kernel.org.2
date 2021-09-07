Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE596402FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbhIGUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:30:06 -0400
Received: from gecko.sbs.de ([194.138.37.40]:33379 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346600AbhIGU36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:29:58 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 187KSXW1005590
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 22:28:33 +0200
Received: from [167.87.245.242] ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187KSWxs030398;
        Tue, 7 Sep 2021 22:28:32 +0200
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
To:     Aswath Govindraju <a-govindraju@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
 <20210907152746.fbddtkktvx6hb5ti@cattishly>
 <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
 <20210907153547.53cc2zx23rx72kqf@thyself>
 <482dddc1-b1f8-15db-a0c5-0d6def5d859f@ti.com>
 <20210907165316.4s3jrouctcpc3kvo@pessimism>
 <d69acf3d-e0c4-ef7b-be23-0d98dd6b05aa@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4cb6e76e-479f-5e06-778a-4788be53afb9@siemens.com>
Date:   Tue, 7 Sep 2021 22:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d69acf3d-e0c4-ef7b-be23-0d98dd6b05aa@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 19:01, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 07/09/21 10:23 pm, Nishanth Menon wrote:
>> On 22:17-20210907, Aswath Govindraju wrote:
>>> Hi Nishanth,
>>>
>>> On 07/09/21 9:05 pm, Nishanth Menon wrote:
>>>> On 17:30-20210907, Jan Kiszka wrote:
>>>>> On 07.09.21 17:27, Nishanth Menon wrote:
>>>>>> On 17:20-20210907, Jan Kiszka wrote:
>>>>>>> On 07.09.21 17:13, Nishanth Menon wrote:
>>>>>>>> On 16:22-20210907, Jan Kiszka wrote:
>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>
>>>>>>>>> This ensures that the SD card will remain mmc0 across Basic and Advanced
>>>>>>>>> devices, also avoiding surprises for users coming from the downstream
>>>>>>>>> kernels.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>> ---
>>>>>>>>>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
>>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>>> index ec9617c13cdb..d1d5278e0b94 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>>> @@ -18,6 +18,11 @@ / {
>>>>>>>>>  	compatible = "siemens,iot2050-advanced", "ti,am654";
>>>>>>>>>  	model = "SIMATIC IOT2050 Advanced";
>>>>>>>>>  
>>>>>>>>> +	aliases {
>>>>>>>>> +		mmc0 = &sdhci1;
>>>>>>>>> +		mmc1 = &sdhci0;
>>>>>>>>> +	};
>>>>>>>>
>>>>>>>>
>>>>>>>> Should we do this at SoC level?
>>>>>>>>
>>>>>>>
>>>>>>> Well, I wouldn't mind - but that would also impact your EVMs. For us,
>>>>>>> this is fine as we are coming from that ordering above with our
>>>>>>> downstream kernel/dts.
>>>>>>>
>>>>>>
>>>>>> I think it'd probably be a welcome change. overall we've standardized on
>>>>>> partuuid.
>>>>>>
>>>>>
>>>>> Yeah, it's more about "dd if=emmc.img of=/dev/mmcblk1 - damn, the wrong
>>>>> one again."
>>>>>
>>>>> Let me know what you prefer, and I'll update my patch.
>>>>
>>>>
>>>> Lets do it at SoC level. I will follow it up with a patch for other K3
>>>> SoCs as well.
>>>>
>>>>
>>>> Unless someone has a strong opinion on this approach - if so, speak up
>>>> with reasons.
>>>>
>>>
>>> Making this change in SoC level for all K3 devices would force changes
>>> to be made in U-Boot too, for consistency. In U-Boot, a major change
>>> would be required in the environment variables to support this. As I
>>> don't see any functional advantage by making this change, I feel that
>>> this change would make things more confusing for users already using the
>>> K3 devices. At present, the ordering is consistent across all the K3
>>> devices, I feel that keeping it the same way would be better.
>>>
>>> As for making changes only on IoT boards, if it is okay to have the
>>> ordering changed between U-Boot and kernel, I don't see any problem
>>> making this change in kernel alone.
>>
>>
>> arch/arm64/boot/dts/ti/k3-am65.dtsi has no ordering. u-boot is supposed
>> to copy from kernel the dtsi files as is. I think having mmc aliases in
>> kernel is a good thing as we do regard kernel as the canonical dts
>> source.
>>
> 
> Yes, you are correct. Aliases are not added for mmc in U-Boot too, but
> due to the ordering in the device tree, mmc0 is always sdhci0 and mmc1
> is always sdhci1 in U-Boot. I agree that, in kernel as the probe order
> is not guaranteed, fixing the order would be better by adding aliases
> explicitly.
> 

We had mmc reordered for our devices in U-Boot already. That separate
snippet would obviously be obsolete when sync'ing common reordering over.

>> If you are suggesting we flip things so that mmc0 is sdhci0 and mmc1 is
>> sdhci1 -  that might be a valid suggestion - Jan, do you see a problem
>> in having consistency here (flip the aliases)?
>>
>>
> 
> Yes, I am suggesting a flip in the order and this order can be applied
> across all the K3 SoC's
> 

I'm not sure what you are suggesting. I've sent v2 already which moves
aliasing to SoC level, and I would push that to U-Boot as well if
acceptable. If not, we will keep this in our board DTs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
