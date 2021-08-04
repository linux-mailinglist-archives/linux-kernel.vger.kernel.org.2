Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203D13DFA29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHDEDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHDECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:02:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4317C061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 21:02:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so1833894pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZB8hSYRKOrLl+E7loPd/8HK8c+ZXrxlOogYwUY2eSfs=;
        b=xuIYEBsn2ryqdGX+FkuwetInmokALqieaEGMa8kT90J0hA64MKJqN0LJ878I/0lb0v
         tkhcV8blLh+C1rmWsmvy+Aux/jdhiT9Z2rmcDr7uPC1+pfCN/TZGCpfWTV0diARD4xwW
         UItWZf4bsjcUCjL2MGH5HHjx8MZY17xbW0F97PHlpCMA5NvJM5uemsbs9K81DN50Eu5A
         XzbRGMyFC8HsaYITWy9qRAGTQ3aa158OQn+jl4R4IlsMlUWJ2m4LjsxYsCN0UCHOnM2/
         4aCgBGoeHSX9jDDlyxsLDysGL9MslKaWc4w2pOpAODcJrvOQigULv7OqP4th2UBSFISU
         hbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZB8hSYRKOrLl+E7loPd/8HK8c+ZXrxlOogYwUY2eSfs=;
        b=jxQWRl+ba7kC5pkfx+ea0gSVc7FY6GFx15pVvXmpuNvhrzs44bNEEL0vUxbwGXccHo
         vfTs9oDIA8szWz5HEtQXovf+czsew5isf8oWdQJzAEXJpPwWZNfuQ7q2PzLATIOFzhT0
         DZEPmTc/pPg4z+lhbSdfgnHmF8kOMgmlcMwEjOGSm4UXQcyI/BkuPFc6TNieC+ryAwCF
         2nHHWlaM/4cdHwr6B3P+xBB6tDUKQjw9Cdc9ypI8r+gxgAbPPIVKzYtbX+x/0CTXvdj+
         ev2VCc01EfDzjpVEEa7uPvI/nPuv+eSunOQAgiGGsrm/7FDGWjVEPcuBxlA126m28smX
         w3xg==
X-Gm-Message-State: AOAM530ylvoZ/ixA4M2TiGbNBkMMHAGi4z24t9Omo0WzKdJjcjgOvHMd
        +NtcJZKR6sKHJcxp8pXsQZAMgw==
X-Google-Smtp-Source: ABdhPJy3dsyNIt/AZvz2RkHKRr3vR7DVqumnZSQuCTMohgzQ/9WXO5p0bWhT04eDCNmAyiuOnAi//g==
X-Received: by 2002:a17:902:ce8f:b029:12c:c4e7:682d with SMTP id f15-20020a170902ce8fb029012cc4e7682dmr7288244plg.58.1628049759151;
        Tue, 03 Aug 2021 21:02:39 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id g20sm723281pfv.88.2021.08.03.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:02:38 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:32:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
Message-ID: <20210804040237.ssrba26jpe572mjf@vireshk-i7>
References: <20210803090744.12143-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803090744.12143-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-08-21, 10:07, Lukasz Luba wrote:
> Stop the initialization when cpumask allocation failed and return an
> error.
> 
> Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> changes:
> v2:
> - removed dev_warn() since it's not needed in this case
> - adjusted the patch description
> 
>  drivers/cpufreq/scmi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ec9a87ca2dbb..75f818d04b48 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -134,7 +134,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	}
>  
>  	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
> -		ret = -ENOMEM;
> +		return -ENOMEM;
>  
>  	/* Obtain CPUs that share SCMI performance controls */
>  	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);

Applied. Thanks.

-- 
viresh
