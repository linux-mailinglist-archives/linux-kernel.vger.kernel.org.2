Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3146732A3E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577745AbhCBJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378980AbhCBJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:33:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B6C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:32:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u187so1612492wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rB2YZeVlRiIlBiMUFP2Kr4sxgf0LrsKz3i54nx6Ay6o=;
        b=RMsllFuLz6x37Cff5WrzhbX/UZNE/mdFnlhIDxWKC+EfX0FLaZDDGw9F4qTMOkQ6jK
         41tu8QoyQFQKFYeLaq5EPXHss9T7DCnl+XYnykFgdc1JfT7JRiUzM0nfQFtjtJbi3DFt
         hhcYy6seW+ALaBscWWdn1HIHX7IEE6RzfMn0k0D8JuODPId7Go1xos47xC6ZBfPFHfMe
         IxM27JQrI99tVe/oMHMKq/xVP4RX+cXz101Y1zT4VfXoxwPxfjTeyMYDJsGxaMSw5bDC
         CQG45KlbyvldLIEFZdF3hZT0baSLCSNNVYQxs/IrrygVWGuVT/UMb0a5/u1jRe00i5L6
         qTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rB2YZeVlRiIlBiMUFP2Kr4sxgf0LrsKz3i54nx6Ay6o=;
        b=qc7ZfYLjqz8Slv1bt+yFoGsfW4GPFgs/V7lWat4Y/abwcvYDIB7AlseIPJTriHk5h8
         F/4X/pCzrNmCJ3rkzkeDS1iSPrRDZq2iCtCDd0Bk7Sak4V4a7EGlS8lR5VkpFwru/81Q
         udkv8meFIgCo7VlYgbG+2zTbVokmkUL1vhn0L4mhL1WRcaOmUjRzMOAki+0eVyskXfFY
         Di9RNj7IiUdeZc7o1lSR29FyR5KIB+L1BPycLPVtNXy2UA7Ldwm5GQFJL8VUKoKJo2mb
         njAmjPV4aawc7fZekwZciB+eDw0Eu9WmSPLDYpbCnga9aCR7/f1GOD3FVqDUdU6j0enf
         Hv9w==
X-Gm-Message-State: AOAM532RU534jGerI/qbWzggqe3RWXCj548U56y7KcmNcFkqc6ls9G05
        pbapjuUcnJbqBVKAS5zqIjkn3Q==
X-Google-Smtp-Source: ABdhPJwG80JoyvyxkHTYyAHhEKLJZ6ht7ktKkW1BHHvyT/PCYlyYaYE0GAo+Do5MTN8APjQxzhVAIQ==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr1922350wmq.60.1614677545697;
        Tue, 02 Mar 2021 01:32:25 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id m10sm1971133wmh.13.2021.03.02.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:32:25 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:32:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 2/2] RDMA/uverbs: Fix kernel-doc warning of
 _uverbs_alloc
Message-ID: <20210302093223.GB2690909@dell>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302074214.1054299-3-leon@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Leon Romanovsky wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Fix the following W=1 compilation warning:
> drivers/infiniband/core/uverbs_ioctl.c:108: warning: expecting prototype for uverbs_alloc(). Prototype was for _uverbs_alloc() instead
> 
> Fixes: 461bb2eee4e1 ("IB/uverbs: Add a simple allocator to uverbs_attr_bundle")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
> index e47c5949013f..3871049a48f7 100644
> --- a/drivers/infiniband/core/uverbs_ioctl.c
> +++ b/drivers/infiniband/core/uverbs_ioctl.c
> @@ -90,8 +90,8 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
>  	WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
>  }
> 
> -/**
> - * uverbs_alloc() - Quickly allocate memory for use with a bundle
> +/*

Why are you also demoting the header?

It looks fine to me.  Just correct the function name.

> + * _uverbs_alloc() - Quickly allocate memory for use with a bundle
>   * @bundle: The bundle
>   * @size: Number of bytes to allocate
>   * @flags: Allocator flags

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
