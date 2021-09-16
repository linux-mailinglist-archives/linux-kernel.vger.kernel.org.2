Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2688C40D129
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhIPBWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhIPBWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:22:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3F060F93
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631755245;
        bh=N8vdbjyf2kqAOWnVrEA55RFKSMKRgVPo8mZ596qmFTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aCA9nZNVQ69O0f+yv/wo3D1I0gnuAseS7SrmlT9uFmDp4Vas95th0CZqUCQCAYsoE
         CTd8jk1mSUAARkLeGoMMgxyqSN4DA8ebpmteW2PCI4pP6tdzd+V9YOgT4gaMl5Se1w
         /bKTV5NcKG2KpZfaAhHXJFTOtRBXSp/b7l1+ex6yQx2o3pRZwoasJEoNUxQuWUszIG
         mD5fJXz/5k+d/4OBT3u4VtlURFEm9AyBHo62jCl1MmR//eLZ1BMAAw/mF0aMF6V2AJ
         m56ZvQQ56apZjYrr9k0frhQpss7qtRIJp+2wGN19n/Ntr2hMkR5v+cipoJLJT0rUBF
         WMRkU+MT1czyw==
Received: by mail-lf1-f43.google.com with SMTP id y28so11874617lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:20:45 -0700 (PDT)
X-Gm-Message-State: AOAM533nf6PqwqdjbskEBLQJWIarMynMtOp32PjAC/81XPiCCPkqcZkx
        uzc1vJe/grm9E5nWoInHZkv3jbYk6aBsoI5/yFo=
X-Google-Smtp-Source: ABdhPJz+GXHr4HX2v0FUy9aKwpP8QUXw8A79CVUhuNj8Hy1BRETa0saqeya2VTa2CI7/Bd1Vfz9vb5u3+LerP+oeraU=
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr2571362ljp.507.1631755243805;
 Wed, 15 Sep 2021 18:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-4-guoren@kernel.org>
 <20210915074827.GC20024@lst.de>
In-Reply-To: <20210915074827.GC20024@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 09:20:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSZLieg1kYA6a0CPajPukHzwN0wvPuh4RQ-t45fciFOYA@mail.gmail.com>
Message-ID: <CAJF2gTSZLieg1kYA6a0CPajPukHzwN0wvPuh4RQ-t45fciFOYA@mail.gmail.com>
Subject: Re: [RFC PATCH V4 3/6] RISC-V: Support a new config option for
 non-coherent DMA
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 3:48 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Sep 11, 2021 at 05:21:36PM +0800, guoren@kernel.org wrote:
> > +     select DMA_GLOBAL_POOL
> > +     select DMA_DIRECT_REMAP
>
> No need to select DMA_GLOBAL_POOL when DMA_DIRECT_REMAP is select.
If we want to support PBMT & global_dma_pool both in riscv. Could they
work together in arch/riscv with [1]?

[1]: https://lore.kernel.org/lkml/20210818142715.GA10755@lst.de/T/

>
> Also a patch just to add a option that is not selected and won't build
> if selected does not make sense.
I just want to rebase on Atish's patch and append DMA_DIRECT_REMAP.
Okay, DMA_DIRECT_REMAP & DMA_GLOBAL_POOL should be separated from the
patch.



--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,

  if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
     !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
     !dev_is_dma_coherent(dev))
  return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);

+ if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+    !dev_is_dma_coherent(dev))
+ return dma_alloc_from_global_coherent(dev, size, dma_handle);
+
  /*
  * Remapping or decrypting memory may block. If either is required and
  * we can't block, allocate the memory from the atomic pools.
@@ -255,11 +260,19 @@ void dma_direct_free(struct device *dev, size_t size,

  if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
     !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
     !dev_is_dma_coherent(dev)) {
  arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
  return;
  }

+ if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+    !dev_is_dma_coherent(dev)) {
+ if (!dma_release_from_global_coherent(page_order, cpu_addr))
+ WARN_ON_ONCE(1);
+ return;
+ }
+
Here CONFIG_DMA_GLOBAL_POOL is independent from CONFIG_DMA_DIRECT_REMAP.

  /* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
  if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
     dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
