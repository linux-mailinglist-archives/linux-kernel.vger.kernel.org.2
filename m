Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F1381A42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhEORqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhEORqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:46:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15CC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 10:45:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c15so2230624ljr.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Uew60+G+SsxW8j8MijONIawIC+5YuiNS9/uDWrf3cP4=;
        b=q7uMGfIu5kGZ+6hGNujZ64ZmMGy4RAikXSf8gFyIKdRbA71krFjYMlArGdyx2gq9Vq
         d9WOncS48vT9ws4TVxrvOPftv0vDMA0vs1BNZuOx0H1ORjEG171ueeUTtuYABCXCtDV8
         VU02/2EfHzaGqprgipQVXAGhRyhW15jGjR19GiwNRD813aX3pyJgYqC6LekkD/on9E3k
         VTNYeguiwopR8UazK/toaPKYuSp0akJesQd0poBUiPBsST6mjHa7hywxSBqTb7DyWN1n
         J7fS/NOQsKnZ4+tBOHtHEefonMt015EkuoJrRFfV35eFvsEiMVk5/759MpZUEX/dRu79
         JrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uew60+G+SsxW8j8MijONIawIC+5YuiNS9/uDWrf3cP4=;
        b=i/Kg6UEXEZUnkYvjs0WpkEgEY+iOOq+CynHLj3ODV3BZ6bK9C6Yw9CZuNdy4iOnpTv
         YEqmRZg/hqbFKP+w06eavg5ZwDaQH4DPUx7mHnWrPss9FXDzdcz5fJjVPDovWIymUBzS
         sb4+Fb0sHA05ZiE3Ba0Re1r6J3W1BlYl+68WKVEvDl6+r5e1gspNxbvkBWMos41N0uJT
         yNhJ8B4mcTKpSq6JDSCeC+NcTAnON7wlpX+jIFYplgpflZn+t5KF8pHjwEAUnT4c9TuQ
         adG5M/zlw5/wQafUDkv2O35n+CwGx2bOUtpSCJqmeilZ0iE0+ZzBK6LgyaQ8BGW2/aIu
         2oIA==
X-Gm-Message-State: AOAM530FzunKYLfANmqX4tKnROdXbc6uIdmBENBeAf06kyJxDCDhMFlM
        4zFza2z/ymBWY+/J8Nz1wyNkcPVLQwgJzg==
X-Google-Smtp-Source: ABdhPJzZpYVpC+2X095uKXRc/Oo5tcpmRjH0WCm9hYwhP9EBhCF2KrssdyelK4eKiW3/vctO7ffvdA==
X-Received: by 2002:a2e:b807:: with SMTP id u7mr42869439ljo.67.1621100717420;
        Sat, 15 May 2021 10:45:17 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h4sm1430170lfv.264.2021.05.15.10.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 10:45:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] drm/msm/dpu: Fix error return code in
 dpu_mdss_init()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210510031606.3112-1-thunder.leizhen@huawei.com>
 <20210510031606.3112-2-thunder.leizhen@huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c19cb5e0-2ca3-0453-3c8f-e01f30748031@linaro.org>
Date:   Sat, 15 May 2021 20:45:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510031606.3112-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 06:16, Zhen Lei wrote:
> The error code returned by platform_get_irq() is stored in 'irq', it's
> forgotten to be copied to 'ret' before being returned. As a result, the
> value 0 of 'ret' is returned incorrectly.
> 
> After the above fix is completed, initializing the local variable 'ret'
> to 0 is no longer needed, remove it.
> 
> In addition, when dpu_mdss_init() is successfully returned, the value of
> 'ret' is always 0. Therefore, replace "return ret" with "return 0" to make
> the code clearer.
> 
> Fixes: 070e64dc1bbc ("drm/msm/dpu: Convert to a chained irq chip")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index 06b56fec04e047a..6b0a7bc87eb75b8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -225,7 +225,7 @@ int dpu_mdss_init(struct drm_device *dev)
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct dpu_mdss *dpu_mdss;
>   	struct dss_module_power *mp;
> -	int ret = 0;
> +	int ret;
>   	int irq;
>   
>   	dpu_mdss = devm_kzalloc(dev->dev, sizeof(*dpu_mdss), GFP_KERNEL);
> @@ -253,8 +253,10 @@ int dpu_mdss_init(struct drm_device *dev)
>   		goto irq_domain_error;
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		ret = irq;
>   		goto irq_error;
> +	}
>   
>   	irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
>   					 dpu_mdss);
> @@ -263,7 +265,7 @@ int dpu_mdss_init(struct drm_device *dev)
>   
>   	pm_runtime_enable(dev->dev);
>   
> -	return ret;
> +	return 0;
>   
>   irq_error:
>   	_dpu_mdss_irq_domain_fini(dpu_mdss);
> 


-- 
With best wishes
Dmitry
