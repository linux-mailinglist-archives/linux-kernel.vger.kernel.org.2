Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438CF31C1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBOSw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBOSwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:52:09 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:51:29 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u66so8707278oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXWa925AIO3LIH/jmOKxAvLuXR6xeq8EAPoo9G/LVPs=;
        b=mwJuO+uIPO1JIGp9GCaya7q/7P2IO6XqwIU5FmY3duvnqxZe2Ayg2KCoQq2PupLGY7
         ET5ehCApl/uoprsXlCr/EdyCQqMkQGiQu2sVM3H9at/K2AwzZXuBisDJvjx/GPgn9SD2
         kpoe689fJBRTXXED7iD7X6yNb5YlEA0NO37Z2tW4tLXZ6Fq2h/Sig+NPemq/fmdGO/Nb
         2SUXtkZFFQyVHHgzVClcOobK3CGveDpq9cD+AM1k06eEbhMS0DVzTEKQIAlaHjgQoikJ
         /Xiw5e5kNE01cmS8WbFFNFS/gGfzQ0haxRZQX9Uvc00ND8eHXnK41wbXD67rC8HGg2Bq
         /Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXWa925AIO3LIH/jmOKxAvLuXR6xeq8EAPoo9G/LVPs=;
        b=S6bE/Ad39d5mH1/DOX+6MlG9hk4DYgob9OV67LeNuF5Q1VR5dthl+mq17dVr3UqJTL
         kTHAJtJ5nXZklYxzNdT5jTKqvVpZldGeZnQ0LdL5PbLKR95fRYjPHdAB3L7DTmmjlJN0
         oZVpokey1eQi1khvGV7PgT6TgzfXchgQKjrHC65TmKSiDB6+pSZH/tG2KB4+26fDS9fX
         2VfBT2rFaGtE5yg6Q5NuaU8YrCytpFZ5fBmjWL4jpDHAGp3c++syFomFsQvFinVolR3I
         ubDAP15AL9zWwq3jlKjXW4tOSlndiTIKwwqx9wCtEYONpsAQjHUH+EzTtVLWdc89iEin
         KtMQ==
X-Gm-Message-State: AOAM5328l8PevS2yGnlWpL4xjzH5IW4dRFKtzAnOIoXjHwVOpGb57Wwd
        UqzY+3F3wowfKSLcZvnft4laYDfl15i1K8MaAY8=
X-Google-Smtp-Source: ABdhPJyLYFB1RDFzHl/QlWTxY2E2uXWJGecQ9goXZar9CqZ/0/4BNdZH10F461PkX/NmhdAYNOv0kFtTPoixlBXZyqU=
X-Received: by 2002:aca:c786:: with SMTP id x128mr212794oif.120.1613415088943;
 Mon, 15 Feb 2021 10:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20210210212330.GA880153@embeddedor>
In-Reply-To: <20210210212330.GA880153@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Feb 2021 13:51:17 -0500
Message-ID: <CADnq5_MTPKXA_1G+=zVVH+G3Eqs-DZGH_2pW0=uUT0SMHbs5HQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix potential integer overflow
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 4:23 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Fix potential integer overflow by casting actual_calculated_clock_100hz
> to u64, in order to give the compiler complete information about the
> proper arithmetic to use.
>
> Notice that such variable is used in a context that expects
> an expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
>
> actual_calculated_clock_100hz * post_divider
>
> Fixes: 7a03fdf628af ("drm/amd/display: fix 64bit division issue on 32bit OS")
> Addresses-Coverity-ID: 1501691 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index bc942725b9d8..dec58b3c42e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -240,7 +240,7 @@ static bool calc_fb_divider_checking_tolerance(
>                 pll_settings->calculated_pix_clk_100hz =
>                         actual_calculated_clock_100hz;
>                 pll_settings->vco_freq =
> -                       div_u64(actual_calculated_clock_100hz * post_divider, 10);
> +                       div_u64((u64)actual_calculated_clock_100hz * post_divider, 10);
>                 return true;
>         }
>         return false;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
