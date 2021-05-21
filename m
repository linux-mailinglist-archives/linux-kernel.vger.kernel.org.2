Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED538CF89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhEUVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhEUVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:02:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF2C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:00:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so20929030oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKJQFlbNOnxfAGQolBfqaP4S93vmXU/qq5oY6hR9n1Q=;
        b=RjfImzc3yEqSNWVSTW+M+5GM8IRvR8LGvYvFTIDYohws6M4npb6g0yObp24DV8bAsx
         6IZ7BCPUPy/6p8wVkXGMWQH6Y4Y0s+g8ygnucYQ5zuX1+ar8nWKxVsWFEC2ooPQqQly6
         nYX20pdXcizipg+pGJv84uAjE4k5e/Dsizk9Jr81Cz8dpMBZbtDNJF0UrAhvF9LpW+cG
         BXXFlYcz5k2ghZYde2AdUMJbG7QuRuM7Ym16jGaD6IqSDR8ZWQT3/vMgkDSGpeuDR8wp
         zj03M1p+Zjuz95c4YT+Y6XrxmG3BN45Givi17zY+fRitQ4q9ptlyAD+V7PWhQ/HBDmEl
         1QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKJQFlbNOnxfAGQolBfqaP4S93vmXU/qq5oY6hR9n1Q=;
        b=LEQzX+NlyO8Rb93Od6/ugKOHaXQQrrhakTSlfXBpTUGUA/lF3CeZlnh4TXdt6aXcbT
         taQyHOuk3uI0Kafl1Y6vBCUGNbgoVJuV8z/EVgp9wxuLtAVQMZaA92q+3W3cPq+H5M7k
         rhA7Khk0mgNTscAJpRvgoKatEz9l0xrcYqb6Y4T9wzLtWeEe7p3fqB+PDZMqUlO3aCwC
         7m/sOVyYGksTJ/UDCr9VsElUvZVErobEg/BOWU+86phQKfVhyXM8IQ7wZv6Rl9KVrq0t
         OpM/Kg+Dj1t2YK6qr8DlTlfRhskBssluTngz6WDAzEBnX2ruwNoHAKsYdEKAwtiAoUb1
         VXNQ==
X-Gm-Message-State: AOAM533KfFToPUH6AUdF5RhrTlTaq4UvqkZK+0iVz7mdYH/3lakoRn2G
        tQh3tE8tAYUMTeF6LaYxIq79YPTWn2wB9oRTqtQ=
X-Google-Smtp-Source: ABdhPJxuNzb1jvwtxFKbIpIcb34axGi0g9DbxLQSom5QwpOqZt6As4f1VD4LfCN8dJD2J8t9FfrXA30UJziLGvl2PFE=
X-Received: by 2002:a05:6808:1592:: with SMTP id t18mr3525887oiw.123.1621630835378;
 Fri, 21 May 2021 14:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210521150212.2076151-1-linux@roeck-us.net>
In-Reply-To: <20210521150212.2076151-1-linux@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 May 2021 17:00:24 -0400
Message-ID: <CADnq5_P9C71cc0Ua7cSYwkTPgY_YDXBOw-==XtXQCH+rxgW9Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Drop unnecessary NULL check after container_of
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, May 21, 2021 at 11:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The first parameter passed to container_of() is the pointer to the work
> structure passed to the worker and never NULL. The NULL check on the
> result of container_of() is therefore unnecessary and misleading.
> Remove it.
>
> This change was made automatically with the following Coccinelle script.
>
> @@
> type t;
> identifier v;
> statement s;
> @@
>
> <+...
> (
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 5b6c5669c03d..2f8d352e0069 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -110,8 +110,6 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>
>         workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
>                                 sdma_activity_work);
> -       if (!workarea)
> -               return;
>
>         pdd = workarea->pdd;
>         if (!pdd)
> --
> 2.25.1
>
