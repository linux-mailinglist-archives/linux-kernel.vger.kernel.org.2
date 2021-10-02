Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA241FDF1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhJBTuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 15:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhJBTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 15:50:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BA7C0613EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 12:48:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so53250428lfd.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DvdMhFbXdHD7A6qJ5QaxL5UY0tJ08n/H0zZVRP0lw34=;
        b=YFaCW+4el+K/jG5JcYf1j3WPgImW/sWsAq6uGe/M/7YQcsfv5GhtquTVoq/8QWvm/Z
         Nft+fSHuwn92Gb8wI9Fgmu71gtxXLH+230Lz/0IS3GKMz2rxP1Fgmj4UtPaB3lgwnerN
         w1NUmEVaWUjxN8O6WR7FegRP1VP8n270ocoSQYJ+NdEJHVQdzkLDCmpqujBbukBDLSPG
         mFA7BswIhERO33Um6sRot8rlDwuyeDEE4zrMVy9Yvs49knS45DpfEb3pOq7VEPrx1NSz
         c8p8SJis7t9dlrW/V9e3Pct6Fg7xjR5cEMoH9LSC2TrhOwv5dbhzF5msqownb0alwtZ1
         Pk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DvdMhFbXdHD7A6qJ5QaxL5UY0tJ08n/H0zZVRP0lw34=;
        b=q3TdphMlm++qAwf9Sx7GwdyIt59P2Pn79H/W5Uk1ZSBI5o7dC761hTR8IBuK7q8E9d
         AC8+kRtjhNLNnlgIzt25gdI+CUMQ+uAL1d1YS1F4tW7meQXOVPqRejWlI6HE3jQoUjoN
         c97JXQjyLAUSNHaZ8DgauMwzspfkTjGPBbCG3vih01mKppePqEdNJTsyyCJp4aRZhQvM
         B8bJ9KB0gJnw8Z/G7Mx5GNiNp4/1LVAP7JY+L7GRzuSW/IfwFO8exVa5yAUo/cSKjdrh
         MyVpOBaoi52H0ZJT2QkyqkMwX85eiOtydix7Vs3Ar72u4FZnrB7pfvobqXpUZD9FZ6Vy
         2MFQ==
X-Gm-Message-State: AOAM5333REUumg71H8aRfQk0U+G8EqLHVHAAiWuFuNl2trwZBlPv8ldX
        xkTNV78Xhjmuwya8KgNsfJ7QcTOMNwFgLw==
X-Google-Smtp-Source: ABdhPJw8ihcmBd/kFBOK8dZPMvMjHmdQ7DFw/tJ78Z2qNJWwDmAT/6/rANheh1Pl0qvgWTzcNVzkDQ==
X-Received: by 2002:a2e:95cc:: with SMTP id y12mr5396780ljh.337.1633204135751;
        Sat, 02 Oct 2021 12:48:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k21sm1115451lji.81.2021.10.02.12.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 12:48:55 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: dsi: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
To:     Xu Wang <vulab@iscas.ac.cn>, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        mka@chromium.org, harigovi@codeaurora.org,
        emil.velikov@collabora.com, rikard.falkeborn@gmail.com,
        viresh.kumar@linaro.org, rnayak@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201231095616.25973-1-vulab@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <3de6b365-7ef7-e191-a072-c7bd418c519b@linaro.org>
Date:   Sat, 2 Oct 2021 22:48:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20201231095616.25973-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2020 12:56, Xu Wang wrote:
> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index ab281cba0f08..e7af90f045bf 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -565,13 +565,11 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
>   		goto pixel_clk_err;
>   	}
>   
> -	if (msm_host->byte_intf_clk) {
> -		ret = clk_prepare_enable(msm_host->byte_intf_clk);
> -		if (ret) {
> -			pr_err("%s: Failed to enable byte intf clk\n",
> -			       __func__);
> -			goto byte_intf_clk_err;
> -		}
> +	ret = clk_prepare_enable(msm_host->byte_intf_clk);
> +	if (ret) {
> +		pr_err("%s: Failed to enable byte intf clk\n",
> +			   __func__);
> +		goto byte_intf_clk_err;
>   	}
>   
>   	return 0;
> @@ -667,8 +665,7 @@ void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
>   	dev_pm_opp_set_rate(&msm_host->pdev->dev, 0);
>   	clk_disable_unprepare(msm_host->esc_clk);
>   	clk_disable_unprepare(msm_host->pixel_clk);
> -	if (msm_host->byte_intf_clk)
> -		clk_disable_unprepare(msm_host->byte_intf_clk);
> +	clk_disable_unprepare(msm_host->byte_intf_clk);
>   	clk_disable_unprepare(msm_host->byte_clk);
>   }
>   
> 


-- 
With best wishes
Dmitry
