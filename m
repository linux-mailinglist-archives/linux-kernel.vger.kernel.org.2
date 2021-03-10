Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651B6333FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhCJOCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:02:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhCJOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:02:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F35E7AC17;
        Wed, 10 Mar 2021 14:02:36 +0000 (UTC)
Subject: Re: [PATCH v2] arm: print alloc free paths for address in registers
To:     Maninder Singh <maninder1.s@samsung.com>, linux@armlinux.org.uk,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <CGME20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d@epcas5p3.samsung.com>
 <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6f34c594-a840-30a5-5eb0-42b30844ec87@suse.cz>
Date:   Wed, 10 Mar 2021 15:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 8:56 AM, Maninder Singh wrote:
> In case of "Use After Free" kernel OOPs, free path of object
> is required to debug futher.
> And in most of cases object address is present in one of registers.
> 
> Thus check for register address and if it belongs to slab,
> print its alloc and free path.
> 
> e.g. in below issue  register r6 belongs to slab, and use after free issue
> occurred on one of its derefer values:
> 
> [  124.310386] (ptrval)
> [  124.312647] 8<--- cut here ---
> [  124.313761] Unable to handle kernel paging request at virtual address 6b6b6b6f
> [  124.315972] pgd = (ptrval)
> ...
> [  124.328290] pc : [<c052fc0c>]    lr : [<c052fc00>]    psr: 60000013
> [  124.330349] sp : c8993d28  ip : 0000bff4  fp : c8ae2020
> [  124.332071] r10: 00000000  r9 : 00000001  r8 : c1804cc8
> [  124.333803] r7 : 00000000  r6 : c8ae9180  r5 : c1804a80  r4 : c8ae2008
> [  124.335936] r3 : 6b6b6b6b  r2 : 315049d6  r1 : 2d867000  r0 : c1396584
> ..
> [  124.365233] register r6: c8ae9180 belongs to slab object
> [  124.366364] INFO: Allocated in meminfo_proc_show+0x3c/0x500 age=1 cpu=0 pid=69
> [  124.367545]  meminfo_proc_show+0x3c/0x500
> [  124.368271]  seq_read_iter+0x10c/0x4bc
> [  124.368994]  proc_reg_read_iter+0x74/0xa8
> [  124.369712]  generic_file_splice_read+0xe8/0x178
> [  124.370496]  splice_direct_to_actor+0xe0/0x2b8
> [  124.371261]  do_splice_direct+0xa4/0xdc
> [  124.371917]  do_sendfile+0x1c4/0x3ec
> [  124.372550]  sys_sendfile64+0x128/0x130
> [  124.373109]  ret_fast_syscall+0x0/0x54
> [  124.373664]  0xbe9a2de4
> [  124.374081] INFO: Freed in meminfo_proc_show+0x5c/0x500 age=1 cpu=0 pid=69
> [  124.374933]  meminfo_proc_show+0x5c/0x500
> [  124.375485]  seq_read_iter+0x10c/0x4bc
> [  124.376020]  proc_reg_read_iter+0x74/0xa8
> [  124.376643]  generic_file_splice_read+0xe8/0x178
> [  124.377331]  splice_direct_to_actor+0xe0/0x2b8
> [  124.378022]  do_splice_direct+0xa4/0xdc
> [  124.378633]  do_sendfile+0x1c4/0x3ec
> [  124.379220]  sys_sendfile64+0x128/0x130
> [  124.379822]  ret_fast_syscall+0x0/0x54
> [  124.380421]  0xbe9a2de4
> 
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
> v1 -> v2: do address sanity with virt_addr_valid
> 
>  arch/arm/include/asm/bug.h |  1 +
>  arch/arm/kernel/process.c  | 18 ++++++++++++++++++
>  arch/arm/kernel/traps.c    |  1 +
>  include/linux/slab.h       | 14 ++++++++++++++
>  mm/slab.h                  |  7 -------
>  mm/slub.c                  | 18 ++++++++++++++++++

Instead of your changes to SL*B, could you check mem_dump_obj() and others added
by Paul in 5.12-rc1?

(+CC Paul, thus not trimming)

Thanks,
Vlastimil

>  6 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index 673c7dd..ba8d9d7 100644
> --- a/arch/arm/include/asm/bug.h
> +++ b/arch/arm/include/asm/bug.h
> @@ -88,5 +88,6 @@ extern asmlinkage void c_backtrace(unsigned long fp, int pmode,
>  struct mm_struct;
>  void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr);
>  extern void __show_regs(struct pt_regs *);
> +extern void __show_regs_alloc_free(struct pt_regs *regs);
>  
>  #endif
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 5199a2b..97d2a7c 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -27,6 +27,7 @@
>  #include <linux/random.h>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/leds.h>
> +#include <linux/slab.h>
>  
>  #include <asm/processor.h>
>  #include <asm/thread_notify.h>
> @@ -92,6 +93,23 @@ void arch_cpu_idle_exit(void)
>  	ledtrig_cpu(CPU_LED_IDLE_END);
>  }
>  
> +void __show_regs_alloc_free(struct pt_regs *regs)
> +{
> +	int i;
> +
> +	/* check for r0 - r12 only */
> +	for (i = 0; i < 13; i++) {
> +		unsigned long addr = regs->uregs[i];
> +		void *object;
> +		struct kmem_cache *cache;
> +
> +		if (slab_page_object(addr, &object, &cache)) {
> +			printk("\nregister r%d: %lx belongs to slab object\n", i, addr);
> +			print_tracking(cache, object);
> +		}
> +	}
> +}
> +
>  void __show_regs(struct pt_regs *regs)
>  {
>  	unsigned long flags;
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 17d5a78..64308e3 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -287,6 +287,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>  
>  	print_modules();
>  	__show_regs(regs);
> +	__show_regs_alloc_free(regs);
>  	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
>  		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
>  
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 7ae6040..a19ba55 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -706,4 +706,18 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
>  #define slab_dead_cpu		NULL
>  #endif
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache);
> +extern void print_tracking(struct kmem_cache *s, void *object);
> +#else
> +static inline void print_tracking(struct kmem_cache *s, void *object)
> +{
> +}
> +
> +static inline bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif	/* _LINUX_SLAB_H */
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f..8a072bd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -208,18 +208,11 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>  		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
>  }
>  
> -#ifdef CONFIG_SLUB_DEBUG
>  #ifdef CONFIG_SLUB_DEBUG_ON
>  DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
>  #else
>  DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
> -extern void print_tracking(struct kmem_cache *s, void *object);
> -#else
> -static inline void print_tracking(struct kmem_cache *s, void *object)
> -{
> -}
> -#endif
>  
>  /*
>   * Returns true if any of the specified slub_debug flags is enabled for the
> diff --git a/mm/slub.c b/mm/slub.c
> index 0d5fac3..31436db 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -648,6 +648,24 @@ void print_tracking(struct kmem_cache *s, void *object)
>  	print_track("Freed", get_track(s, object, TRACK_FREE), pr_time);
>  }
>  
> +bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
> +{
> +	void *addr = (void *)address;
> +	struct page *page;
> +
> +	if (virt_addr_valid(addr)) {
> +		page = virt_to_head_page(addr);
> +
> +		if (PageSlab(page)) {
> +			*cache = page->slab_cache;
> +			*object = nearest_obj(*cache, page, addr);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static void print_page_info(struct page *page)
>  {
>  	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
> 

