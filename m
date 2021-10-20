Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879E7434955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:50:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:47:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j129-20020a1c2387000000b00322f53b9bbfso536569wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HBEIclTEjZ+Fsaop4U62ko5K3nTvsTWng5hE0irsAw0=;
        b=RBpO/a6sGSY2J1VvI5FhcfBtSnfyCm0GY9rZIzOjzkU0htqyud98bXUSHv3oYWTi3v
         aLPIIc99Wv5CPKNpvnNGbAv9/gVbvt7azRiDwnuD6H078BoDNYjhk0b40CrSn39NDbCI
         Ya/YzFzW/v7rCfnLCF7ogaDPJzFnW6UW//WLj9DXA4Fkj4SaAvhCugRgvIN2pYmZ4gkw
         MaNbLQZLEfJzsccJxBFLcqebL8t2hO3txX8++PYR7HSjiSyN8tNiBbcmvkOCZz5EzrNR
         A3fV2K7dnU6AlgkHZDBhhA5PpjdMozWgE9VURaEhRvPfI2tsObl2LgJ8XSkyWVmLjoAN
         ITQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HBEIclTEjZ+Fsaop4U62ko5K3nTvsTWng5hE0irsAw0=;
        b=DOrqppDTxPIv5JBFuPu3wQSRiQjTb24nvsD/e83LOKSBfhtUhlUwk2uhgRzalMrPkP
         oQERcjYIpMb/pLBkWzwR4puQqXo4PJQt+hcmdsntCjoY5FvrP56sRHXM31Krw4YEouVn
         b6HX9KkoCdCW9AtVFyLZh+p02TET7kWliYSwaDmMG4lNJGy0CyWvMvEDTBi0ISbhcnuM
         I1Ya4oxY7VCEF0jcMvvWtYLyfJGEeacu/KY7DYUHAuIXFrtDBjGL/ba9ezOi37dpsotP
         /mZ8DuCwCxjRJO5SscyqbvSyiYyf3qBgphxjv2eVrTX95aEqDbv8ssdIT/9BHQWizj8i
         Bh+Q==
X-Gm-Message-State: AOAM530gf3JJMyTnl394Vqy4e5mMyOXGMOxnK3K+kyUgIt0btiE4anti
        fLEGZ8RjwczoOiNWttAHA5dENA==
X-Google-Smtp-Source: ABdhPJwokBEKxFsaXV5dkgf4vZTaV5x0bv7t9JafMAynZ/t9lVcUjphhmp4ecJAtl2uGa8jDHDhS+w==
X-Received: by 2002:adf:a154:: with SMTP id r20mr51583586wrr.326.1634726867105;
        Wed, 20 Oct 2021 03:47:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4799:198d:b6ef:8da7? ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.googlemail.com with ESMTPSA id o11sm2183231wry.0.2021.10.20.03.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 03:47:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] thermal/core: Make the userspace governor
 deprecated
To:     lukasz.luba@arm.com
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6372f16d-7d2d-cb1e-be86-23b21b41816b@linaro.org>
Date:   Wed, 20 Oct 2021 12:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

Do you agree with these changes ?

On 19/10/2021 18:35, Daniel Lezcano wrote:
> The userspace governor is sending temperature when polling is active
> and trip point crossed events. Nothing else.
> 
> AFAICT, this governor is used with custom kernels making the userspace
> governor co-existing with another governor on the same thermal zone
> because there was no notification mechanism, implying a hack in the
> framework to support this configuration.
> 
> The new netlink thermal notification is able to provide more
> information than the userspace governor and give the opportunity to
> the users of this governor to replace it by a dedicated notification
> framework.
> 
> The userspace governor will be removed as its usage is no longer
> needed.
> 
> Add a warning message to tell the userspace governor is deprecated.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/gov_user_space.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
> index 82a7198bbe71..f4fe050e1cbc 100644
> --- a/drivers/thermal/gov_user_space.c
> +++ b/drivers/thermal/gov_user_space.c
> @@ -15,6 +15,14 @@
>  
>  #include "thermal_core.h"
>  
> +static int user_space_bind(struct thermal_zone_device *tz)
> +{
> +	pr_warn("Userspace governor deprecated: use thermal netlink "	\
> +		"notification instead\n");
> +
> +	return 0;
> +}
> +
>  /**
>   * notify_user_space - Notifies user space about thermal events
>   * @tz: thermal_zone_device
> @@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
>  static struct thermal_governor thermal_gov_user_space = {
>  	.name		= "user_space",
>  	.throttle	= notify_user_space,
> +	.bind_to_tz	= user_space_bind,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
