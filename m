Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10849388B96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347943AbhESKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbhESKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:23:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA0C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:21:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so3010894wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=agmM9r0ocVor9/dELzPhDyxV/Q6g4/KHl3BaIRPfQMo=;
        b=Q6r5E6/JTJ/+6maNrSQPa/GSrHfkMCdUNc4pqocJv5EXGNMDrowwxW1txNa/5N/+xk
         GYwR8lgHZ/BFD65gvsud0SnoBSz3HfCltufKq3dO9clYMX2s9Tcy+dbP2wX4TL8a2nNe
         n88muJcwXgf0oVKFKyBM87UMvPIeEOJKEJsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=agmM9r0ocVor9/dELzPhDyxV/Q6g4/KHl3BaIRPfQMo=;
        b=uNNH+j9T/TpuuHOz6WPus8SIUxwacdltwpqVjO34gGobMdlwaz0lMyqIp5EtsEBrIJ
         Ofq2D9fsmK2cR2FZdhNsh/XWVe+L5o2u/gk7f32kY46bFrDpSgudZVczJp2cxrlDhsHh
         iLXIU/j4xaXsB8pKKwKLjhEDwjmSXe3JWHzkqKzk8uHBBppzKuggWTMi32C1IN/BcLUP
         mOI5vb7lzMiqMg+LwZ/9aJzn7Ha8cz9psJyWZhAwuQOcUZMdcxiWhpqaQzk/SJs1J4xJ
         3kXDY4nF0ynnl25bctn8feFGbmJuHboy+JEQ62AYOeJoHmx9Nb6qgoSaDfVHTzzG1VC1
         QN3Q==
X-Gm-Message-State: AOAM533PfKmKia2m6m1ajXMcS8AntWUVwqBwuifVCYBZByUpZPi9OUoL
        dUC1nR9sWom3CuljjToMtBU91g==
X-Google-Smtp-Source: ABdhPJyrrNplyPF4l7h+AsOBRZFblqke572pHjkUgJUA7dvxQHAp9nrQ62XQOtKxwOeNoU38M3wWtw==
X-Received: by 2002:a7b:cc19:: with SMTP id f25mr10714124wmh.153.1621419703930;
        Wed, 19 May 2021 03:21:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q13sm23556881wrw.56.2021.05.19.03.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:21:43 -0700 (PDT)
Date:   Wed, 19 May 2021 12:21:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        joseph.kogut@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: Fix missing unlock and free on error in
 drm_legacy_addbufs_pci()
Message-ID: <YKTmta3l0barePvJ@phenom.ffwll.local>
Mail-Followup-To: Zou Wei <zou_wei@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, joseph.kogut@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1621341302-112089-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621341302-112089-1-git-send-email-zou_wei@huawei.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:35:02PM +0800, Zou Wei wrote:
> Add the missing unlock and free before return from function
> drm_legacy_addbufs_pci() in the error handling case.
> 
> Fixes: 70556e24e18e ("drm: remove usage of drm_pci_alloc/free")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_bufs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index 4805726..c23d7f7 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -984,8 +984,16 @@ int drm_legacy_addbufs_pci(struct drm_device *dev,
>  
>  	while (entry->buf_count < count) {
>  		dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
> -		if (!dmah)
> +		if (!dmah) {
> +			/* Set count correctly so we free the proper amount. */
> +			entry->buf_count = count;
> +			entry->seg_count = count;
> +			drm_cleanup_buf_error(dev, entry);
> +			kfree(temp_pagelist);
> +			mutex_unlock(&dev->struct_mutex);
> +			atomic_dec(&dev->buf_alloc);
>  			return -ENOMEM;
> +		}
>  
>  		dmah->size = total;
>  		dmah->vaddr = dma_alloc_coherent(dev->dev,
> -- 
> 2.6.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
