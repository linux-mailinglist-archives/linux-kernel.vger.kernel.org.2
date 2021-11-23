Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB8459F58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhKWJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhKWJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:37:01 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:33:53 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so32949208otg.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1eFzhqZhKStQ6SAejbe5i9BeR0+rlVTE2OXKMpdriE=;
        b=X/NuWj2aYCJ+2lcyvWwjUYPcjbJ5MQlDDkLmDtPEDST/3hWWBt7AHgGeaOCpl639ba
         lWgROjeIfON09qqiyonuRHQwTWU0aHzcnx26GwXTt3uSZ3iRXDho8JIzoFM+kuwGvU72
         DT0IcVmqxEoBVKQ5tAYMqjxrENYmxeLyCJCFHHeuFli6g3W0qJMVIUmTmtnHkkWmpbyx
         1flQkBfYRtIEYxRCs/3I5v3xCmAjxEUz2dM2jOeRXYL3eLJCv260JYWxakVE1YaPx4ki
         I0UQ+5JeVX8nAqMCy2wMFjM/WkcclAF4IP9vPWRZ4H13dvbmp0/F4b46wRXKuNvfe600
         nSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1eFzhqZhKStQ6SAejbe5i9BeR0+rlVTE2OXKMpdriE=;
        b=Q5nizk5rZLvejdOmX4oi975E0wr9ghjlpHOOhtG2DJ2G3z1xasHIK9Uag0qC6yygfd
         fe4D8g0t0rQ34Ia13cFENYxk/S6qtroOI4ZbscOzLYCllsHItFOXxiuLvXAJv6NoZScz
         /bml+M4Ri5wYJziecUXr0wyMApfNf068FNhZwsxZJhhXj0Kg5xtnQcaaTYUEnq2REKIQ
         eX8yEaedTx06StVEvyg4ugOPWeK8xqsuTRtFyjhtnkRfn+GFpKOvTur97JUcoM+wPEum
         N2jroJOSWQgDXvSbVuZzHxI1G6JPc/NgjGC6Nng621lkyxrWV/vspSBnqKF8Iuwp/Amb
         YMVg==
X-Gm-Message-State: AOAM531dlwYamYW/TzzfsAdBT0pPrNPDV7X+9qi0bcGcgypOkNTo9W44
        jJfw5AzeBLPx1++x/Qlz8aChTMtlJEury7N/+uptpg==
X-Google-Smtp-Source: ABdhPJwyGX6dc9JXTH/JGlfix7XL94vC6ykb+Wdz4x/qw9tS4QrZ+d6qdrdqC+PGECCkLP/FKULRqSUDyi3d6bq1G6M=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr2994949otl.92.1637660032976;
 Tue, 23 Nov 2021 01:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20211123074344.1877731-1-ying.huang@intel.com>
In-Reply-To: <20211123074344.1877731-1-ying.huang@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Nov 2021 10:33:41 +0100
Message-ID: <CANpmjNPGkQ2VWmHjt==yWVr5webCHuRQtXau95jvPjR4Z3gxDw@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: fix potential batched TLB flush race
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 08:44, Huang Ying <ying.huang@intel.com> wrote:
>
> In theory, the following race is possible for batched TLB flushing.
>
> CPU0                               CPU1
> ----                               ----
> shrink_page_list()
>                                    unmap
>                                      zap_pte_range()
>                                        flush_tlb_batched_pending()
>                                          flush_tlb_mm()
>   try_to_unmap()
>     set_tlb_ubc_flush_pending()
>       mm->tlb_flush_batched = true
>                                          mm->tlb_flush_batched = false
>
> After the TLB is flushed on CPU1 via flush_tlb_mm() and before
> mm->tlb_flush_batched is set to false, some PTE is unmapped on CPU0
> and the TLB flushing is pended.  Then the pended TLB flushing will be
> lost.  Although both set_tlb_ubc_flush_pending() and
> flush_tlb_batched_pending() are called with PTL locked, different PTL
> instances may be used.
>
> Because the race window is really small, and the lost TLB flushing
> will cause problem only if a TLB entry is inserted before the
> unmapping in the race window, the race is only theoretical.  But the
> fix is simple and cheap too.

Thanks for fixing this!

> Syzbot has reported this too as follows,
>
> ==================================================================
> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
[...]
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c3a6e6209600..789778067db9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -632,7 +632,7 @@ struct mm_struct {
>                 atomic_t tlb_flush_pending;
>  #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>                 /* See flush_tlb_batched_pending() */
> -               bool tlb_flush_batched;
> +               atomic_t tlb_flush_batched;
>  #endif
>                 struct uprobes_state uprobes_state;
>  #ifdef CONFIG_PREEMPT_RT
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 163ac4e6bcee..60902c3cfb4a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -633,7 +633,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>          * before the PTE is cleared.
>          */
>         barrier();
> -       mm->tlb_flush_batched = true;
> +       atomic_inc(&mm->tlb_flush_batched);

The use of barrier() and atomic needs some clarification. Is there a
requirement that the CPU also doesn't reorder anything after this
atomic_inc() (which is unordered)? I.e. should this be
atomic_inc_return_release() and remove barrier()?

>         /*
>          * If the PTE was dirty then it's best to assume it's writable. The
> @@ -680,15 +680,16 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>   */
>  void flush_tlb_batched_pending(struct mm_struct *mm)
>  {
> -       if (data_race(mm->tlb_flush_batched)) {
> -               flush_tlb_mm(mm);
> +       int batched = atomic_read(&mm->tlb_flush_batched);
>
> +       if (batched) {
> +               flush_tlb_mm(mm);
>                 /*
> -                * Do not allow the compiler to re-order the clearing of
> -                * tlb_flush_batched before the tlb is flushed.
> +                * If the new TLB flushing is pended during flushing,
> +                * leave mm->tlb_flush_batched as is, to avoid to lose
> +                * flushing.
>                  */
> -               barrier();
> -               mm->tlb_flush_batched = false;
> +               atomic_cmpxchg(&mm->tlb_flush_batched, batched, 0);
>         }
>  }
>  #else
> --
> 2.30.2
>
