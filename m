Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A727390673
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEYQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhEYQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:19:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C769C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:18:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso29155858ote.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucrlaXMhJuqZbdL/Kh7Imph/3ZSj2r6db/bMXL/uHzE=;
        b=oRXR+DbpUeQHbBYujjL4GoV6YZPeae9xH+ys4WbWsiYr23JkVyjc/NE19xWDL5uIMR
         r8yvvZ3EAB5E5vSsqw4SId7PfxZkau8VWf6Lt+40Kj1+/lQTX+9+++XfpquLePRRkIo+
         Pff8XYy4T55K3SdNaOiNm6A7r7nof9d+zFrOjVFL/JoxnL0U4QEaB+Q3wQbsss+ze/Qa
         Xa8gky55+s0V2AE2dqdy3JN49OXS76hmXhoBjHex/EynjqI2DCJpCg27zwNsFiYISS/I
         k3YTEPkPI5mz63gWYtcdWbizebVGGbw6PCNRzcabU+17vS7Rd4FmGnSh6HocFOXZRUk3
         /a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucrlaXMhJuqZbdL/Kh7Imph/3ZSj2r6db/bMXL/uHzE=;
        b=TxeV0TfEoS9rfhkZfszNFbKiJLrlfuo2l0PM+qlMnOTkwDUrhpCQXFVpnw33c9J6TC
         uIX3gixyBInL1O2A3zOyUBI52KSwVK7F17Lfms+gH+Gf2Sk76vawXWMEUPFdpwLC4+uZ
         vxlvELSRkkXIMxvS0VQs1SJOHovOFIgOd1gnpe5+JAWfVLz4iF77InqdWT6FYjN33ZUI
         kBW/02Zf24AS5SQJH6eumU9yQozntlL58zZgjr/k49rJhQwQv1te6FtoQDm/9eGLWaOi
         DYigoPYQmH3qgVVZYhJ+haGuO8LI3Ea1rMnKDkmRRcHR7BmYeplC6hFn4hnDOGSA1qOY
         cT3Q==
X-Gm-Message-State: AOAM530o7b3/K1Iz3E0GjxqT5Z7J2A0mlv5mylJyDFvh2TEubEiZ66Ri
        r+2kW8wrWHPYhVqwKzVnwK3g9Q==
X-Google-Smtp-Source: ABdhPJxH4CMEN9KNuMJn0Pyz88KKt0ddlyzym/HaVnNJgh6NHsL6BFT4WGnckaqjEc+ROjW40dJPgQ==
X-Received: by 2002:a05:6830:11d7:: with SMTP id v23mr16491372otq.44.1621959490556;
        Tue, 25 May 2021 09:18:10 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u201sm3287736oia.10.2021.05.25.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:18:10 -0700 (PDT)
Date:   Tue, 25 May 2021 11:18:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/disp/dpu1/dpu_encoder: Drop unnecessary NULL
 checks after container_of
Message-ID: <YK0jQM4AMmBHbUD2@builder.lan>
References: <20210525112904.1747066-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525112904.1747066-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 May 06:29 CDT 2021, Guenter Roeck wrote:

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
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 8d942052db8a..a573fe211375 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1453,11 +1453,6 @@ static void dpu_encoder_off_work(struct work_struct *work)
>  	struct dpu_encoder_virt *dpu_enc = container_of(work,
>  			struct dpu_encoder_virt, delayed_off_work.work);
>  
> -	if (!dpu_enc) {
> -		DPU_ERROR("invalid dpu encoder\n");
> -		return;
> -	}
> -
>  	dpu_encoder_resource_control(&dpu_enc->base,
>  						DPU_ENC_RC_EVENT_ENTER_IDLE);
>  
> @@ -1797,11 +1792,6 @@ static void dpu_encoder_vsync_event_work_handler(struct kthread_work *work)
>  			struct dpu_encoder_virt, vsync_event_work);
>  	ktime_t wakeup_time;
>  
> -	if (!dpu_enc) {
> -		DPU_ERROR("invalid dpu encoder\n");
> -		return;
> -	}
> -
>  	if (dpu_encoder_vsync_time(&dpu_enc->base, &wakeup_time))
>  		return;
>  
> -- 
> 2.25.1
> 
