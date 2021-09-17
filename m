Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7340F2DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhIQHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhIQHF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D7C760ED7;
        Fri, 17 Sep 2021 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631862247;
        bh=403SancS4CQvO5c2rJiMT2tVA4Yjat2UeGGYmKH0yTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m83sWZkyZmPJg1VJ4sBO68BtR7/7Af/G9JOYbCpT+C3N2kRaxOC4w9CRxrbHzgE2h
         3LmrT4PUTCHM9w8Htcya0UZjxC3Xvo45EtAnaU9Hb2FshLfOMEsvrEQLDtC4/2tb5D
         /KTwJPDfOW60tLh4DxBCombhVx+7czSxk/NW+25E=
Date:   Fri, 17 Sep 2021 09:04:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, elver@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 2/3] arm64: Support page mapping percpu first chunk
 allocator
Message-ID: <YUQ95HuATcgtOgsy@kroah.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-3-wangkefeng.wang@huawei.com>
 <YUQ0lvldA+wGpr0G@kroah.com>
 <9b2e89c4-a821-8657-0ffb-d822aa51936c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b2e89c4-a821-8657-0ffb-d822aa51936c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 02:55:18PM +0800, Kefeng Wang wrote:
> 
> On 2021/9/17 14:24, Greg KH wrote:
> > On Fri, Sep 10, 2021 at 01:33:53PM +0800, Kefeng Wang wrote:
> > > Percpu embedded first chunk allocator is the firstly option, but it
> > > could fails on ARM64, eg,
> > >    "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
> > >    "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
> > >    "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
> > > then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
> > > even the system could not boot successfully.
> > > 
> > > Let's implement page mapping percpu first chunk allocator as a fallback
> > > to the embedding allocator to increase the robustness of the system.
> > > 
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   arch/arm64/Kconfig       |  4 ++
> > >   drivers/base/arch_numa.c | 82 +++++++++++++++++++++++++++++++++++-----
> > >   2 files changed, 76 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 077f2ec4eeb2..04cfe1b4e98b 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1042,6 +1042,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> > >   	def_bool y
> > >   	depends on NUMA
> > > +config NEED_PER_CPU_PAGE_FIRST_CHUNK
> > > +	def_bool y
> > > +	depends on NUMA
> > Why is this a config option at all?
> 
> The config is introduced from
> 
> commit 08fc45806103e59a37418e84719b878f9bb32540
> Author: Tejun Heo <tj@kernel.org>
> Date:   Fri Aug 14 15:00:49 2009 +0900
> 
>     percpu: build first chunk allocators selectively
> 
>     There's no need to build unused first chunk allocators in. Define
>     CONFIG_NEED_PER_CPU_*_FIRST_CHUNK and let archs enable them
>     selectively.
> 
> For now, there are three ARCHs support both PER_CPU_EMBED_FIRST_CHUNK
> 
> and PER_CPU_PAGE_FIRST_CHUNK.
> 
>   arch/powerpc/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK
>   arch/sparc/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK
>   arch/x86/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK
> 
> and we have a cmdline to choose a alloctor.
> 
>    percpu_alloc=   Select which percpu first chunk allocator to use.
>                    Currently supported values are "embed" and "page".
>                    Archs may support subset or none of the selections.
>                    See comments in mm/percpu.c for details on each
>                    allocator.  This parameter is primarily for debugging
>                    and performance comparison.
> 
> embed percpu first chunk allocator is the first choice, but it could fails
> due to some
> 
> memory layout(it does occurs on ARM64 too.), so page mapping percpu first
> chunk
> 
> allocator is as a fallback, that is what this patch does.
> 
> > 
> > > +
> > >   source "kernel/Kconfig.hz"
> > >   config ARCH_SPARSEMEM_ENABLE
> > > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > > index 46c503486e96..995dca9f3254 100644
> > > --- a/drivers/base/arch_numa.c
> > > +++ b/drivers/base/arch_numa.c
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/of.h>
> > >   #include <asm/sections.h>
> > > +#include <asm/pgalloc.h>
> > >   struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> > >   EXPORT_SYMBOL(node_data);
> > > @@ -168,22 +169,83 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
> > >   	memblock_free_early(__pa(ptr), size);
> > >   }
> > > +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
> > Ick, no #ifdef in .c files if at all possible please.
> 
> The drivers/base/arch_numa.c is shared by RISCV/ARM64, so I add this config
> to
> 
> no need to build this part on RISCV.

Ok, then you need to get reviews from the mm people as I know nothing
about this at all, sorry.  This file ended up in drivers/base/ for some
reason to make it easier for others to use cross-arches, not that it had
much to do with the driver core :(

thanks,

greg k-h
