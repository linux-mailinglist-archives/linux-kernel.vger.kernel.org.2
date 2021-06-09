Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB523A1EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFIVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:18:13 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33640 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFIVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:18:10 -0400
Received: by mail-ot1-f50.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11664934otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dY+o+I9YjgbuQFjtJhzXCirY8XIoJgc7jb+LLRGuVWA=;
        b=lEOrWAPpo2TsONLfsPjgQPQC9Tu4QsDNPlsEUKIXEz4YxGJVCpHENODUaM6m7OviLq
         Bnj0yTT8MvCdR19LCH0siDvvsVYXKAETz9RGDZ0XxWe6jeyi9R1haz65c0sJFHeuQOwu
         9MhJSdT6f4eqlLrtkcNSC4zKZhqFNp5DqALmMsll4yKvg5u7VFRJNdwfact5oEv2vXPQ
         +XOORacSrKvKSkOM8NbvTMClS460eOZg13G11KBrJmsL8JiMaAr0LIZWthji5jXXLHEm
         t7G1DUGGNoPd/sbF9devLtX1SOhixREe5XufyrcwxAs6KFbdMPWs4zjP+6AzWsSaEcDy
         MfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dY+o+I9YjgbuQFjtJhzXCirY8XIoJgc7jb+LLRGuVWA=;
        b=pqCNXTwPfE7JR9yApOeM51AOYoXz2Jvo3hKnlCRrnHLN9IEnk6X2tW2TG5AH2hy0tK
         FZeIGGu5URGsQ48DanaIj0idBqlvJggIrpxUejt8TLiYpvvWmTkpsccNxj0MTKxpVHwc
         fV+/5/RFOJdSwdalZyeDYRmZhHa5jVYQeoh41XIY2Y/tZSUOys3BJ/8mmT5SdyqrpYQb
         3+ChyRpPeO9UqVC26aNsqXQKaLqdQBRBATAGp3fI9Xxt9FdZOKnoHkNS0x6v1M3qR/Z0
         CwkZEtrYCubx9lswS7IeeNmdtCRZsaClNsFSDzHpTpN7ZEqyOz/FwCo/0r0W7C2Q2dZI
         oa1Q==
X-Gm-Message-State: AOAM530Hc6Z3+ihBpOS0bLxAf1pGbYduswjv3eBE8t1fUSjnsGNnH5cF
        a65vSHlbf3SbwMqdAFuAN8dvSVlvvX4P6PofPT4=
X-Google-Smtp-Source: ABdhPJw8Yyop7qFQOPrXtKB6YTNlg7AEsfSxxuZALWB8KJBhbngOYLJMNMfXSMkgU5D05gk41DvORh3q41sGtOPxNpM=
X-Received: by 2002:a05:6830:1e64:: with SMTP id m4mr1157634otr.23.1623273315719;
 Wed, 09 Jun 2021 14:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210609030202.113368-1-wanjiabing@vivo.com> <20210609184756.rewxv73j2jj4bfys@outlook.office365.com>
In-Reply-To: <20210609184756.rewxv73j2jj4bfys@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Jun 2021 17:15:04 -0400
Message-ID: <CADnq5_P_npH90e6Vjr2qjsYbx2fF3MnerjJy=SzVM5ANR+EQcw@mail.gmail.com>
Subject: Re: [PATCH] drm: display: Remove duplicated argument in dcn31
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Chris Park <Chris.Park@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Anson Jacob <anson.jacob@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Jun 9, 2021 at 2:48 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> On 06/09, Wan Jiabing wrote:
> > Fix the following coccicheck warning:
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c:
> > 3539:12-42: duplicated argument to && or ||
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c:
> > 5677:87-123: duplicated argument to && or ||
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> > index d655655baaba..06fac59a3d40 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> > @@ -3536,7 +3536,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 4;
> >               *BytePerPixelC = 0;
> > -     } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> > +     } else if (SourcePixelFormat == dm_444_16) {
> >               *BytePerPixelDETY = 2;
> >               *BytePerPixelDETC = 0;
> >               *BytePerPixelY = 2;
> > @@ -5674,7 +5674,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
> >       for (k = 0; k < v->NumberOfActivePlanes; k++) {
> >               if (v->ViewportWidth[k] > v->SurfaceWidthY[k] || v->ViewportHeight[k] > v->SurfaceHeightY[k]) {
> >                       ViewportExceedsSurface = true;
> > -                     if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
> > +                     if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32
> >                                       && v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8
> >                                       && v->SourcePixelFormat[k] != dm_rgbe) {
> >                               if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k]
> > --
> > 2.20.1
> >
>
> + Anson
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
