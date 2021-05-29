Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E533949D2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 03:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhE2B2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 21:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE2B2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 21:28:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:26:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y2so7926714ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZ/n1upF6y4dHGuF+5q5Ane5fc6tdErY7dLjDHhrr90=;
        b=Rc5Oo0Hj8wJs8AgCZEPpaB+yAWCPY5npU4TdUfXuKtl9PAA/+tyBVBO6zHzE/fgIN/
         ZwbU+HG5MqOik0AlVPrM1x47Nz7SySFKp3VZV/1cW3o0arpfNixp0r1AgOI5S4QrGP5X
         Zlmk0jEz4aRVYlmMNdZtxF0kpXjfXncTBUABUwT+lIetSrhoBarrds9RAXvAVlo1BKf3
         hUMyDuREfujPZGxrwE7ozqMVuXiKhSuTkIMJqtxw7gahKTpdQ3N/Cj7PY7Q4Wn2CMqGA
         tMYO9d4XD3cwIc0Ee/JymJTNOv/DLBwTNJVluJsVn4KLn3QwEQ04c43en4YkKStrbPs7
         cYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZ/n1upF6y4dHGuF+5q5Ane5fc6tdErY7dLjDHhrr90=;
        b=EsFlMDGL9adcQWsEwjDoD59HfIkuqBgvR5x4FK1edUqzTtw/sJZqo3HNe4/6UuFq3D
         YmK4OXxeBIWXJfTXA3LeXUmztuBSX7QCuVT//6abdgnlX4iiScDPJ7zHztCfaQavsNwM
         34o8I0oNZxGlp/MbFtWm2pZkB6odIeGltKIMpATXKOGgxpPC9y00XqJCS7NJzGd8UjqJ
         YSVzL/nojuf0At6e+/MtHhi9KdSMapXzSCO1pRfmIYgLtkFmZC3u3DOqyQ9DPLTsfxiN
         vIfEORk2OneXfwlfredI38pROtdLX9liT6e9UoBirPPR8V3sa8Xx3rt+nJo8VOsMNIhh
         mHKw==
X-Gm-Message-State: AOAM533e1QJabbyM2JUbGPaqBK10KXI5Z3/bd2qpgyoHfFRJqJTDxfpO
        kuLpv/rhLBpxm+KhZAE7J7B8FGvclsCLK/xm0O0weA==
X-Google-Smtp-Source: ABdhPJw1c9LLURhr/NJE984MKJmmFf9T8vhee9/dsV3T6zM1sPopMfxOn96WumnwAS7/I0ftSPsfpNz+G/elaZXurIg=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr15294469ybc.136.1622251598048;
 Fri, 28 May 2021 18:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com> <20210428153542.2814175-34-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-34-Liam.Howlett@Oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 May 2021 18:26:26 -0700
Message-ID: <CAJuCfpGD3EC_chwHWBETSJ9x7DR6umX6kFZES0sWyphtVNeNRw@mail.gmail.com>
Subject: Re: [PATCH 33/94] mm: Remove rb tree.
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> Remove the RB tree and start using the maple tree for vm_area_struct
> tracking.
>
> Drop validate_mm() calls in expand_upwards() and expand_downwards() as
> the lock is not held.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  arch/x86/kernel/tboot.c    |   1 -
>  drivers/firmware/efi/efi.c |   1 -
>  fs/proc/task_nommu.c       |  55 ++--
>  include/linux/mm.h         |   4 +-
>  include/linux/mm_types.h   |  26 +-
>  kernel/fork.c              |   8 -
>  mm/init-mm.c               |   2 -
>  mm/mmap.c                  | 525 ++++++++-----------------------------
>  mm/nommu.c                 |  96 +++----
>  mm/util.c                  |   8 +
>  10 files changed, 185 insertions(+), 541 deletions(-)
>
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 6f978f722dff..121f28bb2209 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -97,7 +97,6 @@ void __init tboot_probe(void)
>
>  static pgd_t *tboot_pg_dir;
>  static struct mm_struct tboot_mm = {
> -       .mm_rb          = RB_ROOT,
>         .mm_mt          = MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
>         .pgd            = swapper_pg_dir,
>         .mm_users       = ATOMIC_INIT(2),
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 271ae8c7bb07..8aaeaa824576 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -54,7 +54,6 @@ static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
>
>  struct mm_struct efi_mm = {
> -       .mm_rb                  = RB_ROOT,
>         .mm_mt                  = MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
>         .mm_users               = ATOMIC_INIT(2),
>         .mm_count               = ATOMIC_INIT(1),
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index a6d21fc0033c..8691a1216d1c 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -22,15 +22,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
>         struct vm_region *region;
> -       struct rb_node *p;
>         unsigned long bytes = 0, sbytes = 0, slack = 0, size;
> -
> -       mmap_read_lock(mm);
> -       for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -               vma = rb_entry(p, struct vm_area_struct, vm_rb);
> +       MA_STATE(mas, &mm->mm_mt, 0, 0);
>
> +       mmap_read_lock(mm);
> +       rcu_read_lock();
> +       mas_for_each(&mas, vma, ULONG_MAX) {
>                 bytes += kobjsize(vma);
> -
>                 region = vma->vm_region;
>                 if (region) {
>                         size = kobjsize(region);
> @@ -53,7 +51,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>                 sbytes += kobjsize(mm);
>         else
>                 bytes += kobjsize(mm);
> -
> +
>         if (current->fs && current->fs->users > 1)
>                 sbytes += kobjsize(current->fs);
>         else
> @@ -77,20 +75,21 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>                 "Shared:\t%8lu bytes\n",
>                 bytes, slack, sbytes);
>
> +       rcu_read_unlock();
>         mmap_read_unlock(mm);
>  }
>
>  unsigned long task_vsize(struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
> -       struct rb_node *p;
>         unsigned long vsize = 0;
> +       MA_STATE(mas, &mm->mm_mt, 0, 0);
>
>         mmap_read_lock(mm);
> -       for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -               vma = rb_entry(p, struct vm_area_struct, vm_rb);
> +       rcu_read_lock();
> +       mas_for_each(&mas, vma, ULONG_MAX)
>                 vsize += vma->vm_end - vma->vm_start;
> -       }
> +       rcu_read_unlock();
>         mmap_read_unlock(mm);
>         return vsize;
>  }
> @@ -101,12 +100,12 @@ unsigned long task_statm(struct mm_struct *mm,
>  {
>         struct vm_area_struct *vma;
>         struct vm_region *region;
> -       struct rb_node *p;
>         unsigned long size = kobjsize(mm);
> +       MA_STATE(mas, &mm->mm_mt, 0, 0);
>
>         mmap_read_lock(mm);
> -       for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
> -               vma = rb_entry(p, struct vm_area_struct, vm_rb);
> +       rcu_read_lock();
> +       mas_for_each(&mas, vma, ULONG_MAX) {
>                 size += kobjsize(vma);
>                 region = vma->vm_region;
>                 if (region) {
> @@ -119,6 +118,7 @@ unsigned long task_statm(struct mm_struct *mm,
>                 >> PAGE_SHIFT;
>         *data = (PAGE_ALIGN(mm->start_stack) - (mm->start_data & PAGE_MASK))
>                 >> PAGE_SHIFT;
> +       rcu_read_unlock();
>         mmap_read_unlock(mm);
>         size >>= PAGE_SHIFT;
>         size += *text + *data;
> @@ -190,17 +190,20 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
>   */
>  static int show_map(struct seq_file *m, void *_p)
>  {
> -       struct rb_node *p = _p;
> -
> -       return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
> +       return nommu_vma_show(m, _p);
>  }
>
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
>         struct proc_maps_private *priv = m->private;
>         struct mm_struct *mm;
> -       struct rb_node *p;
> -       loff_t n = *pos;
> +       struct vm_area_struct *vma;
> +       unsigned long addr = *pos;
> +       MA_STATE(mas, &priv->mm->mm_mt, addr, addr);
> +
> +       /* See m_next(). Zero at the start or after lseek. */
> +       if (addr == -1UL)
> +               return NULL;
>
>         /* pin the task and mm whilst we play with them */
>         priv->task = get_proc_task(priv->inode);
> @@ -216,14 +219,12 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>                 return ERR_PTR(-EINTR);
>         }
>
> -       /* start from the Nth VMA */
> -       for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
> -               if (n-- == 0)
> -                       return p;
> +       /* start the next element from addr */
> +       vma = mas_find(&mas, ULONG_MAX);
>
>         mmap_read_unlock(mm);
>         mmput(mm);
> -       return NULL;
> +       return vma;
>  }
>
>  static void m_stop(struct seq_file *m, void *_vml)
> @@ -242,10 +243,10 @@ static void m_stop(struct seq_file *m, void *_vml)
>
>  static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
>  {
> -       struct rb_node *p = _p;
> +       struct vm_area_struct *vma = _p;
>
> -       (*pos)++;
> -       return p ? rb_next(p) : NULL;
> +       *pos = vma->vm_end;
> +       return vma->vm_next;
>  }
>
>  static const struct seq_operations proc_pid_maps_ops = {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7f7dff6ad884..146976070fed 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2553,8 +2553,6 @@ extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
>  extern int split_vma(struct mm_struct *, struct vm_area_struct *,
>         unsigned long addr, int new_below);
>  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> -extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
> -       struct rb_node **, struct rb_node *);
>  extern void unlink_file_vma(struct vm_area_struct *);
>  extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>         unsigned long addr, unsigned long len, pgoff_t pgoff,
> @@ -2699,7 +2697,7 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
>  static inline
>  struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  {
> -       return find_vma_intersection(mm, addr, addr + 1);
> +       return mtree_load(&mm->mm_mt, addr);
>  }
>
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 51733fc44daf..41551bfa6ce0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -311,19 +311,6 @@ struct vm_area_struct {
>
>         /* linked list of VM areas per task, sorted by address */
>         struct vm_area_struct *vm_next, *vm_prev;
> -
> -       struct rb_node vm_rb;
> -
> -       /*
> -        * Largest free memory gap in bytes to the left of this VMA.
> -        * Either between this VMA and vma->vm_prev, or between one of the
> -        * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
> -        * get_unmapped_area find a free area of the right size.
> -        */
> -       unsigned long rb_subtree_gap;
> -
> -       /* Second cache line starts here. */
> -
>         struct mm_struct *vm_mm;        /* The address space we belong to. */
>
>         /*
> @@ -333,6 +320,12 @@ struct vm_area_struct {
>         pgprot_t vm_page_prot;
>         unsigned long vm_flags;         /* Flags, see mm.h. */
>
> +       /* Information about our backing store: */
> +       unsigned long vm_pgoff;         /* Offset (within vm_file) in PAGE_SIZE
> +                                        * units
> +                                        */
> +       /* Second cache line starts here. */
> +       struct file *vm_file;           /* File we map to (can be NULL). */
>         /*
>          * For areas with an address space and backing store,
>          * linkage into the address_space->i_mmap interval tree.
> @@ -351,16 +344,14 @@ struct vm_area_struct {
>         struct list_head anon_vma_chain; /* Serialized by mmap_lock &
>                                           * page_table_lock */
>         struct anon_vma *anon_vma;      /* Serialized by page_table_lock */
> +       /* Third cache line starts here. */
>
>         /* Function pointers to deal with this struct. */
>         const struct vm_operations_struct *vm_ops;
>
> -       /* Information about our backing store: */
> -       unsigned long vm_pgoff;         /* Offset (within vm_file) in PAGE_SIZE
> -                                          units */
> -       struct file * vm_file;          /* File we map to (can be NULL). */
>         void * vm_private_data;         /* was vm_pte (shared mem) */
>
> +
>  #ifdef CONFIG_SWAP
>         atomic_long_t swap_readahead_info;
>  #endif
> @@ -389,7 +380,6 @@ struct mm_struct {
>         struct {
>                 struct vm_area_struct *mmap;            /* list of VMAs */
>                 struct maple_tree mm_mt;
> -               struct rb_root mm_rb;
>                 u64 vmacache_seqnum;                   /* per-thread vmacache */
>  #ifdef CONFIG_MMU
>                 unsigned long (*get_unmapped_area) (struct file *filp,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 832416ff613e..83afd3007a2b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -475,7 +475,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                                         struct mm_struct *oldmm)
>  {
>         struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
> -       struct rb_node **rb_link, *rb_parent;
>         int retval;
>         unsigned long charge = 0;
>         MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
> @@ -502,8 +501,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>         mm->exec_vm = oldmm->exec_vm;
>         mm->stack_vm = oldmm->stack_vm;
>
> -       rb_link = &mm->mm_rb.rb_node;
> -       rb_parent = NULL;
>         pprev = &mm->mmap;
>         retval = ksm_fork(mm, oldmm);
>         if (retval)
> @@ -597,10 +594,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                 tmp->vm_prev = prev;
>                 prev = tmp;
>
> -               __vma_link_rb(mm, tmp, rb_link, rb_parent);
> -               rb_link = &tmp->vm_rb.rb_right;
> -               rb_parent = &tmp->vm_rb;
> -
>                 /* Link the vma into the MT */
>                 mas.index = tmp->vm_start;
>                 mas.last = tmp->vm_end - 1;
> @@ -1033,7 +1026,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>         struct user_namespace *user_ns)
>  {
>         mm->mmap = NULL;
> -       mm->mm_rb = RB_ROOT;
>         mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
>         mm->vmacache_seqnum = 0;
>         atomic_set(&mm->mm_users, 1);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 2014d4b82294..04bbe5172b72 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/mm_types.h>
> -#include <linux/rbtree.h>
>  #include <linux/maple_tree.h>
>  #include <linux/rwsem.h>
>  #include <linux/spinlock.h>
> @@ -28,7 +27,6 @@
>   * and size this cpu_bitmask to NR_CPUS.
>   */
>  struct mm_struct init_mm = {
> -       .mm_rb          = RB_ROOT,
>         .mm_mt          = MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
>         .pgd            = swapper_pg_dir,
>         .mm_users       = ATOMIC_INIT(2),
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1bd43f4db28e..7747047c4cbe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -38,7 +38,6 @@
>  #include <linux/audit.h>
>  #include <linux/khugepaged.h>
>  #include <linux/uprobes.h>
> -#include <linux/rbtree_augmented.h>
>  #include <linux/notifier.h>
>  #include <linux/memory.h>
>  #include <linux/printk.h>
> @@ -290,93 +289,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>         return origbrk;
>  }
>
> -static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
> -{
> -       unsigned long gap, prev_end;
> -
> -       /*
> -        * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
> -        * allow two stack_guard_gaps between them here, and when choosing
> -        * an unmapped area; whereas when expanding we only require one.
> -        * That's a little inconsistent, but keeps the code here simpler.
> -        */
> -       gap = vm_start_gap(vma);
> -       if (vma->vm_prev) {
> -               prev_end = vm_end_gap(vma->vm_prev);
> -               if (gap > prev_end)
> -                       gap -= prev_end;
> -               else
> -                       gap = 0;
> -       }
> -       return gap;
> -}
> -
> -#ifdef CONFIG_DEBUG_VM_RB
> -static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
> -{
> -       unsigned long max = vma_compute_gap(vma), subtree_gap;
> -       if (vma->vm_rb.rb_left) {
> -               subtree_gap = rb_entry(vma->vm_rb.rb_left,
> -                               struct vm_area_struct, vm_rb)->rb_subtree_gap;
> -               if (subtree_gap > max)
> -                       max = subtree_gap;
> -       }
> -       if (vma->vm_rb.rb_right) {
> -               subtree_gap = rb_entry(vma->vm_rb.rb_right,
> -                               struct vm_area_struct, vm_rb)->rb_subtree_gap;
> -               if (subtree_gap > max)
> -                       max = subtree_gap;
> -       }
> -       return max;
> -}
> -
> -static int browse_rb(struct mm_struct *mm)
> -{
> -       struct rb_root *root = &mm->mm_rb;
> -       int i = 0, j, bug = 0;
> -       struct rb_node *nd, *pn = NULL;
> -       unsigned long prev = 0, pend = 0;
> -
> -       for (nd = rb_first(root); nd; nd = rb_next(nd)) {
> -               struct vm_area_struct *vma;
> -               vma = rb_entry(nd, struct vm_area_struct, vm_rb);
> -               if (vma->vm_start < prev) {
> -                       pr_emerg("vm_start %lx < prev %lx\n",
> -                                 vma->vm_start, prev);
> -                       bug = 1;
> -               }
> -               if (vma->vm_start < pend) {
> -                       pr_emerg("vm_start %lx < pend %lx\n",
> -                                 vma->vm_start, pend);
> -                       bug = 1;
> -               }
> -               if (vma->vm_start > vma->vm_end) {
> -                       pr_emerg("vm_start %lx > vm_end %lx\n",
> -                                 vma->vm_start, vma->vm_end);
> -                       bug = 1;
> -               }
> -               spin_lock(&mm->page_table_lock);
> -               if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
> -                       pr_emerg("free gap %lx, correct %lx\n",
> -                              vma->rb_subtree_gap,
> -                              vma_compute_subtree_gap(vma));
> -                       bug = 1;
> -               }
> -               spin_unlock(&mm->page_table_lock);
> -               i++;
> -               pn = nd;
> -               prev = vma->vm_start;
> -               pend = vma->vm_end;
> -       }
> -       j = 0;
> -       for (nd = pn; nd; nd = rb_prev(nd))
> -               j++;
> -       if (i != j) {
> -               pr_emerg("backwards %d, forwards %d\n", j, i);
> -               bug = 1;
> -       }
> -       return bug ? -1 : i;
> -}
>  #if defined(CONFIG_DEBUG_MAPLE_TREE)
>  extern void mt_validate(struct maple_tree *mt);
>  extern void mt_dump(const struct maple_tree *mt);
> @@ -405,17 +317,25 @@ static void validate_mm_mt(struct mm_struct *mm)
>                         dump_stack();
>  #ifdef CONFIG_DEBUG_VM
>                         dump_vma(vma_mt);
> -                       pr_emerg("and next in rb\n");
> +                       pr_emerg("and vm_next\n");
>                         dump_vma(vma->vm_next);
> -#endif
> +#endif // CONFIG_DEBUG_VM
>                         pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
>                                  mas.index, mas.last);
>                         pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
>                                  vma_mt->vm_start, vma_mt->vm_end);
> -                       pr_emerg("rb vma: %px %lu - %lu\n", vma,
> +                       if (vma->vm_prev) {
> +                               pr_emerg("ll prev: %px %lu - %lu\n",
> +                                        vma->vm_prev, vma->vm_prev->vm_start,
> +                                        vma->vm_prev->vm_end);
> +                       }
> +                       pr_emerg("ll vma: %px %lu - %lu\n", vma,
>                                  vma->vm_start, vma->vm_end);
> -                       pr_emerg("rb->next = %px %lu - %lu\n", vma->vm_next,
> -                                       vma->vm_next->vm_start, vma->vm_next->vm_end);
> +                       if (vma->vm_next) {
> +                               pr_emerg("ll next: %px %lu - %lu\n",
> +                                        vma->vm_next, vma->vm_next->vm_start,
> +                                        vma->vm_next->vm_end);
> +                       }
>
>                         mt_dump(mas.tree);
>                         if (vma_mt->vm_end != mas.last + 1) {
> @@ -441,21 +361,6 @@ static void validate_mm_mt(struct mm_struct *mm)
>         rcu_read_unlock();
>         mt_validate(&mm->mm_mt);
>  }
> -#else
> -#define validate_mm_mt(root) do { } while (0)
> -#endif
> -static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
> -{
> -       struct rb_node *nd;
> -
> -       for (nd = rb_first(root); nd; nd = rb_next(nd)) {
> -               struct vm_area_struct *vma;
> -               vma = rb_entry(nd, struct vm_area_struct, vm_rb);
> -               VM_BUG_ON_VMA(vma != ignore &&
> -                       vma->rb_subtree_gap != vma_compute_subtree_gap(vma),
> -                       vma);
> -       }
> -}
>
>  static void validate_mm(struct mm_struct *mm)
>  {
> @@ -464,6 +369,8 @@ static void validate_mm(struct mm_struct *mm)
>         unsigned long highest_address = 0;
>         struct vm_area_struct *vma = mm->mmap;
>
> +       validate_mm_mt(mm);
> +
>         while (vma) {
>                 struct anon_vma *anon_vma = vma->anon_vma;
>                 struct anon_vma_chain *avc;
> @@ -488,80 +395,13 @@ static void validate_mm(struct mm_struct *mm)
>                           mm->highest_vm_end, highest_address);
>                 bug = 1;
>         }
> -       i = browse_rb(mm);
> -       if (i != mm->map_count) {
> -               if (i != -1)
> -                       pr_emerg("map_count %d rb %d\n", mm->map_count, i);
> -               bug = 1;
> -       }
>         VM_BUG_ON_MM(bug, mm);
>  }
> -#else
> -#define validate_mm_rb(root, ignore) do { } while (0)
> +
> +#else // !CONFIG_DEBUG_MAPLE_TREE
>  #define validate_mm_mt(root) do { } while (0)
>  #define validate_mm(mm) do { } while (0)
> -#endif
> -
> -RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
> -                        struct vm_area_struct, vm_rb,
> -                        unsigned long, rb_subtree_gap, vma_compute_gap)
> -
> -/*
> - * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
> - * vma->vm_prev->vm_end values changed, without modifying the vma's position
> - * in the rbtree.
> - */
> -static void vma_gap_update(struct vm_area_struct *vma)
> -{
> -       /*
> -        * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
> -        * a callback function that does exactly what we want.
> -        */
> -       vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
> -}
> -
> -static inline void vma_rb_insert(struct vm_area_struct *vma,
> -                                struct rb_root *root)
> -{
> -       /* All rb_subtree_gap values must be consistent prior to insertion */
> -       validate_mm_rb(root, NULL);
> -
> -       rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> -}
> -
> -static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
> -{
> -       /*
> -        * Note rb_erase_augmented is a fairly large inline function,
> -        * so make sure we instantiate it only once with our desired
> -        * augmented rbtree callbacks.
> -        */
> -       rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> -}
> -
> -static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
> -                                               struct rb_root *root,
> -                                               struct vm_area_struct *ignore)
> -{
> -       /*
> -        * All rb_subtree_gap values must be consistent prior to erase,
> -        * with the possible exception of
> -        *
> -        * a. the "next" vma being erased if next->vm_start was reduced in
> -        *    __vma_adjust() -> __vma_unlink()
> -        * b. the vma being erased in detach_vmas_to_be_unmapped() ->
> -        *    vma_rb_erase()
> -        */
> -       validate_mm_rb(root, ignore);
> -
> -       __vma_rb_erase(vma, root);
> -}
> -
> -static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
> -                                        struct rb_root *root)
> -{
> -       vma_rb_erase_ignore(vma, root, vma);
> -}
> +#endif // CONFIG_DEBUG_MAPLE_TREE
>
>  /*
>   * vma has some anon_vma assigned, and is already inserted on that
> @@ -595,38 +435,26 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>                 anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>
> -static int find_vma_links(struct mm_struct *mm, unsigned long addr,
> -               unsigned long end, struct vm_area_struct **pprev,
> -               struct rb_node ***rb_link, struct rb_node **rb_parent)
> +/* Private
> + * range_has_overlap() - Check the @start - @end range for overlapping VMAs and
> + * sets up a pointer to the previous VMA
> + *
> + * @mm - the mm struct
> + * @start - the start address of the range
> + * @end - the end address of the range
> + * @pprev - the pointer to the pointer of the previous VMA
> + *
> + * Returns: True if there is an overlapping VMA, false otherwise
> + */
> +static bool range_has_overlap(struct mm_struct *mm, unsigned long start,
> +                             unsigned long end, struct vm_area_struct **pprev)
>  {
> -       struct rb_node **__rb_link, *__rb_parent, *rb_prev;
> -
> -       __rb_link = &mm->mm_rb.rb_node;
> -       rb_prev = __rb_parent = NULL;
> +       struct vm_area_struct *existing;
>
> -       while (*__rb_link) {
> -               struct vm_area_struct *vma_tmp;
> -
> -               __rb_parent = *__rb_link;
> -               vma_tmp = rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
> -
> -               if (vma_tmp->vm_end > addr) {
> -                       /* Fail if an existing vma overlaps the area */
> -                       if (vma_tmp->vm_start < end)
> -                               return -ENOMEM;
> -                       __rb_link = &__rb_parent->rb_left;
> -               } else {
> -                       rb_prev = __rb_parent;
> -                       __rb_link = &__rb_parent->rb_right;
> -               }
> -       }
> -
> -       *pprev = NULL;
> -       if (rb_prev)
> -               *pprev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
> -       *rb_link = __rb_link;
> -       *rb_parent = __rb_parent;
> -       return 0;
> +       MA_STATE(mas, &mm->mm_mt, start, start);
> +       existing = mas_find(&mas, end - 1);
> +       *pprev = mas_prev(&mas, 0);
> +       return existing ? true : false;
>  }
>
>  /*
> @@ -653,8 +481,6 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
>   * @start: The start of the range.
>   * @len: The length of the range.
>   * @pprev: pointer to the pointer that will be set to previous vm_area_struct
> - * @rb_link: the rb_node
> - * @rb_parent: the parent rb_node
>   *
>   * Find all the vm_area_struct that overlap from @start to
>   * @end and munmap them.  Set @pprev to the previous vm_area_struct.
> @@ -663,76 +489,41 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
>   */
>  static inline int
>  munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
> -                struct vm_area_struct **pprev, struct rb_node ***link,
> -                struct rb_node **parent, struct list_head *uf)
> +                struct vm_area_struct **pprev, struct list_head *uf)
>  {
> -
> -       while (find_vma_links(mm, start, start + len, pprev, link, parent))
> +       // Needs optimization.
> +       while (range_has_overlap(mm, start, start + len, pprev))
>                 if (do_munmap(mm, start, len, uf))
>                         return -ENOMEM;
> -
>         return 0;
>  }
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>                 unsigned long addr, unsigned long end)
>  {
>         unsigned long nr_pages = 0;
> -       unsigned long nr_mt_pages = 0;
>         struct vm_area_struct *vma;
> +       unsigned long vm_start, vm_end;
> +       MA_STATE(mas, &mm->mm_mt, addr, addr);
>
> -       /* Find first overlapping mapping */
> -       vma = find_vma_intersection(mm, addr, end);
> +       /* Find first overlaping mapping */

nit: I think the original comment was correct.

> +       vma = mas_find(&mas, end - 1);
>         if (!vma)
>                 return 0;
>
> -       nr_pages = (min(end, vma->vm_end) -
> -               max(addr, vma->vm_start)) >> PAGE_SHIFT;
> +       vm_start = vma->vm_start;
> +       vm_end = vma->vm_end;
> +       nr_pages = (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
>
>         /* Iterate over the rest of the overlaps */
> -       for (vma = vma->vm_next; vma; vma = vma->vm_next) {
> -               unsigned long overlap_len;
> -
> -               if (vma->vm_start > end)
> -                       break;
> -
> -               overlap_len = min(end, vma->vm_end) - vma->vm_start;
> -               nr_pages += overlap_len >> PAGE_SHIFT;
> +       mas_for_each(&mas, vma, end) {
> +               vm_start = vma->vm_start;
> +               vm_end = vma->vm_end;
> +               nr_pages += (min(end, vm_end) - vm_start) >> PAGE_SHIFT;
>         }
>
> -       mt_for_each(&mm->mm_mt, vma, addr, end) {
> -               nr_mt_pages +=
> -                       (min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
> -       }
> -
> -       VM_BUG_ON_MM(nr_pages != nr_mt_pages, mm);
> -
>         return nr_pages;
>  }
>
> -void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
> -               struct rb_node **rb_link, struct rb_node *rb_parent)
> -{
> -       /* Update tracking information for the gap following the new vma. */
> -       if (vma->vm_next)
> -               vma_gap_update(vma->vm_next);
> -       else
> -               mm->highest_vm_end = vm_end_gap(vma);
> -
> -       /*
> -        * vma->vm_prev wasn't known when we followed the rbtree to find the
> -        * correct insertion point for that vma. As a result, we could not
> -        * update the vma vm_rb parents rb_subtree_gap values on the way down.
> -        * So, we first insert the vma with a zero rb_subtree_gap value
> -        * (to be consistent with what we did on the way down), and then
> -        * immediately update the gap to the correct value. Finally we
> -        * rebalance the rbtree after all augmented values have been set.
> -        */
> -       rb_link_node(&vma->vm_rb, rb_parent, rb_link);
> -       vma->rb_subtree_gap = 0;
> -       vma_gap_update(vma);
> -       vma_rb_insert(vma, &mm->mm_rb);
> -}
> -
>  static void __vma_link_file(struct vm_area_struct *vma)
>  {
>         struct file *file;
> @@ -780,19 +571,8 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
>                 GFP_KERNEL);
>  }
>
> -static void
> -__vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
> -       struct vm_area_struct *prev, struct rb_node **rb_link,
> -       struct rb_node *rb_parent)
> -{
> -       vma_mt_store(mm, vma);
> -       __vma_link_list(mm, vma, prev);
> -       __vma_link_rb(mm, vma, rb_link, rb_parent);
> -}
> -
>  static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
> -                       struct vm_area_struct *prev, struct rb_node **rb_link,
> -                       struct rb_node *rb_parent)
> +                       struct vm_area_struct *prev)
>  {
>         struct address_space *mapping = NULL;
>
> @@ -801,7 +581,8 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
>                 i_mmap_lock_write(mapping);
>         }
>
> -       __vma_link(mm, vma, prev, rb_link, rb_parent);
> +       vma_mt_store(mm, vma);
> +       __vma_link_list(mm, vma, prev);
>         __vma_link_file(vma);
>
>         if (mapping)
> @@ -813,30 +594,18 @@ static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
>
>  /*
>   * Helper for vma_adjust() in the split_vma insert case: insert a vma into the
> - * mm's list and rbtree.  It has already been inserted into the interval tree.
> + * mm's list and the mm tree.  It has already been inserted into the interval tree.
>   */
>  static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>         struct vm_area_struct *prev;
> -       struct rb_node **rb_link, *rb_parent;
>
> -       if (find_vma_links(mm, vma->vm_start, vma->vm_end,
> -                          &prev, &rb_link, &rb_parent))
> -               BUG();
> -       __vma_link(mm, vma, prev, rb_link, rb_parent);
> +       BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
> +       vma_mt_store(mm, vma);
> +       __vma_link_list(mm, vma, prev);
>         mm->map_count++;
>  }
>
> -static __always_inline void __vma_unlink(struct mm_struct *mm,
> -                                               struct vm_area_struct *vma,
> -                                               struct vm_area_struct *ignore)
> -{
> -       vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
> -       __vma_unlink_list(mm, vma);
> -       /* Kill the cache */
> -       vmacache_invalidate(mm);
> -}
> -
>  /*
>   * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
>   * is already present in an i_mmap tree without adjusting the tree.
> @@ -854,13 +623,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>         struct rb_root_cached *root = NULL;
>         struct anon_vma *anon_vma = NULL;
>         struct file *file = vma->vm_file;
> -       bool start_changed = false, end_changed = false;
> +       bool vma_changed = false;
>         long adjust_next = 0;
>         int remove_next = 0;
>
> -       validate_mm(mm);
> -       validate_mm_mt(mm);
> -
>         if (next && !insert) {
>                 struct vm_area_struct *exporter = NULL, *importer = NULL;
>
> @@ -986,21 +752,23 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>         }
>
>         if (start != vma->vm_start) {
> -               unsigned long old_start = vma->vm_start;
> +               if (vma->vm_start < start)
> +                       vma_mt_szero(mm, vma->vm_start, start);
> +               else
> +                       vma_changed = true;
>                 vma->vm_start = start;
> -               if (old_start < start)
> -                       vma_mt_szero(mm, old_start, start);
> -               start_changed = true;
>         }
>         if (end != vma->vm_end) {
> -               unsigned long old_end = vma->vm_end;
> +               if (vma->vm_end > end)
> +                       vma_mt_szero(mm, end, vma->vm_end);
> +               else
> +                       vma_changed = true;
>                 vma->vm_end = end;
> -               if (old_end > end)
> -                       vma_mt_szero(mm, end, old_end);
> -               end_changed = true;
> +               if (!next)
> +                       mm->highest_vm_end = vm_end_gap(vma);
>         }
>
> -       if (end_changed || start_changed)
> +       if (vma_changed)
>                 vma_mt_store(mm, vma);
>
>         vma->vm_pgoff = pgoff;
> @@ -1018,25 +786,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>         }
>
>         if (remove_next) {
> -               /*
> -                * vma_merge has merged next into vma, and needs
> -                * us to remove next before dropping the locks.
> -                * Since we have expanded over this vma, the maple tree will
> -                * have overwritten by storing the value
> -                */
> -               if (remove_next != 3)
> -                       __vma_unlink(mm, next, next);
> -               else
> -                       /*
> -                        * vma is not before next if they've been
> -                        * swapped.
> -                        *
> -                        * pre-swap() next->vm_start was reduced so
> -                        * tell validate_mm_rb to ignore pre-swap()
> -                        * "next" (which is stored in post-swap()
> -                        * "vma").
> -                        */
> -                       __vma_unlink(mm, next, vma);
> +               __vma_unlink_list(mm, next);
> +               /* Kill the cache */
> +               vmacache_invalidate(mm);
>                 if (file)
>                         __remove_shared_vm_struct(next, file, mapping);
>         } else if (insert) {
> @@ -1046,15 +798,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>                  * (it may either follow vma or precede it).
>                  */
>                 __insert_vm_struct(mm, insert);
> -       } else {
> -               if (start_changed)
> -                       vma_gap_update(vma);
> -               if (end_changed) {
> -                       if (!next)
> -                               mm->highest_vm_end = vm_end_gap(vma);
> -                       else if (!adjust_next)
> -                               vma_gap_update(next);
> -               }
>         }
>
>         if (anon_vma) {
> @@ -1112,10 +855,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>                         remove_next = 1;
>                         end = next->vm_end;
>                         goto again;
> -               }
> -               else if (next)
> -                       vma_gap_update(next);
> -               else {
> +               } else if (!next) {
>                         /*
>                          * If remove_next == 2 we obviously can't
>                          * reach this path.
> @@ -1142,8 +882,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>                 uprobe_mmap(insert);
>
>         validate_mm(mm);
> -       validate_mm_mt(mm);
> -
>         return 0;
>  }
>
> @@ -1290,7 +1028,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>         struct vm_area_struct *area, *next;
>         int err;
>
> -       validate_mm_mt(mm);
>         /*
>          * We later require that vma->vm_flags == vm_flags,
>          * so this tests vma->vm_flags & VM_SPECIAL, too.
> @@ -1366,7 +1103,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>                 khugepaged_enter_vma_merge(area, vm_flags);
>                 return area;
>         }
> -       validate_mm_mt(mm);
>
>         return NULL;
>  }
> @@ -1536,6 +1272,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>         vm_flags_t vm_flags;
>         int pkey = 0;
>
> +       validate_mm(mm);
>         *populate = 0;
>
>         if (!len)
> @@ -1856,10 +1593,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma, *prev, *merge;
>         int error;
> -       struct rb_node **rb_link, *rb_parent;
>         unsigned long charged = 0;
>
> -       validate_mm_mt(mm);
>         /* Check against address space limit. */
>         if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
>                 unsigned long nr_pages;
> @@ -1875,8 +1610,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                         return -ENOMEM;
>         }
>
> -       /* Clear old maps, set up prev, rb_link, rb_parent, and uf */
> -       if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
> +       /* Clear old maps, set up prev and uf */
> +       if (munmap_vma_range(mm, addr, len, &prev, uf))
>                 return -ENOMEM;
>         /*
>          * Private writable mapping: check memory availability
> @@ -1984,7 +1719,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                         goto free_vma;
>         }
>
> -       vma_link(mm, vma, prev, rb_link, rb_parent);
> +       vma_link(mm, vma, prev);
>         /* Once vma denies write, undo our temporary denial count */
>         if (file) {
>  unmap_writable:
> @@ -2021,7 +1756,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>         vma_set_page_prot(vma);
>
> -       validate_mm_mt(mm);
>         return addr;
>
>  unmap_and_free_vma:
> @@ -2041,7 +1775,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  unacct_error:
>         if (charged)
>                 vm_unacct_memory(charged);
> -       validate_mm_mt(mm);
>         return error;
>  }
>
> @@ -2324,9 +2057,6 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>
>         rcu_read_lock();
>         vma = mas_find(&mas, ULONG_MAX);
> -       if (!vma)
> -               mas_reset(&mas);
> -
>         *pprev = mas_prev(&mas, 0);
>         rcu_read_unlock();
>         return vma;
> @@ -2390,7 +2120,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>         unsigned long gap_addr;
>         int error = 0;
>
> -       validate_mm_mt(mm);
>         if (!(vma->vm_flags & VM_GROWSUP))
>                 return -EFAULT;
>
> @@ -2437,15 +2166,13 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>                         error = acct_stack_growth(vma, size, grow);
>                         if (!error) {
>                                 /*
> -                                * vma_gap_update() doesn't support concurrent
> -                                * updates, but we only hold a shared mmap_lock
> -                                * lock here, so we need to protect against
> -                                * concurrent vma expansions.
> -                                * anon_vma_lock_write() doesn't help here, as
> -                                * we don't guarantee that all growable vmas
> -                                * in a mm share the same root anon vma.
> -                                * So, we reuse mm->page_table_lock to guard
> -                                * against concurrent vma expansions.
> +                                * We only hold a shared mmap_lock lock here, so
> +                                * we need to protect against concurrent vma
> +                                * expansions.  anon_vma_lock_write() doesn't
> +                                * help here, as we don't guarantee that all
> +                                * growable vmas in a mm share the same root
> +                                * anon vma.  So, we reuse mm->page_table_lock
> +                                * to guard against concurrent vma expansions.
>                                  */
>                                 spin_lock(&mm->page_table_lock);
>                                 if (vma->vm_flags & VM_LOCKED)
> @@ -2453,10 +2180,9 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>                                 vm_stat_account(mm, vma->vm_flags, grow);
>                                 anon_vma_interval_tree_pre_update_vma(vma);
>                                 vma->vm_end = address;
> +                               vma_mt_store(mm, vma);
>                                 anon_vma_interval_tree_post_update_vma(vma);
> -                               if (vma->vm_next)
> -                                       vma_gap_update(vma->vm_next);
> -                               else
> +                               if (!vma->vm_next)
>                                         mm->highest_vm_end = vm_end_gap(vma);
>                                 spin_unlock(&mm->page_table_lock);
>
> @@ -2466,8 +2192,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>         }
>         anon_vma_unlock_write(vma->anon_vma);
>         khugepaged_enter_vma_merge(vma, vma->vm_flags);
> -       validate_mm(mm);
> -       validate_mm_mt(mm);
>         return error;
>  }
>  #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
> @@ -2475,14 +2199,12 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  /*
>   * vma is the first one with address < vma->vm_start.  Have to extend vma.
>   */
> -int expand_downwards(struct vm_area_struct *vma,
> -                                  unsigned long address)
> +int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  {
>         struct mm_struct *mm = vma->vm_mm;
>         struct vm_area_struct *prev;
>         int error = 0;
>
> -       validate_mm(mm);
>         address &= PAGE_MASK;
>         if (address < mmap_min_addr)
>                 return -EPERM;
> @@ -2519,15 +2241,13 @@ int expand_downwards(struct vm_area_struct *vma,
>                         error = acct_stack_growth(vma, size, grow);
>                         if (!error) {
>                                 /*
> -                                * vma_gap_update() doesn't support concurrent
> -                                * updates, but we only hold a shared mmap_lock
> -                                * lock here, so we need to protect against
> -                                * concurrent vma expansions.
> -                                * anon_vma_lock_write() doesn't help here, as
> -                                * we don't guarantee that all growable vmas
> -                                * in a mm share the same root anon vma.
> -                                * So, we reuse mm->page_table_lock to guard
> -                                * against concurrent vma expansions.
> +                                * We only hold a shared mmap_lock lock here, so
> +                                * we need to protect against concurrent vma
> +                                * expansions.  anon_vma_lock_write() doesn't
> +                                * help here, as we don't guarantee that all
> +                                * growable vmas in a mm share the same root
> +                                * anon vma.  So, we reuse mm->page_table_lock
> +                                * to guard against concurrent vma expansions.
>                                  */
>                                 spin_lock(&mm->page_table_lock);
>                                 if (vma->vm_flags & VM_LOCKED)
> @@ -2539,7 +2259,6 @@ int expand_downwards(struct vm_area_struct *vma,
>                                 /* Overwrite old entry in mtree. */
>                                 vma_mt_store(mm, vma);
>                                 anon_vma_interval_tree_post_update_vma(vma);
> -                               vma_gap_update(vma);
>                                 spin_unlock(&mm->page_table_lock);
>
>                                 perf_event_mmap(vma);
> @@ -2548,7 +2267,6 @@ int expand_downwards(struct vm_area_struct *vma,
>         }
>         anon_vma_unlock_write(vma->anon_vma);
>         khugepaged_enter_vma_merge(vma, vma->vm_flags);
> -       validate_mm(mm);
>         return error;
>  }
>
> @@ -2681,16 +2399,14 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
>         vma->vm_prev = NULL;
>         vma_mt_szero(mm, vma->vm_start, end);
>         do {
> -               vma_rb_erase(vma, &mm->mm_rb);
>                 mm->map_count--;
>                 tail_vma = vma;
>                 vma = vma->vm_next;
>         } while (vma && vma->vm_start < end);
>         *insertion_point = vma;
> -       if (vma) {
> +       if (vma)
>                 vma->vm_prev = prev;
> -               vma_gap_update(vma);
> -       } else
> +       else
>                 mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
>         tail_vma->vm_next = NULL;
>
> @@ -2821,11 +2537,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>         if (len == 0)
>                 return -EINVAL;
>
> -       /*
> -        * arch_unmap() might do unmaps itself.  It must be called
> -        * and finish any rbtree manipulation before this code
> -        * runs and also starts to manipulate the rbtree.
> -        */
> +        /* arch_unmap() might do unmaps itself.  */
>         arch_unmap(mm, start, end);
>
>         /* Find the first overlapping VMA */
> @@ -2833,7 +2545,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>         if (!vma)
>                 return 0;
>         prev = vma->vm_prev;
> -       /* we have  start < vma->vm_end  */
> +       /* we have start < vma->vm_end  */
>
>         /* if it doesn't overlap, we have nothing.. */
>         if (vma->vm_start >= end)
> @@ -2893,7 +2605,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>         if (mm->locked_vm)
>                 unlock_range(vma, end);
>
> -       /* Detach vmas from rbtree */
> +       /* Detach vmas from the MM linked list and remove from the mm tree*/
>         if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
>                 downgrade = false;
>
> @@ -3041,11 +2753,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>   *  anonymous maps.  eventually we may be able to do some
>   *  brk-specific accounting here.
>   */
> -static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long flags, struct list_head *uf)
> +static int do_brk_flags(unsigned long addr, unsigned long len,
> +                       unsigned long flags, struct list_head *uf)
>  {
>         struct mm_struct *mm = current->mm;
>         struct vm_area_struct *vma, *prev;
> -       struct rb_node **rb_link, *rb_parent;
>         pgoff_t pgoff = addr >> PAGE_SHIFT;
>         int error;
>         unsigned long mapped_addr;
> @@ -3064,8 +2776,8 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
>         if (error)
>                 return error;
>
> -       /* Clear old maps, set up prev, rb_link, rb_parent, and uf */
> -       if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
> +       /* Clear old maps, set up prev and uf */
> +       if (munmap_vma_range(mm, addr, len, &prev, uf))
>                 return -ENOMEM;
>
>         /* Check against address space limits *after* clearing old maps... */
> @@ -3099,7 +2811,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
>         vma->vm_pgoff = pgoff;
>         vma->vm_flags = flags;
>         vma->vm_page_prot = vm_get_page_prot(flags);
> -       vma_link(mm, vma, prev, rb_link, rb_parent);
> +       vma_link(mm, vma, prev);
>  out:
>         perf_event_mmap(vma);
>         mm->total_vm += len >> PAGE_SHIFT;
> @@ -3219,26 +2931,10 @@ void exit_mmap(struct mm_struct *mm)
>  int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>         struct vm_area_struct *prev;
> -       struct rb_node **rb_link, *rb_parent;
> -       unsigned long start = vma->vm_start;
> -       struct vm_area_struct *overlap = NULL;
>
> -       if (find_vma_links(mm, vma->vm_start, vma->vm_end,
> -                          &prev, &rb_link, &rb_parent))
> +       if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
>                 return -ENOMEM;
>
> -       overlap = mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
> -       if (overlap) {
> -
> -               pr_err("Found vma ending at %lu\n", start - 1);
> -               pr_err("vma : %lu => %lu-%lu\n", (unsigned long)overlap,
> -                               overlap->vm_start, overlap->vm_end - 1);
> -#if defined(CONFIG_DEBUG_MAPLE_TREE)
> -               mt_dump(&mm->mm_mt);
> -#endif
> -               BUG();
> -       }
> -
>         if ((vma->vm_flags & VM_ACCOUNT) &&
>              security_vm_enough_memory_mm(mm, vma_pages(vma)))
>                 return -ENOMEM;
> @@ -3260,7 +2956,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>                 vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
>         }
>
> -       vma_link(mm, vma, prev, rb_link, rb_parent);
> +       vma_link(mm, vma, prev);
>         return 0;
>  }
>
> @@ -3276,9 +2972,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>         unsigned long vma_start = vma->vm_start;
>         struct mm_struct *mm = vma->vm_mm;
>         struct vm_area_struct *new_vma, *prev;
> -       struct rb_node **rb_link, *rb_parent;
>         bool faulted_in_anon_vma = true;
> -       unsigned long index = addr;
>
>         validate_mm_mt(mm);
>         /*
> @@ -3290,10 +2984,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>                 faulted_in_anon_vma = false;
>         }
>
> -       if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
> +       if (range_has_overlap(mm, addr, addr + len, &prev))
>                 return NULL;    /* should never get here */
> -       if (mt_find(&mm->mm_mt, &index, addr+len - 1))
> -               BUG();
> +
>         new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
>                             vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
>                             vma->vm_userfaultfd_ctx);
> @@ -3334,7 +3027,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>                         get_file(new_vma->vm_file);
>                 if (new_vma->vm_ops && new_vma->vm_ops->open)
>                         new_vma->vm_ops->open(new_vma);
> -               vma_link(mm, new_vma, prev, rb_link, rb_parent);
> +               vma_link(mm, new_vma, prev);
>                 *need_rmap_locks = false;
>         }
>         validate_mm_mt(mm);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 8848cf7cb7c1..c410f99203fb 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -566,13 +566,14 @@ static void put_nommu_region(struct vm_region *region)
>   */
>  static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -       struct vm_area_struct *pvma, *prev;
>         struct address_space *mapping;
> -       struct rb_node **p, *parent, *rb_prev;
> +       struct vm_area_struct *prev;
> +       MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
>
>         BUG_ON(!vma->vm_region);
>
>         mm->map_count++;
> +       printk("mm at %u\n", mm->map_count);

I think this was added while debugging and should be removed?

>         vma->vm_mm = mm;
>
>         /* add the VMA to the mapping */
> @@ -586,42 +587,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
>                 i_mmap_unlock_write(mapping);
>         }
>
> +       rcu_read_lock();
> +       prev = mas_prev(&mas, 0);
> +       rcu_read_unlock();
> +       mas_reset(&mas);
>         /* add the VMA to the tree */
> -       parent = rb_prev = NULL;
> -       p = &mm->mm_rb.rb_node;
> -       while (*p) {
> -               parent = *p;
> -               pvma = rb_entry(parent, struct vm_area_struct, vm_rb);
> -
> -               /* sort by: start addr, end addr, VMA struct addr in that order
> -                * (the latter is necessary as we may get identical VMAs) */
> -               if (vma->vm_start < pvma->vm_start)
> -                       p = &(*p)->rb_left;
> -               else if (vma->vm_start > pvma->vm_start) {
> -                       rb_prev = parent;
> -                       p = &(*p)->rb_right;
> -               } else if (vma->vm_end < pvma->vm_end)
> -                       p = &(*p)->rb_left;
> -               else if (vma->vm_end > pvma->vm_end) {
> -                       rb_prev = parent;
> -                       p = &(*p)->rb_right;
> -               } else if (vma < pvma)
> -                       p = &(*p)->rb_left;
> -               else if (vma > pvma) {
> -                       rb_prev = parent;
> -                       p = &(*p)->rb_right;
> -               } else
> -                       BUG();
> -       }
> -
> -       rb_link_node(&vma->vm_rb, parent, p);
> -       rb_insert_color(&vma->vm_rb, &mm->mm_rb);
> -
> -       /* add VMA to the VMA list also */
> -       prev = NULL;
> -       if (rb_prev)
> -               prev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
> -
> +       vma_mas_store(vma, &mas);
>         __vma_link_list(mm, vma, prev);
>  }
>
> @@ -634,6 +605,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
>         struct address_space *mapping;
>         struct mm_struct *mm = vma->vm_mm;
>         struct task_struct *curr = current;
> +       MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
>
>         mm->map_count--;
>         for (i = 0; i < VMACACHE_SIZE; i++) {
> @@ -643,7 +615,6 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
>                         break;
>                 }
>         }
> -
>         /* remove the VMA from the mapping */
>         if (vma->vm_file) {
>                 mapping = vma->vm_file->f_mapping;
> @@ -656,8 +627,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
>         }
>
>         /* remove from the MM's tree and list */
> -       rb_erase(&vma->vm_rb, &mm->mm_rb);
> -
> +       vma_mas_remove(vma, &mas);
>         __vma_unlink_list(mm, vma);
>  }
>
> @@ -681,24 +651,21 @@ static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
>         struct vm_area_struct *vma;
> +       MA_STATE(mas, &mm->mm_mt, addr, addr);
>
>         /* check the cache first */
>         vma = vmacache_find(mm, addr);
>         if (likely(vma))
>                 return vma;
>
> -       /* trawl the list (there may be multiple mappings in which addr
> -        * resides) */
> -       for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -               if (vma->vm_start > addr)
> -                       return NULL;
> -               if (vma->vm_end > addr) {
> -                       vmacache_update(addr, vma);
> -                       return vma;
> -               }
> -       }
> +       rcu_read_lock();
> +       vma = mas_walk(&mas);
> +       rcu_read_unlock();
>
> -       return NULL;
> +       if (vma)
> +               vmacache_update(addr, vma);
> +
> +       return vma;
>  }
>  EXPORT_SYMBOL(find_vma);
>
> @@ -730,26 +697,25 @@ static struct vm_area_struct *find_vma_exact(struct mm_struct *mm,
>  {
>         struct vm_area_struct *vma;
>         unsigned long end = addr + len;
> +       MA_STATE(mas, &mm->mm_mt, addr, addr);
>
>         /* check the cache first */
>         vma = vmacache_find_exact(mm, addr, end);
>         if (vma)
>                 return vma;
>
> -       /* trawl the list (there may be multiple mappings in which addr
> -        * resides) */
> -       for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -               if (vma->vm_start < addr)
> -                       continue;
> -               if (vma->vm_start > addr)
> -                       return NULL;
> -               if (vma->vm_end == end) {
> -                       vmacache_update(addr, vma);
> -                       return vma;
> -               }
> -       }
> -
> -       return NULL;
> +       rcu_read_lock();
> +       vma = mas_walk(&mas);
> +       rcu_read_unlock();
> +       if (!vma)
> +               return NULL;
> +       if (vma->vm_start != addr)
> +               return NULL;
> +       if (vma->vm_end != end)
> +               return NULL;
> +
> +       vmacache_update(addr, vma);
> +       return vma;
>  }
>
>  /*
> diff --git a/mm/util.c b/mm/util.c
> index 0b6dd9d81da7..35deaa0ccac5 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -287,6 +287,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>         vma->vm_next = next;
>         if (next)
>                 next->vm_prev = vma;
> +       else
> +               mm->highest_vm_end = vm_end_gap(vma);
>  }
>
>  void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
> @@ -301,6 +303,12 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
>                 mm->mmap = next;
>         if (next)
>                 next->vm_prev = prev;
> +       else {
> +               if (prev)
> +                       mm->highest_vm_end = vm_end_gap(prev);
> +               else
> +                       mm->highest_vm_end = 0;
> +       }
>  }
>
>  /* Check if the vma is being used as a stack by this task */
> --
> 2.30.2
