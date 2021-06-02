Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5A398FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFBQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:26:58 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:47023 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:26:56 -0400
Received: by mail-ot1-f41.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso2899625otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cZmDB0R8MYQqdnFyr5kHgXADjM/v40Bk8pYmSEReiu8=;
        b=F2U7lDM58wl86JVA1xx0TFZsmY+sP2repFNTtnLXvAyoTyVb2DTr52JEIZr7nQzXZy
         P1kneitgTOhGVeSgMP1nlppsALjNo//w7ADbiCMxLeE+FqeNqWKc/+8Huo/0rofqphuO
         g14rUobx7YSbZqaQXt8mdxVRi2Z5MXfqHS3hAl+0Owh2keTbCkZyg4aH/CjfuX2hOkcr
         BMq4hwdV54azgJ0fwA/2+THNgEqPevpLeMVoBif67GgdcVLfVVe6U5iyOhX9NqftZ7FX
         OQsyvo81qBEfuURklq7nsVhmqx6tiTtq/yjGYxPY8h/JqmYT17nfjmW4OfpVHsRgVW67
         atbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cZmDB0R8MYQqdnFyr5kHgXADjM/v40Bk8pYmSEReiu8=;
        b=gkbQwlOy8vEFDlpFdWlc95PIscLOFTKzj4buTVNeBFUXlVTZ39LEAXuv44DVxr0gaF
         SnXMAfajquaWOLVCjPHA+CK5VBvYzwQkJl54tbk6ewvdY0tt8aRJ65O1KKFQDY+J1bF9
         2J08qyZxIPzoDyUR8EAo7QyMs9HYo3oFcbb9F5brkORpW0miHfM36Y17CWLf0GWcdulX
         F3+66vGf+H4lIuynQZTEjpP1JdfpwJLhTP319m4IR83yQi6Jl0S9CGuPWKCYm0gBv5qP
         KnD9Es9u5CHLxDcEdaBRwJJ+YI2B0L8GcNBDMu4dF3DDvOPIala+1DVetc+fK6S1c97v
         4JPw==
X-Gm-Message-State: AOAM531lBcCOmR/VbrSMYdZIHpophg6fyPT/nN37pRyJ0rkbKqe6Le8V
        J7z0PbK+JAzF7jshhdtmS23PhAlLzq2Le86xx9Q=
X-Google-Smtp-Source: ABdhPJz1BaV5VzBqVZFn1mtftXfq2NvR/yvqHSfO4Le2Pj/qDgFg26ZzK8ynsMmLvPKySfldKZGgP9zN7tvy/eu1WKg=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr26590805otl.311.1622651039670;
 Wed, 02 Jun 2021 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210602143300.2330146-1-lee.jones@linaro.org> <20210602143300.2330146-17-lee.jones@linaro.org>
In-Reply-To: <20210602143300.2330146-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Jun 2021 12:23:48 -0400
Message-ID: <CADnq5_MHcth1p_00d=0ey+kg8o=_ZQk4t-RcU7zx3fb+35uy+g@mail.gmail.com>
Subject: Re: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove
 superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jun 2, 2021 at 10:33 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:374:22: wa=
rning: no previous prototype for =E2=80=98mod_hdcp_hdcp1_get_link_encryptio=
n_status=E2=80=99
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce=
60_resource.c:28:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: w=
arning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: =
note: in expansion of macro =E2=80=98mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL=E2=
=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note=
: in expansion of macro =E2=80=98SRI=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: n=
ote: in expansion of macro =E2=80=98XFM_COMMON_REG_LIST_DCE60=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: n=
ote: in expansion of macro =E2=80=98transform_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: n=
ote: (near initialization for =E2=80=98xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNT=
L=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: =
note: in expansion of macro =E2=80=98mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL=E2=
=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note=
: in expansion of macro =E2=80=98SRI=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: n=
ote: in expansion of macro =E2=80=98XFM_COMMON_REG_LIST_DCE60=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: n=
ote: in expansion of macro =E2=80=98transform_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: w=
arning: initialized field overwritten [-Woverride-init]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers=
/gpu/drm/amd/display/dc/dce/dce_transform.h
> index cbce194ec7b82..e98b5d4141739 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> @@ -166,8 +166,7 @@
>         SRI(SCL_F_SHARP_CONTROL, SCL, id)
>
>  #define XFM_COMMON_REG_LIST_DCE60(id) \
> -       XFM_COMMON_REG_LIST_DCE60_BASE(id), \
> -       SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
> +       XFM_COMMON_REG_LIST_DCE60_BASE(id)

I believe DCFE_MEM_LIGHT_SLEEP_CNTL should be kept here and it should
be removed from
XFM_COMMON_REG_LIST_DCE60_BASE() to align with other asics.

Alex

>  #endif
>
>  #define XFM_SF(reg_name, field_name, post_fix)\
> --
> 2.31.1
>
