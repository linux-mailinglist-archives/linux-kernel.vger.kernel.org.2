Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D579C32ADB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359830AbhCBWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444904AbhCBTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:31:46 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32721C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 11:30:45 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w69so23227353oif.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+SvXqEUjfhHwthcmMkrQk6d+ywLo9CmIC2aql3ZVM0=;
        b=Lp7mh2C4IHdf0flEGeKe/5N8ZYv6KEEUscBWkwK1euVPGZ/fOHaRUUpBQnOpSgw/si
         xY+qfrjzZF1/am/b6SwS9j6EZgOol6H/gb4/AGyAlk3BbhEoT2ZAbIIpvQuondXQlcU0
         wLG3M1raZqNKtcfCbJmLXbjsYHFA01JqedLealCorhgejMvwwmzFsVgx+Ad4KGxFznvG
         EyU7C/gs4iWpZ7lPgLBGUauUIi6ATTILlwLP19Wx31EpdPTyC5h1/UWGXxiC4OK7T0jB
         3ZkUdZ/EAxW/34sWDTcRSdtvk7HhGBBSCY3IfWdMA/li4ff9B9giPEkYjw62qhWGK2Cw
         yA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+SvXqEUjfhHwthcmMkrQk6d+ywLo9CmIC2aql3ZVM0=;
        b=XVoHd3OXo4W46L3xLHWw3mWdYrC6y+7yXGeDRZlrqWv4jBy/qkXdCLh6fvIWRXiudm
         lNd19b0AgA3E6bKQ6o0lCGBV+aPVcGpH+ApYwL2hx8W7AANarljxR6rMKAD0edK/YH7S
         fTjzxrHYHp92SIxV/kk4PQJLRZvQwTxrnsksTV1nTlAUrMzWO9k6o3OfKKjfGBGdf2vc
         fBMXoyidV7HwbYYu//29JvVMKIhAJ9WE3e13/k+5IuQ5ciHiXcnw3hzvHXNSUUTHdB1q
         dKkpT8X19bw7viHtm7Jt/BjqXSPgQTvo00JGftsg800gfAK29sGq3HzfpFqV+CXePDyJ
         O5qw==
X-Gm-Message-State: AOAM530binJu4FmRTZQRORlJl3/PQp7e6Tm+h6hQDUkfr9kvn/yClaMs
        TI9k36mgOshYHTb4pDqoNNMrBDtTnm2W9Tf4PKI=
X-Google-Smtp-Source: ABdhPJzlv/EMCY/06qzQWW42RcptrNGrRcveS7uV6iQI72w++yR/IzUbjOzwaHiRbj/bu1zhokO2qeQJsPzzePUxsU4=
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr4350086oiw.123.1614713444602;
 Tue, 02 Mar 2021 11:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20210301104316.2766484-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Mar 2021 14:30:33 -0500
Message-ID: <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, 1 Mar 2021, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.12-rc1[1] compared to v5.11[2].
> >
> > Summarized:
> >  - build errors: +2/-0
>
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
> >
> >
> > *** ERRORS ***
> >
> > 2 error regressions:
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
>
> powerpc-gcc4.9/ppc64_book3e_allmodconfig
>
> This was fixed in v5.11-rc1, but reappeared in v5.12-rc1?

Do you know what fixed in for 5.11?  I guess for PPC64 we depend on CONFIG_VSX?

Alex

>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
