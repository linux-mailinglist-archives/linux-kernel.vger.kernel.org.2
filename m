Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8994A41FDE7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhJBTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhJBTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 15:50:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3160C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 12:48:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y26so53247009lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3v/geDj0uGsJ/NYH2t8jxZkd5djSTKuilXHwfdzt1Cc=;
        b=RHg/dSVzLyBV46OXc3FslmwBEmjnSZ551iVREvMg49ZnxMhGpK8IqjAlYnyuzz4VyA
         qDY03Z7ywArwD0J+/I7fU1CqVSTlzISn0nvICz84CkGqS3CEuyMkUYZybqK1ZbROgm83
         JoP6GmR/pLdjYA2ySMpbLnVq3xpW5Fw7voH/YA4xt2g98PJUTVJHjSnZWChxzIk+Rpoa
         BnXuNaAkHfh72cSHr2qMgkLivgXC+PjpgY9Y8t/siTpdwusB9OxwokOeMqk4B/WkuwkF
         79JaNsd0T1XrCNrANY/O++5vhdtYtl4SSE//KL2AOD3Yd8q7vxa/DveK4vOwzOdEB0sa
         hw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3v/geDj0uGsJ/NYH2t8jxZkd5djSTKuilXHwfdzt1Cc=;
        b=BK6j9J7pFxLS0DUUOYpfPUw+p4LGAm2K4lyPaeB/+4/j+h9axiCHa5VY2NXjFpamoY
         ZeN1eaJBtvctny/YrDnwzKW6CyKA0kQjDvZPJsAPPZ9HreIweuwH6HnEmPZ0EkTP5x7E
         Qn+whKyuXExLEc1iASvdw5byakjFaSKg39eR9+8bWDAtC9VGSlj7m1wQj0Yf5Orh/laN
         Kp5u6X+7RZ6k06rMn2qJ8FJQSMRXWq+YeECVm4oNgfym+ycLE2o4Q7i/IxJDQFFIaQOA
         i3r+N2EMXwBSsggJyJ34ZGAERI5KSWqCboDgq75Tvn4yL0goR+ln18IesowkUUirkQr2
         7bKg==
X-Gm-Message-State: AOAM531zeVcF87j/GYsX27RO4g1ZTg8SReFvd2QwFfYfin1n9XbHUWf1
        Gcj1MNWn61PbLiL9P+H+Q/Gl5j7nS8QPyg==
X-Google-Smtp-Source: ABdhPJwLnDBY0HJqJaaf7DmtwiIdW9JIcvRLJwkpht+8jNm1I/nya8rzp3SvoRS6VNc2NJxlBiCI8Q==
X-Received: by 2002:a2e:1557:: with SMTP id 23mr5644871ljv.84.1633204115051;
        Sat, 02 Oct 2021 12:48:35 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e23sm632330lfn.215.2021.10.02.12.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 12:48:34 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/mdp4: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
To:     Xu Wang <vulab@iscas.ac.cn>, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, jcrouse@codeaurora.org,
        tzimmermann@suse.de, sam@ravnborg.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201231094155.25481-1-vulab@iscas.ac.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <3809d7e9-3aa6-8ac0-c1ea-88b63a3d6d63@linaro.org>
Date:   Sat, 2 Oct 2021 22:48:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20201231094155.25481-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2020 12:41, Xu Wang wrote:
> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> index 3d729270bde1..696a22d571ad 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -207,12 +207,9 @@ int mdp4_disable(struct mdp4_kms *mdp4_kms)
>   	DBG("");
>   
>   	clk_disable_unprepare(mdp4_kms->clk);
> -	if (mdp4_kms->pclk)
> -		clk_disable_unprepare(mdp4_kms->pclk);
> -	if (mdp4_kms->lut_clk)
> -		clk_disable_unprepare(mdp4_kms->lut_clk);
> -	if (mdp4_kms->axi_clk)
> -		clk_disable_unprepare(mdp4_kms->axi_clk);
> +	clk_disable_unprepare(mdp4_kms->pclk);
> +	clk_disable_unprepare(mdp4_kms->lut_clk);
> +	clk_disable_unprepare(mdp4_kms->axi_clk);
>   
>   	return 0;
>   }
> @@ -222,12 +219,9 @@ int mdp4_enable(struct mdp4_kms *mdp4_kms)
>   	DBG("");
>   
>   	clk_prepare_enable(mdp4_kms->clk);
> -	if (mdp4_kms->pclk)
> -		clk_prepare_enable(mdp4_kms->pclk);
> -	if (mdp4_kms->lut_clk)
> -		clk_prepare_enable(mdp4_kms->lut_clk);
> -	if (mdp4_kms->axi_clk)
> -		clk_prepare_enable(mdp4_kms->axi_clk);
> +	clk_prepare_enable(mdp4_kms->pclk);
> +	clk_prepare_enable(mdp4_kms->lut_clk);
> +	clk_prepare_enable(mdp4_kms->axi_clk);
>   
>   	return 0;
>   }
> 


-- 
With best wishes
Dmitry
