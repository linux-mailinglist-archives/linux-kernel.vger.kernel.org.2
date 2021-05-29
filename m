Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCE3949A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 02:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhE2AoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 20:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2AoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 20:44:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C06C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 17:42:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i4so7913793ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rNp2fDhgwLzO7RkwblP26djFafGfFHWnlzvqzrDqZI=;
        b=JtO5JzwuwvNHdC8HPItbi1wgfO3RerPFQ7UvmufO2tmaQDI3nUvBkIYWx5Qw8bL7rW
         b4R/92IAdFYe9t0DOQSSY8rJaEV1Fi+kVw0rE4AeeAcmlby0gXRdh3TF4wI40160vnf2
         PM4NofM66n+oYEjXwjnacFNBwGBPs647mX62tA9asWVExbxHfNZOKhQj8+qxQpPMX7Ag
         33AG08O8L6XT/+8F3Nxnzu+u8iwDJaRAxoIC2kVZAOauSV02MuM+3bH7mJZRgQdzuy4T
         zACJxjavU8c7+boCEYycqQAxILr6g0SBGpQMSDYoXnlxc9y02/uQd0880A/gaJTGkTQC
         K14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rNp2fDhgwLzO7RkwblP26djFafGfFHWnlzvqzrDqZI=;
        b=HI+k52jtWM0VYtrW35aosg+rEayU+YrCby5L3TMvkD4PoQ3m07cZAqimdb729VDwr7
         1wePvkvB1ovsyK7mtkBRBtWVxSCdwBW/byPsbGM/ethyZNdV1h/zXfbR1At7WPIKWDr2
         ERI26Rjiij9xotSHVxcsYlHOJbIdIea0Y7ExPfvKvIm1zFf/5ntbchVm/37RLrokdC3J
         v5B73YTG6r6yRSUiqacp0OhI61j/p092Gj3R+6rmYEQa4S6Nz430YQAyhrbaOLO7lUix
         bjfPCkk/uHDeNO4ziFk8ON7SUuGzLBzzVvxrYHdt1ir87dEFmeolgLgreOrp0Q/LJtgV
         GeVA==
X-Gm-Message-State: AOAM531lcg4kDNUEZvFISCCWw/23zkKPm664KtwmiH/oU7sOnxzDCACu
        pmDjPrP7L3j8iEl7JadABlIzFmhcCwuXDKl/TXCZEQ==
X-Google-Smtp-Source: ABdhPJzYj5znEzvjKe5Vxy6OnJiZYUmbPY/dv7trRPa7wnbyk+9j71wVOX/3HQa/ISUv61OHwbSbZPOaMLj3xMIiX2A=
X-Received: by 2002:a25:74c6:: with SMTP id p189mr10271289ybc.84.1622248959537;
 Fri, 28 May 2021 17:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com> <20210428153542.2814175-33-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-33-Liam.Howlett@Oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 May 2021 17:42:28 -0700
Message-ID: <CAJuCfpEBnrTShvYN9G9PTHjBWnEBeibuMwNOER66r1TdqBWNzg@mail.gmail.com>
Subject: Re: [PATCH 32/94] kernel/fork: Convert dup_mmap to use maple tree
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
> Use the maple tree iterator to duplicate the mm_struct trees.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  include/linux/mm.h       |  2 --
>  include/linux/sched/mm.h |  3 +++
>  kernel/fork.c            | 24 +++++++++++++++++++-----
>  mm/mmap.c                |  4 ----
>  4 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e89bacfa9145..7f7dff6ad884 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2498,8 +2498,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
>  /* nommu.c */
>  extern atomic_long_t mmap_pages_allocated;
>  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
> -/* maple_tree */
> -void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
>
>  /* interval_tree.c */
>  void vma_interval_tree_insert(struct vm_area_struct *node,
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index e24b1fe348e3..76cab3aea6ab 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,6 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> +#include <linux/maple_tree.h>
>
>  /*
>   * Routines for handling mm_structs
> @@ -67,11 +68,13 @@ static inline void mmdrop(struct mm_struct *mm)
>   */
>  static inline void mmget(struct mm_struct *mm)
>  {
> +       mt_set_in_rcu(&mm->mm_mt);
>         atomic_inc(&mm->mm_users);
>  }
>
>  static inline bool mmget_not_zero(struct mm_struct *mm)
>  {
> +       mt_set_in_rcu(&mm->mm_mt);

Should you be calling mt_set_in_rcu() if atomic_inc_not_zero() failed?
I don't think mmput() is called after mmget_not_zero() fails and
mt_clear_in_rcu() will not be called.

>         return atomic_inc_not_zero(&mm->mm_users);
>  }
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c37abaf28eb9..832416ff613e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -477,7 +477,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>         struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
>         struct rb_node **rb_link, *rb_parent;
>         int retval;
> -       unsigned long charge;
> +       unsigned long charge = 0;
> +       MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
> +       MA_STATE(mas, &mm->mm_mt, 0, 0);
>         LIST_HEAD(uf);
>
>         uprobe_start_dup_mmap();
> @@ -511,7 +513,13 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                 goto out;
>
>         prev = NULL;
> -       for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
> +
> +       retval = mas_entry_count(&mas, oldmm->map_count);
> +       if (retval)
> +               goto fail_nomem;
> +
> +       rcu_read_lock();
> +       mas_for_each(&old_mas, mpnt, ULONG_MAX) {
>                 struct file *file;
>
>                 if (mpnt->vm_flags & VM_DONTCOPY) {
> @@ -525,7 +533,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                  */
>                 if (fatal_signal_pending(current)) {
>                         retval = -EINTR;
> -                       goto out;
> +                       goto loop_out;
>                 }
>                 if (mpnt->vm_flags & VM_ACCOUNT) {
>                         unsigned long len = vma_pages(mpnt);
> @@ -594,7 +602,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                 rb_parent = &tmp->vm_rb;
>
>                 /* Link the vma into the MT */
> -               vma_store(mm, tmp);
> +               mas.index = tmp->vm_start;
> +               mas.last = tmp->vm_end - 1;
> +               mas_store(&mas, tmp);
>
>                 mm->map_count++;
>                 if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -604,14 +614,17 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>                         tmp->vm_ops->open(tmp);
>
>                 if (retval)
> -                       goto out;
> +                       goto loop_out;
>         }
>         /* a new mm has just been created */
>         retval = arch_dup_mmap(oldmm, mm);
> +loop_out:
>  out:
> +       rcu_read_unlock();
>         mmap_write_unlock(mm);
>         flush_tlb_mm(oldmm);
>         mmap_write_unlock(oldmm);
> +       mas_destroy(&mas);
>         dup_userfaultfd_complete(&uf);
>  fail_uprobe_end:
>         uprobe_end_dup_mmap();
> @@ -1092,6 +1105,7 @@ static inline void __mmput(struct mm_struct *mm)
>  {
>         VM_BUG_ON(atomic_read(&mm->mm_users));
>
> +       mt_clear_in_rcu(&mm->mm_mt);
>         uprobe_clear_state(mm);
>         exit_aio(mm);
>         ksm_exit(mm);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 929c2f9eb3f5..1bd43f4db28e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -780,10 +780,6 @@ static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma
>                 GFP_KERNEL);
>  }
>
> -void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
> -       vma_mt_store(mm, vma);
> -}
> -
>  static void
>  __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
>         struct vm_area_struct *prev, struct rb_node **rb_link,
> --
> 2.30.2
