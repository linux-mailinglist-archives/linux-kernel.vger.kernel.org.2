Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4437B66B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhELHB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhELHBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB366192E
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620802813;
        bh=tOlm23mTOpNM0/BbK/ucKXhqG2RgCDl/OY+dbOJpNlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TWprbVSJw/7Y52OoBeErncbDWObcKZErbEP7n9087p7QetbLh0+ddhF0dJN0VtnRn
         lhaJ4+89Tu10BwQTI91IyHahseZGISnbKtQyWPsLpVtgfIF4wpK/uY3lvV9CeqvKKs
         Qm4oX1UuNKwGsbS2+UyX7XTSMGw0C4if2NJXeWFp6J6qhUmeOqCqYiLW7HZqQaxZMD
         hzXx6rD62P4ySuu6A/z3yiTrdX+ILDtXlWY79HqfY9F2ol/tEHUqEwFXymm5jxxXK1
         3GFKD42/JceAA8vvRrC9wsMlC3bDu13YowtjQ3uvy57H47TSehrxh17TUspc5foTb2
         U853PsOiPLu5g==
Received: by mail-ot1-f41.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso18943082ots.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:00:13 -0700 (PDT)
X-Gm-Message-State: AOAM533Xwqb1fjGCPLEYEO/O+E3he9XnHMWi9BP8wHAFzTTwQ+YDeAuI
        GcXHUgY5H/1dGMjVGm1GfH7L2H4UMqSSCYyvTOo=
X-Google-Smtp-Source: ABdhPJxU0Rx7jp0gaYTPEDkowYZKavU9wU/cyN0P5bupNnkZT/v5SN2zcx17yX3HlQYWKlMd1elbP469y2PbHzA/c0M=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr17652427otn.90.1620802812741;
 Wed, 12 May 2021 00:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210511100550.28178-1-rppt@kernel.org>
In-Reply-To: <20210511100550.28178-1-rppt@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 09:00:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHLkmgZKEb8BtgGt6GQ93Qd+yv6NtiCvtgX0ex9wSeyw@mail.gmail.com>
Message-ID: <CAMj1kXFHLkmgZKEb8BtgGt6GQ93Qd+yv6NtiCvtgX0ex9wSeyw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 12:05, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> pfn_valid_within() to 1.
>
> The idea is to mark NOMAP pages as reserved in the memory map and restore
> the intended semantics of pfn_valid() to designate availability of struct
> page for a pfn.
>
> With this the core mm will be able to cope with the fact that it cannot use
> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> will be treated correctly even without the need for pfn_valid_within.
>
> The patches are boot tested on qemu-system-aarch64.
>

Did you use EFI boot when testing this? The memory map is much more
fragmented in that case, so this would be a good data point.


> I beleive it would be best to route these via mmotm tree.
>
> v4:
> * rebase on v5.13-rc1
>
> v3: Link: https://lore.kernel.org/lkml/20210422061902.21614-1-rppt@kernel.org
> * Fix minor issues found by Anshuman
> * Freshen up the declaration of pfn_valid() to make it consistent with
>   pfn_is_map_memory()
> * Add more Acked-by and Reviewed-by tags, thanks Anshuman and David
>
> v2: Link: https://lore.kernel.org/lkml/20210421065108.1987-1-rppt@kernel.org
> * Add check for PFN overflow in pfn_is_map_memory()
> * Add Acked-by and Reviewed-by tags, thanks David.
>
> v1: Link: https://lore.kernel.org/lkml/20210420090925.7457-1-rppt@kernel.org
> * Add comment about the semantics of pfn_valid() as Anshuman suggested
> * Extend comments about MEMBLOCK_NOMAP, per Anshuman
> * Use pfn_is_map_memory() name for the exported wrapper for
>   memblock_is_map_memory(). It is still local to arch/arm64 in the end
>   because of header dependency issues.
>
> rfc: Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org
>
> Mike Rapoport (4):
>   include/linux/mmzone.h: add documentation for pfn_valid()
>   memblock: update initialization of reserved pages
>   arm64: decouple check whether pfn is in linear map from pfn_valid()
>   arm64: drop pfn_valid_within() and simplify pfn_valid()
>
>  arch/arm64/Kconfig              |  3 ---
>  arch/arm64/include/asm/memory.h |  2 +-
>  arch/arm64/include/asm/page.h   |  3 ++-
>  arch/arm64/kvm/mmu.c            |  2 +-
>  arch/arm64/mm/init.c            | 14 +++++++++++++-
>  arch/arm64/mm/ioremap.c         |  4 ++--
>  arch/arm64/mm/mmu.c             |  2 +-
>  include/linux/memblock.h        |  4 +++-
>  include/linux/mmzone.h          | 11 +++++++++++
>  mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
>  10 files changed, 60 insertions(+), 13 deletions(-)
>
>
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> --
> 2.28.0
>
