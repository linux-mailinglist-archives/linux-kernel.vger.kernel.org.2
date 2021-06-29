Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8853B76A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhF2QuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhF2QuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:50:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:47:32 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a5-20020a05683012c5b029046700014863so6508943otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGTK4lyAMdeYSqK3dGA2v+GiJW5Wa7AmD5LZbDWF2LE=;
        b=Q5uzHCoi5dQJkGW36AFCtkNIiGQDKyQ8V5uKpN0wkzykiKyCVjL8Bfj6Be6Gd9x4of
         elyv0+DB7ZnuKpJ+B5GOZu/YGBUsJsEffcKOjJY9IPYVBeWoZpbgRZ3rKMzfneoyV1ma
         BwOXaIDLbQuoNjQCwvCjApiNxxLRZvfiBr8c51Ol5b0JYeyybQ51qJToFtDeqpW+WbEE
         BoGKH9snFUYSVFfqgeZtgLk5FU4N5trf8f+i3XDs0CpAnecKCLNObvinSLf7M2DNwDLz
         kMRnQLwMlGql1OlJu74MmrEra5Z9zp3Jp6xJoxEJielk5DM+vGenWf03inbdnQ2Afuvt
         tdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGTK4lyAMdeYSqK3dGA2v+GiJW5Wa7AmD5LZbDWF2LE=;
        b=o13mdozmVXX7CHdroH2RuqK/h+2+iT5Km78o9mwmoVxHsnRZL+R3MtFpea3lCDQHMH
         KAn+KC3VaDRiByZWp6j7Y4lwAiPzMyDxW2qw3VI6ZRXnmTx3/7U11qVdtPvN12/J4Vgu
         N6h/lxRv0Qpv71D4qkyLAdrB2pIGCtDuJpV1Uba+Q9gnYrdlKKrFtdNRM2h+CgDDaz0b
         nowqtw+imjJSSpXrmtD1IXgJ4UwjGI67SxNz3x6ey210tm+e/4H2lTizODznL+omCHL3
         EBjd2RwTE0OSxOXLE3kxoYBw1nNrPDZZ22FoXphF4bAgrdrwCNKQe4zIQy8aT/Sm4G+0
         4Dzg==
X-Gm-Message-State: AOAM530PtyalD3QmESg/en2mw1N/DFvjn+Iy+D6fZRESeDEeDdSa2ljk
        L3IgWrAipUR1caHY43Dgp5yIwgTGTOc8lI4IPxw=
X-Google-Smtp-Source: ABdhPJwAtOPJLy7khY9BGMqPmkZQ3pEn+TYCMaJD8d1zpiZNz/ojO0rlC+Y7kq60yh5KEFZlyHLCiNDcEjkqteqw1/8=
X-Received: by 2002:a05:6830:33ef:: with SMTP id i15mr5256611otu.311.1624985252222;
 Tue, 29 Jun 2021 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210629112647.1.I7813d8e7298aa1a1c6bee84e6fd44a82ca24805c@changeid>
 <9e21a922-38d2-3d03-4524-c122965f7db3@amd.com>
In-Reply-To: <9e21a922-38d2-3d03-4524-c122965f7db3@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jun 2021 12:47:21 -0400
Message-ID: <CADnq5_PXwDe03e8zJ7O6Y0FXKsp0FngyRVQvaM=hN9UWE6TmTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Respect CONFIG_FRAME_WARN=0 in dml Makefile
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Reka Norman <rekanorman@chromium.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Reka Norman <rekanorman@google.com>,
        Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Kolesa <daniel@octaforge.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Huang Rui <ray.huang@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Jun 29, 2021 at 11:10 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-06-28 9:27 p.m., Reka Norman wrote:
> > Setting CONFIG_FRAME_WARN=0 should disable 'stack frame larger than'
> > warnings. This is useful for example in KASAN builds. Make the dml
> > Makefile respect this config.
> >
> > Fixes the following build warnings with CONFIG_KASAN=y and
> > CONFIG_FRAME_WARN=0:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3642:6:
> > warning: stack frame size of 2216 bytes in function
> > 'dml30_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6:
> > warning: stack frame size of 2568 bytes in function
> > 'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than=]
> >
> > Signed-off-by: Reka Norman <rekanorman@google.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > index d34024fd798a..45862167e6ce 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > @@ -50,6 +50,10 @@ dml_ccflags += -msse2
> >  endif
> >  endif
> >
> > +ifneq ($(CONFIG_FRAME_WARN),0)
> > +frame_warn_flag := -Wframe-larger-than=2048
> > +endif
> > +
> >  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> >
> >  ifdef CONFIG_DRM_AMD_DC_DCN
> > @@ -60,9 +64,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
> > -CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
> > +CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(frame_warn_flag)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
> > -CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) -Wframe-larger-than=2048
> > +CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> >  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
