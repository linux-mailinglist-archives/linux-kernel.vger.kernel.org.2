Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8539D44EFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhKLWyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:54:33 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C78C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:51:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q124so20633285oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLzIBsTyi5anlNkdUPxTn+CgSU0qm6Id0co/DWFLZLM=;
        b=oZAiCn5bj/KyDEohqn+qP/WvAJ1FsinCXqcrsvfB1KoSv9yuI6lqla/OPCi/Ksr+Vl
         2QghttB9JfrKpP2F2l4hunMGTmTY8cSlDVUBBPzFwQJQkNt3ZADdwj2tPBWgOwf1Yc9+
         smQbT0Li4C+vD7dd8UWZHfHkyozN1H498X2ClSwMVTnQ3T1URa0rQ3QGDBuK+RHyy0uS
         eRHHSOHLVEI+sk7mbgH31l1VMrbO1MHL3ivuxPrPCMdx7anllZC9ZG1Htbe+D/sEeou9
         79qrXdT4+VFSeJud2DowsYyOu2vwC5T1G2z24mr9Exd2rYOCBMhDUgRTRiCJ6G7Bly6h
         /xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLzIBsTyi5anlNkdUPxTn+CgSU0qm6Id0co/DWFLZLM=;
        b=gppVUdwlfWQAZsX2jJoL7GZteUPUXqtLtoHIHimCKxSAbDCCFduZJJjqYChkRzuZI5
         rXe/8vUTNVoL3/n90jCvPP5pyXV6CmYRxyE6GfbKRc/uIx3k/D/SZUEzrIPvVadlAgno
         4ligijAx4M/V4VWfBXEP27OxZ6TsXWRlSFx3shYv+3Yk12Fa60tpRPtY4460oZud1eq2
         KpchvmbdzTKZqZSNzmUBotSYc+4U2PXPtyExRGsaKcBi8L45BLbWNmNKHIY2ytp3JkRm
         KgqOlIIZGC9SrXxz0K1X3cyVNTa/0mKDJqubKmt21knBhXyMWqe3ze55kHV9HDj6lzyR
         L0nA==
X-Gm-Message-State: AOAM533f2gs1Z4TMD6RETVXhrwgUC3pZfAHMfTDLOV0kSYxum8OTEW93
        xN54j61jbjwDdgj5IfVUN1x/4GF4MHFduaZBeDcYw3rV
X-Google-Smtp-Source: ABdhPJwgyYh0RREmbw4GiriaHJ4K0Kj+m6J4NQ2IGpXCRtIDbSrp4aWxlwa3a/LByhKzmp69EriOJvibNEELW189YyQ=
X-Received: by 2002:a05:6808:144b:: with SMTP id x11mr16013641oiv.123.1636757501349;
 Fri, 12 Nov 2021 14:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20211111033207.28565-1-hongao@uniontech.com>
In-Reply-To: <20211111033207.28565-1-hongao@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Nov 2021 17:51:30 -0500
Message-ID: <CADnq5_OXkMUBu6AOBUARm3ogok=Qyj6z0KzFgSMh63JAO==Wkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix set scaling mode Full/Full aspect/Center
 not works on vga and dvi connectors
To:     hongao <hongao@uniontech.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Nov 10, 2021 at 10:54 PM hongao <hongao@uniontech.com> wrote:
>
> amdgpu_connector_vga_get_modes missed function amdgpu_get_native_mode
> which assign amdgpu_encoder->native_mode with *preferred_mode result in
> amdgpu_encoder->native_mode.clock always be 0. That will cause
> amdgpu_connector_set_property returned early on:
> if ((rmx_type != DRM_MODE_SCALE_NONE) &&
>         (amdgpu_encoder->native_mode.clock == 0))
> when we try to set scaling mode Full/Full aspect/Center.
> Add the missing function to amdgpu_connector_vga_get_mode can fix this.
> It also works on dvi connectors because
> amdgpu_connector_dvi_helper_funcs.get_mode use the same method.
>
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index b9c11c2b2885..0de66f59adb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -827,6 +827,7 @@ static int amdgpu_connector_vga_get_modes(struct drm_connector *connector)
>
>         amdgpu_connector_get_edid(connector);
>         ret = amdgpu_connector_ddc_get_modes(connector);
> +       amdgpu_get_native_mode(connector);
>
>         return ret;
>  }
> --
> 2.20.1
>
>
>
