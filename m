Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9C309E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhAaUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhAaTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05BED64E43
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612117607;
        bh=MKWpmZEwgflR/tg9uIfU5icINT1Ba4YkYbavbNKWndk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u4s+ClkidDrWitAQ+/0lteh7Zggar8KT3j8Z5GNVH8F5+JucR0WWVz5tmg5uI/s57
         /JFkFHuGrkBHl80SG8c/ILiuejd2WJpG2SQ06KA0Tg92iIUcMWrOaISMgGvDKP8qTa
         V683ptPgog2VjhPvtTP4Up79jc1nEFwUvFeCLFneq0ooWY1XK8t5ezIrhLTSOmCdXx
         M3Td7CsdozgvLc+LOkIcSRXLSgs0xvNN/xF9sQS7PueVxrgw4Ewlx08+FUUCF1vSD0
         aRoz43T3PxoxbB04zHRL0Eme9BzvyiRUymhAVQDb1O10mm/13lY7zG9MDOAyy928+X
         TUMf9DWb2TFhA==
Received: by mail-ed1-f45.google.com with SMTP id s5so3472435edw.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 10:26:46 -0800 (PST)
X-Gm-Message-State: AOAM532nrURkYgHEv9X0d+nm3ox8COb3Y0Xq9Z7pln34IUb7S/92Rg1K
        D8BC1/K5UUv9f/Q/rL5lL35DHIitEloXwMJ8L2QVng==
X-Google-Smtp-Source: ABdhPJxcH/OxKjyA8VB3yDBVpwEhEg/X27LdcUkmTawledJjdB742M6RMRGzViP74t5Yj1thr+1Ob/7dfm/Z/3WZVVU=
X-Received: by 2002:aa7:c384:: with SMTP id k4mr15047523edq.23.1612117605566;
 Sun, 31 Jan 2021 10:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-8-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-8-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Jan 2021 10:26:34 -0800
X-Gmail-Original-Message-ID: <CALCETrV488g=U6dK5XfhczCUfn3Wvgs6kF8fvdBSZ5DfTwR+RQ@mail.gmail.com>
Message-ID: <CALCETrV488g=U6dK5XfhczCUfn3Wvgs6kF8fvdBSZ5DfTwR+RQ@mail.gmail.com>
Subject: Re: [RFC 07/20] mm: move x86 tlb_gen to generic code
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Nadav Amit <namit@vmware.com>
>
> x86 currently has a TLB-generation tracking logic that can be used by
> additional architectures (as long as they implement some additional
> logic).
>
> Extract the relevant pieces of code from x86 to general TLB code. This
> would be useful to allow to write the next "fine granularity deferred
> TLB flushes detection" patches without making them x86-specific.

Tentative ACK.

My biggest concern about this is that, once it's exposed to core code,
people might come up with clever-but-incorrect ways to abuse it.  Oh
well.

>  struct workqueue_struct *efi_rts_wq;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0974ad501a47..2035ac319c2b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -560,6 +560,17 @@ struct mm_struct {
>
>  #ifdef CONFIG_IOMMU_SUPPORT
>                 u32 pasid;
> +#endif
> +#ifdef CONFIG_ARCH_HAS_TLB_GENERATIONS
> +               /*
> +                * Any code that needs to do any sort of TLB flushing for this
> +                * mm will first make its changes to the page tables, then
> +                * increment tlb_gen, then flush.  This lets the low-level
> +                * flushing code keep track of what needs flushing.
> +                *
> +                * This is not used on Xen PV.

That last comment should probably go away.
