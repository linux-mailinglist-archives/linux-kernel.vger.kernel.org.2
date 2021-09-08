Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FF403EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhIHR4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhIHRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:55:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8AC0613D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:54:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z19so4023672edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=w24hLsRl7XZ5LbDSKhuzZ/Cfz4LFXM+tWc1TnSEUUss=;
        b=gewWGShr7Xr2Qy09YNJ3ZB3EE97D9zs6XnByfQ/9byau67LOFQ7/Pl37j7Ld6KiYMV
         CZuNmSoK1BnjvwIvkJxM2tTz+SYOqSAeW1Vx55yJcJ8tscSAuulR2d/2GtTTQlIVt9aq
         Fk4sBJSYv1cp2LvywuuLKQa5IOJdXteV+Sv3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=w24hLsRl7XZ5LbDSKhuzZ/Cfz4LFXM+tWc1TnSEUUss=;
        b=erM2TO8Kbrt4GbwMRMpa+jjWQreoFSNtO296LRm3m3x71c3Qt/kqaHAiI2fr26MSxh
         0nPTeE0wwJwPvZDoB550HpFFKFWgKy6V0nJyR4U8AZDO4k38RV7SclqBqzI5gWrePorB
         707DjoMV6FLwr8hZzsPOQey+0VsM8yHMdxQ0VDovVplqagFp8iISqLVPgsAzkwNmjvkQ
         qiZ4lKfqaBNIdWjDC5lMz1NcWVRBwFcUViTZAYRZ2Fq1ZnpeWgIZaa65u9YNMrdfEryy
         sskUcX4mz12PaaAAqm9UQyW6smRRvOK3Dc6UuYLS9db8TetnYCIjQxlbFJzxAVKjsYC5
         OmcQ==
X-Gm-Message-State: AOAM5339dmqBR4UegufOsqEYftbeBAMfgpIRF2xBObng2U7Fi4sxFm+x
        EuJRKuhGzsrAQHRBv0/r9hswdA==
X-Google-Smtp-Source: ABdhPJxBIQkBjPF3Gt5WEu386lz3cQM0dwlAunhiFpiwa6VJYwYAF1IbUqPzkfujW1BiIhDKl7lybg==
X-Received: by 2002:a05:6402:1248:: with SMTP id l8mr4993687edw.94.1631123658998;
        Wed, 08 Sep 2021 10:54:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p8sm1365586ejo.2.2021.09.08.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:54:18 -0700 (PDT)
Date:   Wed, 8 Sep 2021 19:54:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] dma-buf/fence-chain: Add fence deadline support
Message-ID: <YTj4yPk1YuFk3oeL@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210903184806.1680887-1-robdclark@gmail.com>
 <20210903184806.1680887-8-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903184806.1680887-8-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:47:58AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/dma-buf/dma-fence-chain.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
> index 1b4cb3e5cec9..736a9ad3ea6d 100644
> --- a/drivers/dma-buf/dma-fence-chain.c
> +++ b/drivers/dma-buf/dma-fence-chain.c
> @@ -208,6 +208,18 @@ static void dma_fence_chain_release(struct dma_fence *fence)
>  	dma_fence_free(fence);
>  }
>  
> +
> +static void dma_fence_chain_set_deadline(struct dma_fence *fence,
> +					 ktime_t deadline)
> +{
> +	dma_fence_chain_for_each(fence, fence) {
> +		struct dma_fence_chain *chain = to_dma_fence_chain(fence);
> +		struct dma_fence *f = chain ? chain->fence : fence;

Doesn't this just end up calling set_deadline on a chain, potenetially
resulting in recursion? Also I don't think this should ever happen, why
did you add that?
-Daniel

> +
> +		dma_fence_set_deadline(f, deadline);
> +	}
> +}
> +
>  const struct dma_fence_ops dma_fence_chain_ops = {
>  	.use_64bit_seqno = true,
>  	.get_driver_name = dma_fence_chain_get_driver_name,
> @@ -215,6 +227,7 @@ const struct dma_fence_ops dma_fence_chain_ops = {
>  	.enable_signaling = dma_fence_chain_enable_signaling,
>  	.signaled = dma_fence_chain_signaled,
>  	.release = dma_fence_chain_release,
> +	.set_deadline = dma_fence_chain_set_deadline,
>  };
>  EXPORT_SYMBOL(dma_fence_chain_ops);
>  
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
