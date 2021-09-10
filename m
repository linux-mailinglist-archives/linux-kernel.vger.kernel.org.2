Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C331407097
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhIJRff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhIJRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:35:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA09C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:34:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so3760726wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hxA24XJE/7PoVZT7SdePcfAonAYSzxjiLY3FiFBVkfk=;
        b=WtKucyDAwA7EBAmXucoEnE4Ch25JPvZJ8BNYYKMv0MKH7uYsZLgyvfbLAmhXbdqsLU
         GYaoHa0D5caFEA9wsLmUwLrnIECEFwvm8ePGklJK6oQP1DH4G0fbFpVj+PKnpGC96m6/
         JnIPsSGiYyXG00bKEeDe+Wqf1e/ftQMFFKRS/kxwJrbO2y36nbhotwjwoq/AgLbqFMQW
         +11/Hy6mYp8diTcQq9uIZx0QkCcKeOcA2c4moP6TsZKSUiJAdV0hPDIEJr/35/sDpos5
         Zqo+HxvG0s+doJ6pm3mO4omWXbkf+oUeISl3UNzDJmG+BrnFujrLscqRRyU4aNGhX89e
         wRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxA24XJE/7PoVZT7SdePcfAonAYSzxjiLY3FiFBVkfk=;
        b=LE6m4jE/sAN03d1txF+rrBQpA0aAoq3HbHO6oJkq0nkg89twg4SntEGt8cWrnnbmsL
         xtywELU4LH6/IMS3yOCT/cVdYqmoSdkpf2xTwbNmO92hQkoO80Z447E5czGRzcVqW32q
         pAmXsnnVA9k0GclymlXLav3tLR6ribZrjZsRJyLkhVEpBlgInwuS3uJlbCUUeI/p79Vf
         T4YudN5NWiL4pkxaFkONOQSZSdBP7ks4QfvPfbLerEb+fWzn7KSLIHsBe6cxeZ5n8yMe
         LUmMvB49E/4Taznm5msorBXKF9ozvJor3Xc1TQyasMyifQgnFW1Eo2SywixMuCOtPe3v
         yFYg==
X-Gm-Message-State: AOAM530AI0cTAtmRdlRV8l8vXKaxgtdWs2Tq1E4Ox55584qFSDLe9b7F
        H4t+SR4rNHYLy+Vu8cs16OnYjA==
X-Google-Smtp-Source: ABdhPJwsejhaMHvjcsCB5tM6A5+O9//HTdfLg0em065ISATd8O+gZJu5TxlDHmCvAki9/v3XvUQpQA==
X-Received: by 2002:a5d:6e84:: with SMTP id k4mr11049477wrz.426.1631295260164;
        Fri, 10 Sep 2021 10:34:20 -0700 (PDT)
Received: from [192.168.1.12] (host-92-17-52-213.as13285.net. [92.17.52.213])
        by smtp.gmail.com with ESMTPSA id d129sm5114573wmd.23.2021.09.10.10.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:34:19 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: Disable frequency clamping on a630
To:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <e2cebf65-012d-f818-8202-eb511c996e28@linaro.org>
 <CAF6AEGs11aYnkL30kp79pMqLTg3_4otFwG2Oc890Of2ndLbELw@mail.gmail.com>
 <b7334a1a-c4ad-da90-03b4-0d19e1811b13@linaro.org>
 <CAF6AEGv0WWB3Z1hmXf8vxm1_-d7fsNBRcaQF35aE2JXcJn8-cA@mail.gmail.com>
 <8aa590be-6a9f-9343-e897-18e86ea48202@linaro.org>
 <CAF6AEGtd_5jKhixp6h+NnN8-aqjBHTLopRozASE73oT3rfnFHA@mail.gmail.com>
 <6eefedb2-9e59-56d2-7703-2faf6cb0ca3a@codeaurora.org>
 <CAF6AEGvhqPHWNK=6GYz+Mu5aKe8+iE4_Teem6o=X6eiANhWsPg@mail.gmail.com>
 <83ecbe74-caf0-6c42-e6f5-4887b3b534c6@linaro.org>
 <53d3e5b7-9dc0-a806-70e9-b9b5ff877462@codeaurora.org>
 <YTgeIuwumPoR9ZTE@ripper>
 <CAF6AEGt2f16=WWpKgGiWw1OJLrWMSunzrm853H+mGxPQuf2Xug@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
Message-ID: <de162479-c4cb-e8b7-6044-e7ccd3cf29f6@linaro.org>
Date:   Fri, 10 Sep 2021 18:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGt2f16=WWpKgGiWw1OJLrWMSunzrm853H+mGxPQuf2Xug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2021 18:18, Rob Clark wrote:
> On Tue, Sep 7, 2021 at 7:20 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>>
>> On Mon 09 Aug 10:26 PDT 2021, Akhil P Oommen wrote:
>>
>>> On 8/9/2021 9:48 PM, Caleb Connolly wrote:
>>>>
>>>>
>>>> On 09/08/2021 17:12, Rob Clark wrote:
>>>>> On Mon, Aug 9, 2021 at 7:52 AM Akhil P Oommen
>>>>> <akhilpo@codeaurora.org> wrote:
>> [..]
>>>>>> I am a bit confused. We don't define a power domain for gpu in dt,
>>>>>> correct? Then what exactly set_opp do here? Do you think this usleep is
>>>>>> what is helping here somehow to mask the issue?
>>>> The power domains (for cx and gx) are defined in the GMU DT, the OPPs in
>>>> the GPU DT. For the sake of simplicity I'll refer to the lowest
>>>> frequency (257000000) and OPP level (RPMH_REGULATOR_LEVEL_LOW_SVS) as
>>>> the "min" state, and the highest frequency (710000000) and OPP level
>>>> (RPMH_REGULATOR_LEVEL_TURBO_L1) as the "max" state. These are defined in
>>>> sdm845.dtsi under the gpu node.
>>>>
>>>> The new devfreq behaviour unmasks what I think is a driver bug, it
>>>> inadvertently puts much more strain on the GPU regulators than they
>>>> usually get. With the new behaviour the GPU jumps from it's min state to
>>>> the max state and back again extremely rapidly under workloads as small
>>>> as refreshing UI. Where previously the GPU would rarely if ever go above
>>>> 342MHz when interacting with the device, it now jumps between min and
>>>> max many times per second.
>>>>
>>>> If my understanding is correct, the current implementation of the GMU
>>>> set freq is the following:
>>>>    - Get OPP for frequency to set
>>>>    - Push the frequency to the GMU - immediately updating the core clock
>>>>    - Call dev_pm_opp_set_opp() which triggers a notify chain, this winds
>>>> up somewhere in power management code and causes the gx regulator level
>>>> to be updated
>>>
>>> Nope. dev_pm_opp_set_opp() sets the bandwidth for gpu and nothing else. We
>>> were using a different api earlier which got deprecated -
>>> dev_pm_opp_set_bw().
>>>
>>
>> On the Lenovo Yoga C630 this is reproduced by starting alacritty and if
>> I'm lucky I managed to hit a few keys before it crashes, so I spent a
>> few hours looking into this as well...
>>
>> As you say, the dev_pm_opp_set_opp() will only cast a interconnect vote.
>> The opp-level is just there for show and isn't used by anything, at
>> least not on 845.
>>
>> Further more, I'm missing something in my tree, so the interconnect
>> doesn't hit sync_state, and as such we're not actually scaling the
>> buses. So the problem is not that Linux doesn't turn on the buses in
>> time.
>>
>> So I suspect that the "AHB bus error" isn't saying that we turned off
>> the bus, but rather that the GPU becomes unstable or something of that
>> sort.
>>
>>
>> Lastly, I reverted 9bc95570175a ("drm/msm: Devfreq tuning") and ran
>> Aquarium for 20 minutes without a problem. I then switched the gpu
>> devfreq governor to "userspace" and ran the following:
>>
>> while true; do
>>    echo 257000000 > /sys/class/devfreq/5000000.gpu/userspace/set_freq
>>    echo 710000000 > /sys/class/devfreq/5000000.gpu/userspace/set_freq
>> done
>>
>> It took 19 iterations of this loop to crash the GPU.
> 
> I assume you still had aquarium running, to keep the gpu awake while
> you ran that loop?
> 
> Fwiw, I modified this slightly to match sc7180's min/max gpu freq and
> could not trigger any issue.. interestingly sc7180 has a lower min
> freq (180) and higher max freq (800) so it was toggling over a wider
> freq range.  I also tried on a device that  had the higher 825MHz opp
> (since I noticed that was the only opp that used
> RPMH_REGULATOR_LEVEL_TURBO_L1 and wanted to rule that out), but could
> not reproduce.
> 
> I guess a630 (sdm845) should have higher power draw (it is 2x # of
> shader cores and 2x GMEM size, but lower max freq).. the question is,
> is this the reason we see this on sdm845 and not sc7180?  Or is there
> some other difference.  On the gpu side of this, they are both closely
> related (ie. the same "sub-generation" of a6xx, same gmu fw, etc)..
> I'm less sure about the other parts (icc, rpmh, etc)

My guess would be power draw, nobody has mentioned this yet but I've realised that the vdd_gfx rail is powered by a buck 
converter, which could explain a lot of the symptoms.

Buck converters depend on high frequency switching and inductors to work, this inherently leads to some lag time when 
changing voltages, and also means that the behaviour of the regulator is defined in part by how much current is being 
drawn. Wikipedia has a pretty good explanation: https://en.wikipedia.org/wiki/Buck_converter

At the best of times these regulators have a known voltage ripple, when under load and when rapidly switching voltages 
this will get a lot worse.

Someone with an oscilloscope and schematics could probe the rail and probably see exactly what's going on when the GPU 
crashes. Because of the lag time in the regulator changing voltage, it might be undershooting whilst the GPU is trying 
to clock up and draw more current - causing instability and crashes.
> 
> BR,
> -R
> 
>> So the problem doesn't seem to be Rob's change, it's just that prior to
>> it the chance to hitting it is way lower. Question is still what it is
>> that we're triggering.
>>
>> Regards,
>> Bjorn

-- 
Kind Regards,
Caleb (they/them)
