Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4032BF80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835536AbhCCSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448169AbhCCPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:24:09 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031DC061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:23:08 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 40so15512829otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03LVkMkDFQRNhHiuk8kPbyos2+C08G21+Pb9aPcNsbI=;
        b=Ma16FxV6movCHSVnqY0o/p4pFQN26Dy2vfqYj+aUKdbCcXC+pvYF1IvC4H1SFt0eRC
         ZcwnmPLn0PQ8t6fOFcwbdkA3Df5Sk6WzomDYbjMbgKauPVzNKswvHRPitdqefiuuRBHH
         k+S3oHfjgqhiaxhotzeEgxTue5Hgs+MukBV7K+zM0kVU9aEFVzAK5HdVX3Bq10096DBB
         u+g/INhCcIeLl6DvOejFyStWY2EQpgPCPHAsvQFvrP4sXl2YhJt+naZGv6A4JYYVuzoM
         F1vS40QKMvDt9+ow4t4RzvZ0wzKg7kQL8GO+Agy1ejtvVqgukD2uqogtcDShSr+Oiolx
         3FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03LVkMkDFQRNhHiuk8kPbyos2+C08G21+Pb9aPcNsbI=;
        b=sMaoBpC1Uh2Fyjm1aKvvqFiXMQcem4kxiQaoLJxsjd0GIlTUzl+UzP6uUSeXEYdodz
         yI+n1Na2ubRYmgqCD3TB0muac/saBQTRJTiUfizldJBu06+KYf1XQtzlZIwL02K6sdb9
         b8Gtkm3JTh593fwebyrfUmkqzHevfayFLCUx9Zv9ZVhGUPoiY2p7xc200F2dYhsTUwUF
         uiS+eV2aPD1ITZ+Ja0cTsOfD6YnbMLhy5EtuIZrHKxGUhWiD4+nICrA7iCKvbiwJjiSA
         wJyFH7zf2bdZam2+16wwD71RDPRcd++K1RGxgX3CC0CujhWrUBJ3oHx5JdfhffAal6Md
         BdrQ==
X-Gm-Message-State: AOAM532CrfJMdocmDs9ZLJqvsnFpVbfQzvLL2XOEpxMdbPe6K+2904JN
        JeglwF58SLDmliof7PwhFmeiF29q0/ZS999LZP4=
X-Google-Smtp-Source: ABdhPJyvcIB0lg9d4EmsJpSurkNzxjIde6sw+k4XQp+cf3DJ0qN1rBdINSKS5rlxIp3psa2ri4PkN4RsXQY3xu1y9JM=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr22906018otl.23.1614784987261;
 Wed, 03 Mar 2021 07:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20210303134319.3160762-1-lee.jones@linaro.org> <20210303134319.3160762-8-lee.jones@linaro.org>
In-Reply-To: <20210303134319.3160762-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Mar 2021 10:22:56 -0500
Message-ID: <CADnq5_O6-Cc3qkO3+qPoSH+M_35f+HgBWDy_Pjuz4fzPuctA_A@mail.gmail.com>
Subject: Re: [PATCH 07/53] drm/amd/display/dc/bios/command_table: Remove
 unused variable and associated comment
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In functi=
on =E2=80=98adjust_display_pll_v2=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1462:11: w=
arning: unused variable =E2=80=98pixel_clock_10KHz_in=E2=80=99 [-Wunused-va=
riable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Same comment as patch 4.


Alex

> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/driver=
s/gpu/drm/amd/display/dc/bios/command_table.c
> index 9d3bc3a073821..e879ceb0c49ed 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1518,10 +1518,6 @@ static enum bp_result adjust_display_pll_v2(
>  {
>         enum bp_result result =3D BP_RESULT_FAILURE;
>
> -       /* We need to convert from KHz units into 10KHz units and then co=
nvert
> -        * output pixel clock back 10KHz-->KHz */
> -       uint32_t pixel_clock_10KHz_in =3D bp_params->pixel_clock / 10;
> -
>         bp->cmd_helper->encoder_id_to_atom(
>                 dal_graphics_object_id_get_encoder_id(bp_params->encoder_=
object_id));
>         bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, f=
alse);
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
