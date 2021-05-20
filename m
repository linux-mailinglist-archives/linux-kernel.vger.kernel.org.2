Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D5E389C35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhETD5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETD5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:57:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49511C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:56:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z4so6045059plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=po4uQOPMb2vlHYmlr9YHEFFwM3Cu/99nzbQP8WwI5lA=;
        b=QA2gT1MQUF6M1toXCLbBIu346gFBWM2+MW4S6+iOCrftmZ9J9H6x/wOB7FEGqXedgw
         TsyB2746ddL7IozzQ4uUKW5spTp9bbxpp5GWvQGG/QByDCNc7dwsWrsmeLAhiZh2wjRB
         xGu2cndaRm50Eze5PR/Ykkdgq7BNRdQHT7BNCsJceMQftYTLT8WhVtrjKpDOErlml/hV
         xkmp948hPsMEX01dI+vp51mgYJbySMDiQwgT9oJUZiwNtyQfTbX062DXhuQpW9tESltX
         xuygOdF4raqwfyzMzuJBPN9VtL37DxDzYOHl/URYwvp4J+IUdN1EHq9eKzYPj9Zozh5/
         3dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=po4uQOPMb2vlHYmlr9YHEFFwM3Cu/99nzbQP8WwI5lA=;
        b=lrrphLiVv+f06XkMNPrz+DC/nDc4CA34/hKPvlr0PeSy5aa1Qzfm6bAEhb4/9RoeSj
         2beWU+5i5Kw4Bc6RwJx6lAzAlV9YmVRIt6fAFTsKJDNdXnoHr7Rb8+TnkCgzemINHMgO
         lXm5E5cSCYHFBC5dVyPv6H5iAFkOrPXITMlL9AXc3ZGIFcauRL0AoANUKNW1MV6b4mmk
         sDBkIGodG9Yv0KsQ9rK9DSk8hp4/BatLY49d0z/MDf8Cr7XkNXxkS+IBoGTFpt4h0QNg
         NijOS/usuzBemjIrkfG1KPyB2lWnD8YO2prvuytKeaXBefzVX4AI4vafT4jz8zsjUQRt
         iVGg==
X-Gm-Message-State: AOAM532jVwEGmAbdr5KRvztLO7XVY+bXH078BWi+lYtTMHEU3zLVpxl5
        ESHFNJujZTalaLzus3YIzj4ECA==
X-Google-Smtp-Source: ABdhPJzLrj2GgWWPuAohBxvwb17XdNk9prc3xA0DJgRsykC+2R2crjPg0lGmRQCkouKu1bT0psKqVQ==
X-Received: by 2002:a17:902:db09:b029:f4:8d37:8d12 with SMTP id m9-20020a170902db09b02900f48d378d12mr3529028plx.52.1621482985771;
        Wed, 19 May 2021 20:56:25 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id a10sm5221770pjs.39.2021.05.19.20.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:56:24 -0700 (PDT)
Date:   Thu, 20 May 2021 09:26:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        mka@chromium.org, sboyd@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: blacklist SC7280 in cpufreq-dt-platdev
Message-ID: <20210520035622.e276tqpl4gg5fxhk@vireshk-i7>
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
 <1620807083-5451-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807083-5451-2-git-send-email-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-21, 13:41, Sibi Sankar wrote:
> Add SC7280 to cpufreq-dt-platdev blacklist since the actual scaling is
> handled by the 'qcom-cpufreq-hw' driver.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 5e07065ec22f..345418b8250e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -137,6 +137,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sc7180", },
> +	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sdm845", },
>  
>  	{ .compatible = "st,stih407", },

Applied 1/2. Thanks.

What do you want to do for 2/2 ? Go through my tree? need an update ?

-- 
viresh
