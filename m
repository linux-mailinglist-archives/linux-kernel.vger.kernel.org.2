Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A093A3F4031
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhHVPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhHVPAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 11:00:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED97C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:59:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t42so10532332pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtofH/4/jYATs6D3O66/kVjkwIShCI9KUHIKJ5lCCCQ=;
        b=FppxUShmrv1HQlTx8QZBDRPqLPtReo25tMpskXxjbrkbA4X1jxuCaO4f6Jneu1lUsJ
         IdYXunWAD0daSap4XsBjkgT8GoEdcyeMjXonPXUCMkqLZSMPeXhVWatiGgJuHPEPX8P9
         7uxra4LgX1SoqkAwok8hnkAnjgVqNbQocISMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtofH/4/jYATs6D3O66/kVjkwIShCI9KUHIKJ5lCCCQ=;
        b=XjDD94VbRRuJZ7ZwElqemWNJRyKNqfx+CfQG70c/Ht9rkVHfUx/w7wdjVg8AnWij9t
         yqNZbt+RbNo+wkAb7sV7+i0qa8y+YZCuYWZJRxlu1qvoZJdTy36LRDnIL9be/sAZ/bMz
         By+5lXfObyE5RniTEOdkvs7XE2gZ1T4bcM3oT3SvKKgIb8cCTtaPr6qSaHT+jKc+m0Fz
         ShTLIKT5gnlL/ezxmQvPnzJseLtbKDIXx5oaVil9eScQw1yx7pzcM7kO7hVamlxWLk6Q
         NoihoHcfB2dUhCkpQHfa06uR9Tt2FmF37O+7Qfz/PLnU/RZhKao/7xuU6kev1jZOg5HC
         QUJg==
X-Gm-Message-State: AOAM532uUQw2Wu/2JQkUXsuu+0wx9VWETDsSDvto26DjnmjR9TUw/n6p
        cPWnOs0bW/tHfQH4/Ltp8mgJ7A==
X-Google-Smtp-Source: ABdhPJz24gydAFeYUmKy99MGb+xa3/haHNHNvNWd9CFYlv2OtlpJDxbQgxEgWQfqFeiqxwGK01QHjA==
X-Received: by 2002:a63:1247:: with SMTP id 7mr27588364pgs.366.1629644393320;
        Sun, 22 Aug 2021 07:59:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t18sm12779320pfg.111.2021.08.22.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:59:52 -0700 (PDT)
Date:   Sun, 22 Aug 2021 07:59:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] staging/rtl8192u: Prefer kcalloc over open coded
 arithmetic
Message-ID: <202108220751.4E6ADBA@keescook>
References: <20210822142820.5109-1-len.baker@gmx.com>
 <20210822142820.5109-3-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822142820.5109-3-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 04:28:20PM +0200, Len Baker wrote:
> Dynamic size calculations (especially multiplication) should not be
> performed in memory allocator (or similar) function arguments due to the
> risk of them overflowing. This could lead to values wrapping around and
> a smaller allocation being made than the caller was expecting. Using
> those allocations could lead to linear overflows of heap memory and
> other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.

It might be useful to reference the documentation on why this change is
desired:
https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Here and in the docs, though, it's probably worth noting that these
aren't actually dynamic sizes: both sides of the multiplication are
constant values. I still think it's best to refactor these anyway, just
to keep the open-coded math idiom out of code, though.

Also, have you looked at Coccinelle at all? I have a hideous pile of
rules that try to find these instances, but it really needs improvement:
https://github.com/kees/coccinelle-linux-allocator-overflow/tree/trunk/array_size

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
> index ff6fe2ee3349..97f4d89500ae 100644
> --- a/drivers/staging/rtl8192u/r819xU_phy.c
> +++ b/drivers/staging/rtl8192u/r819xU_phy.c
> @@ -1195,17 +1195,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
>  	u8 e_rfpath;
>  	bool ret;
> 
> -	pre_cmd = kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
> +	pre_cmd = kcalloc(MAX_PRECMD_CNT, sizeof(*pre_cmd), GFP_KERNEL);
>  	if (!pre_cmd)
>  		return false;
> 
> -	post_cmd = kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
> +	post_cmd = kcalloc(MAX_POSTCMD_CNT, sizeof(*post_cmd), GFP_KERNEL);
>  	if (!post_cmd) {
>  		kfree(pre_cmd);
>  		return false;
>  	}
> 
> -	rf_cmd = kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
> +	rf_cmd = kcalloc(MAX_RFDEPENDCMD_CNT, sizeof(*rf_cmd), GFP_KERNEL);
>  	if (!rf_cmd) {
>  		kfree(pre_cmd);
>  		kfree(post_cmd);
> --
> 2.25.1
> 

-- 
Kees Cook
