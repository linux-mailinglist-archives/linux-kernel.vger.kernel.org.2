Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89247426593
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhJHIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJHIGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:06:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E605AC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:04:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so2380861pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DeR+7GpxoRNUeEEHb8NPT+aLj2hVPbRU+o+5A+ubwxY=;
        b=zLv6nQYDKZUUtInR3WJHKXsy4Y1A/g/9Mz6q5bx9kMIsQYh6ILwVmKsF/mODixybVq
         7kO2p8iQgoiCTaZulwnfs+HtqSXrif8GMnIRtQNbYXfPEmzZjL3sK+M/bfZUS4cA5wCw
         C6PFMiS9rFy4GK6r9dPDAu7mw2NOPnjZ9vSM0Mxbc5noBCzfYQOn7GvizJCpkRQEh0Rh
         K/O554ZOnNxjyYTFTyA9YVIb+dRdAuY4jjFXsWc8aQJNBvbAkHBoZx938+HywV+4a65W
         Fd/V/dLGyPeb48ceXx5FKMe3Xv07voqSoqvOYsNjVwXUd0PyyqTuL4b1aX83t5hPr+t5
         5AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DeR+7GpxoRNUeEEHb8NPT+aLj2hVPbRU+o+5A+ubwxY=;
        b=sxCkGSGU4YM3V4e8A3mS+7jGvEBJaZQJado4EQpYnBP414ikdn5IWyhQb+UqSH3i1A
         1jJjemu9b5Htyslb0zrMdPYwoaygw8LzmXoI3D4vbPQdlf1n24zUgEy6K3KMhVm72GYB
         qXW7Suj8BC/b9sRRRLypD3IAapIQEwtIgHdUDlTdAG1bIE8F0eSl440+3lkO2ERhsuwb
         gUJdKLokPqRY8CQFYcH34zPAtGy9TyKkVFgwkHwlpfANZN6xQSvHYetC8zoeWeb3JIrx
         ncqj03Fz0abADU4A4rpLBZrBMw78S+DcfaTtjBVmyy9DA/rgeCVd89j+hGEle2cE7Hb6
         OHRw==
X-Gm-Message-State: AOAM532tVOHcvrgYjVh1PL8+3es9Sa6IWzERbEO3jeqYi7dKMSdlLUMd
        QR1aHzdSY5Rb6JmQ68cfpyiIBA==
X-Google-Smtp-Source: ABdhPJzr4I6xc19o/8fwfjqRfCs10YkJ2fyHtm6ad2iEzH/RHLsk929ajPNe2U9vqIrvsEM7U+Ji0g==
X-Received: by 2002:a62:6206:0:b0:44c:bc1f:aa5a with SMTP id w6-20020a626206000000b0044cbc1faa5amr8402640pfb.5.1633680288225;
        Fri, 08 Oct 2021 01:04:48 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id g8sm1781289pfv.51.2021.10.08.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:04:47 -0700 (PDT)
Date:   Fri, 8 Oct 2021 13:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, d-gerlach@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] opp: Fix return in _opp_add_static_v2()
Message-ID: <20211008080446.jppjpwjliwdotk3h@vireshk-i7>
References: <20211008074652.19700-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008074652.19700-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-21, 15:46, YueHaibing wrote:
> Fix sparse warning:
> drivers/opp/of.c:924 _opp_add_static_v2() warn: passing zero to 'ERR_PTR'
> 
> For duplicate OPPs 'ret' be set to zero.
> 
> Fixes: deac8703da5f ("PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 2a97c6535c4c..c32ae7497392 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -921,7 +921,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  free_opp:
>  	_opp_free(new_opp);
>  
> -	return ERR_PTR(ret);
> +	return ret ? ERR_PTR(ret) : NULL;
>  }
>  
>  /* Initializes OPP tables based on new bindings */

Applied. Thanks.

-- 
viresh
