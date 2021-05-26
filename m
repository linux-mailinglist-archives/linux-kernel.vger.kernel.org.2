Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C63390DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEZBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEZBC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:02:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62285C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 18:00:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so11880475lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVD+VaC1x6mEUUpHbrv0Vf+0CSBqOy9uuOikGpUxMvg=;
        b=oAxZJiGtciI9t/NLX66UdglzTF6S5YVGLrkNbEEq97ZK8FlZoJqA0iR5+303WI5BVt
         17gSGV4Ktd9RRwq2NBcXLrhJb3aQb008GP0vtLdj0+b+AqzZVS/3gqeAN147/Xm+hYDQ
         wyA75VHCv4xKN3AxB0McTmhN7PYqiLycGS1ZR7fdp6hROFumBKA4c5dyua+z1JDKXS0O
         qg5pAevul3ddtq/JLOSGzxP+nTzgoyStxs2eAYLAgZqBwQycf2GXmMo0IAzGNwGQvqY2
         bqfZnjFsCCV9KihaSuAcCSehZjhCN9d2BejQkofYqYugvB3sXhBSA+19F0+fGhQCKYPJ
         LuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVD+VaC1x6mEUUpHbrv0Vf+0CSBqOy9uuOikGpUxMvg=;
        b=ErVw140eilBWcO/+Mfh2s4DXtMJlczfE/mQRSEUNUiVxyICBT67jj7Wvm2rIjmJL6V
         BsIC2xvqChjx+0oJ3R/hDq24o3BsvYkTYSQJ0ijUy4soY9LiuCYiu2QFUNoCC7Z3cM4C
         H+OihjyJQ8IqN8H2YwruLmyb+xqIPDfalH8F+K569F+6BTI7lAE3CXPVOmhKt8I3smEX
         q6H27o2dpA8uBqR+fM671gbzUExMI3d5mhGy+2u+wy3Bp5PmcB6Of2K45pYJj49idcBP
         a2VerP3N8J+0I7HWeGv3LsnIc8WQo7UAbRrynQ3BlMnCcnwjZ6XzbmdnmdTZHbO1XWdM
         Gfvg==
X-Gm-Message-State: AOAM530XUIFkDSKWoomyInQjJ1+id8nga3mU4QSjVdtFuiJcJMey8fOU
        GENZhn1JUVekg4y6oPkPtZyZXmFdd0Jqzw==
X-Google-Smtp-Source: ABdhPJysf1cz6iFkNRX8YN3S7joFh5Eqs7viTEl74u3GaRRhR/c17IOQmLIcX1E8b76GLltAHvJ3sQ==
X-Received: by 2002:a19:7012:: with SMTP id h18mr264097lfc.432.1621990852362;
        Tue, 25 May 2021 18:00:52 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c7sm1839140lfs.263.2021.05.25.18.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 18:00:51 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/disp/dpu1/dpu_encoder: Drop unnecessary NULL
 checks after container_of
To:     Guenter Roeck <linux@roeck-us.net>, Rob Clark <robdclark@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210525112904.1747066-1-linux@roeck-us.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <73c997e5-79dc-f269-f649-d5bc54c2e86c@linaro.org>
Date:   Wed, 26 May 2021 04:00:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525112904.1747066-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 14:29, Guenter Roeck wrote:
> The result of container_of() operations is never NULL unless the embedded
> element is the first element of the structure. This is not the case here.
> The NULL checks on the result of container_of() are therefore unnecessary
> and misleading. Remove them.
> 
> This change was made automatically with the following Coccinelle script.
> 
> @@
> type t;
> identifier v;
> statement s;
> @@
> 
> <+...
> (
>    t v = container_of(...);
> |
>    v = container_of(...);
> )
>    ...
>    when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 8d942052db8a..a573fe211375 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1453,11 +1453,6 @@ static void dpu_encoder_off_work(struct work_struct *work)
>   	struct dpu_encoder_virt *dpu_enc = container_of(work,
>   			struct dpu_encoder_virt, delayed_off_work.work);
>   
> -	if (!dpu_enc) {
> -		DPU_ERROR("invalid dpu encoder\n");
> -		return;
> -	}
> -
>   	dpu_encoder_resource_control(&dpu_enc->base,
>   						DPU_ENC_RC_EVENT_ENTER_IDLE);
>   
> @@ -1797,11 +1792,6 @@ static void dpu_encoder_vsync_event_work_handler(struct kthread_work *work)
>   			struct dpu_encoder_virt, vsync_event_work);
>   	ktime_t wakeup_time;
>   
> -	if (!dpu_enc) {
> -		DPU_ERROR("invalid dpu encoder\n");
> -		return;
> -	}
> -
>   	if (dpu_encoder_vsync_time(&dpu_enc->base, &wakeup_time))
>   		return;
>   
> 


-- 
With best wishes
Dmitry
