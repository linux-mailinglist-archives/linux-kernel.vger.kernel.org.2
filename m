Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631E53E3ACE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhHHOdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 10:33:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F6C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 07:33:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f5so2028007wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RSDdpJDs5I5H+cnySVvBmZO9n/arZ4/s3l55lni6I4E=;
        b=MMamCucheQ+iQUP6sVWlqRPg1udHcmzx3A/LIlhwM/hCCmtutGQ6YhGVBf+ayB7jfi
         BFhQi6Itq3GzXWiXG3gGUJh+bM75Hp3PRMrJpjJxa3m8tdsYgYmyiN1jqhxM3MuhxA9h
         DkiPoT04R482yjrznKNrfeS8BvruReXzFc3KDAuOuVYafJNlxhhNhmZH+NOnyK/pp2ST
         wB/G5vh6iPHcSHQb9JDFgION7Z6WYQdJgDnzac3hMvydsuDjbBe+Pl3hok9326wS6UuW
         zTyQfxlC7n8wKym2l8buz8E61+Q79g4G7N67VZ5lc0oy1o6u5NSCKy/SVJOovERvORgt
         ph2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RSDdpJDs5I5H+cnySVvBmZO9n/arZ4/s3l55lni6I4E=;
        b=ZC4pTOj1JVtQFXfZc5IzEyltSklsiLxOWWGCbs1mDCfrcMzV+cS6KpDcyL45x/axur
         D6Iif2oPArbLUBLvPEV9sd01elDsUJEAs5HzrGCT3/U275CjFCV2ZHHwKt7A2rTGqs3A
         kBwySVfj0FE/nV19g30Fi6OsqIHAhrFzoA3AlmeKY+I0EK3HETyGT2bIMMsoizmGK8UT
         EI3W+/Dja9yLqLZdHWMMnxnAJKq2TUHf5cP9hbN/7iYdLOC5TiDyVN7vxrO5mVec5Bho
         1QxBYiCOYsU7m0/ClFmoj65IngnmAfACJWKCttTHWNgXyKegnJyK2y/CBY/sGoijIMg+
         +lXA==
X-Gm-Message-State: AOAM533ijv+mNNZuMrJg5kDJZ4CD5A4vZUO14JaWwiCcVga9Nn9+quKG
        sSpLeDdA3q5p9zbpvjxFGoZtLA==
X-Google-Smtp-Source: ABdhPJwa9kx11dPE2c+M12vo1MlHXBGzVqZg3DkY8yu8O/h8BnOlsD0goOm/5fEB53msHC0c7e4IpQ==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr19579171wro.279.1628433182367;
        Sun, 08 Aug 2021 07:33:02 -0700 (PDT)
Received: from [192.168.1.12] (host-92-17-52-101.as13285.net. [92.17.52.101])
        by smtp.gmail.com with ESMTPSA id a9sm16290339wrv.37.2021.08.08.07.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 07:33:01 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: Disable frequency clamping on a630
To:     Rob Clark <robdclark@gmail.com>
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20210729183942.2839925-1-robdclark@gmail.com>
 <1a38a590-a64e-58ef-1bbf-0ae49c004d05@linaro.org>
 <CAF6AEGs5dzA7kfO89Uqbh3XmorXoEa=fpW+unk5_oaihHm479Q@mail.gmail.com>
 <e2cebf65-012d-f818-8202-eb511c996e28@linaro.org>
 <CAF6AEGs11aYnkL30kp79pMqLTg3_4otFwG2Oc890Of2ndLbELw@mail.gmail.com>
 <b7334a1a-c4ad-da90-03b4-0d19e1811b13@linaro.org>
 <CAF6AEGv0WWB3Z1hmXf8vxm1_-d7fsNBRcaQF35aE2JXcJn8-cA@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
Message-ID: <8aa590be-6a9f-9343-e897-18e86ea48202@linaro.org>
Date:   Sun, 8 Aug 2021 15:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGv0WWB3Z1hmXf8vxm1_-d7fsNBRcaQF35aE2JXcJn8-cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2021 21:04, Rob Clark wrote:
> On Sat, Aug 7, 2021 at 12:21 PM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> Hi Rob, Akhil,
>>
>> On 29/07/2021 21:53, Rob Clark wrote:
>>> On Thu, Jul 29, 2021 at 1:28 PM Caleb Connolly
>>> <caleb.connolly@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 29/07/2021 21:24, Rob Clark wrote:
>>>>> On Thu, Jul 29, 2021 at 1:06 PM Caleb Connolly
>>>>> <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> Hi Rob,
>>>>>>
>>>>>> I've done some more testing! It looks like before that patch ("drm/msm: Devfreq tuning") the GPU would never get above
>>>>>> the second frequency in the OPP table (342MHz) (at least, not in glxgears). With the patch applied it would more
>>>>>> aggressively jump up to the max frequency which seems to be unstable at the default regulator voltages.
>>>>>
>>>>> *ohh*, yeah, ok, that would explain it
>>>>>
>>>>>> Hacking the pm8005 s1 regulator (which provides VDD_GFX) up to 0.988v (instead of the stock 0.516v) makes the GPU stable
>>>>>> at the higher frequencies.
>>>>>>
>>>>>> Applying this patch reverts the behaviour, and the GPU never goes above 342MHz in glxgears, losing ~30% performance in
>>>>>> glxgear.
>>>>>>
>>>>>> I think (?) that enabling CPR support would be the proper solution to this - that would ensure that the regulators run
>>>>>> at the voltage the hardware needs to be stable.
>>>>>>
>>>>>> Is hacking the voltage higher (although ideally not quite that high) an acceptable short term solution until we have
>>>>>> CPR? Or would it be safer to just not make use of the higher frequencies on a630 for now?
>>>>>>
>>>>>
>>>>> tbh, I'm not sure about the regulator stuff and CPR.. Bjorn is already
>>>>> on CC and I added sboyd, maybe one of them knows better.
>>>>>
>>>>> In the short term, removing the higher problematic OPPs from dts might
>>>>> be a better option than this patch (which I'm dropping), since there
>>>>> is nothing stopping other workloads from hitting higher OPPs.
>>>> Oh yeah that sounds like a more sensible workaround than mine .
>>>>>
>>>>> I'm slightly curious why I didn't have problems at higher OPPs on my
>>>>> c630 laptop (sdm850)
>>>> Perhaps you won the sillicon lottery - iirc sdm850 is binned for higher clocks as is out of the factory.
>>>>
>>>> Would it be best to drop the OPPs for all devices? Or just those affected? I guess it's possible another c630 might
>>>> crash where yours doesn't?
>>>
>>> I've not heard any reports of similar issues from the handful of other
>>> folks with c630's on #aarch64-laptops.. but I can't really say if that
>>> is luck or not.
>> It looks like this affects at least the OnePlus 6 and PocoPhone F1, I've done some more poking and the following diff
>> seems to fix the stability issues completely, it seems the delay is required to let the update propagate.
>>
>> This doesn't feel like the right fix, but hopefully it's enough to come up with a better solution than disabling the new
>> devfreq behaviour on a630.
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index d7cec7f0dde0..69e2a5e84dae 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -139,6 +139,10 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
>>                   return;
>>           }
>>
>> +       dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>> +
>> +       usleep_range(300, 500);
>> +
> 
> Hmm, this is going to be in the critical path on idle -> active
> transition (ie. think response time to user-input).. so we defn don't
> want to do this unconditionally..
> 
> If I understand the problem, we just want to limit how far we jump the
> gpu freq in one go.. maybe deleting the lowest (and perhaps highest)
> OPP would accomplish that?  Could that be done in the board(s)'s
> toplevel dts files?
That would be a workaround, however I'd really like to avoid limiting performance as a solution if I can help it, 
especially as the fix might just be "set the opp first, wait for it to apply, then set the core clock".

Is there a sensible way to get a callback from the opp notify chain? Or from rpmh directly? Or is this solution really 
not the right way to go?
> 
> BR,
> -R
> 
>>           gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
>>
>>           gmu_write(gmu, REG_A6XX_GMU_DCVS_PERF_SETTING,
>> @@ -158,7 +162,6 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
>>           if (ret)
>>                   dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>>
>> -       dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
>>           pm_runtime_put(gmu->dev);
>>    }
>>>
>>> Maybe just remove it for affected devices?  But I'll defer to Bjorn.
>>>
>>> BR,
>>> -R
>>>
>>
>> --
>> Kind Regards,
>> Caleb (they/them)

-- 
Kind Regards,
Caleb (they/them)
