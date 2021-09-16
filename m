Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0640D29B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 06:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhIPEkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 00:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhIPEkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:40:51 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D38BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:39:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m70so10399863ybm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObPDTmZPpxAdnjCpIiAd46RqCXfB5lsbopxNimw2AIA=;
        b=N5t7V90qffEF/ZhejZl+iBxrOA9sHwERjgwzmWS5h7qdVdKU0pCnOwskRNvjv5IsAW
         t82nIlvBzHnlUO8WxoEYOy3aLivxLUC4VdaYWOQgbsfLaC9+idrFwDycT8PQHGfm4kYD
         baFSptL9j5MNf9Plt3p8I/WmjueldYPgLYwrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObPDTmZPpxAdnjCpIiAd46RqCXfB5lsbopxNimw2AIA=;
        b=fHyEfTUDM1TYPk3gENYCJJkPmXjzOWfEMMVweDOxNJRWhzjgyv2lWBiJ3rpUiTib+7
         rpR6i6MgRcIIpjNWTBC4NGcj2dTkoC+RnKgXeiV/dUK9HYP2735RK8UsQCn+wvzQ08+y
         YZ2TuvrIwsw+eVjQXA8Sm4OM5JFfEIHqmGF60i4OI8MQ5yk69RWS2PzHXPTVzpDbEg2p
         PgNeBhU3/s3fD4/kxc4889Kxw5jNtm4MxsttwDb0GRgmuI96VLclQBW+pkpuxuZZ9nsS
         PiuBOsJD2EtYx+L0YmxELQlE1u/9jZa3BIofWlKMP0fITr7pvNp9L2BOpz1ithFro881
         RcxQ==
X-Gm-Message-State: AOAM530Wj+rspqSLUYKc+6qC5vS4VmatNpBgIodl+bHErBI2sCKtbK14
        n509zvoOsFpejTJEoD7NImokIWRhHz/oMCIlzowM
X-Google-Smtp-Source: ABdhPJz4i/E3+irjPi8Qhf59eg0o6TGq7n/Xy5hYwtrOOAatLAjPQqo3wDS945cVo/kelPy4rK20NZ9Vtvtmun2MIfE=
X-Received: by 2002:a25:1683:: with SMTP id 125mr4347701ybw.164.1631767170718;
 Wed, 15 Sep 2021 21:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-4-guoren@kernel.org>
 <20210915074827.GC20024@lst.de> <CAJF2gTSZLieg1kYA6a0CPajPukHzwN0wvPuh4RQ-t45fciFOYA@mail.gmail.com>
In-Reply-To: <CAJF2gTSZLieg1kYA6a0CPajPukHzwN0wvPuh4RQ-t45fciFOYA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 15 Sep 2021 21:39:19 -0700
Message-ID: <CAOnJCULyEHdyr9=Ez-NxRGKow3_RbNym_wg9RcZGWv-vJ-0B9Q@mail.gmail.com>
Subject: Re: [RFC PATCH V4 3/6] RISC-V: Support a new config option for
 non-coherent DMA
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
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 6:21 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Sep 15, 2021 at 3:48 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sat, Sep 11, 2021 at 05:21:36PM +0800, guoren@kernel.org wrote:
> > > +     select DMA_GLOBAL_POOL
> > > +     select DMA_DIRECT_REMAP
> >
> > No need to select DMA_GLOBAL_POOL when DMA_DIRECT_REMAP is select.
> If we want to support PBMT & global_dma_pool both in riscv. Could they
> work together in arch/riscv with [1]?

We don't have to worry about it as the next version of my series will
use the simpler
dma_uncached functionality to support uncached window approach taken
by starlight socs.

I was supposed to send it sooner but got busy with PMU stuff and a bad flu :(.

>
> [1]: https://lore.kernel.org/lkml/20210818142715.GA10755@lst.de/T/
>
> >
> > Also a patch just to add a option that is not selected and won't build
> > if selected does not make sense.
> I just want to rebase on Atish's patch and append DMA_DIRECT_REMAP.
> Okay, DMA_DIRECT_REMAP & DMA_GLOBAL_POOL should be separated from the
> patch.
>
>
>
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>
>   if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>      !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>      !dev_is_dma_coherent(dev))
>   return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>
> + if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> +    !dev_is_dma_coherent(dev))
> + return dma_alloc_from_global_coherent(dev, size, dma_handle);
> +
>   /*
>   * Remapping or decrypting memory may block. If either is required and
>   * we can't block, allocate the memory from the atomic pools.
> @@ -255,11 +260,19 @@ void dma_direct_free(struct device *dev, size_t size,
>
>   if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>      !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>      !dev_is_dma_coherent(dev)) {
>   arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>   return;
>   }
>
> + if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> +    !dev_is_dma_coherent(dev)) {
> + if (!dma_release_from_global_coherent(page_order, cpu_addr))
> + WARN_ON_ONCE(1);
> + return;
> + }
> +
> Here CONFIG_DMA_GLOBAL_POOL is independent from CONFIG_DMA_DIRECT_REMAP.
>
>   /* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>   if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>      dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
