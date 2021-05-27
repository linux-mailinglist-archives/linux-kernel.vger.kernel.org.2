Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5F3925ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhE0EOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE0EOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:14:30 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:12:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso3218992ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wAtRRMb1FBGzO+jQIGrd+HIGuJW9STgbsAS6K+V97RQ=;
        b=HuW+0u6qUbeGkEDLvz7I2oy9Mc8OAbS1xNk5cVRIHHTMPu3qv3rBsTxByh3rpGW21a
         UOQSJhQdd+f3D185abbIMjJ2tMotDyk2KQ59iHE4DhpjxSmJjdY50esGah5i4BH2Sxdi
         8EiHVgeT9GQcqotkfiZCgSOI8X+Ub6+TL6JrT5L1Y+LwelzQHywdvv5dpdhFnKDJTAZc
         kaghpeLh4X77oaWOsCWtbqp1cG3c2JvGPOrlUqpeKe1wAB7LPMEngj7S6KmDGoftBT0m
         n/10XZfuyxymxLXV+3ci3/T8i4lGUdaveLHS9uwkqE3rBjgBogEN0ypopdFVp+zDMUxT
         sYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wAtRRMb1FBGzO+jQIGrd+HIGuJW9STgbsAS6K+V97RQ=;
        b=NT+3haY+143VlQS0VOHKydj8+1dqtlwM3i5dxJhuMoPGkX/LD9/APQHACPcTUKtp6h
         A0qlU7tLGpaQTabtr2H1XcydRK5PZ8G8A7SXtsozRS8OYvGWQ1qANG2AMzw5mBc//LKc
         gMtL1pbSuNmjmbSPrawvCAf8sUILsNV104QiLaoG5ydCpqoWtYVl6OHODz9zUkmYGEWh
         jSLWMB8GGQY1agosfq4iwifdTvY+u5a78UhhErsUrzYFSN8ErDDGeiutq/4U/mBKSifr
         Vp7n3AO0BJGuJsPUvPJXPD0osCYSKWcinrJIZoj0BQSB/ZFO7lNZp6AJLosCk9uusgxt
         58qQ==
X-Gm-Message-State: AOAM530WhmBkN+52q83tlGMb+RBpEBGVLxa0smb62gRTKzDxSjHXTKcn
        PII8SBPjNdYTBzSBS2mFWNZA9LBfJM88AwyBqgw=
X-Google-Smtp-Source: ABdhPJwZ4Ix3NcRn/6nTGZbbXYbkWrttOSD2i6IYoabkkdQes4mjHf1EiB4EJLDbj4Ps2yyCovGYGLpZQFalG5HV6jo=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1254263otl.311.1622088777455;
 Wed, 26 May 2021 21:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org> <20210526084726.552052-17-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 May 2021 00:12:46 -0400
Message-ID: <CADnq5_PmyZyZLO1N0q2fMM9NKPYYiMhbPBfgFyeOAWgi-i1MFg@mail.gmail.com>
Subject: Re: [PATCH 16/34] drm/amd/display/dc/dce/dce_transform: Remove
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

On Wed, May 26, 2021 at 4:48 AM Lee Jones <lee.jones@linaro.org> wrote:
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

I believe this should be kept and it should be removed from
XFM_COMMON_REG_LIST_DCE60_BASE().

Alex

>  #endif
>
>  #define XFM_SF(reg_name, field_name, post_fix)\
> --
> 2.31.1
>
