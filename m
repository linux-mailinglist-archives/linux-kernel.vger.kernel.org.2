Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0340D2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 06:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIPEoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 00:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhIPEn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:43:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E244C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:42:39 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a93so10474325ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FI6YcgDTwmh92T2Tz0zE+YLI6Tc+4Fm0YSTJ17PXswQ=;
        b=becGQyFpbtC4G/09KFN7ZM9j4ZAjZDFIlLPI4icTAnOAuMMuV2pUbVZIQmpnBXmzNq
         H/zKbZzlXSBmQJJrNIKm4qqwLXN3fjm1VAK6sRBLEo3JGbF9B+68TG9LV/Q1DWCT1PIa
         G3FfSyFoelepOtGOkEZF+ugdBNbcwyiigfW9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI6YcgDTwmh92T2Tz0zE+YLI6Tc+4Fm0YSTJ17PXswQ=;
        b=AAtMkGuXoTttApLzea6+CJkwQpOt/Qi47LiirjtofAk8m1VeZh3Cv25/mEOQoyBjUI
         8ou8pRi6qGlR+19Gto8TizSMZOU8Y4a3Vw8FQQojuUCgwwxUwkd5OaFYvtqT256msUYq
         oqU8vYHkIYKY61iJdgn+p8A6EZ1xJ54gPPhDhzjgpVmk2YSYrpTnuIuEN3UVshnG3UyZ
         wqIsvcDBqIjnjxM9bpsbDxv8C34e8SzAwGgjFjVIsPp7rFOHcjvzXq5GjMKjd0iU0FB0
         eSW8Z4JyyVIPms9/9ER3oWxM8HZk90UPwl6lHKwXEKCSS2EoJ7wXjZ90Nai+v8PnjyXl
         CH4w==
X-Gm-Message-State: AOAM530B7ObJ3C2t8qx808TQR76nu/Bj404UQxFCDZn1sKTcvUjBQK6L
        v9Pj5fIq82tLDQLGlV2qOPUxrpmQR/IUasIpboV1
X-Google-Smtp-Source: ABdhPJzX4DibkVG6ODqR3hw14RQsMpLCXnQQnm7eQIzxz69L+RLuUsKzkMvS55nHRhEN9xk9I90s1MZ38yc3G4x6Wpo=
X-Received: by 2002:a25:9d83:: with SMTP id v3mr4465092ybp.97.1631767358505;
 Wed, 15 Sep 2021 21:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-5-guoren@kernel.org>
 <20210915075007.GD20024@lst.de> <CAJF2gTSgbmff7aTjwTD+rhQroWeaXfjepGeEAmooBV6d4u70kg@mail.gmail.com>
 <CAAhSdy1hdgn94eQKkgG6WtWxf-cNEFnaxPtKTgOKeRaBO5V-zg@mail.gmail.com>
In-Reply-To: <CAAhSdy1hdgn94eQKkgG6WtWxf-cNEFnaxPtKTgOKeRaBO5V-zg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 15 Sep 2021 21:42:27 -0700
Message-ID: <CAOnJCU+j33gaq4rDsXnDotTRnfCxsR81V4aHayNjbg7=DsB3Fw@mail.gmail.com>
Subject: Re: [RFC PATCH V4 4/6] RISC-V: Implement arch_sync_dma* functions
To:     Anup Patel <anup@brainfault.org>
Cc:     Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 9:25 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Sep 16, 2021 at 7:03 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Wed, Sep 15, 2021 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Sat, Sep 11, 2021 at 05:21:37PM +0800, guoren@kernel.org wrote:
> > > > +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > > > +{
> > > > +     if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > > > +             dma_cache_sync->cache_invalidate(paddr, size);
> > > > +     else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > > > +             dma_cache_sync->cache_clean(paddr, size);
> > > > +     else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > > > +             dma_cache_sync->cache_flush(paddr, size);
> > > > +}
> > >
> > > Despite various snipplets this is a still pretty much the broken previous
> > > versions.  These need to use the CMO instructions directly which are
> > > about to go into review, and then your SBI can trap on those can call
> > > whatever non-standard mess you're using.
> > I think you mean put an ALTERNATIVE slot in the prologue of __dma_sync?
> >
> > #define ALT_DMA_SYNC()                                           \
> > asm(ALTERNATIVE(".rept 64\n nop\n .endr\n", "<vendor code>",
> > XXX_VENDOR_ID,        \
> >                 ERRATA_XXX, CONFIG_ERRATA_XXX)  \
> >                 : : : "memory")
> >
> > static void __dma_sync(phys_addr_t paddr, size_t size, enum
> > dma_data_direction dir)
> > {
> >         ALT_DMA_SYNC();
> >
> >         /* future cmo codes */
> > }
>
> I think Christoph is suggesting to always use CMO instructions for
> implementing arch specific DMA sync functions. The SBI implementation
> will trap-n-emulate CMO instructions when underlying HW does not
> have it. This means custom cache instructions on D1 can reside in
> the platform support code of OpenSBI.
>
> I also agree with the above suggestion. At least, this will ensure that we
> have only one way of doing cache operations from S-mode perspective
> which is CMO instructions.
>

Sounds good to me. For stralight Socs, we may need to add a l2 cache controller
driver in OpenSBI as well. IIRC, sifive cores do have some M-mode only
CMO instructions
as well but they may not align with CMO spec. I have to double check.


> Regards,
> Anup
>
> >
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
