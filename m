Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00731E9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBRMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhBRK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:59:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295ABC061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:35:43 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g20so1031003plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tHsrb0DYK4lku3a8AnYlDdd6INw/DQti6oTvXdTAcko=;
        b=LdDO9eJw/qbgP0/LCpOnbkjSGBMMN2AU6sn65utGj7Jbua7u3RHte1Ox/HaIXhwAa1
         8WZs8xvJP5LX0JCKAIv0wcvEMVuGI4MBYfuBEEqnBHsMwui4ItoSi7MOzdrCyYXCZMih
         jmv9VGZOheR15KF2A6NvprAkZD/QpuZXEvvqyvk7bKpmpogMJxwticcQJu1V+D7TE/3c
         ezkwqo8856MsFmFSJx0NkN0oKzNAEeyiqNjGOOg/ptNajf7WWTog46DrEXXbC5mvNtjv
         xfhJ5NZ+iDUWHrfYEGRleXN8ft4+SZVzUOB8O0RllCZYf8eaVGm6dbBJoOPG5Enq1Zwk
         nLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tHsrb0DYK4lku3a8AnYlDdd6INw/DQti6oTvXdTAcko=;
        b=XDjgkfjz9wWfAGfXHYLFCo1FBXeyHyYen+s/yDyUZz5Vu3xYqRkobwybSQLhRGrGV0
         mqVErix6rHFCO+CVZxKm6pJgq5BdZmXrNEor2r2LziOPtGKJJe9lmt4W/5mbPrldJclE
         vGLJNeRatpXov+UU/7xUAEzbTbWh9VZvGbKOZ0SemAQaC++ZvjNlemT62JnVtcGzlwIw
         puDkqWT+htWjuOtUF9hw9mP8QAaHNGcG6DlMc/W4sg8inm4K1dsAF3o0l+kVfCBjUH0d
         jnE5rCS7dSJPKIJvuTbIuL9boB9EAEqjhd3VHUY0lc70qQXnFNeZOqWGpMpXvafREyF/
         Q0ow==
X-Gm-Message-State: AOAM533PUzsm87Ut+DvZGC0YcHheP0kgFsOEvbgXFlPDithV9zwtsxy/
        c8ggNiMK0by71sCpyERgmxQOZA==
X-Google-Smtp-Source: ABdhPJxQm2bKWc2RQXMTCauGvO51yB4Estxp63HbHEwUBI1tly6FVkm3dSOXS/hj6Pnmun84byamxA==
X-Received: by 2002:a17:903:2285:b029:e1:58a2:b937 with SMTP id b5-20020a1709032285b02900e158a2b937mr3536248plh.68.1613644542659;
        Thu, 18 Feb 2021 02:35:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id z2sm5627390pfa.121.2021.02.18.02.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 02:35:42 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:05:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
Subject: Re: [PATCH v7 1/3] scmi-cpufreq: Remove deferred probe
Message-ID: <20210218103539.zkxhqxaivhifmjwj@vireshk-i7>
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
 <20210215075139.30772-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215075139.30772-2-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-21, 07:51, Nicola Mazzucato wrote:
> The current implementation of the scmi_cpufreq_init() function returns
> -EPROBE_DEFER when the OPP table is not populated. In practice the
> cpufreq core cannot handle this error code.
> Therefore, fix the return value and clarify the error message.
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 491a0a24fb1e..34bf2eb8d465 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -155,9 +155,11 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (nr_opp <= 0) {
> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> -		ret = -EPROBE_DEFER;
> -		goto out_free_opp;

Why change goto label as well ?

> +		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
> +			__func__, ret);
> +
> +		ret = -ENODEV;
> +		goto out_free_priv;
>  	}
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -- 
> 2.27.0

-- 
viresh
