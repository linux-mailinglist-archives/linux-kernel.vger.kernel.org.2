Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A109C323B34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBXLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhBXLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:20:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:19:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h98so1489635wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y1amc0xUUDXKyMkYpBNAZwR5P9bhKoCJSS4XEZ56VYA=;
        b=OdI1Nh16csmUafIBo4cGakR3MV48vT6+emCMcit7JQ8pv8fbf09Pzu4qgDmXBRrxVP
         MqrSktI0jUbZV58GN5mmyAj/Nk9wJDerYysxbJ90AUNx+lniy7sBZP6sd9ZtgkblWGGd
         6GW7SnoT0vMzndPTdWB2Pt8+OgVixRhhdjf9D+cUDSdvp2D4lwctvN7XRC2LzJVR07Lx
         m8BViKyEJyo+5D3AbO01NLWbGPXdJupsDFQSd7MSA53huqr5wP+5IgWN4psSl88Wb72e
         aLjiAtfM1ws8K/9zMSjXGtA6/VPWMl3bySW8fsX+O/gQCudq6jdUeNuvetls6aSPKG9M
         wSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y1amc0xUUDXKyMkYpBNAZwR5P9bhKoCJSS4XEZ56VYA=;
        b=CB/zdW3Smi6yGoH1l2AYLpDMMc2cQBQ+asymNwli5Q6y+0RWaATLijCr26UwNRl8rt
         jchZ+DmzL9ApqkMJZEOqpXQ8QheGjM3DquCQGwybSFx0sOehrDmNzyy5yA6AAKMifLuQ
         lCFmqZqZgD/233Bmw7dbggOjlRleXn059vkRjY6+HLYTs2CqpQW6z7HDWN4/D2XQg84H
         JVcL/rF7LzHYlmHOJWyaLjni9BVYW0H3O29N4e563BXoLZgSVAbO4r9zeJJ9dkAUaNQ3
         E4idpsdE8iRSHDLu1zAGBxtlvGLiEo8ly2dIxhX40VQ9mwgaFcAOym8GOUmD1xNYUvqq
         Mo/g==
X-Gm-Message-State: AOAM530qxA/zlw5PJDQI0oB5iz+YJ7FGMR/bAPxq/t4sG3Pd7vpGQuBO
        yqi+etM1nxYtIAbFpnvOv2+uOw==
X-Google-Smtp-Source: ABdhPJzOx+OdbNolIfDYzohxY1RMg4sxN9tprKAWEdVYqQSYcIphGwY5yi8s5yDexEpWOJeed1ePhg==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr28828323wru.290.1614165557793;
        Wed, 24 Feb 2021 03:19:17 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id e17sm3583648wro.36.2021.02.24.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 03:19:17 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:19:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        cj.chengjian@huawei.com, judy.chenhui@huawei.com,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH 4.9.y 1/1] futex: Fix OWNER_DEAD fixup
Message-ID: <20210224111915.GA641347@dell>
References: <20210223144151.916675-1-zhengyejian1@huawei.com>
 <20210223144151.916675-2-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223144151.916675-2-zhengyejian1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021, Zheng Yejian wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> commit a97cb0e7b3f4c6297fd857055ae8e895f402f501 upstream.
> 
> Both Geert and DaveJ reported that the recent futex commit:
> 
>   c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
> 
> introduced a problem with setting OWNER_DEAD. We set the bit on an
> uninitialized variable and then entirely optimize it away as a
> dead-store.
> 
> Move the setting of the bit to where it is more useful.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Dave Jones <davej@codemonkey.org.uk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@us.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
> Link: http://lkml.kernel.org/r/20180122103947.GD2228@hirez.programming.kicks-ass.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Why have you dropped my Reviewed-by?

> ---
>  kernel/futex.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index b65dbb5d60bb..604d1cb9839d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2424,9 +2424,6 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
>  	int err = 0;
>  
>  	oldowner = pi_state->owner;
> -	/* Owner died? */
> -	if (!pi_state->owner)
> -		newtid |= FUTEX_OWNER_DIED;
>  
>  	/*
>  	 * We are here because either:
> @@ -2484,6 +2481,9 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
>  	}
>  
>  	newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
> +	/* Owner died? */
> +	if (!pi_state->owner)
> +		newtid |= FUTEX_OWNER_DIED;
>  
>  	if (get_futex_value_locked(&uval, uaddr))
>  		goto handle_fault;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
