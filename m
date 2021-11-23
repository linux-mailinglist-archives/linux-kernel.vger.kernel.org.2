Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82B4599D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhKWBuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKWBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:50:34 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:47:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v138so55096774ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPJygyTVm3LaiTYDIf43ooZ8K/o9AhsrwBhV4qKQzSk=;
        b=IkYsbKDEF+3U7qHV98R8IgRkeTR9j0jpUpn1csVzaW/2NuL9GlSJJRcuIfHL2+o+5E
         dEo0tzmnq0a9B3cRgPuk3djQmmKaDtt3+epyWtpsoq3Jb9fvkVuugDDroEzLGkMF8b+x
         coxNzN20o0RCTriOmdxRpQwI+voaYkHuUbhr9BGC23LAgApD+M2/5wavuTz48CS8szhi
         xiNN9ImcXPiYIBA3LK1QRaeL8uYgWOJCx2VIgqv8MKIV9fceafgSixtIfsGewGwNEau1
         Wv+J1PfwGHPi+y8y4vwh+xgIVWsKM1zSBevVULUj0C36lIYQKuZKQsRpKvv0qA4N1DxU
         +D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPJygyTVm3LaiTYDIf43ooZ8K/o9AhsrwBhV4qKQzSk=;
        b=PoHYG13Z8blI8uhyyiA9fffE9poLH7SwlsHAe8cQ7YSW6N7VndiKgEijFizxc2NMw+
         SprMxsxYNP1kvp7IbUj0Y2VyEt2NXYrEs8GjJdnGJLVAkQKycrJW/9GkjGFNHI6Kowmd
         piOTdX2B1Lo+V4LWsLkIXsgzQ+LnbxwvByImy61Sm4o0C+RNyWSQgjeeK4c5dn0tW9FX
         wGHMY9DlzrNSRtF+u9lyOiOdB0k+hCpkdQM+O6bJLRbb6I3n/vDwOu562arc//kDuvWf
         pVCvj+muckZ9eKvXzm2hzbb91+I9OYII60ztakGZDi/DroDRSJBX/uRAdRXRfXUwdFZr
         RIVQ==
X-Gm-Message-State: AOAM532gHuPsZ2AxD5SvrGXn+MCr8V+lu4GyxH0dJxLiiYB83mG+AK79
        0ZZ0b+RpSd0/18U1VVTdGCH2VHmlBoNbuRSFxrMljg==
X-Google-Smtp-Source: ABdhPJwHxFLwDJzjCt9YMqN1C1kz288fbcwTv20u44vVF/XxAZFtdLQISEavPFXFN3tXBb18su6J4APNqGl1rcG/6Ts=
X-Received: by 2002:a25:a429:: with SMTP id f38mr1949614ybi.34.1637632046025;
 Mon, 22 Nov 2021 17:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20211116215715.645231-1-surenb@google.com>
In-Reply-To: <20211116215715.645231-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 22 Nov 2021 17:47:14 -0800
Message-ID: <CAJuCfpGjr3a90896Vknw9ytBvz-d3whFQc=DDoVMxxcLGKpX2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock
 in exit_mmap
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 1:57 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> oom-reaper and process_mrelease system call should protect against
> races with exit_mmap which can destroy page tables while they
> walk the VMA tree. oom-reaper protects from that race by setting
> MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> before taking and releasing mmap_write_lock. process_mrelease has
> to elevate mm->mm_users to prevent such race. Both oom-reaper and
> process_mrelease hold mmap_read_lock when walking the VMA tree.
> The locking rules and mechanisms could be simpler if exit_mmap takes
> mmap_write_lock while executing destructive operations such as
> free_pgtables.
> Change exit_mmap to hold the mmap_write_lock when calling
> free_pgtables. Operations like unmap_vmas() and unlock_range() are not
> destructive and could run under mmap_read_lock but for simplicity we
> take one mmap_write_lock during almost the entire operation. Note
> also that because oom-reaper checks VM_LOCKED flag, unlock_range()
> should not be allowed to race with it.
> In most cases this lock should be uncontended. Previously, Kirill
> reported ~4% regression caused by a similar change [1]. We reran the
> same test and although the individual results are quite noisy, the
> percentiles show lower regression with 1.6% being the worst case [2].
> The change allows oom-reaper and process_mrelease to execute safely
> under mmap_read_lock without worries that exit_mmap might destroy page
> tables from under them.
>
> [1] https://lore.kernel.org/all/20170725141723.ivukwhddk2voyhuc@node.shutemov.name/
> [2] https://lore.kernel.org/all/CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com/

Friendly nudge.
Michal, Matthew, from our discussion in
https://lore.kernel.org/all/YXKhOKIIngIuJaYi@casper.infradead.org I
was under the impression this change would be interesting for you. Any
feedback?

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bfb0ea164a90..69b3036c6dee 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3142,25 +3142,27 @@ void exit_mmap(struct mm_struct *mm)
>                  * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>                  * __oom_reap_task_mm() will not block.
>                  *
> -                * This needs to be done before calling munlock_vma_pages_all(),
> +                * This needs to be done before calling unlock_range(),
>                  * which clears VM_LOCKED, otherwise the oom reaper cannot
>                  * reliably test it.
>                  */
>                 (void)__oom_reap_task_mm(mm);
>
>                 set_bit(MMF_OOM_SKIP, &mm->flags);
> -               mmap_write_lock(mm);
> -               mmap_write_unlock(mm);
>         }
>
> +       mmap_write_lock(mm);
>         if (mm->locked_vm)
>                 unlock_range(mm->mmap, ULONG_MAX);
>
>         arch_exit_mmap(mm);
>
>         vma = mm->mmap;
> -       if (!vma)       /* Can happen if dup_mmap() received an OOM */
> +       if (!vma) {
> +               /* Can happen if dup_mmap() received an OOM */
> +               mmap_write_unlock(mm);
>                 return;
> +       }
>
>         lru_add_drain();
>         flush_cache_mm(mm);
> @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
>         unmap_vmas(&tlb, vma, 0, -1);
>         free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>         tlb_finish_mmu(&tlb);
> +       mmap_write_unlock(mm);
>
>         /*
>          * Walk the list again, actually closing and freeing it,
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>
