Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC93423FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCSSGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:06:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhCSSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AEBB31B;
        Fri, 19 Mar 2021 11:05:59 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6FD83F792;
        Fri, 19 Mar 2021 11:05:56 -0700 (PDT)
Subject: Re: [PATCH] dt: rockchip: rk3399: Add dynamic power coefficient for
 GPU
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210319110511.24787-1-daniel.lezcano@linaro.org>
 <5db868e4-5b86-7b32-51e0-665a2e1fc1ac@arm.com>
 <9322db05-2cad-453c-ec1b-1fdb3df142fa@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <11480a47-47da-c5b3-edad-c2dd8edb2cd9@arm.com>
Date:   Fri, 19 Mar 2021 18:05:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9322db05-2cad-453c-ec1b-1fdb3df142fa@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-19 14:35, Daniel Lezcano wrote:
> 
> Hi Robin,
> 
> On 19/03/2021 13:17, Robin Murphy wrote:
>> On 2021-03-19 11:05, Daniel Lezcano wrote:
>>> The DTPM framework is looking for upstream SoC candidates to share the
>>> power numbers.
>>>
>>> We can see around different numbers but the one which seems to be
>>> consistent with the initial post for the values on the CPUs can be
>>> found in the patch https://lore.kernel.org/patchwork/patch/810159/
>>
>> The kernel hacker in me would be more inclined to trust the BSP that the
>> vendor actively supports than a 5-year-old patch that was never pursued
>> upstream. Apparently that was last updated more recently:
>>
>> https://github.com/rockchip-linux/kernel/commit/98d4505e1bd62ff028bd79fbd8284d64b6f468f8
> 
> Yes, I've seen this value also.
> 
>> The ex-mathematician in me can't even comment either way without
>> evidence that whatever model expects to consume this value is even
>> comparable to whatever "arm,mali-simple-power-model" is. >
>> The way the
>> latter apparently needs an explicit "static" coefficient as well as a
>> "dynamic" one, and the value here being nearly 3 times that of a
>> similarly-named one in active use downstream (ChromeOS appears to still
>> be using the values from before the above commit), certainly incline me
>> to think they may not be...
> 
> Sorry, I'm missing the point :/
> 
> We dropped in the kernel any static power computation because as there
> was no value, the resulting code was considered dead. So we rely on the
> dynamic power only.

Right, so a 2-factor model is clearly not identical to a 1-factor model, 
so how do we know that a value for one is valid for the other, even if 
it happens to have a similar name? I'm not saying that it is or isn't; I 
don't know. If someone can point to the downstream coefficient 
definition being identical to the upstream one then great, let's use 
that as justification. If not, then the justification of one arbitrary 
meaningless number over any other is a bit misleading.

>>> I don't know the precision of this value but it is better than
>>> nothing.
>>
>> But is it? If it leads to some throttling mechanism kicking in and
>> crippling GPU performance because it's massively overestimating power
>> consumption, that would be objectively worse for most users, no?
> 
> No because there is no sustainable power specified for the thermal zones
> related to the GPU.
OK, that's some reassurance at least. Does the exact value have any 
material effect? If not, what's to stop us from using an obviously 
made-up value like 1, and saying so?

Robin.
