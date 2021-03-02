Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22E332ADD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840076AbhCBWPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:15:33 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:35630 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbhCBUCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:02:19 -0500
Received: by mail-vs1-f54.google.com with SMTP id t23so11295950vsk.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzf9U5TyFr8YSgCYbQV0aCCbWT0MRYgraMrf2J/E5OM=;
        b=MUIBpGfgoiHEGU8xStahm+ISOYThAi3D01ZDeHRZzZPF4mIXur0dDMfZFBnWhCAs20
         GWGWwrO74a3BpGmBDsu6PGoV81YFbfPGAiOfmxUW9AYqvNGSyIu4+fddsQPgtxRuefQH
         JBHmDZUwgFoqC/9Wt/bKhdrF+4tKZdN5tReD7pVSZEppA7HxXpZLaVMYD8jY50uBfF0O
         lJbZQH40qx/6Wzyj3B6JbP/6uazo8s3kQ5x3jiQWWk23bScPkkqmCmZgGZzd8By2uws0
         2oEZr+aZnnVDL68/Vylphr2HLG8xc3AQotfFXdLB0q6X+9rcCjXmD0vj9+mRQaDjcMH5
         xX1A==
X-Gm-Message-State: AOAM531IN3X5zw8k7upsd5Gc8h8rLydmxxCRnQmUuv+N6bUzBEq6qHbr
        5iUnc4pw/nt30ajO6lK6YRSIu+ch/NAQTJhkWps=
X-Google-Smtp-Source: ABdhPJzRCGpW4RCsZEhpYEAn3MR1Q73gbJHqe3CH+KRCFvVBwE5R/NVI0GIx7VbV9hgc+A3Gg/HXK7gUOE34HM0PfoU=
X-Received: by 2002:a67:fb86:: with SMTP id n6mr3865292vsr.3.1614715282171;
 Tue, 02 Mar 2021 12:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20210301104316.2766484-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg> <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
In-Reply-To: <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 21:01:10 +0100
Message-ID: <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc1
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, Mar 2, 2021 at 8:30 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, Mar 1, 2021 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 1 Mar 2021, Geert Uytterhoeven wrote:
> > > Below is the list of build error/warning regressions/improvements in
> > > v5.12-rc1[1] compared to v5.11[2].
> > >
> > > Summarized:
> > >  - build errors: +2/-0
> >
> > > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
> > > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
> > >
> > >
> > > *** ERRORS ***
> > >
> > > 2 error regressions:
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
> >
> > powerpc-gcc4.9/ppc64_book3e_allmodconfig
> >
> > This was fixed in v5.11-rc1, but reappeared in v5.12-rc1?
>
> Do you know what fixed in for 5.11?  I guess for PPC64 we depend on CONFIG_VSX?

Looking at the kisskb build logs for v5.11*, it seems compilation never
got to drivers/gpu/drm/ due to internal compiler errors that weren't caught
by my scripts.  So the errors listed above were not really fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
