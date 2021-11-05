Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE494469B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhKEUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhKEUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:31:44 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BDC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:29:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u191so16272741oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8JOiyVnxfxaZAhXkgjHfAK5HrLExH5oiye43Nc9y5lE=;
        b=Mkh7tjdb+bN/TRolya14M3jL1kGZiyedL6PMEh8LA19iejEw/DTZsdk3WhwKP9870o
         gnhPaIE6lMNPDZXnoMl3bV4nqSkCnnVcBUV3WZyzt1Jlxzy1vhG8Z92AeNC+4BByn6GD
         cCblwnlHT/5PSL/T9MENFZI4KIBTqCwXE6ilRQrgZxV+XzkVuFDkfGZw8oq/y1igL6ZO
         p1JnAnwT4gQouVR3lGoiwxh/Eh2ljiQczHGJXxyMYIy848ciIc8G5EGt5DPONSQz7ldK
         1WgeNYkxTZJbcX6UmDqXNRtz6/cLKOeC1vNFWWMo1rvp69mJCVwhxX5X2UvKrSl1pifH
         ADPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8JOiyVnxfxaZAhXkgjHfAK5HrLExH5oiye43Nc9y5lE=;
        b=n6H8+87OifaB/H/xapNqxNc+85ycjrCAYNr+JJsWt5GUcp2Nj1Q70ifBsi+K++aTcL
         PPDqxTpguMFHAHergCM+xkr2I7r3QxruGrmAq5TWCXpgg/6+6QHSFC2wE5GbA5MtU405
         MeJ3J3UsqEK9UMMEHi45MqyPQYNErj4UzZzSBkv4wL4JRHXCAz+wigY8pjBIAUmhvbl/
         EpwayZb16Qc1rpTnSVwt2PcsV5Ujfa5mKyY+oZW2w3vfbDjO+1/cVrRj/cDFnRRQKkv3
         Gd7q7spkXCPz8+cyNB/lUKBKwm8TR8VdVxFXNnUawtiz68P/qIucNThvBQ4hxYQ3Y1i3
         jtug==
X-Gm-Message-State: AOAM531bJYa9neugXJFQeVxHVXstQxEZvM+fzxW2BIYJMhOpwwuqU3J7
        RZVIV2CAGI9RSQIBH8jipwBawQ==
X-Google-Smtp-Source: ABdhPJx4R55434miRtFXT3rDjHhYO7yoc/PDMCPS0UxSDNaJESWi8pqHCWAz0JuewFqOuhbI+Hr6Zw==
X-Received: by 2002:a05:6808:158c:: with SMTP id t12mr24051841oiw.24.1636144143770;
        Fri, 05 Nov 2021 13:29:03 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id c18sm3551722ots.64.2021.11.05.13.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 13:29:03 -0700 (PDT)
Message-ID: <fb85e94a-a961-aad2-494d-9318e9ae8f1c@kali.org>
Date:   Fri, 5 Nov 2021 15:29:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2] drm/msm/devfreq: Fix OPP refcnt leak
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20211105202021.181092-1-robdclark@gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211105202021.181092-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/5/21 3:20 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 9bc95570175a ("drm/msm: Devfreq tuning")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index d32b729b4616..07f1169df89b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -20,6 +20,10 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>   	struct msm_gpu *gpu = dev_to_gpu(dev);
>   	struct dev_pm_opp *opp;
>   
> +	/*
> +	 * Note that devfreq_recommended_opp() can modify the freq
> +	 * to something that actually is in the opp table:
> +	 */
>   	opp = devfreq_recommended_opp(dev, freq, flags);
>   
>   	/*
> @@ -28,6 +32,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>   	 */
>   	if (gpu->devfreq.idle_freq) {
>   		gpu->devfreq.idle_freq = *freq;
> +		dev_pm_opp_put(opp);
>   		return 0;
>   	}
>   

Tested on the Lenovo Yoga C630 and don't see the message from v1 :D

Tested-By: Steev Klimaszewski <steev@kali.org>

