Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAB3CA201
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhGOQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGOQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:13:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF82C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 09:10:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e11so4184655oii.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6c3zyMYOnu8f5V0VEW0ba+C0gb8GX+p+9qHajQ6vagk=;
        b=ky2omVb78fdTIgHSoV6mfHrwbcyGxVRmdbWzk6MLrtzpjB+9YIZzxHelwVAd3LKV+Q
         UFfn8+ds8zYXDUtMiGqgx84L44tIlAoRVa+N5bFrVFkWHb75GKPrhJ4j8FuZ7lfPnKOH
         +pg0qcn15QrD/RSLV4aTO1lDeB0xnh/5ly3iKrn/mRauK97lweuJU1NKYaygj+qSpn4P
         nFMMlBRguz6x3SapXagwLr4hg4RS+OFC0uGStRO3oCLY6ybHJ2Hlk04guFvmj7UDN1av
         bhMM5oKTtP47NEZGDVj5rgKq+9RbecBcmQMnTknECHpOxLIagKTGkInBHvzAIK1G6Kow
         QbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6c3zyMYOnu8f5V0VEW0ba+C0gb8GX+p+9qHajQ6vagk=;
        b=PnPJgptLSBORD+ESAGZeN+V1ygQ/6ApjdI+cbJvN95+8dFri7AkqQfV8y99pciGveE
         ngTvjM4n6+2mV5D8cOyaQL7u/nUzQb6y4C4NwJjl1psT5wrOr6og9y+iebl0mhAyxyXc
         Drwtw4aUfr7QPuzFcXAkynbgE7qyADHhFvb3bFX9BNiXJODj+CMNgeobBRGG1sAupPuD
         2dJshBAvzZbuh99giYfafD3o8kIkLAe/dNfXt+KMgVo9sFiS+vHHLGcUcVnr7zhZl0zu
         JX0JgAD6pNJBBBP8sjiqJjPobf0LOnVFPgHekv6cnjsvl+cQbQJx2T6UAF8ORnI59dkN
         NcCg==
X-Gm-Message-State: AOAM530vfFO1sVPasj3zPv3yQ3lI9bXbIudF2uthKx+5oStYuKaGS2dX
        AScte7Sfo6Dt0O9OXb8+Xl3i04jZL8zEmN3LDp4=
X-Google-Smtp-Source: ABdhPJzEq72ZaeVqWHRV9xBl988kk8YBBxczyWyRPiiSGDCmqJSum/5U8fkHz6YIoJumevbUrAXhI5T4FOdLnqOhd9c=
X-Received: by 2002:aca:ac15:: with SMTP id v21mr8249953oie.5.1626365411814;
 Thu, 15 Jul 2021 09:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210714080652.113381-1-liviu@dudau.co.uk>
In-Reply-To: <20210714080652.113381-1-liviu@dudau.co.uk>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Jul 2021 12:10:01 -0400
Message-ID: <CADnq5_OA-em2jM-vmwaM7xxycOS-18EPC0r_myb7REy9b4h_vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 10bit 4K display on CIK GPUs
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 4:15 AM Liviu Dudau <liviu@dudau.co.uk> wrote:
>
> Commit 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at
> 30bpp for DCE-11.0.") doesn't seems to have fixed 10bit 4K rendering over
> DisplayPort for CIK GPUs. On my machine with a HAWAII GPU I get a broken
> image that looks like it has an effective resolution of 1920x1080 but
> scaled up in an irregular way. Reverting the commit or applying this
> patch fixes the problem on v5.14-rc1.
>
> Fixes: 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at 30bpp for DCE-11.0.")
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Harry or Mario any ideas?  Maybe we need finer grained DCE version
checking?  I don't remember all of the caveats of this stuff.  DCE11
and older is getting to be pretty old at this point.  I can just apply
this if you don't have any insights.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index a6a67244a322e..1596f6b7fed7c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1062,7 +1062,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
>          * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
>          * did not show such problems, so this seems to be the exception.
>          */
> -       if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
> +       if (plane_state->ctx->dce_version > DCE_VERSION_11_0)
>                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
>         else
>                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
