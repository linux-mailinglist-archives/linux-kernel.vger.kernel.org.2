Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05E40D266
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 06:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhIPE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 00:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhIPE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:26:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:24:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q11so7209231wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3F+o0j9jxKTxiI+Asnv/VhXByAoLQ8BKv0fUB5qlTq0=;
        b=t3/5Icsh9RDoPOdDCqDC7zfKbtWPaJ0wgaKU1BJ4Z/dd8cj0/PCkM9X6W7+QXkKFbh
         iT3ZA2KEuPEQY0Dma7pyaJQJQr6Y1tHoQ/919xDOzE2l7ZF8YYlGNar6oaZjxpVWJoxf
         DIqnJUyTU+UF1L1K1a9OsN+jXfIdHeKrbxDWzIPWWLI3FHH8LiAnbgHDRjxSqC8nlVL6
         rKA/gHU3xSGcjyxN63ZCGgXcjw27hu6xp3yPwLI93eyj6i1FzjC++XxcfQZBZKw12Mca
         +OBJ/LZCsUr4ZIc5qBShY9G78PMxn69PcSEEYfxcq6OSlaPjiuBQ4+qsN5UACI+fx3Wn
         Go2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F+o0j9jxKTxiI+Asnv/VhXByAoLQ8BKv0fUB5qlTq0=;
        b=wmeZG438l1lLwq4Tb+DqUrtzwCR1vpt7Ocz8nwR3SHjCoaAv7RyhAnbo4ZVcVCEhTD
         gbvWR/Dn30gU7FOVjM7/4BsssU43gdXhXz+S21QgKTy7vajLfPti5P0crZGDsVZ9JGf4
         dsPkDASjnSjxcaoKDKJQZb67ud5zWJebYsIYF6r5+c0m31ytmw/oh9QlwexIO2OJV/uf
         jBYykLaVsSu75ktdJYi7jgTnJLp2AMF/5JEGPYjf3mfvCud934Pne01NYK0SFL8I78g8
         mlA8v4JMGuuVUtOWcjIyucAi+2ByOb+jsWULjRDkFFpm+KZSZqoIv9Ce0tKGZlFvkcql
         L3SA==
X-Gm-Message-State: AOAM532NBcdm0UHcr+WLFB72WBFyQVyhiuv/qj37viaeuGY9wiBP67ru
        dt4cUM8rfA0ZhoiMyYFvCi/ssb31Hjx7m7GY0M+C+g==
X-Google-Smtp-Source: ABdhPJx2cKD6nQJM73FlWA5hhY8gQepri1EBWZutYONDNBJS3CwQcDwu7fycgaovPzDCqM/S71/7KiH0VcYH/dtpP+Q=
X-Received: by 2002:adf:d084:: with SMTP id y4mr3545518wrh.249.1631766288162;
 Wed, 15 Sep 2021 21:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-5-guoren@kernel.org>
 <20210915075007.GD20024@lst.de> <CAJF2gTSgbmff7aTjwTD+rhQroWeaXfjepGeEAmooBV6d4u70kg@mail.gmail.com>
In-Reply-To: <CAJF2gTSgbmff7aTjwTD+rhQroWeaXfjepGeEAmooBV6d4u70kg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Sep 2021 09:54:36 +0530
Message-ID: <CAAhSdy1hdgn94eQKkgG6WtWxf-cNEFnaxPtKTgOKeRaBO5V-zg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 4/6] RISC-V: Implement arch_sync_dma* functions
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
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

On Thu, Sep 16, 2021 at 7:03 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Sep 15, 2021 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sat, Sep 11, 2021 at 05:21:37PM +0800, guoren@kernel.org wrote:
> > > +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > > +{
> > > +     if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > > +             dma_cache_sync->cache_invalidate(paddr, size);
> > > +     else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > > +             dma_cache_sync->cache_clean(paddr, size);
> > > +     else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > > +             dma_cache_sync->cache_flush(paddr, size);
> > > +}
> >
> > Despite various snipplets this is a still pretty much the broken previous
> > versions.  These need to use the CMO instructions directly which are
> > about to go into review, and then your SBI can trap on those can call
> > whatever non-standard mess you're using.
> I think you mean put an ALTERNATIVE slot in the prologue of __dma_sync?
>
> #define ALT_DMA_SYNC()                                           \
> asm(ALTERNATIVE(".rept 64\n nop\n .endr\n", "<vendor code>",
> XXX_VENDOR_ID,        \
>                 ERRATA_XXX, CONFIG_ERRATA_XXX)  \
>                 : : : "memory")
>
> static void __dma_sync(phys_addr_t paddr, size_t size, enum
> dma_data_direction dir)
> {
>         ALT_DMA_SYNC();
>
>         /* future cmo codes */
> }

I think Christoph is suggesting to always use CMO instructions for
implementing arch specific DMA sync functions. The SBI implementation
will trap-n-emulate CMO instructions when underlying HW does not
have it. This means custom cache instructions on D1 can reside in
the platform support code of OpenSBI.

I also agree with the above suggestion. At least, this will ensure that we
have only one way of doing cache operations from S-mode perspective
which is CMO instructions.

Regards,
Anup

>
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
