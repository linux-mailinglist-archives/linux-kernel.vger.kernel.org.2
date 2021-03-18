Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02A433FD90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhCRDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCRDKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:10:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BBEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 20:10:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w195so853393oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 20:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQttFW1C06IjLp+yLCYHr9yAyp/8boQfWdvRpg9aqas=;
        b=j+V6eiKGG2VjOHFs8wnpC7+raQP+TbyQPcX/6o2YbdbGSLuXoq9j8nK5IOJ4GR7YLR
         4ZFjt0pkrCHiOqgnq4XsWKZDsUYRRiV6NrcrBDMGWkZZALNumhET7LpOI4/X84/Kvkqy
         0rSSY2rgqIVKepPCYfvyYsV7IUAjHLbHfn9vaLVUqPqMMCX8gNF6hFgkPKWtiUxRiw3M
         AIvow+LbItQccZ5GF1Z00xWted2Bkj0M93XVqYsSn/RxYhABMqAwYgyykuDAHt6/r3XH
         tiKXMrpMlmZzB3/+HHc8LgjksHM5mPMz7E5EnqjMezp3zN7mia2rufpeUH9MOsXs201w
         l7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQttFW1C06IjLp+yLCYHr9yAyp/8boQfWdvRpg9aqas=;
        b=iVy8xL0X8W/sdFELzWTeVnUL9M3AGbUwBChKSTzuucZ7xCPVmR+5J8vITp0UmjGn92
         dpDtqld1mFFEBjjuBJOAWtwtrUv7fyYK08Q6+WJWz4Bc8t4icy580GqH0wFObBKOiiGv
         NFRGPglbgqH12DUH6uqA/XMMYO3lPiF9X6dHkuVQ1DAJWDQtWycCsdq4WHdkMQg1Xv0Y
         abDoayMRF2he/xMmBT2WXk0+3Ml6+GKr/5sGS9Sb+C3HtcgQfovtUHpa4oxlmiehrBjy
         Re04J9TUgIRC51SKILRgGP0XtjcsQ5B8NCGHomJ3sKQGym/HDtb49Gm8e/XPJscrI4or
         wTLA==
X-Gm-Message-State: AOAM530Z+tusAuRhn3vI4FMF2VJs6lmRFZDFEDumms+VYkE91FpFMGnF
        SLgi0Md5i+mbxvvqM/E/WkjcBYBVjnf1k3VbAV/bLYHL
X-Google-Smtp-Source: ABdhPJyLqFby/dx5Ecblmd8XvGAAgX2S0LkgPnrJooV+IuiaHmQehvbBSIpfwwzzzu+cwk+n3BPZr0cFZvPIAnOwLjU=
X-Received: by 2002:aca:af10:: with SMTP id y16mr1501636oie.120.1616037008216;
 Wed, 17 Mar 2021 20:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <1615882129-14822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615882129-14822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Mar 2021 23:09:57 -0400
Message-ID: <CADnq5_Or=P-cfjRo2vMURnoay20SAhD_SKY8pvtCiK1J3b5+eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 4:09 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c:721:65-70: WARNING:
> conversion to bool not needed here.
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c:1139:67-72: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> index 6e864b1..434d3c4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
> @@ -718,7 +718,7 @@ bool dpp3_program_blnd_lut(
>                 next_mode = LUT_RAM_B;
>
>         dpp3_power_on_blnd_lut(dpp_base, true);
> -       dpp3_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
> +       dpp3_configure_blnd_lut(dpp_base, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_A)
>                 dpp3_program_blnd_luta_settings(dpp_base, params);
> @@ -1136,7 +1136,7 @@ bool dpp3_program_shaper(
>         else
>                 next_mode = LUT_RAM_A;
>
> -       dpp3_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
> +       dpp3_configure_shaper_lut(dpp_base, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_A)
>                 dpp3_program_shaper_luta_settings(dpp_base, params);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
