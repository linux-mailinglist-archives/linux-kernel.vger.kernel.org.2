Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9773F43CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhHWDSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 23:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhHWDSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:18:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6992C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so17738684pjr.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBOogX3XB4mHC8GpV87UjjRCgHNuTvok/Zf+qYgDrJU=;
        b=rnynb/BFuTERp3DG5b3HDTRYOODWJFs8FUmWZEHn7kdOXK+v9GxGmvo0OZFlxH1mH9
         bUV4VDB7HNP/BmT8ZUsmRKGWfDaRPpP10ne9zXhvr6lvIo5xTb0qCuDHcFMIlKp3a6Y+
         nIuje/j7f6we6kMd+YnHIJVmTdwK689j91h0HLlrgmNhJ6PUODi/Ayd/enZltherbOOu
         4Ohs97FD2bGwzi1sugYy35jgXHJGxs3UH591RdTa/peLxvB5t8u4UCzaTBSxqAfHe6Jb
         MsNXRH6SgO+PT99HXwQny/85q88UbIrMeKN3rtZMifRcpsenyRmHRFWTJfK1hNio+M01
         G3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBOogX3XB4mHC8GpV87UjjRCgHNuTvok/Zf+qYgDrJU=;
        b=EF8hFqJt+ALIPr/JFDbeP4L8iIxJx4p4Q55kgAqYqWlyJJsbZVjU9HBuPPThCPqTU9
         yv7Bz1z8zQcIA5PEA5G+kF10+MnyqtiJJpTziTKPo6fisqGHlwMC75M+YwO1oQpHzdQW
         xQAsdBhgG8+mCbY82wsWWicy6GMJaA0eR/F1JXS51H2TTa5zWBQymYFMx71Xwmh/H7/S
         ukvKyEY1VuTUhPQcU7CVWn89GYJBykPfIoNLdal/gCxIdO5ZrQnlHMQ9Mqfau+lBiVvB
         7Jxl0vUd+RB3AApUht09+27BUl9PoRetx2qTeyFS4S3Iyxe9jfTDxOvVx9MOSHS4v29h
         +HSw==
X-Gm-Message-State: AOAM5325u0JKD6F0IgSwaJNvpDpzXMBAJCLmX4DgnRJcEBcsy9VM7xl/
        IH468Q1Szl4tcrv6J8aoFXzOHw==
X-Google-Smtp-Source: ABdhPJzqg3ToMHCG7N81BJvsddQsivBmCGSHavIG0r6EDRSWDesCvSDugU108BZ4HKtVDXXBfvuzKQ==
X-Received: by 2002:a17:90b:4b84:: with SMTP id lr4mr17964004pjb.32.1629688648248;
        Sun, 22 Aug 2021 20:17:28 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id h9sm10922286pjg.9.2021.08.22.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 20:17:27 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:47:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH] cpufreq: blocklist more Qualcomm platforms in
 cpufreq-dt-platdev
Message-ID: <20210823031717.hh3pn4d2c4sughem@vireshk-i7>
References: <20210820215700.130575-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820215700.130575-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-21, 14:57, Bjorn Andersson wrote:
> The Qualcomm sa8155p, sm6350, sm8250 and sm8350 platforms also uses the
> qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
> blocklist.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 231e585f6ba2..ca1d103ec449 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -137,11 +137,15 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
> +	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm8150", },
> +	{ .compatible = "qcom,sm8250", },
> +	{ .compatible = "qcom,sm8350", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },

Applied. Thanks.

-- 
viresh
