Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9913424E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCSSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhCSSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41774C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:38:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o16so10101167wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYEoRUOi3MntuNkgcxlA6PixhZq/KlalSw6PsKJS1mU=;
        b=SUAFQoXy615WjK85B20Of9o5+6NbEcn/9xeVNPrxbOALG3VcWJDiiAEqTTzRKIXDzo
         WxFi7vp9gDN8wGTK6caLhl4yrVdp+a4TpRE9h5QzU/BfvRSIjusPNwcZYfS4CiBOkpdi
         17P0ouNK6+RS5cMOfbss/M6p3HRgbD+jYpQgkJGjSloocdpBJ+YQGLAgjY41pZWJOJv0
         Km39jOr+Bi3VYPUEPZmr4g64G327d3XI33uY9xPG5J5+gUXpSRMB/s5A8FwKroROPdlo
         N2n5AqzZTlpG0of7lTEads3/Iehu4hSSKdtCS1954fuMj68J4sdc93YpAKbJbxBtlof6
         B0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYEoRUOi3MntuNkgcxlA6PixhZq/KlalSw6PsKJS1mU=;
        b=W5rVIlgpie9ueQ39G3bd6YK/Rn8Em0Hmx6qy2HjubbIVNtF5F7hcsj3Jh2v7h89LYh
         so0Hj3HOl3Y5spCLb857ipwXcZBUfoAiJhcZPr41M67aGcTciOUPhHY7ql+2Igc8pcGe
         h561hU6EpVbIRCmyqooiWSNc/TG3r6tbySv0UEZy1HcN2amVo0hEFj9erUMAfhHAu6Kc
         Ii78pSwj1z603MMWrR9eVkEoGO7EhDgftfRu1uxys2EyiHiwfMuOXOvh26NdICCXiR3u
         lPH0z1uLx1Ic3CMcNZ/YcEG1sBaxwwyiWAoOPNj/Jhup2/ZlSk1+QDqYd2w+a72c2saY
         zUaA==
X-Gm-Message-State: AOAM530i+erL4Ql+nl7F48IVBtKhX1TqSZv+9VFIYbyEamVG2mRB1ZOX
        KXHkNTPAPpP191IiQGav2iRiv7zDNCgljQ==
X-Google-Smtp-Source: ABdhPJy1by9RHeFpSNx+To1gQgU5tcR6deACavE7xJJbx3XBXQciKlwzam3By8vz828NoTt3oZmW9A==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr5769517wrp.383.1616179115865;
        Fri, 19 Mar 2021 11:38:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85? ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.googlemail.com with ESMTPSA id p27sm7792340wmi.12.2021.03.19.11.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 11:38:35 -0700 (PDT)
Subject: Re: [PATCH] dt: rockchip: rk3399: Add dynamic power coefficient for
 GPU
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
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
 <11480a47-47da-c5b3-edad-c2dd8edb2cd9@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54f3d4d4-ca01-d00c-09d6-4cf100538cbe@linaro.org>
Date:   Fri, 19 Mar 2021 19:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <11480a47-47da-c5b3-edad-c2dd8edb2cd9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2021 19:05, Robin Murphy wrote:
> On 2021-03-19 14:35, Daniel Lezcano wrote:
>>
>> Hi Robin,
>>
>> On 19/03/2021 13:17, Robin Murphy wrote:
>>> On 2021-03-19 11:05, Daniel Lezcano wrote:
>>>> The DTPM framework is looking for upstream SoC candidates to share the
>>>> power numbers.
>>>>
>>>> We can see around different numbers but the one which seems to be
>>>> consistent with the initial post for the values on the CPUs can be
>>>> found in the patch https://lore.kernel.org/patchwork/patch/810159/
>>>
>>> The kernel hacker in me would be more inclined to trust the BSP that the
>>> vendor actively supports than a 5-year-old patch that was never pursued
>>> upstream. Apparently that was last updated more recently:
>>>
>>> https://github.com/rockchip-linux/kernel/commit/98d4505e1bd62ff028bd79fbd8284d64b6f468f8
>>>
>>
>> Yes, I've seen this value also.
>>
>>> The ex-mathematician in me can't even comment either way without
>>> evidence that whatever model expects to consume this value is even
>>> comparable to whatever "arm,mali-simple-power-model" is. >
>>> The way the
>>> latter apparently needs an explicit "static" coefficient as well as a
>>> "dynamic" one, and the value here being nearly 3 times that of a
>>> similarly-named one in active use downstream (ChromeOS appears to still
>>> be using the values from before the above commit), certainly incline me
>>> to think they may not be...
>>
>> Sorry, I'm missing the point :/
>>
>> We dropped in the kernel any static power computation because as there
>> was no value, the resulting code was considered dead. So we rely on the
>> dynamic power only.
> 
> Right, so a 2-factor model is clearly not identical to a 1-factor model,
> so how do we know that a value for one is valid for the other, even if
> it happens to have a similar name? I'm not saying that it is or isn't; I
> don't know. If someone can point to the downstream coefficient
> definition being identical to the upstream one then great, let's use
> that as justification. If not, then the justification of one arbitrary
> meaningless number over any other is a bit misleading.

That's a call :)

>>>> I don't know the precision of this value but it is better than
>>>> nothing.
>>>
>>> But is it? If it leads to some throttling mechanism kicking in and
>>> crippling GPU performance because it's massively overestimating power
>>> consumption, that would be objectively worse for most users, no?
>>
>> No because there is no sustainable power specified for the thermal zones
>> related to the GPU.
> OK, that's some reassurance at least. Does the exact value have any
> material effect? 

Yes, it has when it is combined with other devices having also power
values, like the CPUs and hopefully the DMC soon.

If we can have more or less consistent power numbers for the DMC, CPU
and GPU on the rock960, with the thermal zone having these three heating
sources, we can use the DTPM framework to act on the power of the whole.

I don't know the best coefficient, 733, 977 or 1780 [1]

The value of 977 sound to me as a starting point.



[1]
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/factory-gru-8652.B-chromeos-4.4/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin-r3.dts

> If not, what's to stop us from using an obviously
> made-up value like 1, and saying so?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
