Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4439E50E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:16:41 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C794C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:14:36 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso4295538ooc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dN2t+25j0me0dqCGourrl5uxnoeiK8B9YLt2YtSFhI=;
        b=oc2PqVHyYMlZw4hOPvYw5HlnHSiCMzNsJz8q3hg88et9M4aNH0ut2LT3sQXK1SSia5
         PNyW+cPfH/+wxZMxyzo5v8VDwW12iGXbnGFgKbJkq6QlQgk4ZLLrndesTHBNRN6re3Z/
         an4DWRG1ySXlS7UBuNzXzHI91u6aGBc+uq7+6PjoODBbiDkdnvcYv1zS83CbCagXw1du
         juLzp4zWcUsnBrRiEuxD4o5eZm8fpacL0stHEJrdHHF9fNslx7nB+1MbDGwAbxjlt0Vk
         CYeXpuDVNxJiPMT0sP1RD50TSQxX1jkBei/rjs5bSHBdf+2CIf0oKUiFCm7otqnrdm9U
         zWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dN2t+25j0me0dqCGourrl5uxnoeiK8B9YLt2YtSFhI=;
        b=qcS3mHVaqlHaz+FAkOZT4nNUrIyfB9QO5FjoF4VckXVZmB04iesIxwBGflB4eK4IbR
         CmsLKLFjw+EfDUGmJmt/D7hDHUl8WQuDKbtG5hbYUhRQ+NXzB90AabUnD/X8QoDVJlqd
         S4VO8BxiKDyMdwLV9KI6paXIzVkUnK45BGWRdSAPLQIh4REYEOcVr6beJLaLd9Heh/9Q
         vLvc4++F09Db1ZQ7t9gruXbX0g3RWDvm9kN+J3OAo08WaiR+pch53tqdBJ7qli72Md5p
         RCvyjxduxwAtCnsFbaFQcOb5iBawxiygh53tdkK70uOoChfcZJRUZO6paDhoiCd0sWoh
         25yQ==
X-Gm-Message-State: AOAM533Rnu3e3BiiBVZmZUgFgCy/ATPoLcU8Lf5UeHFRKdERpEZRvt5l
        Q20DV/Iy/pOy+9UuRT4jrrB2/I8SvnQmBDpdYzg=
X-Google-Smtp-Source: ABdhPJzy9qq/+5dPLG1VTR3jcNKRWhEs4CUDq5rywX+/7tXl9Mu6ZmbU8cYW1KilNB3jGeF2tDM4EFqq4n35dZ2viZk=
X-Received: by 2002:a4a:8c09:: with SMTP id u9mr13947559ooj.72.1623086075022;
 Mon, 07 Jun 2021 10:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210605123137.8800-1-bernard@vivo.com>
In-Reply-To: <20210605123137.8800-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Jun 2021 13:14:24 -0400
Message-ID: <CADnq5_Px95C7Zosa4ADkBkmDXvPCkz=Hhns1twtixCMAx4y_dA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove no need variable
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 8:31 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> remove no need variable, just return the DC_OK
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index f962b905e79e..7daadb6a5233 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -1266,8 +1266,6 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
>
>  static enum dc_status dcn10_patch_unknown_plane_state(struct dc_plane_state *plane_state)
>  {
> -       enum dc_status result = DC_OK;
> -
>         enum surface_pixel_format surf_pix_format = plane_state->format;
>         unsigned int bpp = resource_pixel_format_to_bpp(surf_pix_format);
>
> @@ -1279,7 +1277,7 @@ static enum dc_status dcn10_patch_unknown_plane_state(struct dc_plane_state *pla
>                 swizzle = DC_SW_64KB_S;
>
>         plane_state->tiling_info.gfx9.swizzle = swizzle;
> -       return result;
> +       return DC_OK;
>  }
>
>  struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
> --
> 2.31.0
>
