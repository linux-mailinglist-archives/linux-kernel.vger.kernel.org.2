Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3377234B8B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhC0SEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhC0SEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:04:05 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07451C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:04:04 -0700 (PDT)
Date:   Sat, 27 Mar 2021 18:03:48 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
Message-ID: <20210327180348.137d8fe2@sf>
In-Reply-To: <20210326172522.70c1cdde@sf>
References: <20210326112650.307890-1-slyfox@gentoo.org>
        <6c4a20f3-16ab-3c6c-1d6d-4708db4e9ebf@suse.cz>
        <20210326172522.70c1cdde@sf>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 17:25:22 +0000
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> On Fri, 26 Mar 2021 15:17:00 +0100
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > On 3/26/21 12:26 PM, Sergei Trofimovich wrote:  
> > > init_on_free=1 does not guarantee that free pages contain only zero bytes.
> > > 
> > > Some examples:
> > > 1. page_poison=on takes presedence over init_on_alloc=1 / ini_on_free=1    
> > 
> > Yes, and it spits out a message that you enabled both and poisoning takes
> > precedence. It was that way even before my changes IIRC, but not consistent.  
> 
> Yeah. I probably should not have included this case as page_poison=on actually
> made my machine boot just fine. My main focus was to understand why I an seeing
> the crash on kernel with init_on_alloc=1 init_on_free=1 and most debugging options
> on.
> 
> My apologies! I'll try to find where this extra poisoning comes from.
> 
> Making a step back and explaining my setup:
> 
> Initially it's an ia64 box that manages to consistently corrupt memory
> on socket free; https://lkml.org/lkml/2021/2/23/653
> 
> To get better understanding where corruption comes from I enabled
> A Lot of VM, pagealloc and slab debugging options. Full config:
> 
>     https://dev.gentoo.org/~slyfox/configs/guppy-config-5.12.0-rc4-00016-g427684abc9fd-dirty
> 
> I boot machine as:
> 
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12.0-rc4-00016-g427684abc9fd-dirty root=/dev/sda3 ro slab_nomerge memblock=debug debug_pagealloc=1 hardened_usercopy=1 page_owner=on page_poison=0 init_on_alloc=1 init_on_free=1 debug_guardpage_minorder=0
> 
> My boot log:
> 
>     https://dev.gentoo.org/~slyfox/bugs/ia64-boot-bug/2021-03-26-init_on_alloc-fail
> 
> Caveats in reading boot log:
>     - kernel crashes too early: stack unwinder does not have working kmalloc() yet
>     - kernel crashes in MCE handler: normally it should not. It's an unrelated bug
>       that makes backtrace useless. I'll try to fix it later, but it will not be fast.
>     - I added a bunch of printk()s around the crash.
> 
> The important pernel boot failure part is:
>   [    0.000000] put_kernel_page: pmd=e000000100000000
>   [    0.000000] pmd:(____ptrval____): aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa  ................................

I added WARN_ON_ONCE(1) to __kernel_poison_pages() to get the idea where
poisoning comes from and got it at:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/page_poison.c:40 __kernel_poison_pages+0x1a0/0x1c0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc4-00016-g427684abc9fd-dirty #196
               Call Trace:
[    0.000000]  [<a0000001000151b0>] show_stack+0x90/0xc0
[    0.000000]  [<a000000101162490>] dump_stack+0x150/0x1c0
[    0.000000]  [<a00000010115a7b0>] __warn+0x180/0x220
[    0.000000]  [<a00000010115a910>] warn_slowpath_fmt+0xc0/0x100
[    0.000000]  [<a0000001003f02e0>] __kernel_poison_pages+0x1a0/0x1c0
[    0.000000]  [<a0000001003ba0a0>] __free_pages_ok+0x2a0/0x10c0
[    0.000000]  [<a0000001003bb9d0>] __free_pages_core+0x2d0/0x480
[    0.000000]  [<a0000001014b7050>] memblock_free_pages+0x30/0x50
[    0.000000]  [<a0000001014bb430>] memblock_free_all+0x280/0x3c0
[    0.000000]  [<a00000010149f540>] mem_init+0x70/0x2d0
[    0.000000]  [<a000000101491550>] start_kernel+0x670/0xc20
[    0.000000]  [<a00000010116e920>] start_ap+0x760/0x780
[    0.000000] ---[ end trace 0000000000000000 ]---

I think I found where page_poison=on get enabled at init_mem_debugging_and_hardening():

void init_mem_debugging_and_hardening(void)
{
        if (_init_on_alloc_enabled_early) {
                if (page_poisoning_enabled())
                        pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
                                "will take precedence over init_on_alloc\n");
                else
                        static_branch_enable(&init_on_alloc);
        }
        if (_init_on_free_enabled_early) {
                if (page_poisoning_enabled())
                        pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
                                "will take precedence over init_on_free\n");
                else
                        static_branch_enable(&init_on_free);
        }

#ifdef CONFIG_PAGE_POISONING
        /*
         * Page poisoning is debug page alloc for some arches. If
         * either of those options are enabled, enable poisoning.
         */
        if (page_poisoning_enabled() ||
             (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
              debug_pagealloc_enabled()))
                static_branch_enable(&_page_poisoning_enabled); // <- HERE
#endif
    ...
}

If I follow the code correctly to trigger the problem one needs to:
- have PAGE_POISONING=y
- have page_poison=off set (or just unset)
- have arch without ARCH_SUPPORTS_DEBUG_PAGEALLOC (ia64 is one of
  such arches)
- have init_on_free=1
- have debug_pagealloc=1

That way we get both executed:
- static_branch_enable(&init_on_free);
- static_branch_enable(&_page_poisoning_enabled);

Sounds plausible? I'll send another version of the patch that also
fixes corruption for me.

> Note 1: I do not really enable page_poison at runtime and was misleading you
> in previous emails. (I initially assumed kernel_poison_pages() poisons pages
> unconditionally but you all explained it does not). Something else manages to
> poison my pmd(s?).
> 
> Note 2: I have many other debugging options enabled that might trigger
> poisoning. 
> 
> > > 2. free_pages_prepare() always poisons pages:
> > > 
> > >        if (want_init_on_free())
> > >            kernel_init_free_pages(page, 1 << order);
> > >        kernel_poison_pages(page, 1 << order    
> > 
> > kernel_poison_pages() includes a test if poisoning is enabled. And in that case
> > want_init_on_free() shouldn't be. see init_mem_debugging_and_hardening()  
> 
> I completely missed that! Thank you! Will try to trace real cause of poisoning.
> 
> > > I observed use of poisoned pages as the crash on ia64 booted with
> > > init_on_free=1 init_on_alloc=1 (CONFIG_PAGE_POISONING=y config).
> > > There pmd page contained 0xaaaaaaaa poison pages and led to early crash.    
> > 
> > Hm but that looks lika a sign that ia64 pmd allocation should use __GFP_ZERO and
> > doesn't. It shouldn't rely on init_on_alloc or init_on_free being enabled.  
> 
> ia64 does use __GFP_ZERO (I even tried to add it manually to pmd_alloc_one()
> before I realized all _PGTABLEs imply __GFP_ZERO).
> 
> I'll provide the call chain I arrived at for completeness:
>     - [ia64 boots]
>     - mem_init() (defined at arch/ia64/mm/init.c)
>      -> setup_gate() (defined at arch/ia64/mm/init.c)
>       -> put_kernel_page() (defined at arch/ia64/mm/init.c)
>        -> [NOTE: from now on it's all generic code, not ia64-speficic]
>         -> pmd_alloc() (defined at include/linux/mm.h)
>          -> __pmd_alloc() (defined at mm/memory.c)
>           -> [under #ifndef __PAGETABLE_PMD_FOLDED] pmd_alloc_one() (defined at include/asm-generic/pgalloc.h)
>            -> pmd_alloc_one() [defined at include/asm-generic/pgalloc.h):  
>  
> static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> {
>         struct page *page;
>         gfp_t gfp = GFP_PGTABLE_USER;
> 
>         if (mm == &init_mm)
>                 gfp = GFP_PGTABLE_KERNEL;
>         page = alloc_pages(gfp, 0);
>         if (!page)
>                 return NULL;
>         if (!pgtable_pmd_page_ctor(page)) {
>                 __free_pages(page, 0);
>                 return NULL;
>         }
>         return (pmd_t *)page_address(page);
> }
> 
> In our case it is a GFP_PGTABLE_KERNEL with __GFP_ZERO and result is
> poisoned page instead of zeroed page.
> 
> If I interpret the above correctly it means that something (probably
> memalloc_free_pages() ?) puts initial free pages as poisoned and later
> alloc_pages() assumes they are memset()-zero. But I don't see why.
> 
> > > The change drops the assumption that init_on_free=1 guarantees free
> > > pages to contain zeros.    
> > 
> > The change assumes that page_poison=on also leaves want_init_on_free() enabled,
> > but it doesn't.
> >  
> > > Alternative would be to make interaction between runtime poisoning and
> > > sanitizing options and build-time debug flags like CONFIG_PAGE_POISONING
> > > more coherent. I took the simpler path.    
> > 
> > So that was done in 5.11 and the decisions can be seen in
> > init_mem_debugging_and_hardening(). There might be of course a bug, or later
> > changes broke something. Which was the version that you observed a bug?
> >   
> > > Tested the fix on rx3600.
> > > 
> > > CC: Andrew Morton <akpm@linux-foundation.org>
> > > CC: linux-mm@kvack.org
> > > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > > ---
> > >  mm/page_alloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index cfc72873961d..d57d9b4f7089 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2301,7 +2301,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> > >  	kernel_unpoison_pages(page, 1 << order);
> > >  	set_page_owner(page, order, gfp_flags);
> > >  
> > > -	if (!want_init_on_free() && want_init_on_alloc(gfp_flags))
> > > +	if (want_init_on_alloc(gfp_flags))
> > >  		kernel_init_free_pages(page, 1 << order);
> > >  }
> > >  
> > >     
> >   
> 
> -- 
> 
>   Sergei


-- 

  Sergei
