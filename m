Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547F0402D62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbhIGRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:03:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbhIGRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:02:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187H1kj4127603;
        Tue, 7 Sep 2021 12:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631034106;
        bh=fK2thzMc0IJwiqIlBOUizs3B5dZVIVtH40fSvScxog0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xUMRrbNXMSlysxCp7Ib01wh5+B0wZYT5CUGANV9ZObT1nRkH8P3sxxfhgK5rnjg9q
         216EX6i49GM7ZFBxFvg6ExJYZ+oDFaAn6fcptSOVErRoldOLCHULFdV5HdbzDb51Bh
         qk0wYiTRXAQeg5Vr8LFwoIB6FRbYMcymfZo10w1w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187H1k8k019509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 12:01:46 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 12:01:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 12:01:45 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187H1gur066531;
        Tue, 7 Sep 2021 12:01:43 -0500
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
To:     Nishanth Menon <nm@ti.com>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
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
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <d69acf3d-e0c4-ef7b-be23-0d98dd6b05aa@ti.com>
Date:   Tue, 7 Sep 2021 22:31:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907165316.4s3jrouctcpc3kvo@pessimism>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 07/09/21 10:23 pm, Nishanth Menon wrote:
> On 22:17-20210907, Aswath Govindraju wrote:
>> Hi Nishanth,
>>
>> On 07/09/21 9:05 pm, Nishanth Menon wrote:
>>> On 17:30-20210907, Jan Kiszka wrote:
>>>> On 07.09.21 17:27, Nishanth Menon wrote:
>>>>> On 17:20-20210907, Jan Kiszka wrote:
>>>>>> On 07.09.21 17:13, Nishanth Menon wrote:
>>>>>>> On 16:22-20210907, Jan Kiszka wrote:
>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> This ensures that the SD card will remain mmc0 across Basic and Advanced
>>>>>>>> devices, also avoiding surprises for users coming from the downstream
>>>>>>>> kernels.
>>>>>>>>
>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>> ---
>>>>>>>>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
>>>>>>>>  1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>> index ec9617c13cdb..d1d5278e0b94 100644
>>>>>>>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>>>>>> @@ -18,6 +18,11 @@ / {
>>>>>>>>  	compatible = "siemens,iot2050-advanced", "ti,am654";
>>>>>>>>  	model = "SIMATIC IOT2050 Advanced";
>>>>>>>>  
>>>>>>>> +	aliases {
>>>>>>>> +		mmc0 = &sdhci1;
>>>>>>>> +		mmc1 = &sdhci0;
>>>>>>>> +	};
>>>>>>>
>>>>>>>
>>>>>>> Should we do this at SoC level?
>>>>>>>
>>>>>>
>>>>>> Well, I wouldn't mind - but that would also impact your EVMs. For us,
>>>>>> this is fine as we are coming from that ordering above with our
>>>>>> downstream kernel/dts.
>>>>>>
>>>>>
>>>>> I think it'd probably be a welcome change. overall we've standardized on
>>>>> partuuid.
>>>>>
>>>>
>>>> Yeah, it's more about "dd if=emmc.img of=/dev/mmcblk1 - damn, the wrong
>>>> one again."
>>>>
>>>> Let me know what you prefer, and I'll update my patch.
>>>
>>>
>>> Lets do it at SoC level. I will follow it up with a patch for other K3
>>> SoCs as well.
>>>
>>>
>>> Unless someone has a strong opinion on this approach - if so, speak up
>>> with reasons.
>>>
>>
>> Making this change in SoC level for all K3 devices would force changes
>> to be made in U-Boot too, for consistency. In U-Boot, a major change
>> would be required in the environment variables to support this. As I
>> don't see any functional advantage by making this change, I feel that
>> this change would make things more confusing for users already using the
>> K3 devices. At present, the ordering is consistent across all the K3
>> devices, I feel that keeping it the same way would be better.
>>
>> As for making changes only on IoT boards, if it is okay to have the
>> ordering changed between U-Boot and kernel, I don't see any problem
>> making this change in kernel alone.
> 
> 
> arch/arm64/boot/dts/ti/k3-am65.dtsi has no ordering. u-boot is supposed
> to copy from kernel the dtsi files as is. I think having mmc aliases in
> kernel is a good thing as we do regard kernel as the canonical dts
> source.
> 

Yes, you are correct. Aliases are not added for mmc in U-Boot too, but
due to the ordering in the device tree, mmc0 is always sdhci0 and mmc1
is always sdhci1 in U-Boot. I agree that, in kernel as the probe order
is not guaranteed, fixing the order would be better by adding aliases
explicitly.

> If you are suggesting we flip things so that mmc0 is sdhci0 and mmc1 is
> sdhci1 -  that might be a valid suggestion - Jan, do you see a problem
> in having consistency here (flip the aliases)?
> 
> 

Yes, I am suggesting a flip in the order and this order can be applied
across all the K3 SoC's

Thanks,
Aswath

