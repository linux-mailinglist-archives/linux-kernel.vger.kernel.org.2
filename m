Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8B3384EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhCLFKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhCLFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:10:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32192C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:10:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4273951pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6BakZvuBA6/044IS82Dv3Q1+ptYsFfCjLSxtAIDKg0=;
        b=qCMBBqhYzpIRKVV7R2y1dy1c07VA8Q6xuiCQz37uV6U6vf1/0y/CPJmSlFWEdOf/Np
         29aprhj2XnTNu70IZhTRmdbzExrjmYZmpXvB+xu5CvgVvOGT0+MzYR9TS2h9bRDQ9pJz
         4IQ4F+o0j9Aw0kG/ApDkkL/9cFQw9tg8jOXDF28IobPMBRz81u7XsYpP0OzA+CZzmLHU
         8KBjq4TJWrXcKd5gUgeDvd9l4ZA9YOm/vt2Ig33k+449HJUz5K5NPMhJ2kyCBe41Mn04
         jFWs4SXcgHQQo1He/YOH3/7XGvnck3SR49GqWOXoGRquPB1LcYRppKo23hlaIqwE/N3y
         DVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6BakZvuBA6/044IS82Dv3Q1+ptYsFfCjLSxtAIDKg0=;
        b=l8l5g8imAznNNEzlWuAJNXnLtk2Rfe63JBdfBtYm8BT3wnAXFL8Avu/drCjToKKkOp
         qobu1ZnbIcZgFS1CGM1FvFM8wI5udkqG2mvLBTlHMSxpgiUafG57wRPpWivatEt8NVoY
         KR6WZ9DFYW7k0+w7JN9Il+V/wi/g83J+3hJ4727A/fysDoZsRnR3WDzELqT7bIHdkRL+
         bzxFt/5DK3DaGNcMrTRESifAj/5p4H09NdlkEbWDI7yi9cN3SsxLNsRmp8BcQZAdXUsl
         GVQu28T8+jf8zKLDu8ouRftlkEoQY3uQwQkceHEq1Kji6LXHS8Jba2eT7q8AaRZizgcb
         wvEw==
X-Gm-Message-State: AOAM531RIMaihJrzk7/YXt7MT6/v6PqSH7hj2SIwrpgdsjqBHMGj1iv8
        ayYxJsQvA1xhv/NUV+6EGa7qZA==
X-Google-Smtp-Source: ABdhPJwuEUAY8Fx50jmfZg7eaGbHLntIFyrR1v+7b65hRO6EGJj9Qeye0mbocEQfVIRDV+HjwIQieg==
X-Received: by 2002:a17:90a:9309:: with SMTP id p9mr11493563pjo.174.1615525809796;
        Thu, 11 Mar 2021 21:10:09 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id v14sm754370pju.19.2021.03.11.21.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 21:10:09 -0800 (PST)
Date:   Fri, 12 Mar 2021 10:40:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] thermal/drivers/cpufreq_cooling: Use device name
 instead of auto-numbering
Message-ID: <20210312051007.u4f3d3h6jtkb5lqz@vireshk-i7>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310114600.27178-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-21, 12:45, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>  thermal-cpufreq-0
>  thermal-cpufreq-1
>  etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal prefix and changes the number by the device
> name. So the naming above becomes:
> 
>  cpufreq-cpu0
>  cpufreq-cpu4
>  etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)

For 1,3/3

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
