Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A441DD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhI3PO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:14:56 -0400
Received: from phobos.denx.de ([85.214.62.61]:35984 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245132AbhI3POz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:14:55 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9F46F81FEC;
        Thu, 30 Sep 2021 17:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633014791;
        bh=4n+78j9+c4MNjpI8CIXjUqArDX7g1K5iL35BABt5u6M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c9iM/svv66/9gVlCeN6ciTz7ljQ3i6Yqc422DnME00grr3LTtOT3UWOir40oLGfVf
         x8lWoESgZuxUQvFZOiv3sdMRuYSI/BvjQLKTj/IALhVyry7VDBp2DPCXQD9KpLMeVC
         6cUSRGk6xApgc3LZUMn/Z0QZU64n5Mgfk1X4xTBKVYPmWIZojRHfi9Q98FdOKG2Jg4
         PG1h975ZRLb6TJHnSpWWvon2tgyHP6yhbwwJWFuJlYz26Q8/O4Wtda12reVvTC3Q72
         FFegOB9RA1vLrs04zlyegsqAk8x6YcGNeqdQ/T97mL0N+z2BOqU4S/d2/yuBWH6xgr
         iDRoiSdMtSmyA==
Subject: Re: [PATCH 1/1] ARM: dts: stm32: fix AV96 board SAI2B pin muxing on
 stm32mp15
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20210927114553.21843-1-olivier.moysan@foss.st.com>
 <beb6e7c8-f3c8-fc4e-6017-fea5690b9f33@denx.de>
 <e8d40be8-045c-096a-f079-d9f6364254e9@foss.st.com>
 <cfbb8475-ad1e-9075-cd82-92a8b315efc9@denx.de>
 <9b278eb2-7ca9-0e4b-ecb1-5949ce3c5c10@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <88867104-97f5-1c5f-506a-cfcac0962e55@denx.de>
Date:   Thu, 30 Sep 2021 17:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9b278eb2-7ca9-0e4b-ecb1-5949ce3c5c10@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 5:05 PM, Alexandre TORGUE wrote:
> On 9/30/21 12:26 PM, Marek Vasut wrote:
>> On 9/30/21 10:47 AM, Alexandre TORGUE wrote:
>>> Hi Marek
>>>
>>> On 9/29/21 1:18 PM, Marek Vasut wrote:
>>>> On 9/27/21 1:45 PM, Olivier Moysan wrote:
>>>>> Fix SAI2B pin muxing for AV96 board on STM32MP15.
>>>>> The label "sai2a-4" is defined twice. Change redundant label to 
>>>>> "sai2b-4".
>>>>>
>>>>> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for 
>>>>> SAI2 pins on stm32mp15")
>>>>>
>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>> ---
>>>>>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi 
>>>>> b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>>> index 5b60ecbd718f..b9cc9e0dd4fc 100644
>>>>> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>>> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
>>>>> @@ -1235,7 +1235,7 @@
>>>>>           };
>>>>>       };
>>>>> -    sai2b_pins_c: sai2a-4 {
>>>>> +    sai2b_pins_c: sai2b-4 {
>>>>>           pins1 {
>>>>>               pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>>>>>               bias-disable;
>>>>
>>>> This mp1 pinmuxing is a total mess, sigh.
>>>
>>> What is the issue here ?
>>
>> The same-old discussion about where to place the pinmux nodes, whether 
>> we should have these clusters of pre-defined options in 
>> ...pinctrl.dtsi, or whether we should do more nxp-like per-board 
>> configuration.
> 
> ok it's a bit more precise. Honestly I don't understand why the current 
> topology is an issue here. Maybe pinctrl SAI nodes names are not well 
> chosen or are not enough explicit. Concerning our topology and the NXP 
> ones both exists and both have advantages and drawbacks. For ST boards 
> (DK/EV) we want to keep all configs in the same place.
> 
> As I prefer to not re open this topic again and again, feel free to add 
> your pin config in your dts board file, I'll accept it.

Yes, let's not reopen it. I'm sorry if my grumbling came across as too 
strong.
