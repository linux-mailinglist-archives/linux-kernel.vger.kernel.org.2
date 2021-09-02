Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D723FEC32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhIBKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhIBKfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:35:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:34:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n5so2090579wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wv3yG8UonDy2C4uqmvlaNx323WtksVFXoFNswtxsVYo=;
        b=Mko8j91K9w3jzTvp/k1lQBtZGMhGwDuY4cJRhKuSj25A0k+y9tZqD8tQg6FNrO/VlR
         SOfSGFKbEfzCCH34WdDMZSgLb+dEdHWb5xRlCFKrEgp2llsiWqY54pbyLOlfTcKvptrC
         167GOyjDQDkTWb5+5UCn9ojwYdQu3mkBAhvuVTx6MmI7Ukl/IbJ2zXZviIUMp+/uhUyW
         aPzfZKLa6sgh0adSMKqG3fFG+evqOkiasO5iymtHk/2sijwfkOojjicBVDT1VGlEfoma
         LZwLMHRtEcrQn3+hbfAD2ealCxsPvH24qVX+X3RJwnhUUrgCLRyWwreQFcuKOcOgkB4w
         3evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wv3yG8UonDy2C4uqmvlaNx323WtksVFXoFNswtxsVYo=;
        b=oQlipPyGx7iARMhp9PnfNkaSt7Cmx281PtWJmuy5hzF53nGNnpgjXJe8V4pQ8iYay5
         E7eTRIJ77Q6wizU7TPB3KSZ0Yzo7ynDp5FvsJ23lnlwKh303EAnx7ZJCKInj/9uJlIVg
         7ITcYhKfIO5uMTpVEBu329hMK+99sJc4JeEnKjzlVfN33j37V3E9wPSuieoHO2g9ivdF
         oPSOJFDi+X0Nkh7/CQAq9VPHdU3eYzRqtlCNjNRV5W88qi+gXCRMfo5LpepU0cVaXEQO
         DODxOrfB51d3zTTJDmXQAU/MQzOItT+PJ0z95Enh6iNi9YwBaUgBIaypUp8MC1IVRTfo
         vc6A==
X-Gm-Message-State: AOAM530UpFPcSDtA6mLNrL4FLkWj1WkBo9mDtYG7xMw5rNLgYK7sF57E
        ilZtW9ZS4yRhUey2H5Bwz2MA0Q==
X-Google-Smtp-Source: ABdhPJzvh7l5ChueJQNe8tX9Ar/+xf4A8tcDgDgCNZTRKD7GYHFcDwgGJhfRjRCjQvHnZD+kqja2IA==
X-Received: by 2002:adf:edc2:: with SMTP id v2mr2860902wro.255.1630578871371;
        Thu, 02 Sep 2021 03:34:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g1sm1516409wmk.2.2021.09.02.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:34:30 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:34:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof
 to pointer
Message-ID: <20210902103428.bdbkybvi6he6mgy2@maple.lan>
References: <c66fd6f831571b53b741350513e36405bba6c666.1629211976.git.jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66fd6f831571b53b741350513e36405bba6c666.1629211976.git.jing.yangyang@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 08:21:27PM -0700, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> ./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to pointer
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>

This should not affect code generation since both pages and *pages are
pointers but the change looks good to me.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/tee/optee/shm_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index c41a9a5..d167039 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -35,7 +35,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  		unsigned int nr_pages = 1 << order, i;
>  		struct page **pages;
>  
> -		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> +		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>  		if (!pages) {
>  			rc = -ENOMEM;
>  			goto err;
> -- 
> 1.8.3.1
