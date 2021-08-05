Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48B3E0D05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhHEENp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhHEENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:13:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58ECC0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 21:13:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a20so5608917plm.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FqB8XGm+aamjbVDR+I0fpf47HqBYuxRSrQDk6Wt6JK8=;
        b=jyAJPEcYskiQauSKaezVhYGduYQB509Pexly95GuGm2KwJ/OPI3hddL6xWgolV0opZ
         7qeg5ajf21wDpQekmIq4MBx3fFy4vja3FAn+1hlwuprSyFkscLrIEVgxg6YLhXhDoVV7
         NLNl5iWqI3A8u5yh6i5+qO06UVmXSlvKSf5X5oPVX2J5ffUqt7DMsC5Fxhp6yoIQk7+3
         J0pimAZmykN+evRpy9Uuc5y91gz2ePYQGAXVgZjjdCL7mGwb2Lqj6p56Gc5P6qpyeWz9
         psc6u9JRYMifyM0RQuKRaeO2o34gWEgtVoINrIv1yRSgCk8z6nljRys5o1uKGXlhRLAs
         F0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FqB8XGm+aamjbVDR+I0fpf47HqBYuxRSrQDk6Wt6JK8=;
        b=YAPtVER/o0FY/6AVvFOznYVdvEoUTIaGkOz23vHJzWKqDZM1Z+CW2FEkA2dPf9X+4o
         TsQ0rmSu2pRok7s3refv2+6cRFAfAK9JBJYxCwROr9+pQlZYcC3bQBY/mvQ/OKsi1lph
         8B20583A/0jnrrWL/NHRi3kyXZ1wdFGPuOrPiByRZLlaN7cLxrUtkZgxIfXeDeNNJIOc
         OhtI/bFTD8O1/Xl/55wFV69PT2/8GykkjgEYlF0vG2JasGurmM+UQPFBaulXT1iKUURJ
         5qlJu3+JegTj0oz7k2QIMzuRlwBp5PKQfUwN2Uff5C7gHKeP0rVjnMBImoJhJ4dX94CP
         HHLg==
X-Gm-Message-State: AOAM53086XPqYQwIV/TDnNyoQpzpzb+yB7A6cTPJ9ytee+ffNmYjXErI
        zFsUg88EKMpbwaGM1vx9JLFyjg==
X-Google-Smtp-Source: ABdhPJy/cCv7Gt8iYtqpJVtfVCS+dSM1sieVhL45IykaMlSJTCGbhjC/mpKXWv4T+OgvjVV7nERFyw==
X-Received: by 2002:a62:e416:0:b029:3c5:f084:7212 with SMTP id r22-20020a62e4160000b02903c5f0847212mr2778606pfh.76.1628136810122;
        Wed, 04 Aug 2021 21:13:30 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j19sm4525423pfr.82.2021.08.04.21.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 21:13:29 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:43:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Patch v2] cpufreq: blocklist Qualcomm sm8150 in
 cpufreq-dt-platdev
Message-ID: <20210805041328.cte244ee2nop4zv6@vireshk-i7>
References: <20210804203420.2641463-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804203420.2641463-1-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-08-21, 16:34, Thara Gopinath wrote:
> The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
> add it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> v1->v2: Replaced "blacklist" in subject header with "blocklist".
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 9d5a38a91f10..231e585f6ba2 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm8150", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Applied. Thanks.

-- 
viresh
