Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C9331E51C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 05:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBRETB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 23:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBRES6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 23:18:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C061C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 20:18:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e9so654040pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 20:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3QtOCBR1uNsMvstvlJGQmLZPz9kZ2BpyJJHfU7ws7Ac=;
        b=XfW/FE0YCOmxYtDEzfo9gsSp9wzn8/rYRDDgf1sS0aqW7dmI2YS0H8mmi066VffGJY
         lO5b6oh4MKkwBg+23bpxyyRN49NNpb7MpcW6ySqVs7xX5TyyGEZu3Z3DwGXxV0Old0NR
         a8xSsubs/+wMzD0O6aumhnnOXdC48W/KebDQLQhsGBI/sTYGYi60IhOxBd1EUR+O+DWK
         x6e/Y7ak47kYvKnoa8Vpx8tVzfR8gSbiEgCg7F8m7roEmuAa70bQAUl3m/OdHplUo5yO
         H8WTJIjw48Ny+nwz3b528tg0aNWuv4itvMTNJJfIITpo9+EdWfvKUdl2YNiwOsaFWOg7
         /fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QtOCBR1uNsMvstvlJGQmLZPz9kZ2BpyJJHfU7ws7Ac=;
        b=SJ8832p9FDX3eP+FBpCxNJCIPt5297bbj3kEujzAIH46tYmpp1tSF8iRG02wxgb4bX
         vPCruMA1Gea0z1lDg+r5PuBmIW5ZX7Oqoj7FcvjkPTRgTXlAmuQxxguwDWkGoGActub2
         6SXjRGcwNO+NEFirRZ5/PyJuCDOfNo8vDYIME90lWRfDnF9DH5SQLyLWPdH+rPfBUoOQ
         IBWpOLRlniNUpVAu9eGxk5FQNcYJeT7amqFQfKSqhWvd2fWsi2zgOg9Ec6L2LoE4r8d3
         4pNUVNXMhA7l4jYZei7i9odJJflRp8TsD31Tl1U3r7gVie86a0P6uLUaAtFE8aRFs6/V
         IAjg==
X-Gm-Message-State: AOAM530emW/4mXNpIaOIVkCcITJgZlFW6EscmaoHeVezzviwv1iiVtX9
        87wBEHLKBnurQGETVxnHLIkZkg==
X-Google-Smtp-Source: ABdhPJwm/BhAa527F2yvdN49LTjZgzP8wP9gBP2uuOY0RM5fkz7U7RLOH3pYlcWSPyZqYZXkqznEuA==
X-Received: by 2002:a17:902:9348:b029:e1:506a:7f67 with SMTP id g8-20020a1709029348b02900e1506a7f67mr2292370plp.71.1613621897664;
        Wed, 17 Feb 2021 20:18:17 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w3sm268628pjn.12.2021.02.17.20.18.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 20:18:17 -0800 (PST)
Date:   Thu, 18 Feb 2021 09:48:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        daniel.lezcano@linaro.org, thara.gopinath@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com
Subject: Re: [RESEND PATCH] MAINTAINERS: update thermal CPU cooling section
Message-ID: <20210218041812.o2yksgbfdvbgtwc4@vireshk-i7>
References: <20210217115908.22547-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217115908.22547-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-02-21, 11:59, Lukasz Luba wrote:
> Update maintainers responsible for CPU cooling on Arm side.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Daniel,
> 
> Please ignore the previous email and that this change with 'R'.
> Javi will ack it later.
> 
> Regards,
> Lukasz
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f32ebcff37d2..fe34f56acb0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17774,7 +17774,7 @@ THERMAL/CPU_COOLING
>  M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
> -M:	Javi Merino <javi.merino@kernel.org>
> +R:	Lukasz Luba <lukasz.luba@arm.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/driver-api/thermal/cpu-cooling-api.rst

Good that we have one more reviewer for this :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
