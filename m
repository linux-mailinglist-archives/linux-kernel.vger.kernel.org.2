Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FC3E0007
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhHDLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237584AbhHDLOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:14:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 224EA60FC4;
        Wed,  4 Aug 2021 11:14:04 +0000 (UTC)
Date:   Wed, 4 Aug 2021 12:14:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] vmalloc: Choose a better start address in
 vm_area_register_early()
Message-ID: <20210804111402.GB4857@arm.com>
References: <20210720025105.103680-1-wangkefeng.wang@huawei.com>
 <20210720025105.103680-2-wangkefeng.wang@huawei.com>
 <20210801152311.GB28489@arm.com>
 <0de87be6-7041-c58b-a01f-3d6e3333c6f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de87be6-7041-c58b-a01f-3d6e3333c6f0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:39:04AM +0800, Kefeng Wang wrote:
> On 2021/8/1 23:23, Catalin Marinas wrote:
> > On Tue, Jul 20, 2021 at 10:51:03AM +0800, Kefeng Wang wrote:
> > > There are some fixed locations in the vmalloc area be reserved
> > > in ARM(see iotable_init()) and ARM64(see map_kernel()), but for
> > > pcpu_page_first_chunk(), it calls vm_area_register_early() and
> > > choose VMALLOC_START as the start address of vmap area which
> > > could be conflicted with above address, then could trigger a
> > > BUG_ON in vm_area_add_early().
> > > 
> > > Let's choose the end of existing address range in vmlist as the
> > > start address instead of VMALLOC_START to avoid the BUG_ON.
> > > 
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   mm/vmalloc.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index d5cd52805149..a98cf97f032f 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2238,12 +2238,14 @@ void __init vm_area_add_early(struct vm_struct *vm)
> > >    */
> > >   void __init vm_area_register_early(struct vm_struct *vm, size_t align)
> > >   {
> > > -	static size_t vm_init_off __initdata;
> > > +	unsigned long vm_start = VMALLOC_START;
> > > +	struct vm_struct *tmp;
> > >   	unsigned long addr;
> > > -	addr = ALIGN(VMALLOC_START + vm_init_off, align);
> > > -	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
> > > +	for (tmp = vmlist; tmp; tmp = tmp->next)
> > > +		vm_start = (unsigned long)tmp->addr + tmp->size;
> > > +	addr = ALIGN(vm_start, align);
> > >   	vm->addr = (void *)addr;
> > >   	vm_area_add_early(vm);
> > Is there a risk of breaking other architectures? It doesn't look like to
> > me but I thought I'd ask.
> 
> Before this patch, vm_init_off is to record the offset from VMALLOC_START,
> 
> but it use VMALLOC_START as start address on the function
> vm_area_register_early()
> 
> called firstly,  this will cause the BUG_ON.
> 
> With this patch, the most important change is that we choose the start
> address via
> 
> dynamic calculate the 'start' address by traversing the list.
> 
> [wkf@localhost linux-next]$ git grep vm_area_register_early
> arch/alpha/mm/init.c: vm_area_register_early(&console_remap_vm, PAGE_SIZE);
> arch/x86/xen/p2m.c:     vm_area_register_early(&vm, PMD_SIZE *
> PMDS_PER_MID_PAGE);
> mm/percpu.c:    vm_area_register_early(&vm, PAGE_SIZE);
> [wkf@localhost linux-next]$ git grep vm_area_add_early
> arch/arm/mm/ioremap.c:  vm_area_add_early(vm);
> arch/arm64/mm/mmu.c:    vm_area_add_early(vma);
> 
> x86/alpha won't call vm_area_add_early(), only arm64 could call both vm_area_add_early()
> and  vm_area_register_early() when this patchset is merged. so it won't break other architectures.

Thanks for checking.

> > Also, instead of always picking the end, could we search for a range
> > that fits?
> 
> We only need a space in vmalloc range,  using end or a range in the middle
> is not different.

I was thinking of making it more future-proof in case one registers a
vm area towards the end of the range. It's fairly easy to pick a range
in the middle now that you are adding a list traversal.

-- 
Catalin
