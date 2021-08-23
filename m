Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE33F4875
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhHWKS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhHWKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:18:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C259C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:17:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y11so14922195pfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgupZisMt6B/EkcO1mCnOq/BHKVDB2h1wHoKSAT0jDI=;
        b=wFpMASr0ag7gujaOAvZAm2W9EREBoa0m+GCteTZHosg35JZSON2VXRALN2LjBELAiW
         7iMS8S2RS393nVyxEsPv1XB7PtOjwj0qKfJPjWFm4TJ1vl1kpSkrJ/uYA9JLF92mlFkw
         nDcXENZbm2W1QslHWUjWpk1NuN80gkcBEyY2j4WDvswbwHKhs1YInTvnhusZSE5BPyh0
         wUvmVeOqgyIGHIhFuwCGEjI8o6ktSICPx87Kgr/3GfMQOoD6lRtpEwTBVu23zzHDSdKB
         8t2cwZAqscT9H0W4hRnzGO2DVqoGsdNP9hxDg6RYOBpCgydUVwMhhOaBS4y4VCGUpzuy
         iL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgupZisMt6B/EkcO1mCnOq/BHKVDB2h1wHoKSAT0jDI=;
        b=EKKLiqNFmNltEgpPerfO4tYU3iwVv150pdmPjo/SuYFXR6AuLW8+Ur8ukJXkwT7EBn
         owgGO0tLSjm2WX72p9BSljJVNtTtrK3Sxf7KY6vZIDxttOHlmkJ/Bge1IUkK5Q+OVBH7
         nLzjTwSnvlTUoB3ys+ElM9oIoLYDIiZqjwnCi3o36dNQVuKQbtCBQrtpnDSQPN8ZafiG
         urSCTq6ftjoeGrVdwBXvKjD+JGosXusc7zHlrSUvnHzAug8bq+gd8p8UYJTK+UG2R6la
         9EyFaxwT65cajliyPuh8HH3Nj3M64eEqcmtr3QFry5HBGnI0HXKGS7pxt7/l2N+KZdc8
         tTHQ==
X-Gm-Message-State: AOAM533wFOqEl30289Pc6HPzI4XaShHhWb+HepK8z5QsLIY8+OMOmJpK
        HQJey8TjwFFfSt28tLbVWFeUUA==
X-Google-Smtp-Source: ABdhPJwnZpsd6FB86D6GOKijSfJHmTjKjglgYkL9/dBwKnYfP7Zz9XknOB1i4OOO8Na3wI6vA6BhuQ==
X-Received: by 2002:a62:7693:0:b029:3e0:8a78:3001 with SMTP id r141-20020a6276930000b02903e08a783001mr33240400pfc.7.1629713861100;
        Mon, 23 Aug 2021 03:17:41 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id y5sm15329363pfa.5.2021.08.23.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:17:40 -0700 (PDT)
Date:   Mon, 23 Aug 2021 15:47:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
Message-ID: <20210823101738.vli2nhiasfysnpmu@vireshk-i7>
References: <1629713746-18360-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629713746-18360-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-21, 15:45, Taniya Das wrote:
> As remote cpufreq updates are supported on QCOM platforms, set
> dvfs_possible_from_any_cpu cpufreq driver flag.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
> [v3]
>   * update the dvfs_possible_from_any_cpu always from qcom_cpufreq_hw_cpu_init
> [v2]
>   * update the dvfs_possible_from_any_cpu always.
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859b..4dd77ac 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -348,6 +348,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	}
> 
>  	policy->driver_data = data;
> +	policy->dvfs_possible_from_any_cpu = true;
> 
>  	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>  	if (ret) {

Applied. Thanks.

-- 
viresh
