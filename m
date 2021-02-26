Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67AA32698E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBZVaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBZVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:30:20 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB12C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:29:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id z126so11211250oiz.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+XuI1x+8YDlt07TAQPA3xx8+2WYMMEBzo0uXxTMkC4=;
        b=mJlk0wqt+hovCyn5pQJ5lMizNw18al5kCVeYtx1FPDccDVE7hpeji7OHh9al4m/HAf
         Pxsnznei5j6RO9dyA23/LwklDtMFEo/dljBb7oKyGLlW8u7+g+XtIq8ySo6pXhdKwvbh
         jSxviSw42gDvyi3+A9tuXV/lIYwfPVLlZ4bgLvyVkdoM5grOxKP5GYFdXXpQmGVfoh2S
         fwwZT+mwfymQN2ZtjF9u5noz+qnIAc4DJvV5HB9l+TpV05wY2m6w9Zm4ChBqELnsTDT0
         vkiPG+VuQpEDn6MPfwAzRwJ3uBMTC6msW7Qb8BFZLBBtTTsxj2k+pdnZQ/X2orhJio02
         IsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+XuI1x+8YDlt07TAQPA3xx8+2WYMMEBzo0uXxTMkC4=;
        b=iSlq5pOjSL9rXiFNSvwsSJyW0zTwoEYAUR4bwz29OhMMbd4KmiZG6F44jZj46QBKgo
         zv6arDYeK9drMCTwCDVz/cV5ePGYVFsFKeM71QdBsl+YQ7ZQgRl+55MrgPAPzebFcQP+
         FcydmwAYuHvcgvZnLd5n4OMk7cybwPqOe2Q58RwDwhjgH77Tl1/5ntKDvLloKul3l+DU
         XUggbc04ZlpR+cGi3CrsmfrHKTt1iEYb1a2dZ3VFJ4oPUBMRkS+zX/t25F0568OdYPXO
         7/pmypLdNLQZQjHJK7GaUprRLaDmNsBfW/xRoH2439A9FYg9P+Ltl5NoU/NVLYSSFg3L
         U7qw==
X-Gm-Message-State: AOAM533v1I3GVcMrR84tg3SZUzz3+ou5FcG7XEA9BoyABdU/nkxhS77P
        vdIE+7gLyUEx96Uau1l9ck2t9uuYEwsUip0iEK1RyGIy
X-Google-Smtp-Source: ABdhPJzM/GD97FBNksX+qUYYCV5b+mBloW+GDX6JAIooMsjETRDa6/4gNIukKjRYSZ1ufHxF9fzRZbq2+cKYNgPZDsQ=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr3362138oii.5.1614374979385;
 Fri, 26 Feb 2021 13:29:39 -0800 (PST)
MIME-Version: 1.0
References: <1614332527-5014-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614332527-5014-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Feb 2021 16:29:28 -0500
Message-ID: <CADnq5_M2vL2RE5eJ727FFskdONAmW4RL-0LrXRTiJiACHY8SYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/dc/dce/dmub_psr: Remove unnecessary
 conversion to bool
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

On Fri, Feb 26, 2021 at 4:42 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c:273:16-21: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 69e34be..c13f967 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -269,8 +269,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>         copy_settings_data->frame_cap_ind                       = psr_context->psrFrameCaptureIndicationReq;
>         copy_settings_data->init_sdp_deadline                   = psr_context->sdpTransmitLineNumDeadline;
>         copy_settings_data->debug.u32All = 0;
> -       copy_settings_data->debug.bitfields.visual_confirm      = dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
> -                                                                       true : false;
> +       copy_settings_data->debug.bitfields.visual_confirm      = dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
>         copy_settings_data->debug.bitfields.use_hw_lock_mgr             = 1;
>
>         dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
