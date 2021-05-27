Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E94392603
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE0EVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:21:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740BAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:19:26 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t24so3868829oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GxApXEItPh1raGDrpdpbzF4cCWpre96Qop/w5eo9AH4=;
        b=uV2vMU5CdMvrqRlaky97MC3D0teGx7VHH8yKWf2LOSnCv/wkfttqnnyHi7/XdQPCn1
         /2KgdpadhjBg31XJJO9gqCahvPtuwLTJnJShSeCaNQYGXbvPvmPlxxJXMM7bINw9XehF
         AiTa+iULDP4sNREsyOuVE5l8I2h+9sc/rLGEZ3NWBcGRpLZe3kjHN8CLTQTmA19nJdWe
         ds+J6vpsw71q+pUh3J0du0h1K9FdWzwZwx68eoKEeBOcVshDOACisnimmK7LB0tgXzlh
         U4qmS5LgPBd6E1ZhM6Z5FUvvyGqVpRQk8+/wmCHYyoXKCvpP1uT+wTx4fXpRI4QrEbvs
         q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GxApXEItPh1raGDrpdpbzF4cCWpre96Qop/w5eo9AH4=;
        b=b/ZELrMiUdMMFiHamUnFAbEsr7DweLsH2eXA71/4zfiNbR6JvYGEyWPgv92gN7vBpj
         eTtjlgov+yzVgMn3depD+3Kv/smQDqtuXCwLa16+epcz+r7i5mCO23xbZE6ARcNEEL1R
         h9wFdxiajxFXmFGHM8NSn6V68fYXjN9Ar/TivrkBuFEPJWxbaRHynZQr2OUcCzR8HUVI
         dZoOGZxmoOtPC0wh4EXmSvqvOx392czKjKTguw+B8oQEo0hC09Upe+6mnjAIogW5OR74
         bWBIPdXaqKxQYxwUp3Jym1TSJnrSo4jrkjK/ov+gQ1O8CGJAGS/Df9q/oQbS6AcKp2Bf
         5VGQ==
X-Gm-Message-State: AOAM533Jqd0Skoh0ehrvzkjeDicdE4PGn+IxSdjj+hz5U+bREEmDOaXb
        08DB/EZIdTs1Zm2XWhZ3SwPT1B5l7lWJMhouLEM=
X-Google-Smtp-Source: ABdhPJwRzRLtrY0LuUNzchMZWMetRzagOjLwXjzqQBkfGkeaUCxmv8eOs5mwrrp99/ek9z3LvjOx8XzgjsRD3y3ydH0=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr4050235oie.5.1622089165937;
 Wed, 26 May 2021 21:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-18-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:19:15 -0400
Message-ID: <CADnq5_OJaW5UXPPdYefkpjz=tfeGWUJY+wdZnj_f_o4qT_q6fw@mail.gmail.com>
Subject: Re: [PATCH 17/34] drm/amd/display/dc/dce/dce_mem_input: Remove
 duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK}
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note=
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note=
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note=
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:265:2: note=
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
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers=
/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> index 23db5c72f07ed..9b1c4d56275a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
> @@ -181,7 +181,6 @@ struct dce_mem_input_registers {
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
