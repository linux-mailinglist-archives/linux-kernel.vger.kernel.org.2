Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B492D32A3E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577732AbhCBJwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378868AbhCBJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:32:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC7C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:31:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l22so1626868wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=duqySNS7K2RXV+A+no11hnCWpUd9p0lgrM9odevZ3Ko=;
        b=KybiIHEHfVSg3YhOS1sOgCd+YntEv3ioQBT6wh7u/BT45PH7GWuqA/X23Y58kK9uqv
         6In53BefBhjfG5PWhh+8ykxb+dkd2NB96/fqfr5bsCa3F56syAj2XgWXR1U+riEuZIBK
         XLg20tRKCRtnlIkXl+yyesmt3HuYnd2N/SRHFpWm/k7aFk68CONLlnhXXMSa5T9aDpKy
         5jSWLHwp+w67XhmEtTS0iUnmBst6SHL6vQEfshvOeauqCwfLeWrGRkF2hhdEBd0jC8H4
         Kz7nfImcRvgBNavSpFSs8Jz63S025faWMvwgTRrcBvTtVfN0h45L9XyCascOfBa479rK
         LAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=duqySNS7K2RXV+A+no11hnCWpUd9p0lgrM9odevZ3Ko=;
        b=erimcoYsDBPtWjh5KriwHslfRVpdhkuz1ZolO4/rxoyFwyKaFmMZ5p0vsEk+AjGvQk
         /COzFkE59CXbeh/Ey41ozxImM4V6zc2Dh38vqM1NVH5VBSZM5asbMQDobI2tRfiXJcWz
         8s1oBj/T962FcRr63vIY+VJ67vwHUQIf+9lwtvthpPNVke7UViLKWuYHCP02BCHQAIi7
         FuoXCoXHeTDA2G7pv7ibtO5P77hjV2jOAGbSIRdyXLzucfIfTqsDDKMJbBmBgMWYwsSv
         cuvRBEO7gEdqRBWLLPBIw4bhRaKBpqnf4/ZBki4rKDc+e5VL6urGok0EJFwpIZN1O9bU
         u6Uw==
X-Gm-Message-State: AOAM533u4SEg3lCy1EgQ1yZh0wF9c7SWHVjxrdWzsxlhU1X1lz6DFVFD
        xnHX4hBty6hvGM6NfF6r35HLYw==
X-Google-Smtp-Source: ABdhPJxIml2cSRQmyrAOS0vFHxqQG8C+95GOs0WSZY9gEUVuk5drR143w/v2r/4g0i7bWLO+GtoX+g==
X-Received: by 2002:a05:600c:49aa:: with SMTP id h42mr3132506wmp.49.1614677472184;
        Tue, 02 Mar 2021 01:31:12 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a6sm2557430wmm.0.2021.03.02.01.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:31:11 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:31:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 1/2] RDMA/mlx5: Set correct kernel-doc identifier
Message-ID: <20210302093109.GA2690909@dell>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302074214.1054299-2-leon@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Leon Romanovsky wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The W=1 allmodconfig build produces the following warning:
> drivers/infiniband/hw/mlx5/odp.c:1086: warning: wrong kernel-doc identifier on line:
>   * Parse a series of data segments for page fault handling.
> 
> Fix it by changing /** to be /* as it is written in kernel-doc documentation.
> 
> Fixes: 5e769e444d26 ("RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index 374698186662..b103555b1f5d 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -1082,7 +1082,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
>  	return ret ? ret : npages;
>  }
> 
> -/**
> +/*

This is not the correct fix.

Kernel-doc is asking for the function name.

>   * Parse a series of data segments for page fault handling.
>   *
>   * @dev:  Pointer to mlx5 IB device

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
