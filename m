Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC153221A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhBVVkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhBVVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:39:15 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:38:35 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p6so247505oot.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdA4QMTkvcuLnrvRLDVtBXvNd3HImh3DqClB8gl/vNc=;
        b=jV8vA8ffi1Ah+DtRGWB7+I7T3WuB40v2z1tztQc7a5uWHrAuMzNGfroESOSWu0WcZ2
         dBrkXBgxKWwtmiOZid6iaruXrpyvamrAQGEO9dDUhjpWN1ZcsDJwHgKjoQ9NYAdRKnSi
         RPFBYbriX9O6Zxs0SJq1zO9hktkIwTJGeil6WNtGvDu9KaKcjIX9rY6Qu2nBRLyrD1cV
         lZYzZK+F/92Bsm0yG5chEGmK3ONt3oPcv6Xg95Clm3ck5D+p0EAXk2ePe42QTWZ4eGCR
         K/p/1HqvxqQpebi+I2zdi33AFxdpKZsSXJajhWuoFgx4mVJuRNv4Ot5f7zxbw1uXnqgi
         G+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdA4QMTkvcuLnrvRLDVtBXvNd3HImh3DqClB8gl/vNc=;
        b=cHpfahi66nGrpiGsxDOpX5yr/vDcW1put8ee8kqfgyyDKCPIiT4yEnlpYT8i5Onwt2
         4w3khb6chOV9RJZK2mOYEXZ2RQGulqrYWvRrn15SOCyAtcTQZclcGCu+R18ut+PrInJ1
         NUQRadieb13r5INP83JbYpYZLzRc6ieZQilte0SZytvEvnnGlFrFGhHnAg+ZEzD2riTY
         WNVMBytTfcSLU1HjBgRdhU+LjdPKiqEsPWm/Ysbxyk2QzLXBM7Co3xkHfee4P1U1gSTI
         eCUXoVlwbDrzA7858HuLmD/u6D2KeYcHd1ma0DO/OUEBvI7LP7UqyYT3ipG6S0hAE8ow
         WEow==
X-Gm-Message-State: AOAM532NOZBk7KkVs8UzxLl2vh+Rb+iYrpqEl1iPz7NTWT3MBk4yxZ0U
        xqKc+NCvcIwq6lWMycLy2CY1Pgja3SuBUU9FXmI2m14Y
X-Google-Smtp-Source: ABdhPJyd9vTXp2zxAjtj+Zjzb2HSfrL+MuU1Fsvdy/rwyJVFvzuRT76sJTKVRtzMZefb1N/9hBKBE8vhI8oxnNNVJyw=
X-Received: by 2002:a4a:9801:: with SMTP id y1mr1728430ooi.90.1614029914834;
 Mon, 22 Feb 2021 13:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20210218224849.5591-1-nathan@kernel.org> <DE2DF569-7545-41C2-AF18-400D6BD73215@amd.com>
In-Reply-To: <DE2DF569-7545-41C2-AF18-400D6BD73215@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Feb 2021 16:38:23 -0500
Message-ID: <CADnq5_Oc5U9-bPzr4vNiF=BvxSfQHKCvGmSjJjKh=6OUbxmZ0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/swsmu: Avoid using structure_size
 uninitialized in smu_cmn_init_soft_gpu_metrics
To:     "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Feb 18, 2021 at 6:12 PM Wang, Kevin(Yang) <Kevin1.Wang@amd.com> wro=
te:
>
> thanks,
>
> Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
>
> Regards,
> Kevin
>
> > =E5=9C=A8 2021=E5=B9=B42=E6=9C=8819=E6=97=A5=EF=BC=8C06:49=EF=BC=8CNath=
an Chancellor <nathan@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > =EF=BB=BFClang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
> > variable 'structure_size' is used uninitialized whenever switch default
> > is taken [-Wsometimes-uninitialized]
> >        default:
> >        ^~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
> > uninitialized use occurs here
> >        memset(header, 0xFF, structure_size);
> >                             ^~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:753:25: note:
> > initialize the variable 'structure_size' to silence this warning
> >        uint16_t structure_size;
> >                               ^
> >                                =3D 0
> > 1 warning generated.
> >
> > Return in the default case, as the size of the header will not be known=
.
> >
> > Fixes: de4b7cd8cb87 ("drm/amd/pm/swsmu: unify the init soft gpu metrics=
 function")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1304
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu_cmn.c
> > index bb620fdd4cd2..bcedd4d92e35 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -762,7 +762,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uin=
t8_t frev, uint8_t crev)
> >        structure_size =3D sizeof(struct gpu_metrics_v2_0);
> >        break;
> >    default:
> > -        break;
> > +        return;
> >    }
> >
> > #undef METRICS_VERSION
> > --
> > 2.30.1
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
