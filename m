Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBA324CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhBYJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhBYJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:18:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:17:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f12so678428wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xYVgNKYZnkO3UBX4MMId4voMW/i/bKSPJY8pF+VUUbY=;
        b=KuQP4Fdaew84KHfFyUTOZk66h0js+ph9/KOKdQCGQI834+m+MvDykdPOReRUuPvwfa
         FtWMwGCK2oD2QF67WL61he5z1eS6qNEU2DZogaRPy6QfGNUQaxTs018fVMDJSGyAoBdX
         Gav7attvyjihADlTxWK+x7Pffn/KFyRnJ2RXk9QrxOJS3r30Yb0nyNOOnoRHbClFR82b
         Ul1ZaJKSFgFK32poc0xqTFjyqgFBSPKBsjDNLbGheAH2I1RRo+OAnoRyQU9H+Or/2N80
         aJF1Q3ZmEVbJ3NslR+bxPcEfzAyVKGLk+e2h2CtkDVGsbJ7iIh3MoVxjBCWiIPWrSFPR
         zIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xYVgNKYZnkO3UBX4MMId4voMW/i/bKSPJY8pF+VUUbY=;
        b=eXJIjXlObkkl3957LaSGGfl5z5Ib4L87sV38w0+jUr7GW/TnB78c6JlMHcBkJkiFyY
         t45fjROKtCYmkGDthR4t9p/sIv20tiuuubMsaxFD5aR0KPVFl6xUW69CKdZHF86pWmvh
         qSPeUTcfAnH8RpZnOQgixpeRZm9Qp2BOezTOieiByocWsvO+kauOs4p120CQm51vWqnc
         nNe4iTMgicAhbe3gEIs4JacPjqriyV8lfU1v+ZiQZluP16/TSNKJJU/4K/dED/wEgigN
         eOYRkeOJqnPyEErPIZfTS8E7DV+4rBXtn0X8HUInqTzT8Rg/tHHZ3qOGhiL/LDVjBQOa
         5gDQ==
X-Gm-Message-State: AOAM530mddCt/us8/wNYo7lQWTli/YqAVtFxvxmf15Ik98TsXo1zKbcI
        EQ6vSbAwbBtojPNud78KB3FkXQ==
X-Google-Smtp-Source: ABdhPJx2/tTcgEFEDtUcpa1kS7N+8ZyLq4ix+srxq4T5kIK7+KPGURnKL2wk6Lff9ucshfSJ+fiycw==
X-Received: by 2002:adf:f6d0:: with SMTP id y16mr2415352wrp.351.1614244660343;
        Thu, 25 Feb 2021 01:17:40 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f7sm7365822wre.78.2021.02.25.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:17:39 -0800 (PST)
Date:   Thu, 25 Feb 2021 09:17:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, sashal@kernel.org, tglx@linutronix.de,
        wangle6@huawei.com, zhengyejian1@huawei.com
Subject: Re: [PATCH 4.9.258] futex: fix dead code in attach_to_pi_owner()
Message-ID: <20210225091738.GC641347@dell>
References: <20210224100923.51315-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224100923.51315-1-nixiaoming@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021, Xiaoming Ni wrote:

> The handle_exit_race() function is defined in commit 9c3f39860367
>  ("futex: Cure exit race"), which never returns -EBUSY. This results
> in a small piece of dead code in the attach_to_pi_owner() function:
> 
> 	int ret = handle_exit_race(uaddr, uval, p); /* Never return -EBUSY */
> 	...
> 	if (ret == -EBUSY)
> 		*exiting = p; /* dead code */
> 
> The return value -EBUSY is added to handle_exit_race() in upsteam
> commit ac31c7ff8624409 ("futex: Provide distinct return value when
> owner is exiting"). This commit was incorporated into v4.9.255, before
> the function handle_exit_race() was introduced, whitout Modify
> handle_exit_race().
> 
> To fix dead code, extract the change of handle_exit_race() from
> commit ac31c7ff8624409 ("futex: Provide distinct return value when owner
>  is exiting"), re-incorporated.
> 
> Fixes: 9c3f39860367 ("futex: Cure exit race")
> Cc: stable@vger.kernel.org # v4.9.258
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  kernel/futex.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

To clarify, this is not a wholesale back-port from Mainline.

It takes the remaining functional snippet of:

 ac31c7ff8624409 ("futex: Provide distinct return value when owner is exiting")

... and is the correct fix for this issue.

Reviewed-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/kernel/futex.c b/kernel/futex.c
> index b65dbb5d60bb..0fd785410150 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1207,11 +1207,11 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
>  	u32 uval2;
>  
>  	/*
> -	 * If the futex exit state is not yet FUTEX_STATE_DEAD, wait
> -	 * for it to finish.
> +	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
> +	 * caller that the alleged owner is busy.
>  	 */
>  	if (tsk && tsk->futex_state != FUTEX_STATE_DEAD)
> -		return -EAGAIN;
> +		return -EBUSY;
>  
>  	/*
>  	 * Reread the user space value to handle the following situation:

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
