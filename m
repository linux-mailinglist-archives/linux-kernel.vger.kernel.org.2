Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4239766C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhFAPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFAPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:22:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:20:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d5-20020a17090ab305b02901675357c371so1292312pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CI70r76BFSMLECFKgdAL+NAIKpF655i5q5eYzPA3DBE=;
        b=VL5NQ+ydqfqna6gCPcvruZpvNX5YuLzsffDzlEkVpJn1oDqpiPVlhn8Nx/6yPvO/D+
         TsLHVzsUhAmhGmY1eN+Amwc8eyh6+2AYFTza/Jpq7NchNg6xucxd5ApynRO4TQ0RnPA6
         gGmswxJa4EKDl5q6KRSmgJAwJB0oIX4cuAVxh49o09WnvFwcWDC4iD3t6FjMn+vUXNxb
         hCQ/5PTNO5JXCdmgbAFBWLa0MwTIIZcOdnaLb1vkG4ehrUQeQUU7chxBQgSVeE6iideR
         LZ2sWMtADn+vEk8XM4v91QwXyWB8cv/oTNA9dCvRFw7CaqIQs5TY5LdCehwXSXuyPOab
         LfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CI70r76BFSMLECFKgdAL+NAIKpF655i5q5eYzPA3DBE=;
        b=rZ80eUG/Z35tM2Xwz3lhTYSRxe8wq55cJD7OKLegtlRmngtHRg/xIzYpI5L5c5j31i
         Vg/LRHyLcn32wQ/BcJ+IM2x3oyo9KrKJ7cBnd2l7U/v7rb3TGKdBlRr93vl76yASaXJI
         evc8TUvts3jI7Hj/Cd3l8PjFiNdPYK7pU7SVK+GkfciuIYJoxGGbLU8qgAqt7sWA3cij
         Z17GBGfh5OKVcA4QXycwDc0NCkLE/Wky+WqTUDzGIFD6SWxUgW35qxZ4ir5d1HoLVcFL
         FBtc+hw6bi/3eFfro/QkI4Ribidrf0IGFEk7Vs4qV/hxVe9WSFI7O5bpBVWDQ0YwoqIQ
         Qrnw==
X-Gm-Message-State: AOAM532I7wNUYFWicp5G0h5UMauCZRxVNMr9+WEfHE5l0w1ZlUhT3tSf
        Y6CMAL+loHHTNHGQZPPNwrwJKA==
X-Google-Smtp-Source: ABdhPJzAU8nJgjyhrVqMPVfny+5INyvMfkAT73Y3iliTdWDwQ45JGkq4egRpyOLVb/pN3d0ogBvuUg==
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr25893852pjn.66.1622560850293;
        Tue, 01 Jun 2021 08:20:50 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 125sm13243467pfg.52.2021.06.01.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:20:49 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:20:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] remoteproc: pru: Remove redundant dev_err call in
 pru_rproc_probe()
Message-ID: <20210601152047.GA1759269@xps15>
References: <20210601083100.130776-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601083100.130776-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:31:00PM +0800, Zhihao Cheng wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index e5778e476245..6491c731c6e2 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -822,8 +822,6 @@ static int pru_rproc_probe(struct platform_device *pdev)
>  						   mem_names[i]);
>  		pru->mem_regions[i].va = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(pru->mem_regions[i].va)) {
> -			dev_err(dev, "failed to parse and map memory resource %d %s\n",
> -				i, mem_names[i]);

https://patchwork.kernel.org/project/linux-remoteproc/patch/20210511120426.5834-1-thunder.leizhen@huawei.com/

>  			ret = PTR_ERR(pru->mem_regions[i].va);
>  			return ret;
>  		}
> -- 
> 2.31.1
> 
