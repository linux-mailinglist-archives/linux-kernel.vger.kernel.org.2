Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD2352D22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhDBPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbhDBPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:54:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C546C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:54:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so5102868wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ti7CnZ58ioPvRJAxkKcVR48hDbgDyg23JEYsm8ZJBog=;
        b=iSRjkTqLZUuJikPDzHYiXZ8jIF/uxsMAUYe4ao54ac2AYPnBjtwTdT3D7BomFgr1fe
         q47RUynjmfMwBWCvyHhC7HwslAUPDbmvLOmE17nksDiLS+3JJxxM1DRJ0nwZRVlDmMWT
         vm5HWYIyxaHdBCHzoBL66Shnbt0Zd52W88Lifkh1bFuydGOvx3lJU1Ed+zl55W33xRjF
         IebEDt1lmKXGs92j7jZhJnwIKuDd03ALBk75RimAeFcqxcBs/u1aJWhV/jkPSvUfpx+e
         os5TieoYDXBt6OrWbLDClxOabOCD237MiE1Vk59hOZlCVVr7ofnFC6E6KJfzLMKUpmNj
         jVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ti7CnZ58ioPvRJAxkKcVR48hDbgDyg23JEYsm8ZJBog=;
        b=cPQDzoxTFMj3FHmA3LM8fT7XrrOIKI2PDTDAmpi3/vBKkc7Y06GVEntu3gbeF2xwws
         LzDk3VHXf1YwRDlh0GQN4oJXkIHk63vmsXzdEgoOvBxOreGrDLZktehzqbsjvg8Cj+Zd
         EBYxt49ZhPLzlBegITWayV+31ieysDYt15xWY+GoN1rSOxWKnShScoy9VUk8RpDHSOSP
         Zp3VdztoMwJPGmxlaPVj4+RaFlDN8QXjjNh9RKRlCrnJimoDqIRr1qWsT/haToN0uNB5
         LwPcpb0aMVcT0DpByV3vaTWT4V7pfzEdNs//3tHhGV3s8Tqk9xEshZY3g2YOfaWruO8d
         p6LQ==
X-Gm-Message-State: AOAM531sRt4z6o4FafvEgLti5CUMfYv61GwjXVQCH3DcKFrCZ98lZpmU
        b9S0hVdPBOv1AOY9mhrzLXF4RA==
X-Google-Smtp-Source: ABdhPJzaVDJiLDo9IUQhDeV/SCNHxTwjdoKMLCtOajCASmmDBBxLQozwfEAS3QNWgYqpTWJRTQho5A==
X-Received: by 2002:adf:f742:: with SMTP id z2mr15552411wrp.130.1617378868075;
        Fri, 02 Apr 2021 08:54:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf? ([2a01:e34:ed2f:f020:34f1:44bb:31bf:7aaf])
        by smtp.googlemail.com with ESMTPSA id j123sm12943231wmb.1.2021.04.02.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 08:54:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
Date:   Fri, 2 Apr 2021 17:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331163352.32416-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 18:33, Lukasz Luba wrote:
> When the temperature is below the first activation trip point the cooling
> devices are not checked, so they cannot maintain fresh statistics. It
> leads into the situation, when temperature crosses first trip point, the
> statistics are stale and show state for very long period. 

Can you elaborate the statistics you are referring to ?

I can understand the pid controller needs temperature but I don't
understand the statistics with the cooling device.


> This has impact
> on IPA algorithm calculation and wrong decisions. Thus, check the cooling
> devices even when the temperature is low, to refresh these statistics.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2802a0e13c88..0cbd10cab193 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -575,15 +575,27 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
>  {
>  	struct thermal_instance *instance;
>  	struct power_allocator_params *params = tz->governor_data;
> +	u32 req_power;
>  
>  	mutex_lock(&tz->lock);
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		struct thermal_cooling_device *cdev = instance->cdev;
> +
>  		if ((instance->trip != params->trip_max_desired_temperature) ||
>  		    (!cdev_is_power_actor(instance->cdev)))
>  			continue;
>  
>  		instance->target = 0;
>  		mutex_lock(&instance->cdev->lock);
> +		/*
> +		 * Call for updating the cooling devices local stats and avoid
> +		 * periods of dozen of seconds when those have not been
> +		 * maintained. The long period would come into the first check
> +		 * when lower threshold is crossed. Thus, limit it to single
> +		 * one longer polling period.
> +		 */
> +		cdev->ops->get_requested_power(cdev, &req_power);
> +
>  		instance->cdev->updated = false;
>  		mutex_unlock(&instance->cdev->lock);
>  		thermal_cdev_update(instance->cdev);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
