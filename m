Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C67392609
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhE0EVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:21:52 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B83AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:20:19 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso825596ooh.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tB2Ch1VAJgDCULc93W+ONDreVArjrFcuA8jYDECY1ZU=;
        b=VM40zPswSOR0WHvr7mFAcvMsytjXslU5Xgt+a/AKBXSjgv6TrTQs0dH4MkkEhHrOvL
         8jPmWmQyiWe7TrPAaIHA9Gfr52wEHkLY70Egh0S02aC3JFEcO20d5Gb8IhfiuexWPJdF
         55/8L8gLDKONp/XbKR9e/o6n3wKlNJjmjzqxvmLhEx4ApaT4PMTl7ZL3Ep6wgzgLxQOL
         CRuPpyYxYZ/yrv8Q2K5OhLGjS5BmF4SYuAygcOTmfqLp6OatL7qcIMWBWZ44g//tekLo
         IULOUlvA/hZcz4aIAXfsYZ+o0YhTw1cV0BA9p21vrF1UEQboL5BAkmlCmFLIamJIdKgp
         oBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tB2Ch1VAJgDCULc93W+ONDreVArjrFcuA8jYDECY1ZU=;
        b=dWva2hJyvk17lbLQyt92uHV2hSd2+iKsgbIMsu8TN9D/OLwAITair2VcDRRVOPzkep
         sM6fEZ7m9OgOo7jQ0kZszrbmytm0N0SgRALzmsUaPjR5o9Qj9vUzAJOpXo0XWDy4v7Wk
         WtcjDnlhHjTCPh3hUcvx5IMVqlxk6eDekxa9xAEvz8A2WW8zSDYj8kmVDxrr0qc62ynr
         3aHNgyM/77YPYOlpwy6bdxEV1WHQ1wosM4zCCAif5qL7WgCixq6Nffu9ORcZLyFgq3QV
         fL4/WxMiS6HU7lvFcGGd/qJk54ChZazTbveIMb3kLXT66CUfYABrz1Qn1rUrYzWMgCdd
         nj0A==
X-Gm-Message-State: AOAM533cjzeKqw/DZuLstXe4ZzNJSWym3PNgUBhP0t3B71taQ4Qseuc9
        /vwshWt5Ivk7kuaWC+EUKKq7nWDUAUDylqJwXuQ=
X-Google-Smtp-Source: ABdhPJwgz6poKjp8tEOBLdsTE0+QFAawghJ+wX2eX3p3YHYTocBFCGx4CvV0sbQAbiCWjtFokYUIMyhGhaj/mrup5/k=
X-Received: by 2002:a4a:d004:: with SMTP id h4mr1268994oor.90.1622089218043;
 Wed, 26 May 2021 21:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-19-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:20:07 -0400
Message-ID: <CADnq5_P3fdAutZTgKJVQW=7aj-9gi5fJWCafYgQ_0XDd8UV-Bg@mail.gmail.com>
Subject: Re: [PATCH 18/34] drm/amd/display/dc/dce/dce_mem_input: Remove
 duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK
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

Applied.  Thanks!

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce=
60_resource.c:29:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:727=
0:45: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note=
: in expansion of macro =E2=80=98MI_GFX6_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: n=
ote: in expansion of macro =E2=80=98MI_DCE6_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:727=
0:45: note: (near initialization for =E2=80=98mi_shifts.GRPH_NUM_BANKS=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note=
: in expansion of macro =E2=80=98MI_GFX6_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:657:3: n=
ote: in expansion of macro =E2=80=98MI_DCE6_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:726=
9:43: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS_MASK=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note=
: in expansion of macro =E2=80=98MI_GFX6_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: n=
ote: in expansion of macro =E2=80=98MI_DCE6_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_sh_mask.h:726=
9:43: note: (near initialization for =E2=80=98mi_masks.GRPH_NUM_BANKS=E2=80=
=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: not=
e: in expansion of macro =E2=80=98GRPH_CONTROL__GRPH_NUM_BANKS_MASK=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:159:2: note=
: in expansion of macro =E2=80=98SFB=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:264:2: note=
: in expansion of macro =E2=80=98MI_GFX6_TILE_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:662:3: n=
ote: in expansion of macro =E2=80=98MI_DCE6_MASK_SH_LIST=E2=80=99
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers=
/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> index 9b1c4d56275a4..08a4c8d029d9f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> @@ -206,7 +206,6 @@ struct dce_mem_input_registers {
>         SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
>         SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
>         SFB(blk, GRPH_CONTROL, GRPH_FORMAT, mask_sh),\
> -       SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
>         SFB(blk, GRPH_X_START, GRPH_X_START, mask_sh),\
>         SFB(blk, GRPH_Y_START, GRPH_Y_START, mask_sh),\
>         SFB(blk, GRPH_X_END, GRPH_X_END, mask_sh),\
> --
> 2.31.1
>
