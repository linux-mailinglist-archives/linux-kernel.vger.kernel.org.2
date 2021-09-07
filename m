Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C2402BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbhIGPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:31:31 -0400
Received: from thoth.sbs.de ([192.35.17.2]:56496 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345158AbhIGPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:31:30 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 187FUEkh024943
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 17:30:14 +0200
Received: from [167.87.245.242] ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187FUDCI012757;
        Tue, 7 Sep 2021 17:30:13 +0200
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
 <20210907152746.fbddtkktvx6hb5ti@cattishly>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
Date:   Tue, 7 Sep 2021 17:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907152746.fbddtkktvx6hb5ti@cattishly>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 17:27, Nishanth Menon wrote:
> On 17:20-20210907, Jan Kiszka wrote:
>> On 07.09.21 17:13, Nishanth Menon wrote:
>>> On 16:22-20210907, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> This ensures that the SD card will remain mmc0 across Basic and Advanced
>>>> devices, also avoiding surprises for users coming from the downstream
>>>> kernels.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>> index ec9617c13cdb..d1d5278e0b94 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>>> @@ -18,6 +18,11 @@ / {
>>>>  	compatible = "siemens,iot2050-advanced", "ti,am654";
>>>>  	model = "SIMATIC IOT2050 Advanced";
>>>>  
>>>> +	aliases {
>>>> +		mmc0 = &sdhci1;
>>>> +		mmc1 = &sdhci0;
>>>> +	};
>>>
>>>
>>> Should we do this at SoC level?
>>>
>>
>> Well, I wouldn't mind - but that would also impact your EVMs. For us,
>> this is fine as we are coming from that ordering above with our
>> downstream kernel/dts.
>>
> 
> I think it'd probably be a welcome change. overall we've standardized on
> partuuid.
> 

Yeah, it's more about "dd if=emmc.img of=/dev/mmcblk1 - damn, the wrong
one again."

Let me know what you prefer, and I'll update my patch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
