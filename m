Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821EE3CAD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbhGOT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbhGOTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:51:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818BC014B1E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:20:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qb4so11060871ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihOfb0tc3xVL5q8N3onToRfW8DW3UJeYLmddd1YjXNw=;
        b=TNgFfAfMluhQ3/TAFnzR108JbZSD2t2Cg2OhHV+y5IzE4VZgg1atgOSY+17DQV4w2c
         au925Ps4U0kh4odD9rUI8rvZ8i8ZVpvl5YuAvvi1UdsMvzHYryfDULnip10C99VCRPlP
         Z3Bd9lXqcSyqY11k16uH3Pyu5BSAfZ2ylIIIzQD7lxNYjEI6xTXO2Uoriff7B5obchay
         /uynkrtBj0a+NGRdJDqlyJRt4vgm8Stvy/RUVvzDwA6SaqTpF9rlpqCL/iJM5AAMfPws
         vK/Jz0snmMnTjnh6Q/EQhTW9IdDcJdk3Ezysmcrxz+8s5cfzdi1W0iY7vB6RrgSUeVlG
         Kb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihOfb0tc3xVL5q8N3onToRfW8DW3UJeYLmddd1YjXNw=;
        b=OIcdxmJkygOBszrBnsdiaTxd7NO3dDhofP3ghe19V+Hmbc0P2KWXWfcGUbWa3fwaQH
         n+gF+nf/N4Tx0wB6Td9SR6DVf0yf9KxzaWkMVs4GOHAT+ogpuYk3pHJKg2yjzbKrUt6W
         GUDMHok0+NeBjoaeRby9q0wbh/GAsQY45HGfde//xg54cXCP1b6h/SXVZK8IoCprFvk0
         Rkj/N0uLbEZgrF6BEQW12Mm/EunfTgFMpuRPSTYBZqEHh1T3829Wvb6kxtir+deAH8dv
         lygpuppw1E/GgLElPOnjOhj7fPcGq1cga7t1OE0vPz9U1AJxjRsyEW5FkumcQfS9rGHq
         K36Q==
X-Gm-Message-State: AOAM531Og+4uoGWJLZkby3kyxKRhaMl+RK2Su2y4eTH5Q+tVmCiZUMVE
        WVP8VPehwCaEK1Onm8GZasgECDURVxhwVmNjalc=
X-Google-Smtp-Source: ABdhPJzFJhZDB3GiTntdV5Ju70ZAArFbxHINZyOxXMcxKyzPXkyoe3NFdbQONOO97TDXsNpV1EreDhU1j7OBkscM1O0=
X-Received: by 2002:a17:906:4a8d:: with SMTP id x13mr7186041eju.349.1626376805330;
 Thu, 15 Jul 2021 12:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210714080652.113381-1-liviu@dudau.co.uk> <CADnq5_OA-em2jM-vmwaM7xxycOS-18EPC0r_myb7REy9b4h_vA@mail.gmail.com>
In-Reply-To: <CADnq5_OA-em2jM-vmwaM7xxycOS-18EPC0r_myb7REy9b4h_vA@mail.gmail.com>
From:   Mario Kleiner <mario.kleiner.de@gmail.com>
Date:   Thu, 15 Jul 2021 21:19:53 +0200
Message-ID: <CAEsyxyhurQ2vm=xwaRMqT8z+PJ2R60hYXt6kL8HnaB4zwbee3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 10bit 4K display on CIK GPUs
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 6:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jul 14, 2021 at 4:15 AM Liviu Dudau <liviu@dudau.co.uk> wrote:
> >
> > Commit 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at
> > 30bpp for DCE-11.0.") doesn't seems to have fixed 10bit 4K rendering over
> > DisplayPort for CIK GPUs. On my machine with a HAWAII GPU I get a broken
> > image that looks like it has an effective resolution of 1920x1080 but
> > scaled up in an irregular way. Reverting the commit or applying this
> > patch fixes the problem on v5.14-rc1.
> >
> > Fixes: 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at 30bpp for DCE-11.0.")
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>
> Harry or Mario any ideas?  Maybe we need finer grained DCE version
> checking?  I don't remember all of the caveats of this stuff.  DCE11
> and older is getting to be pretty old at this point.  I can just apply
> this if you don't have any insights.
>
> Alex
>

Hi Alex

I'd be fine with applying this. As my original commit says, photometer
measurements showed that increasing the line buffer depth was only
needed for my DCN-1 RavenRidge, not for my DCE-11.2 Polaris11 or a
DCE-8.3 cik, so this should probably not cause harm to the increased
precision modes.

Note that given the hardware and USB-C/DP-HDMI adapters i have, I only
tested this on a 2560x1440@144 Hz DP monitor with DCN-1, DCE-11.2, and
a 2560x1440@100 Hz HDMI monitor iirc with DCN-1, DCE-8.3, and i think
on a 2880x1800@60 Hz MBP Retina eDP panel with DCE-11.2. These are the
highest resolution/framerate monitors I have atm.I don't have access
to any 4k monitors, so maybe the problem is somehow specific to such
high resolutions? Maybe somewhere else in the code something would
need to be adapted? Lacking actual hw docs, my coding here is by
pattern matching against existing DC code, guessing and testing on my
limited hw samples.

Acked-by: Mario Kleiner <mario.kleiner.de@gmail.com>

-mario

> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index a6a67244a322e..1596f6b7fed7c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -1062,7 +1062,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
> >          * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
> >          * did not show such problems, so this seems to be the exception.
> >          */
> > -       if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
> > +       if (plane_state->ctx->dce_version > DCE_VERSION_11_0)
> >                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> >         else
> >                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
> > --
> > 2.32.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
