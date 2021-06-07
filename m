Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2D39D581
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGHBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:01:22 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8AC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:59:31 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id c17so9137977uao.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8go6xRc0aBiej5IJzY7Bxzao9xX1kdd2uVB1Pbd1SXM=;
        b=N7zNnuWp7VyoRUAqAcO7Ei/BilDAEcsV4rQxHdVqm/Aw2lAQCN+fVjcP0TzxN5QYlD
         /mNSccs7mIgXxjkUjG145KToYQk+2UaH17TNcDWl/D5pUdU9fBu8Zr+Oliqz+W1HaOVT
         8SUvRROEiXLOh9X0Zgfa/5M0TEu/rrLBaLxmA91LUQ9oetMyGD+0aZ9TNYad+F4EUv18
         UT3o/IIj4x7Vd/dqCKjXp/5I/twXikVVSIOtscACaROzTGszgnBZM/L5WFpgnd+GDlJ3
         98XgsQc3F54ENtZo/YsrOUqsI8JbrE4pl2wkafZLDfEyi8HMXi8C7yvNruSVFnzDwegl
         XfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8go6xRc0aBiej5IJzY7Bxzao9xX1kdd2uVB1Pbd1SXM=;
        b=L3CQ4hPhG4HWWreElLNpkF4idi/myK/4FZS+ToTP/lRPbmI0wJvcVwLj4KXzCssdF5
         LKSpoV0t5XBHpeCnADtQcfvasNKo8QTQErT9Qedwp4y+r9F/M4nW0xOysheRX/gq8/Tn
         3MyyWNXQKmZB6IVzb2ZVSNGghpLfDwruEKQRcJSloKi8E0vf1VL1SDaJ5eM7vC/CjHDA
         sNc8ZdIQgndyiFdbkwfTkxvJ3ltyzK3rsFXisyMJEFKtEpdSnbjDUjC73GDtCJVPmdq8
         WxxXUqZeg+pQkQ+Rl9vkGLPQo96Ovqr5Dal4z88Wwgi7YCWHueErpqFP62ab6VTXkJZ5
         J0Wg==
X-Gm-Message-State: AOAM53141KkyM8WNiKtT4LgYrTKpUVrMCUD55id06fWutAOfy8VaWd/2
        kfz3tVGw3py3vSz6ZBeqRDxB8g6tB8vafhdbq5Q=
X-Google-Smtp-Source: ABdhPJyn0G40vkF00f9FMmTSW2dXYgPINXqDM6wh1HjEyCrjt75uPki5UekC7UymRHTOGBv5plEYJABxhWmGeylXfCQ=
X-Received: by 2002:ab0:1464:: with SMTP id c33mr8016762uae.118.1623049170722;
 Sun, 06 Jun 2021 23:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210605121838.8357-1-bernard@vivo.com>
In-Reply-To: <20210605121838.8357-1-bernard@vivo.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 7 Jun 2021 08:59:25 +0200
Message-ID: <CAH9NwWdKvX3SN=StUMRcmavvOwoMotjkiVzrWxrJutGEe+Ha2w@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: remove NULL check which is not needed
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 5. Juni 2021 um 14:18 Uhr schrieb Bernard Zhao <bernard@vivo.com>:
>
> NULL check before kvfree functions is not needed.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index b390dd4d60b7..d741b1d735f7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -80,8 +80,7 @@ static void etnaviv_gem_prime_release(struct etnaviv_gem_object *etnaviv_obj)
>         /* Don't drop the pages for imported dmabuf, as they are not
>          * ours, just free the array we allocated:
>          */
> -       if (etnaviv_obj->pages)
> -               kvfree(etnaviv_obj->pages);
> +       kvfree(etnaviv_obj->pages);
>
>         drm_prime_gem_destroy(&etnaviv_obj->base, etnaviv_obj->sgt);
>  }
> --
> 2.31.0
>

Thanks for the patch, but there is an other one queued up in
etnaviv/next that fixes the same issue:
https://git.pengutronix.de/cgit/lst/linux/commit/?h=etnaviv/next&id=7d614ab2f20503ed8766363d41f8607337571adf

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
