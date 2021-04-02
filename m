Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B893529ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhDBKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:53:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F442C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:53:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v11so4396046wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YeuRMro+NYlemmiBecIwMHC/igd2WvrdXftOjTB+J/4=;
        b=eTenZD0cIEu/A9IhVQ3aA5AxPSwyzVWSRwfJdoNBmD7/km2nXxTCHeVEeNgQhIeb92
         qXJ44YJNIFFaF5iMds4FZThuF9/rJ9zmQWcvJrmCXfaNFDqNhKDPY6c8qhXPV7j/b8xx
         Ij+bCNPH/iV7pGdkuO/yIaCMahmHMgXUYAghQR3KgK3sOGIqlxeSVgdHBSD92cYxO8c2
         5sutiuDCxo2J7ivWlRGbI1iK7f5TpuHJDKsmcVsa5aTybOceI7FoKOIbrz9fua+huDvO
         XOBoDP/ka+WoWLPfRz74+KFrKBtWAv4g1NQkmm+yZd7hLpfdM7JCenFoLjB3pFot018B
         HZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YeuRMro+NYlemmiBecIwMHC/igd2WvrdXftOjTB+J/4=;
        b=nYa86UA2kMao1JziDGF+RK+xUN6U5pnsljWDYGtcEwXhWO6HBmuwOk45x31bvtOBYQ
         Aimk6ryw8As22PVAtK/44/TSx9rUE6Wa31gJQDy48Y6RYXG0wr6JufIRuSB/R98Graki
         fVwUhZHPocfPDfjH7Hls3QlMAibv3TI6shvU7IA+SLnEKNagMOe8FpliM0c3AZXzAYpb
         U4AIowBAbl0mSGPrQ5t1PJxkOaS5y8yxfRmqJ3jQo5alzvbd9V/vsZX3sGjzAD6J0k1S
         uO4ctXVMqR6W5I0M/R0UVag3f//4iAp0G2PF7399hrD7i8QWmrVhMlEEKabD7rvYN8r8
         /7wA==
X-Gm-Message-State: AOAM530JaA04RQkwy8yVyQQJhDILIagLROCyArTMyE3Jsv8elTTD+7t1
        tGammhhKIWq6rFd+Ds8ES4A81g==
X-Google-Smtp-Source: ABdhPJzFy3ezgRBh5FMJ0R7/+Tly5WVc9yBtzlAly/Quyvh0VMNjHl8QEJvOU0NxicvG93IP9aHcUA==
X-Received: by 2002:adf:f143:: with SMTP id y3mr15411346wro.198.1617360790068;
        Fri, 02 Apr 2021 03:53:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf? ([2a01:e34:ed2f:f020:c9d5:e4dc:e7c5:5fcf])
        by smtp.googlemail.com with ESMTPSA id d18sm15941593wra.8.2021.04.02.03.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:53:09 -0700 (PDT)
Subject: Re: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        thara.gopinath@linaro.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210217115908.22547-1-lukasz.luba@arm.com>
 <20210218041812.o2yksgbfdvbgtwc4@vireshk-i7>
 <e3208461-f4ec-8c88-8af4-67c777f9382a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fe4cf822-2915-6de3-3920-9d1a4aa1d3e1@linaro.org>
Date:   Fri, 2 Apr 2021 12:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e3208461-f4ec-8c88-8af4-67c777f9382a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2021 12:25, Lukasz Luba wrote:
> Hi Viresh, Daniel
> 
> On 2/18/21 4:18 AM, Viresh Kumar wrote:
>> On 17-02-21, 11:59, Lukasz Luba wrote:
>>> Update maintainers responsible for CPU cooling on Arm side.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>> Hi Daniel,
>>>
>>> Please ignore the previous email and that this change with 'R'.
>>> Javi will ack it later.
>>>
>>> Regards,
>>> Lukasz
>>>
>>>   MAINTAINERS | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f32ebcff37d2..fe34f56acb0f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
>>>   M:    Amit Daniel Kachhap <amit.kachhap@gmail.com>
>>>   M:    Daniel Lezcano <daniel.lezcano@linaro.org>
>>>   M:    Viresh Kumar <viresh.kumar@linaro.org>
>>> -M:    Javi Merino <javi.merino@kernel.org>
>>> +R:    Lukasz Luba <lukasz.luba@arm.com>
>>>   L:    linux-pm@vger.kernel.org
>>>   S:    Supported
>>>   F:    Documentation/driver-api/thermal/cpu-cooling-api.rst
>>
>> Good that we have one more reviewer for this :)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
> 
> I believe it has lost somewhere in people mailboxes.
> 
> Thank you Viresh for the ACK.
> 
> Could you Daniel (or you Viresh) take this patch, please?

I was expecting Javi to ack it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
