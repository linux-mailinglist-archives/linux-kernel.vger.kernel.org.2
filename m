Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B74732E465
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:10:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570EC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:10:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w11so1220680wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=63BZTwf3MLMQAkn2BdrHZ1xTK2bwmRKITVezIt3sV9k=;
        b=qIhQjiqOP57bI/hD1kFs2/6tOxvCVgreYU6SWkrNvwDFlxQwEnv3kFFVIEiRAtV0bs
         ghqevsOeKImy2rOLICgbeqWEThfUBb62WD98f6OLGoRbJPi+3ECHQTjzD7T09L6iNH1X
         oAm7OJWf/W0mgFiXr47BHOFHjWLpDx1yqdw07vCbJeqMn/SZ6et48VCP9iSh47jL2RrG
         gVVStZeH/O8pcqGXOJ9EMd4F8njNQwNN9alPkOkaB3F9hedHZi9ivpiK4dy/1O75s2EC
         b80SYjFrOOr3XHujkCejze9BNQcAsrZT3Cpqt9O3cmDicy//qO7rhTZOo3V9VbGlcI9b
         TE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=63BZTwf3MLMQAkn2BdrHZ1xTK2bwmRKITVezIt3sV9k=;
        b=lstpnIf9NlRwm2C8qAmFQjlwP56YEj8rTQeQTEWJF+JSIrglC+fcwMM5LcLdEiaiVq
         f3WSLJmPbqahEGxZwpgZylG0Y9D2gtOICXmQWo+7kcCgVOIEud8xum54X823xi+Sxu8w
         HQduBbYop4mjU3+TFu7ZSuzek1SebCC+yGIua3seEpW2hUhbRmPJ4Z0+eL+WDGL6/8mL
         BrjUBFaF4AGjSnph/qJczoq267Dg/JYme/YP161lTWBal3QpRf5JNlcxA2m+u65ZoeZc
         3Ga/7KuclybMvB2yjBdrCmGANtUoEy3aETBzrTkEPF2eO5c5WCEOZZ1+3zNkoAS6hiLK
         qjyw==
X-Gm-Message-State: AOAM530Y9fKq3S7xCUXxOI/0+/KAQZ/jOFldluNo/nAry06OCfEOaUT/
        CF4bNzLrL3advsGgE+Wl2JVO/g==
X-Google-Smtp-Source: ABdhPJwGPV9w/pRUAVZfWeOAHCnQFfI/8tinbzeWQre8iQkJRqLUzFYfp3bIvMhEWSuLcWlSXdr0MQ==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr8376871wrv.194.1614935418378;
        Fri, 05 Mar 2021 01:10:18 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id 36sm3695411wrh.94.2021.03.05.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 01:10:17 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Steven Price <steven.price@arm.com>, cwchoi00@gmail.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
 <23db1b13-9418-91f5-4871-f45b983f6e3c@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e8c5f550-0ca5-b4e4-1113-3af760d2780e@linaro.org>
Date:   Fri, 5 Mar 2021 10:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23db1b13-9418-91f5-4871-f45b983f6e3c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2021 09:12, Steven Price wrote:
> On 04/03/2021 12:50, Daniel Lezcano wrote:
>> Currently the default behavior is to manually having the devfreq
>> backend to register themselves as a devfreq cooling device.
>>
>> There are no so many and actually it makes more sense to register the
>> devfreq device when adding it.
>>
>> Consequently, every devfreq becomes a cooling device like cpufreq is.
>>
>> Having a devfreq being registered as a cooling device can not mitigate
>> a thermal zone if it is not bound to this one. Thus, the current
>> configurations are not impacted by this change.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>>       if (pfdevfreq->opp_of_table_added) {
>>           dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
>>           pfdevfreq->opp_of_table_added = false;
> 
> You've removed all references to pfdevfreq->cooling, so please also
> remove the member from struct panfrost_devfreq (as already done with
> lima and msm).

Sure, thanks for spotting this.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
