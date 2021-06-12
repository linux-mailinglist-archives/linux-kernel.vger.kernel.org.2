Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121B3A4F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFLO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:27:52 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44030 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:27:51 -0400
Received: by mail-wr1-f52.google.com with SMTP id r9so9119986wrz.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPvRd3I03GEmWUI3cd1cTAMqfrjwc30D61P1B9SGlkI=;
        b=WYbLrKPINcxVinRcL0M+IGG9ajz81eMgSA8Uppfa3Y2kw1X77iQpuBMwGoEQ9gzI5O
         gmA2q0ytCaCsUKK/omhbC5VTDJ47Rsx0uedi/0Y886n4+EzOrJ0y2qiP3KjAsY2RFIZl
         fFi0SjU1T6NpKCw7WucsaAObBGDgMvKzfc7rCMccTb3IUf/B31Xbt8gVw/VDU+hmNcLH
         0/IONzRb6tycedTzqHIi40pQ7oUWkX808TEeStqWmjBUZB5QQbVryhHSC5tZbon3MCEB
         UQhmYJri8lKA9qQgampft7lI2uAHzPeVbZUmJSNZG0MqdN7k6QmsIzsw4IF21kTfDAu1
         IBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPvRd3I03GEmWUI3cd1cTAMqfrjwc30D61P1B9SGlkI=;
        b=iLg/DFyw7yNWTZfMUerkrm3z655TpnIwFtAK/xLY/SbNBeA5V2anhhGQLCJUHaZQsD
         oze9eYmnectPBP8EU4A1GRiWxKr8YiW04j39y7cIBuKZylj/m3JFZwa8DiNRWb006CE3
         ErszBj6FZfMjmyNDHAGBAHbwtl9LNcN5kB7Pe1kAkWjAC6ebPOSf7hPAWOAN1seLPMk1
         ymt2p5kHCKsVFVUiac6B7sytCcLupW3BFCLKqANnFTdnDnLESUdHSfX4OksshHl1bDgV
         LkNGUQE8KZYILyeiofKf5RHHQb5xLOeB5X+MRAxIIRymS7xrIFoxoo95mj1F40VNoDO3
         zCPA==
X-Gm-Message-State: AOAM532kqxMl64vC2EmrOOOAcxEUMoC2Vjtjlj4WjxwhtgJizww7lCpp
        g9qaFALeGGX0SJULMlLW0q/QL+Atc/gP40zo
X-Google-Smtp-Source: ABdhPJwOnuTq+tUyB3ODOGA7NcLlE6JdvqChyny1VOTpWM/cd+gFL5d6xrd23g/V8fCP9UEf6xSgbQ==
X-Received: by 2002:adf:f985:: with SMTP id f5mr5235742wrr.201.1623507891403;
        Sat, 12 Jun 2021 07:24:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:15bb:2e33:aa66:1b44? ([2a01:e34:ed2f:f020:15bb:2e33:aa66:1b44])
        by smtp.googlemail.com with ESMTPSA id m7sm11265303wrv.35.2021.06.12.07.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 07:24:50 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c65a732d-b203-a1a0-e90b-0aa0664cfb55@linaro.org>
Date:   Sat, 12 Jun 2021 16:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eedb5792-d3a5-78b3-ec89-b26d2e45f9c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2021 12:40, Dmitry Osipenko wrote:
> 11.06.2021 12:52, Daniel Lezcano пишет:
>> On 14/05/2021 23:16, Michał Mirosław wrote:
>>> On Mon, May 10, 2021 at 11:25:53PM +0300, Dmitry Osipenko wrote:
>>>> It's possible to hit the temperature of the thermal zone in a very warm
>>>> environment under a constant load, like watching a video using software
>>>> decoding. It's even easier to hit the limit with a slightly overclocked
>>>> CPU. Bump the temperature limit by 10C in order to improve user
>>>> experience. Acer A500 has a large board and 10" display panel which are
>>>> used for the heat dissipation, the SoC is placed far away from battery,
>>>> hence we can safely bump the temperature limit.
>>>
>>> 60^C looks like a touch-safety limit (to avoid burns for users). Did you
>>> verify the touchable parts' temperature somehow after the change?
>>
>> The skin temperature and the CPU/GPU etc ... temperatures are different
>> things.
>>
>> For the embedded system there is the dissipation system and a
>> temperature sensor on it which is the skin temp. This temperature is the
>> result of the heat of all the thermal zones on the board and must be
>> below 45°C. The temperature slowly changes.
>>
>> On the CPU, the temperature changes can be very fast and you have to
>> take care of keeping it below the max temperature specified in the TRM
>> by using different techniques (freq changes, idle injection, ...) but
>> the temperature can be 75°C, 85°C or whatever the manual says.
>>
>> 50°C and 60°C are low temperature for a CPU and that will inevitably
>> impact the performances, so setting the temperature close the max
>> temperature is what will allow max performances.
>>
>> What matters is the skin temperature.
>>
>> The skin temperature must be monitored by other techniques, eg. using
>> the TDP of the system and throttle the different devices to keep them in
>> this power budget. That is the role of an thermal daemon.
> 
> Thank you for the clarification. Indeed, I wasn't sure how to make use
> of the skin temperature properly.
> 
> The skin temperature varies a lot depending on the thermal capabilities
> of a particular device. It's about 15C below CPU core at a full load on
> A500, while it's 2C below CPU core on Nexus 7. But this is expected
> since Nexus 7 can't dissipate heat efficiently.
Yeah, but it can not be directly related to the CPU because if the GPU
is intensively used and the battery is charging at the same time, the
skin temp will increase anyway.

You should set the trip points close to the functioning boundary
temperature given in the hardware specification whatever the resulting
heating effect is on the device.

The thermal zone is there to protect the silicon and the system from a
wild reboot.

If the Nexus 7 is too hot after the changes, then you may act on the
sources of the heat. For instance, set the the highest OPP to turbo or
remove it, or, if there is one, change the thermal daemon to reduce the
overall power consumption.

In case you are interested in: https://lwn.net/Articles/839318/

Hope that helps

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
