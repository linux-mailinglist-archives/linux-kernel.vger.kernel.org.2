Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54FC38CAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhEUQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEUQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:12:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:10:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x188so15237107pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ihp+ytTiUWgyI29GTYcg+5bxVmDMKZK1zsaXkk3K4xE=;
        b=p2tBg1d9u/a3/D4ni57yw6Qr8GncJ0y7CdjDH308OVSvY/9/JJLSnbtj5AiTlJztes
         HHHW/CtPYfQDSeOURZwbfnOoeFiCBsrJruqgDTN+N1YBeYvWz+B6NQPM6KGS/Ac2fwfC
         RtjZz1CkZr0QvdxDey79m51T7EOznEYxc4nUUG+qZr9gf3cmV5L9fUxnNQR2f6/s+eHd
         5qfUiDUxZwWH2djNBMGeWdDSZWMrsnfy09Stf3O1hSYGKVK34O5+ms9IDGNR1VkdWz/E
         3JllUJiQ3C5Gf5tXqdgw3ULARPsG/uupOzCKRMdXG6BYLehdFF7dVHYgY6hMw4m/EBcI
         9hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ihp+ytTiUWgyI29GTYcg+5bxVmDMKZK1zsaXkk3K4xE=;
        b=qSz4vDAEPDCg75SGpTa5Vjb7GuUjDTIWGPPvRz3s6mS34ZQs+rAFTQxpvypL+ejECV
         VbOqCB7OIhXh/VJJbVz5aOzcNYSucF9SY466y6aN4sacPWo9FjgXd3wgn7KEj7lg6mAQ
         KfNfZQmk+rfqZ1fFmxRUAVBGvI3HqW3r/s9jC2yeK0CxI8bf4sa9ZcWlnkpjgQqEbA6D
         nK5T6UBpsjNdmqiW3viuO8x6RSusomMfyNQ/39rScZMQPDNedU8YOfx0gR7gQlFqYphe
         rb+xz2aJ9LKZB1ejnCyvA8Z0BbkZnvvY1HdkC+3Powr0eZvAFQsSxuAWTo3ef5Dm5vXa
         oBCA==
X-Gm-Message-State: AOAM531ZnClPl5PhwXj6HIhl1NPq5qQDzciVCVELMUtPSx4fX5ORM96/
        ev8pgy2VrDDwZmNEL1MGYXxCnQ==
X-Google-Smtp-Source: ABdhPJyKjFkdsHzy5Q4L+90L82Uu4TBusygqvXkQ96AYJo3A0jmoD68prbWof+A26qXxLMlLGxOChw==
X-Received: by 2002:a05:6a00:224c:b029:28e:6004:d0a5 with SMTP id i12-20020a056a00224cb029028e6004d0a5mr11014805pfu.1.1621613447355;
        Fri, 21 May 2021 09:10:47 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s8sm4723599pfe.112.2021.05.21.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 09:10:46 -0700 (PDT)
Date:   Fri, 21 May 2021 10:10:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 1/1] coresight: core: Switch to krealloc_array()
Message-ID: <20210521161044.GA997016@xps15>
References: <20210520135041.56163-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520135041.56163-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:50:41PM +0300, Andy Shevchenko wrote:
> Let the krealloc_array() check for multiplication overflow.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6c68d34d956e..a7971c68b0be 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1730,9 +1730,9 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>  	if (idx < 0) {
>  		/* Make space for the new entry */
>  		idx = dict->nr_idx;
> -		list = krealloc(dict->fwnode_list,
> -				(idx + 1) * sizeof(*dict->fwnode_list),
> -				GFP_KERNEL);
> +		list = krealloc_array(dict->fwnode_list,
> +				      idx + 1, sizeof(*dict->fwnode_list),
> +				      GFP_KERNEL);

Applied - thanks.

Mathieu

>  		if (ZERO_OR_NULL_PTR(list)) {
>  			idx = -ENOMEM;
>  			goto done;
> -- 
> 2.30.2
> 
