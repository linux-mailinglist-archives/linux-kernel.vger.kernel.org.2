Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB32BF87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835601AbhCCSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448348AbhCCPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:25:01 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B70C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:24:20 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e45so23862881ote.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MVdKPr2r+FQpE96NqJvY5W4N+J4PiUQgsBxVk8RDXds=;
        b=lrZIKY1Dv0lB+oQNN0dsbP/Dg5v0tO8N1XqpP3/+Edmgca/GyklGGMHnr1PivrMApA
         fn2YSdDvJOo+kYlMelVty5TTB3DfJAEEqN0cvPHzuZmT7MyvbQS7hfL+b5wiUEfn0cnI
         Q3T3Tb6zZpJLH9okTGsDqbMYLI3wI0Jf0eqROW3iUqtZ3b4Rba8NH/hGEvm/DeVVqtc9
         RMe6+66tD2zTzv8qdBBtGfwMjFsg3Qa8/zRzkhz4vZpVFtfUe0bIaAwDI5Dg69S2WhAy
         dP9J0XokCtx/5dYjDMHOQS2EaZX5APkelKieqyFNJ46ASH22cnH/nh8Hs8w2OCmAv7w3
         zRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MVdKPr2r+FQpE96NqJvY5W4N+J4PiUQgsBxVk8RDXds=;
        b=WAAfAbuuz1YWKgAiMmARtobnK3JPLdFujoGGvU6mIH7tosSfNvg6w84vVLmI7E03Z7
         feCOjUIs/l+EhEINQyAUl6X7Azeb2a+CDMLj1UZPdjC2VwLJr26/vDhv4Y4z6VZQoB+2
         79ZfzmsL+XSwSQrnRvaY91fC3Il9aiiyqrEuIksG6oUt9bhUrl/seFZlQ9ivg7d8jW8+
         iN1CmJBiuZb3WJ3Fv8m4RI7HRI+adRwg597A322TaMG9vQCeoIqzpmSX+IjaQxVW4hly
         Q4qDUp37f95NB49w3pBiZNfVBwV6oWFa/MYnJGQ7H0+eklOUflLrSSCGTs0OH2UKy8bF
         csvA==
X-Gm-Message-State: AOAM533Eh2TxG8bqxSFszxXaf/M7F07HgnxxgZskXc56Tjdybrn1Qtvt
        YYtP+/N2tHFAAsrjlCqWbDWH3391gyCeOQfZrjk=
X-Google-Smtp-Source: ABdhPJxEPlfs1KO7UFxK2eKpp99xb5i7AOaLDl+MPjiX2lQZChR3ae9OtgwjaXMEpYL7DOa+Muj0ydoMSMCywJ+xtvM=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr4676329ott.132.1614785060048;
 Wed, 03 Mar 2021 07:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20210303134319.3160762-1-lee.jones@linaro.org> <20210303134319.3160762-11-lee.jones@linaro.org>
In-Reply-To: <20210303134319.3160762-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Mar 2021 10:24:09 -0500
Message-ID: <CADnq5_MidBZ=BdQRPG-Xt6J6hSxd2E0+MYRn6tA-W=dLgeuaJw@mail.gmail.com>
Subject: Re: [PATCH 10/53] drm/amd/display/dc/dce/dce_aux: Remove duplicate
 line causing 'field overwritten' issue
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

On Wed, Mar 3, 2021 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dc=
e112_resource.c:59:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
014:58: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
014:58: note: (near initialization for =E2=80=98aux_shift.AUX_SW_AUTOINCREM=
ENT_DISABLE=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIF=
T=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
013:56: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK=
=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:181:2:=
 note: in expansion of macro =E2=80=98DCE_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
013:56: note: (near initialization for =E2=80=98aux_mask.AUX_SW_AUTOINCREME=
NT_DISABLE=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in =
expansion of macro =E2=80=98AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK=
=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in e=
xpansion of macro =E2=80=98AUX_SF=E2=80=99
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.h
> index 775e24926380e..566b1bddd8cc6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> @@ -100,7 +100,6 @@ struct dce110_aux_registers {
>         AUX_SF(AUX_SW_CONTROL, AUX_SW_GO, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_DATA_RW, mask_sh),\
> -       AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_INDEX, mask_sh),\
>         AUX_SF(AUX_SW_DATA, AUX_SW_DATA, mask_sh),\
>         AUX_SF(AUX_SW_STATUS, AUX_SW_REPLY_BYTE_COUNT, mask_sh),\
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
