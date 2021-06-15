Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07A3A7EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFONHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:07:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FADC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:05:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n7so12085804wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/4p05McK2faiVXwCk4BFsV+8YmMH/7iKQXdzhdqhek=;
        b=rDAIoqWfSw65j3/N6CwfdhwRjuBCt8ablOBGx5/JQgSOx6doHcIdhLL06iMwLeyjIz
         8NMq90YBAr/5zaULjf31VSICil7K3OTIpDza/pkGD4UaQg3AtYkbCfsbhmd6aJn9h82N
         g8apN9SiPWXQrP/+h2RA06bFFPtfwEa/2Pbk3sYOEOp2IaMl0+wM010Sgwss1uTSJUau
         eaUCu9zua7iWSzKUUFp6iCOeBNmrwAL9rq8PO15dXAb0uHnXwU5ZeMGNM9SbBd3WuBmi
         EYtUXhXL4JciRpVaKOdtspbu0xUxXXV5MQdHRMkxoNZP2HgaoG3JzdLD0wwjnPnTGLtm
         0ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/4p05McK2faiVXwCk4BFsV+8YmMH/7iKQXdzhdqhek=;
        b=BiyKdZFZ7u8W4ijCxGc2JAvsK4L7jeqPTsaxQqSAsxHwFwtX3p0/5DKKzsnDeDyX3n
         KljUmymkjY6WwMh1jNtQyrnpuIqkhBD6kqghzMAQs/IwPvcJgPU0+Zku2pUGGlzAtuNN
         hEbrg3y8lpZNjZsiHIMhxVhNmIZ9XaioVg5zLgsKvDIUuYOeCN0XEO9vS33fymM5oPDk
         nW8M0h3nP2RdOVijfRzi6MGH4u+Io2s661hvKKgH8nonBKMNwcFLUM+serSUF4rM+zJ1
         ZyjyjLUAc4oQ4qYOgXxLPCSdc/xj0WS5hVBWTV+G0z5CkQWxtsukx2+oMAP4atLAaDke
         8VbQ==
X-Gm-Message-State: AOAM532NS1d+pIHTcu9Hp9jsAR+1mU0y8bct9Cp6FtIsi2/gg0i4IyxF
        tqJduv6NtuMlbDAs/RNTSmOZSOaJJxH41We+
X-Google-Smtp-Source: ABdhPJy/KBp9eREgdz30fSRAhTAtvzNFrgFTO9OzbgvuLnw8zjLz3DJoVty/4+5esfDgoX8vcg5nig==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr25444259wrq.149.1623762322905;
        Tue, 15 Jun 2021 06:05:22 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:613a:6939:5f7f:dceb? ([2a01:e34:ed2f:f020:613a:6939:5f7f:dceb])
        by smtp.googlemail.com with ESMTPSA id 6sm15715941wmg.17.2021.06.15.06.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:05:22 -0700 (PDT)
Subject: Re: [PATCH v1 03/10] ARM: tegra: acer-a500: Bump thermal trips by 10C
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Agneli <poczt@protonmail.ch>, Paul Fertser <fercerpav@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210510202600.12156-1-digetx@gmail.com>
 <20210510202600.12156-4-digetx@gmail.com>
 <20210514211601.GA1969@qmqm.qmqm.pl>
 <ecc89faf-97f5-65e9-0eb8-93c8414c69e5@linaro.org>
 <eedb5792-d3a5-78b3-ec89-b26d2e45f9c4@gmail.com>
 <c65a732d-b203-a1a0-e90b-0aa0664cfb55@linaro.org>
 <e73b64b2-77a8-3671-1fc6-0bf77e2287c4@gmail.com>
 <1abadc69-1dd1-5939-c089-37a84be4781b@linaro.org>
 <60a280c3-e67f-ff3a-9f0e-7d12fc125c5b@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8091014b-fe1b-9c4c-7a91-6aae5b4037e5@linaro.org>
Date:   Tue, 15 Jun 2021 15:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60a280c3-e67f-ff3a-9f0e-7d12fc125c5b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 14:53, Dmitry Osipenko wrote:
> 13.06.2021 21:19, Daniel Lezcano пишет:
>> On 13/06/2021 02:25, Dmitry Osipenko wrote:
>>
>> [ ... ]
>>
>>>> You should set the trip points close to the functioning boundary
>>>> temperature given in the hardware specification whatever the resulting
>>>> heating effect is on the device.
>>>>
>>>> The thermal zone is there to protect the silicon and the system from a
>>>> wild reboot.
>>>>
>>>> If the Nexus 7 is too hot after the changes, then you may act on the
>>>> sources of the heat. For instance, set the the highest OPP to turbo or
>>>> remove it, or, if there is one, change the thermal daemon to reduce the
>>>> overall power consumption.
>>>> In case you are interested in: https://lwn.net/Articles/839318/
>>>
>>> The DTPM is a very interesting approach. For now Tegra still misses some
>>> basics in mainline kernel which have a higher priority, so I think it
>>> should be good enough to perform the in-kernel thermal management for
>>> the starter. We may consider a more complex solutions later on if will
>>> be necessary.
>>>
>>> What I'm currently thinking to do is:
>>>
>>> 1. Set up the trips of SoC/CPU core thermal zones in accordance to the
>>> silicon limits.
>>>
>>> 2. Set up the skin trips in accordance to the device limits.
>>>
>>> The breached skin trips will cause a mild throttling, while the SoC/CPU
>>> trips will be allowed to cause the severe throttling. Does this sound
>>> good to you?
>>
>> The skin temperature must be managed from userspace. The kernel is
>> unable to do a smart thermal management given different thermal zones
>> but if the goal is to go forward and prevent the tablet to be hot
>> temporarily until the other hardware support is there, I think it is
>> acceptable.
> 
> The current goal is to get maximum from what we already have, thank you.

maximum of performance or maximum of mitigation ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
