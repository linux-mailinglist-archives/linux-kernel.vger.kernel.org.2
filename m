Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B304D32BF7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835527AbhCCSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444290AbhCCPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:23:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DBC061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:22:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id f3so26304615oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1zkQQ97wCx5l4oAwiKRm3PYTro4R8m4Ik8B878uu3kM=;
        b=kDN8FhKHHCBKtHgQukPsPJbWp9YgHQ8aiisj3cwnFjz+bHxAf3P04S+T5e/1SB8m2Q
         eiAbfA5W0GVf517ujz3FM4zc9W/Wu0ST833kAEKQidkTq61QtUjTznUaHSOMIchOhqEJ
         BkYwYzZbob7171aXW9LVFwoGxjftRqVvONBXgFUcIdW66LKUxIOSxzIQLK7pik9lrvKH
         jIimY9tWWbz8WdyQna+oJ1lRNcY/jk84cvi60POdccek60TKvwvOVgcxOpeLFrmqT+C9
         L/6dUWWz2en//yIWdsgfc8tSNcB6aa7hUojzqDdRhYdsfhWKYRwk+MvVzYqR1+3rCSJ/
         GDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1zkQQ97wCx5l4oAwiKRm3PYTro4R8m4Ik8B878uu3kM=;
        b=ZniFM8lNoJlyy7HwGl4ag2EOJdZBSzOR5eVW7lNx0X3FP81ec+zKE5gTO7St62vCXc
         J32w6rQKTLFTTcxFpLNLuR2ReNNFgcyuHDcugOPvJdfDxcwugnYb4OC0hplHRBtIuZv5
         +GBNkPIDUQP6NtzQ1S2jVNP2Taz6wqiGgFW7QiqYnmBgzFz98Z/BySCohlGKCgs8GKmD
         uBc2J5YJ4fu00kkbtskdkpw9U5Zcjk1T8Wi54mxfCrZKP0LIJNxieO+xWEjG7HjVbj9A
         xyUe/F5NDFNR2MUuBjrIVlE4jS10SSUo7PmO1fkSEuHNBKEMRPpz1Vl60/OAbeisNVP5
         NOPQ==
X-Gm-Message-State: AOAM532xyzjFHuPUU+m06sdeEYlB1KtAucVEznKfDU34sLv3Cm6fIj4B
        yMMGnO5OfDY7evHcD+0Em6Xk3kt042ia6DXRMj1erq17oE4=
X-Google-Smtp-Source: ABdhPJwi6JJYtdHJou1KLhj6ufmDeaRaqJbFih9YWS87D4y+uBYiLw1BGv2+cLgbEdPSlrMVt5w8YmVyzRP20pFsvlg=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr7596595oiw.123.1614784951023;
 Wed, 03 Mar 2021 07:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20210303134319.3160762-1-lee.jones@linaro.org> <20210303134319.3160762-5-lee.jones@linaro.org>
In-Reply-To: <20210303134319.3160762-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Mar 2021 10:22:20 -0500
Message-ID: <CADnq5_OaxR7WLNtQizH=wf1W9y0F3zzWVkwmPwXOq975_pPoFw@mail.gmail.com>
Subject: Re: [PATCH 04/53] drm/amd/display/dc/bios/command_table: Remove
 unused variable
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> None of the surrounding code was removed just in case even a small
> fraction of it was functional.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In functi=
on =E2=80=98adjust_display_pll_v2=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1459:35: w=
arning: variable =E2=80=98params=E2=80=99 set but not used [-Wunused-but-se=
t-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Qinglang Miao <miaoqinglang@huawei.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This function should be calling the atom cmd table with the
parameters.  Just sent a patch to fix this:
https://patchwork.freedesktop.org/patch/422833/

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/driver=
s/gpu/drm/amd/display/dc/bios/command_table.c
> index afc10b954ffa7..9d3bc3a073821 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1517,20 +1517,14 @@ static enum bp_result adjust_display_pll_v2(
>         struct bp_adjust_pixel_clock_parameters *bp_params)
>  {
>         enum bp_result result =3D BP_RESULT_FAILURE;
> -       ADJUST_DISPLAY_PLL_PS_ALLOCATION params =3D { 0 };
>
>         /* We need to convert from KHz units into 10KHz units and then co=
nvert
>          * output pixel clock back 10KHz-->KHz */
>         uint32_t pixel_clock_10KHz_in =3D bp_params->pixel_clock / 10;
>
> -       params.usPixelClock =3D cpu_to_le16((uint16_t)(pixel_clock_10KHz_=
in));
> -       params.ucTransmitterID =3D
> -                       bp->cmd_helper->encoder_id_to_atom(
> -                                       dal_graphics_object_id_get_encode=
r_id(
> -                                                       bp_params->encode=
r_object_id));
> -       params.ucEncodeMode =3D
> -                       (uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
> -                                       bp_params->signal_type, false);
> +       bp->cmd_helper->encoder_id_to_atom(
> +               dal_graphics_object_id_get_encoder_id(bp_params->encoder_=
object_id));
> +       bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, f=
alse);
>         return result;
>  }
>
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
