Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52B4397E74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFBCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhFBCJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:09:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 19:07:50 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so1165905otg.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pU1TRPFdg/mvMNMBTDRgncKjTs5cmC/VyWt+TILhNqg=;
        b=leBsDCLV2SQ+QW8NeJ78bjOGFhHQDUCW/Evqpq2ZLpXULUTD/gYVSWB0dKF+OZ2v8/
         C7XYgo/lznFWK0glQZ5BhIsDN4m+9THwBBrByZI1kPwsRbO+4oDbSI3miRWMTMXEL+TJ
         1bdst67rVthfP5BTO5o7lI3krd9Eb7oCk4+SErPCDN/Egx3dajMebOIS64mmZR9VKZAA
         OixVbaRn4O994jn/KWkrQaEWsVAZ7QoxOgZvu9FzCcPJf+N7wHU74hl8nazHzgKTthi+
         5Wtb2q8dVFp8ElfhO3dwBkVDj8xJxy5wa6AceM5RNEykul5QZjSehyXxn02IrOPIi55P
         FBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pU1TRPFdg/mvMNMBTDRgncKjTs5cmC/VyWt+TILhNqg=;
        b=hpDU+Dt0NvdzfTpd2uGlRUNKsy7KdaRGEEzfSY6+myWObJO0bKdtQ32mVR7lBruo6K
         kSDUg5/H+DbWlpnpRpF2UFxpRQU1CzbLC8+FKCB2LFqcRYLJtQiemvbcWfWMRtWJW3a7
         T0te3D1Keu2yqbilELx1gYk0kV0iOIJef2rgsMyNB1JJUTRmeaz9Hnz67CvcvwC9udlA
         hsC4ivh/xwBpw9itJzjs0FZj5rmEtTK0gXbS1q7HkwZ95FJuY02psGiIVNsbOR+4pQiZ
         KSLbjlofu77V55YcTWqcKtwEjdgOZZCuKteo86s5N1jTYsPklPpu1psPoZvqqPdVMct/
         KsAA==
X-Gm-Message-State: AOAM531aNf+/C6/snvF1bQJAPDQUkP348ytiCWxs+bTDnjkIBVqHPH1y
        oAvi+nBbE1Az9RHp/Lz4RU52z122bkJo+o5fIYI=
X-Google-Smtp-Source: ABdhPJy++Oeg5/01VJ0eNw4v7bM57dKx0Um7cQXKi3LBbMT6j2vCn15UhSf89hqlJcqfgZt7Y2XlXZgo5CTv05pt1g0=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr24108150otl.311.1622599669886;
 Tue, 01 Jun 2021 19:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210529092816.3133745-1-yukuai3@huawei.com>
In-Reply-To: <20210529092816.3133745-1-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Jun 2021 22:07:38 -0400
Message-ID: <CADnq5_Na=AdNCoQpDPVJ=5078s8C7SNMBo295H-Jp1fQZWkmCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix gcc set but not used warning of
 variable 'old_plane_state'
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, yi.zhang@huawei.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, May 29, 2021 at 5:19 AM Yu Kuai <yukuai3@huawei.com> wrote:
>
> define a new macro for_each_new_plane_in_state_reverse to replace
> for_each_oldnew_plane_in_state_reverse, so that the unused variable
> 'old_plane_state' can be removed.
>
> Fix gcc warning:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10066:26: war=
ning:
>  variable =E2=80=98old_plane_state=E2=80=99 set but not used [-Wunused-bu=
t-set-variable]
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++--
>  include/drm/drm_atomic.h                          | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f7a5e5b48ea6..9f4b334bc071 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10063,11 +10063,11 @@ static int validate_overlay(struct drm_atomic_s=
tate *state)
>  {
>         int i;
>         struct drm_plane *plane;
> -       struct drm_plane_state *old_plane_state, *new_plane_state;
> +       struct drm_plane_state *new_plane_state;
>         struct drm_plane_state *primary_state, *cursor_state, *overlay_st=
ate =3D NULL;
>
>         /* Check if primary plane is contained inside overlay */
> -       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_st=
ate, new_plane_state, i) {
> +       for_each_new_plane_in_state_reverse(state, plane, new_plane_state=
, i) {
>                 if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
>                         if (drm_atomic_plane_disabling(plane->state, new_=
plane_state))
>                                 return 0;
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index ac5a28eff2c8..8f1350e599eb 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -895,6 +895,18 @@ void drm_state_dump(struct drm_device *dev, struct d=
rm_printer *p);
>                               (old_plane_state) =3D (__state)->planes[__i=
].old_state,\
>                               (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
>
> +/**
> + * for_each_new_plane_in_state_reverse - other than only tracking new st=
ate,
> + * it's the same as for_each_oldnew_plane_in_state_reverse
> + */
> +#define for_each_new_plane_in_state_reverse(__state, plane, new_plane_st=
ate, __i) \
> +       for ((__i) =3D ((__state)->dev->mode_config.num_total_plane - 1);=
 \
> +            (__i) >=3D 0;                                               =
 \
> +            (__i)--)                                                   \
> +               for_each_if ((__state)->planes[__i].ptr &&              \
> +                            ((plane) =3D (__state)->planes[__i].ptr,    =
 \
> +                             (new_plane_state) =3D (__state)->planes[__i=
].new_state, 1))
> +
>  /**
>   * for_each_old_plane_in_state - iterate over all planes in an atomic up=
date
>   * @__state: &struct drm_atomic_state pointer
> --
> 2.25.4
>
