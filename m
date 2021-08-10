Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5E3DAD98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 22:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhG2U26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2U25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:28:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE2C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:28:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso6442073wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjvy0nNjdoVdeBRrNfPDRD8M9hukWpC6XSosKuNv5ME=;
        b=uXQbJc9YN7jcauyWcxa/AhQHH/ohDJah+P0h3TjE+ye9WEGAKdpNOiKwp67zax537M
         F43p5oywXQXzW7asCsVSZPRdoUPuNWn65XyxofHmG7aWxMGp+tJIyLgWAxAsx0xX4+BP
         83Mv2s4tjdzEoYFWep02aUKE+e0dh7ik6Pl6EJrAobwEdsQ2e0XYKw7xZ6NrHw42FtBb
         4KGArkAiSRGW1h0aCCjkK3PUpAakI9OvAOvzm8rg27FRIaYu+kLYVv7wp7HIrkpm3e6H
         lMm+UbmOX7hCOrlUJ1tRpU1ILGxcun833XNajyZNblK46IgBhP0Y8bxu0l5k15NUag+l
         n9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjvy0nNjdoVdeBRrNfPDRD8M9hukWpC6XSosKuNv5ME=;
        b=RT86rFAYIiteq+MG4pYszgzPdiOtvV8c3Xy/gCYviTgDO/Y3i41AykIDg6nXsMlO3/
         QhN4Bja4O2Qx6S5NO2ttSelqzSlRCZrfrioRYvn/4uQi9sIsWT4MOZjsddemp5zmLicz
         iN0IM6pxuZvliub7x0m6Efce0YrOsaAU9yb2BcNOzL0IzM5E87jMXf9S/sQ/XaR8GHLA
         TcWgwDbvqEzDnrQZF+jc+DHbSpTtUcteaP5ykCXR8Ivru8R+19glEMhN7KeDpfndY4k4
         WH6g4ryQKTxH+9uvqM9eg2Da4YBq+50Gwcu/9dwGaV0ZTRHUfQrJ3xth4j5cvaYkMr0V
         zDjQ==
X-Gm-Message-State: AOAM5337kzOZ5y9+jsOxqnTLKWa7bjxCS+zMV0gdWZGOegLKXUKd0dN8
        ODAlFBgtVbUi759+pZb6B6rPfQ==
X-Google-Smtp-Source: ABdhPJzkzIH6AZrxd5zBBNCDr+3o/XoHDyD63OWg5X4bm6XBxl9fD1BIEF0IQ1s/N/Tdsj+GfXWN5w==
X-Received: by 2002:a05:600c:19d3:: with SMTP id u19mr224549wmq.115.1627590530830;
        Thu, 29 Jul 2021 13:28:50 -0700 (PDT)
Received: from [192.168.1.12] (host-80-41-121-59.as13285.net. [80.41.121.59])
        by smtp.gmail.com with ESMTPSA id v6sm4474677wru.50.2021.07.29.13.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 13:28:50 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: Disable frequency clamping on a630
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20210729183942.2839925-1-robdclark@gmail.com>
 <1a38a590-a64e-58ef-1bbf-0ae49c004d05@linaro.org>
 <CAF6AEGs5dzA7kfO89Uqbh3XmorXoEa=fpW+unk5_oaihHm479Q@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
Message-ID: <e2cebf65-012d-f818-8202-eb511c996e28@linaro.org>
Date:   Thu, 29 Jul 2021 21:28:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGs5dzA7kfO89Uqbh3XmorXoEa=fpW+unk5_oaihHm479Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2021 21:24, Rob Clark wrote:
> On Thu, Jul 29, 2021 at 1:06 PM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> Hi Rob,
>>
>> I've done some more testing! It looks like before that patch ("drm/msm: Devfreq tuning") the GPU would never get above
>> the second frequency in the OPP table (342MHz) (at least, not in glxgears). With the patch applied it would more
>> aggressively jump up to the max frequency which seems to be unstable at the default regulator voltages.
> 
> *ohh*, yeah, ok, that would explain it
> 
>> Hacking the pm8005 s1 regulator (which provides VDD_GFX) up to 0.988v (instead of the stock 0.516v) makes the GPU stable
>> at the higher frequencies.
>>
>> Applying this patch reverts the behaviour, and the GPU never goes above 342MHz in glxgears, losing ~30% performance in
>> glxgear.
>>
>> I think (?) that enabling CPR support would be the proper solution to this - that would ensure that the regulators run
>> at the voltage the hardware needs to be stable.
>>
>> Is hacking the voltage higher (although ideally not quite that high) an acceptable short term solution until we have
>> CPR? Or would it be safer to just not make use of the higher frequencies on a630 for now?
>>
> 
> tbh, I'm not sure about the regulator stuff and CPR.. Bjorn is already
> on CC and I added sboyd, maybe one of them knows better.
> 
> In the short term, removing the higher problematic OPPs from dts might
> be a better option than this patch (which I'm dropping), since there
> is nothing stopping other workloads from hitting higher OPPs.
Oh yeah that sounds like a more sensible workaround than mine 😅.
> 
> I'm slightly curious why I didn't have problems at higher OPPs on my
> c630 laptop (sdm850)
Perhaps you won the sillicon lottery - iirc sdm850 is binned for higher clocks as is out of the factory.

Would it be best to drop the OPPs for all devices? Or just those affected? I guess it's possible another c630 might 
crash where yours doesn't?
> 
> BR,
> -R
> 
>>
>> On 29/07/2021 19:39, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> The more frequent frequency transitions resulting from clamping freq to
>>> minimum when the GPU is idle seems to be causing some issue with the bus
>>> getting voted off when it should be on.  (An enable racing with an async
>>> disable?)  This might be a problem outside of the GPU, as I can't
>>> reproduce this on a618 which uses the same GMU fw and same mechanism to
>>> communicate with GMU to set opp.  For now, just revert to previous
>>> devfreq behavior on a630 until the issue is understood.
>>>
>>> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> Fixes: 9bc95570175a ("drm/msm: Devfreq tuning")
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.c |  3 +++
>>>    drivers/gpu/drm/msm/msm_gpu.h           |  2 ++
>>>    drivers/gpu/drm/msm/msm_gpu_devfreq.c   | 12 ++++++++++++
>>>    3 files changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> index 748665232d29..9fd08b413010 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> @@ -945,6 +945,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>>        pm_runtime_use_autosuspend(dev);
>>>        pm_runtime_enable(dev);
>>>
>>> +     if (adreno_is_a630(adreno_gpu))
>>> +             gpu->devfreq.disable_freq_clamping = true;
>>> +
>>>        return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
>>>                        adreno_gpu->info->name, &adreno_gpu_config);
>>>    }
>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
>>> index 0e4b45bff2e6..7e11b667f939 100644
>>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>>> @@ -112,6 +112,8 @@ struct msm_gpu_devfreq {
>>>         * it is inactive.
>>>         */
>>>        unsigned long idle_freq;
>>> +
>>> +     bool disable_freq_clamping;
>>>    };
>>>
>>>    struct msm_gpu {
>>> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> index 0a1ee20296a2..a832af436251 100644
>>> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> @@ -94,6 +94,12 @@ void msm_devfreq_init(struct msm_gpu *gpu)
>>>        if (!gpu->funcs->gpu_busy)
>>>                return;
>>>
>>> +     /* Revert to previous polling interval if we aren't using freq clamping
>>> +      * to preserve previous behavior
>>> +      */
>>> +     if (gpu->devfreq.disable_freq_clamping)
>>> +             msm_devfreq_profile.polling_ms = 10;
>>> +
>>>        msm_devfreq_profile.initial_freq = gpu->fast_rate;
>>>
>>>        /*
>>> @@ -151,6 +157,9 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>>>        unsigned int idle_time;
>>>        unsigned long target_freq = df->idle_freq;
>>>
>>> +     if (gpu->devfreq.disable_freq_clamping)
>>> +             return;
>>> +
>>>        /*
>>>         * Hold devfreq lock to synchronize with get_dev_status()/
>>>         * target() callbacks
>>> @@ -186,6 +195,9 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
>>>        struct msm_gpu_devfreq *df = &gpu->devfreq;
>>>        unsigned long idle_freq, target_freq = 0;
>>>
>>> +     if (gpu->devfreq.disable_freq_clamping)
>>> +             return;
>>> +
>>>        /*
>>>         * Hold devfreq lock to synchronize with get_dev_status()/
>>>         * target() callbacks
>>>
>>
>> --
>> Kind Regards,
>> Caleb (they/them)

-- 
Kind Regards,
Caleb (they/them)
