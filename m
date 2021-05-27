Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B967E393955
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhE0Xqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE0Xqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:46:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C31C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:45:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p20so3001638ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Agf93Ei+9Tdc8Zvz0bPaizkEiLAVgHXWf+4M50aPaoE=;
        b=nMLBX5g3X755skTAhGoSjvtud9YhlWMACVOScm/kNloVrVed8R0YJUV775o79Jx9Wl
         MDSDih8RcL440wYlNQpFDNytOoigNMc04LUUwX4qflmZjpJfPGt1d9e8j5xKUVgiNWJq
         UtaarziZM/3+2DOLG1Mp8D1+hrRjYRMFsaGFwMLiCjVw2DLYv0ifSiJT0LHxL4WSJil/
         oSJ82ZDgS/UpNpLj0CnbRLmoeHkbULctk4u2GDbHvm1L7sukyOExw6gXoDTmFQRbFfmr
         rSM0UbGJLzvlMpR2BAwpVz+5XaT7ECbXnuit+qUapS5gUbtJI03LwJhbvNBAg2t9oTfX
         ReoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Agf93Ei+9Tdc8Zvz0bPaizkEiLAVgHXWf+4M50aPaoE=;
        b=Lnq998Nz42DPzn8p5UqehPw4r5nG8xcpuH6tQmZEyE7KOHWcsh/ljX0h1ueAvqo4xd
         qi6bOqHCdv37YzLLZaGJNTCHy4IPVpC4W8YB62s9OeUJ1Vr4ZHV6HDipNlawVISExeZJ
         W3QDkDegF+nGl9N8xgviRdIHSXnQQKPmhoIPIlPu+tcRSseFFNfF1/nTtMlW//DPHU34
         JvsgatyrjeVDux3XmKenhKqvypi59y7g5qIPa2qH/80yDG4lC2uXwXWp6uDLBYxgOgmi
         DGGmIXXP3swaTxsLuqxiI9J17u6If9L/dVxrG7B3N8ffq3dFvm2BPyZMC3fRRBebkMx2
         owYg==
X-Gm-Message-State: AOAM532yMXGTPX1X6nQPMogZIyiE0GkLZ53k+n6JG1K908qx5AiDZnfn
        hroF8ix+RTlr1itovd8sT0aTVQ==
X-Google-Smtp-Source: ABdhPJwpm9LP4ARZQheOF4vnrUK8YBrm3JYilKh6GFbYW+t31vOsjf6nmJE0sqqDaGqQ4CfmeZEBTA==
X-Received: by 2002:a2e:9196:: with SMTP id f22mr4363198ljg.88.1622159108474;
        Thu, 27 May 2021 16:45:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s1sm368494ljj.69.2021.05.27.16.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 16:45:07 -0700 (PDT)
Subject: Re: [RFC PATCH 03/13] drm/msm/dsi: add support for dsc data
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-5-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <73815f0b-b6d1-f6f3-d7aa-f77492861967@linaro.org>
Date:   Fri, 28 May 2021 02:45:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521124946.3617862-5-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2021 15:49, Vinod Koul wrote:
> DSC needs some configuration from device tree, add support to read and
> store these params and add DSC structures in msm_drv
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 170 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.h      |  32 ++++++
>   2 files changed, 202 insertions(+)
> 


[skipped]


>   		DRM_DEV_ERROR(dev, "%s: invalid lane configuration %d\n",
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 2668941df529..26661dd43936 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -30,6 +30,7 @@
>   #include <drm/drm_plane_helper.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/drm_fb_helper.h>
> +#include <drm/drm_dsc.h>
>   #include <drm/msm_drm.h>
>   #include <drm/drm_gem.h>
>   
> @@ -70,6 +71,16 @@ enum msm_mdp_plane_property {
>   #define MSM_GPU_MAX_RINGS 4
>   #define MAX_H_TILES_PER_DISPLAY 2
>   
> +/**
> + * enum msm_display_compression_type - compression method used for pixel stream
> + * @MSM_DISPLAY_COMPRESSION_NONE:	Pixel data is not compressed
> + * @MSM_DISPLAY_COMPRESSION_DSC:	DSC compresison is used
> + */
> +enum msm_display_compression_type {
> +	MSM_DISPLAY_COMPRESSION_NONE,
> +	MSM_DISPLAY_COMPRESSION_DSC,
> +};
> +

Seems to be unused

>   /**
>    * enum msm_display_caps - features/capabilities supported by displays
>    * @MSM_DISPLAY_CAP_VID_MODE:           Video or "active" mode supported



-- 
With best wishes
Dmitry
