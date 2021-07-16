Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9277A3CBAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGPQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:48:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DEC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:45:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so10474531ott.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oh7B6qOHJQLQ6+INHEXYWjtOIQ2UOCfXFqFA/OXfYPI=;
        b=O8xIqSR6UI188/ckW83ntnyI7R9KkV4/TFufwwMR3Suenw+hd30OLyXgNfPL5oQb4D
         KZzkAwvoj24wHKIJwyzH7963LW19rFCUCilqpATpLpRIUQ6TJuOiJyFoK3KU7orzpqTg
         BGU+5/qmoKTSju2RWekmWyD7m09Uwu/8QWv6K5G1sam2Elmmtu+U0xrFlzdTiO0Uf+H+
         2XyIGiAoLPe0QSrwyHQze2o+JMcE0ArvWms03ALhnySnsJdSTWiuuK7hf1R4b5hur6GK
         KVbCRp6oVKqWqlB6JJmumA4PRplqd75zeHo4w0n8ubPt9wKZ6I7hZjsQXQ0X8qeJrWkT
         ZrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oh7B6qOHJQLQ6+INHEXYWjtOIQ2UOCfXFqFA/OXfYPI=;
        b=oMb+tc8dYuaAlNqIs+g3kw5JMerhAMHMfbDWIeM9gUn1S/k8/SYoNZdIw5xl/4rQYm
         WAzmkDw8ivJJs3w/QC75KayRfR2ktBQZrnWDHkG6FEtbsZw9p1zhnDJa2i3EBFWnpLL2
         2L4Umbs9lAKss9pbATDygv0VgU2/vAPMGn4Rj6xWknl+bzQw8wm5EV7OBSfXCYfz6Oiy
         cFBlip5i/m7sojpHG705gWSU3Iv1aOgcsEI8JJC3gEyMdi0nM6VMSRKt4rbOm91sk+ov
         c+yXlrLcNXOzG9X/jyRF/kM42bzbrOlD/5MrLmMZvpeGtBMcT4OQrr+2VTwwr20t+gPt
         5hIQ==
X-Gm-Message-State: AOAM531jSRaAYL1lHoTcSPUoK2FYOlqMGqOpLwMUvqa6/U6G6yefKF9q
        SdbTQ8FSMSw+X6i4zaO8SSQaVzps8xiHvVqRasI=
X-Google-Smtp-Source: ABdhPJwkjInGKsBf98xS5SmZAnNHiwknlhx7YlHVTlwVei5t5dsp84qdFDSAKumFhbG0bUNXmw+5oc1bRyEOkWKQToY=
X-Received: by 2002:a05:6830:2683:: with SMTP id l3mr3098702otu.23.1626453957274;
 Fri, 16 Jul 2021 09:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210714080652.113381-1-liviu@dudau.co.uk> <CADnq5_OA-em2jM-vmwaM7xxycOS-18EPC0r_myb7REy9b4h_vA@mail.gmail.com>
 <CAEsyxyhurQ2vm=xwaRMqT8z+PJ2R60hYXt6kL8HnaB4zwbee3Q@mail.gmail.com> <ea5363b5-a54e-383d-f5bd-214bb8b50c96@amd.com>
In-Reply-To: <ea5363b5-a54e-383d-f5bd-214bb8b50c96@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Jul 2021 12:45:46 -0400
Message-ID: <CADnq5_NTdS2x6PU3G3awFQg6z=52bsV0JVXxiB_OnWA4pabTMw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix 10bit 4K display on CIK GPUs
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Mario Kleiner <mario.kleiner.de@gmail.com>,
        Liviu Dudau <liviu@dudau.co.uk>, Leo Li <sunpeng.li@amd.com>,
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

Applied.  Thanks!

Alex

On Thu, Jul 15, 2021 at 3:40 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-07-15 3:19 p.m., Mario Kleiner wrote:
> > On Thu, Jul 15, 2021 at 6:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Wed, Jul 14, 2021 at 4:15 AM Liviu Dudau <liviu@dudau.co.uk> wrote:
> >>>
> >>> Commit 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at
> >>> 30bpp for DCE-11.0.") doesn't seems to have fixed 10bit 4K rendering over
> >>> DisplayPort for CIK GPUs. On my machine with a HAWAII GPU I get a broken
> >>> image that looks like it has an effective resolution of 1920x1080 but
> >>> scaled up in an irregular way. Reverting the commit or applying this
> >>> patch fixes the problem on v5.14-rc1.
> >>>
> >>> Fixes: 72a7cf0aec0c ("drm/amd/display: Keep linebuffer pixel depth at 30bpp for DCE-11.0.")
> >>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> >>
> >> Harry or Mario any ideas?  Maybe we need finer grained DCE version
> >> checking?  I don't remember all of the caveats of this stuff.  DCE11
> >> and older is getting to be pretty old at this point.  I can just apply
> >> this if you don't have any insights.
> >>
> >> Alex
> >>
> >
> > Hi Alex
> >
> > I'd be fine with applying this. As my original commit says, photometer
> > measurements showed that increasing the line buffer depth was only
> > needed for my DCN-1 RavenRidge, not for my DCE-11.2 Polaris11 or a
> > DCE-8.3 cik, so this should probably not cause harm to the increased
> > precision modes.
> >
> > Note that given the hardware and USB-C/DP-HDMI adapters i have, I only
> > tested this on a 2560x1440@144 Hz DP monitor with DCN-1, DCE-11.2, and
> > a 2560x1440@100 Hz HDMI monitor iirc with DCN-1, DCE-8.3, and i think
> > on a 2880x1800@60 Hz MBP Retina eDP panel with DCE-11.2. These are the
> > highest resolution/framerate monitors I have atm.I don't have access
> > to any 4k monitors, so maybe the problem is somehow specific to such
> > high resolutions? Maybe somewhere else in the code something would
> > need to be adapted? Lacking actual hw docs, my coding here is by
> > pattern matching against existing DC code, guessing and testing on my
> > limited hw samples.
> >
> > Acked-by: Mario Kleiner <mario.kleiner.de@gmail.com>
>
> Makes sense.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> >
> > -mario
> >
> >>> ---
> >>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> index a6a67244a322e..1596f6b7fed7c 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> @@ -1062,7 +1062,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
> >>>          * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
> >>>          * did not show such problems, so this seems to be the exception.
> >>>          */
> >>> -       if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
> >>> +       if (plane_state->ctx->dce_version > DCE_VERSION_11_0)
> >>>                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> >>>         else
> >>>                 pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
> >>> --
> >>> 2.32.0
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
