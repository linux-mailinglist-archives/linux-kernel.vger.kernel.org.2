Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C63337358
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhCKNCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:02:36 -0500
Received: from gecko.sbs.de ([194.138.37.40]:60534 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233386AbhCKNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:02:16 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12BD1tAw006730
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 14:01:55 +0100
Received: from [167.87.35.81] ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12BD1spc024424;
        Thu, 11 Mar 2021 14:01:55 +0100
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
To:     Nishanth Menon <nm@ti.com>, "Bajjuri, Praneeth" <praneeth@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
 <9097f361-419f-995f-2f05-d17a949af1cb@ti.com>
 <20210311125634.sasiot7hemsdcajl@thrash>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3e863dea-5dda-7435-e4fb-4135c9c0fcf5@siemens.com>
Date:   Thu, 11 Mar 2021 14:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311125634.sasiot7hemsdcajl@thrash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 13:56, Nishanth Menon wrote:
> On 19:36-20210310, Bajjuri, Praneeth wrote:
>>
>>
>> On 2/20/2021 6:49 AM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Add the DT entry for a watchdog based on RTI1.
>>>
>>> On SR1.0 silicon, it requires additional firmware on the MCU R5F cores
>>> to handle the expiry, e.g. https://github.com/siemens/k3-rti-wdt. As
>>> this firmware will also lock the power domain to protect it against
>>> premature shutdown, mark it shared.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Acked-by: Praneeth Bajjuri <praneeth@ti.com>
>>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> index 7454c8cec0cc..903796bf7d64 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> @@ -308,4 +308,13 @@ mcu_r5fss0_core1: r5f@41400000 {
>>>   			ti,loczrama = <1>;
>>>   		};
>>>   	};
>>> +
>>> +	mcu_rti1: rti@40610000 {
> 
> Jan, I was about to pick up the patches and was running through
> my sanity checks and the following caught my eye with dtbs_check
> (dtschema is at 2021.2.1) test against next-20210311
> 
> /workdir/arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: rti@40610000: $nodename:0: 'rti@40610000' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Please use watchdog@40610000 instead of rti@40610000
> 
> Since this is a minor change, I have done this change locally. let me
> know if you have an issue and I can drop it off my branch for a new
> version.
> 

That's fine, thanks for fixing up - still learning such details.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
