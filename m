Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C03A89F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:10:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5291EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:07:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r16so19124745oiw.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grpU+dQ6BtmxyQhqwU8VFa14I3/A2Q4X/WY+Pgyf6LU=;
        b=i95F7m9fSgaCfK1vBEfApT1tlSEjk19eUCHmQCgPU3lENBPylJ9IljD7V+1hDtpIO5
         J4uwdhfHQawtz00tf4AJG2xJtxkqbDEXVB/nzknIAC8tn4mLbSg78YlColMLDNlsU0YG
         n4qT4l8cL+iGNVLmK3F2JPDYMh6l+tybd/5ma6JdsmK+VXL5hPS8zJ2zDDCc/Ex7v0Wh
         GAGq4dHALmIoRnt6YDZyaE514UwJPJmK0EcyCobAHk/8F4elgtR/4/YWyGg4zHxZn4AE
         wGiFddT9qzc20CpHvC1HHdidvwAoSXmXQN0rmU4VRdYtqaDjg+M4YengxDYlj/gESBIf
         hQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grpU+dQ6BtmxyQhqwU8VFa14I3/A2Q4X/WY+Pgyf6LU=;
        b=GMCLMO3CPf0RfjphGb2dX3uHTBi5hUVrtrFKIUta0n4L0V5xoemhLQ091wsI6hVou5
         R+6px4RanWGABvlip4bW64LeIgN3FdORWMLsgxpR/6fw/0WP5E+5pZofdlrO7mpvKgZf
         cYvGMTzrXSEt/OI1NoI90nuE7RQ9x/JvFGv1dP5OTcRNT2DY1CO/86tjId0XlaF4zIos
         +LeVbpQG1ONtn6twiE0JQWIersB6DkxR4EW4TR70jvHdIYqT5nMMnZcV/kjTbZs1pF97
         BT0czdaXbKFe52sD8xVqVo4OC4xB+OiHs+ltNsye/GAzj3d1PAQT1OocQmeDKZ5L0qz8
         04Hg==
X-Gm-Message-State: AOAM533Ity+m7JKBnDJ91tbxXTWAFV0NDpX2pPAAf9+NyIw+UrlWRVvO
        89NXy6ZQIKQGG7ID2dFo5/X8qh5O6rZIClra0PE=
X-Google-Smtp-Source: ABdhPJwzP9efs2U6D7VzGqrlTEr9BDxh02uo2PpPnHgBG/J7KcRFMiuDelbPo7UwGsMyezXZFRpLA4KQlSdsxMJnIkA=
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr556675oic.123.1623787677732;
 Tue, 15 Jun 2021 13:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615114410.7708-1-wanjiabing@vivo.com> <20210615125402.nhvl2g7q2da4sb3r@outlook.office365.com>
In-Reply-To: <20210615125402.nhvl2g7q2da4sb3r@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Jun 2021 16:07:46 -0400
Message-ID: <CADnq5_P7petfdwXgfe-JK4NYgQoojHB6tpJ2ejrt+1Fyg6TDrA@mail.gmail.com>
Subject: Re: [PATCH] drm: display: Fix duplicate field initialization in dcn31
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Zhan Liu <zhan.liu@amd.com>,
        Roman Li <roman.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!


On Tue, Jun 15, 2021 at 8:54 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> On 06/15, Wan Jiabing wrote:
> > Fix the following coccicheck warning:
> > drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c:917:56-57:
> > pstate_enabled: first occurrence line 935, second occurrence line 937
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > index 0d6cb6caad81..c67bc9544f5d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> > @@ -934,7 +934,6 @@ static const struct dc_debug_options debug_defaults_drv = {
> >       .dmub_command_table = true,
> >       .pstate_enabled = true,
> >       .use_max_lb = true,
> > -     .pstate_enabled = true,
> >       .enable_mem_low_power = {
> >               .bits = {
> >                       .vga = false,
> > --
> > 2.20.1
> >
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> Thanks
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
