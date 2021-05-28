Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9D393C48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 06:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhE1EUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 00:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhE1ETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 00:19:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607ADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 21:18:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y76so3029900oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0XNV7usCBQG7IKqGs/iEc1hnq8nlSXpsmXeWkLciLkE=;
        b=ZoRswZ4gYO5MnCJ88IP2JhKPZ8fO6WhxSgBjAiVca0fNYJBj/jzjMzYUuOTdvK9mw3
         Tl+mX6YUr1/AD95KYCUrjy2sUK2ppsKhZoH9pzZCsSpI60D2qqwFQEmJuaIhc1Nv2/qv
         79qbnIwRA/rA1/07BAkzA4gOaEHPH2XM0DOTqTbetbUzj3FcQ0EfshIMBsQ5U9KAdjcI
         dLx/+bydYXUUVmjhZ1WsACuWXwqc/uDATP6l8e8j/8Ke9ze0L/CIb8c5RDOKratFcsXV
         NyoCWtQq9RDzWcxERbD/2kgj0AHRFNbB3yJEoHoadOzvLrm4QD52k8fix1V3u9j/DPIE
         qoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XNV7usCBQG7IKqGs/iEc1hnq8nlSXpsmXeWkLciLkE=;
        b=O1Hre8AhQ+HwEuVCwzrHZGQFdQu91ajNxZtZQ4EdSe8TpfdVdoiKe3j4T3aHX5d6Uz
         1ngj9YmikTSsnETvGUAksZRm11C0CGnJGIP0RNFCsWwSd9l+Gu9lys5eDMjXvF88Hg1z
         H86XSpDBZDIScs95NqPnaLLG5u9Z9wXSpZob6IOA6nKo4d8+C34TC3Aub6zja34vPq6f
         wZ24Ypeynf6JGjoIcyWYrEGYNSlcJYPEBa3PYbvG8D6C7HY6bZrOarfZyPr63l0rYh1u
         2J58x3+4vsChOTclaEdu9hJrOl57O23Uy4kHiPTlM0eeqBTyo4U+AQkECkCeQSWXRbpd
         NU0g==
X-Gm-Message-State: AOAM533qLFdTqjsoOBGV1jIRgSaZtVjuBGIb4htwZ4ox0iP6xN/Qgx2w
        /VfjiaP4TbKD1yMNzh5aKuYUDA==
X-Google-Smtp-Source: ABdhPJxlhovwd28C6GM3k2GPbbSWUgsfHo25XhDhYVqc6DmhQitfLBWlCfFpxRWzcFWfCurnpVr5tg==
X-Received: by 2002:a05:6808:7c1:: with SMTP id f1mr4620540oij.142.1622175479598;
        Thu, 27 May 2021 21:17:59 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v18sm870619oos.23.2021.05.27.21.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 21:17:59 -0700 (PDT)
Date:   Thu, 27 May 2021 23:17:57 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] remoteproc: Introduce rproc_detach_device() wrapper
Message-ID: <YLBu9Wr1vNiwsfWT@builder.lan>
References: <20210522000309.26134-1-s-anna@ti.com>
 <20210522000309.26134-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522000309.26134-2-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 May 19:03 CDT 2021, Suman Anna wrote:

> The .attach() rproc ops is invoked through the helper
> rproc_attach_device(), but the .detach() ops is invoked
> directly at present. Introduce a similar wrapper function
> rproc_detach_device() for .detach() ops so that the code
> is symmetric.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 2 +-
>  drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6348aaa42bbb..6019f46001c8 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1869,7 +1869,7 @@ static int __rproc_detach(struct rproc *rproc)
>  	}
>  
>  	/* Tell the remote processor the core isn't available anymore */
> -	ret = rproc->ops->detach(rproc);
> +	ret = rproc_detach_device(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't detach from rproc: %d\n", ret);
>  		return ret;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index a328e634b1de..931d50b6a0d1 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -121,6 +121,14 @@ static inline int rproc_attach_device(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static inline int rproc_detach_device(struct rproc *rproc)
> +{
> +	if (rproc->ops->detach)
> +		return rproc->ops->detach(rproc);
> +
> +	return 0;

I was going to complain that this will silently succeed to detach a
remoteproc when the driver doesn't implement detach, but then I realized
that in the current code path we just failed if it wasn't set.

So this only becomes a problem if we're out of sync between the wish to
detach and the implementation of detach, in the later patch.


But based on this, why do we allow rproc_attach_device() to succeed even
though a driver doesn't implement attach? Could we achieve the symmetry
by going the other way?

Regards,
Bjorn

> +}
> +
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> -- 
> 2.30.1
> 
