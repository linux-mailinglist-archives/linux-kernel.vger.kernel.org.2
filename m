Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00376309978
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhAaAkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhAaAkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:40:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 404B364E18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612053594;
        bh=ZARN4/SNMif8pmhvtSYaVaBh/E7PVLrk6k7KSJ+Cbgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIOgJQZUx+1+CIY+uUFr3AqjeBFrwk9ryhp+g65Zv5nDG+pIgk1N/r4mSP5BAz/qJ
         wQMg2itlvUY/Y4eRQenumglnlA2SblzxOw8ArHfqgmyYRTbIITjWC1vTcrsXO62gjh
         CAiMWnbH8B47mRo7wSTVqg4YsSNnYSF4R3tLeZ5Nox2xbMZyvruMAPr+CMsXcdN+Qg
         yCxnUose/9kCLov4O5KXuXEvT6QQKnUrvunhz8aUApExv7JPQ7DJwolqGvEVr3AamM
         GOOLJp1AsSd6mqmBcOFoHXrUXpH8x4AQ2A+tdRoYbHyuwgyXJA4koCFCmaLQqp9KCL
         MV5zOeTqz1l8Q==
Received: by mail-ed1-f42.google.com with SMTP id q2so97834edi.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:39:54 -0800 (PST)
X-Gm-Message-State: AOAM532kRrllJ0uRsUqvJYnLkoonLTArpbNcdrDVejevefhXxJMWmqb2
        N9bUBh9ciZQKU6tMwtmY92BfyfQSIM+JPV9tbhS0zw==
X-Google-Smtp-Source: ABdhPJz2HtR+oWDJm9Im8a9Zc9ILIiNOJ3sJ5fZY04oSx16Isz5PJWJD/yFlp6cyFbiANw2fuD8+l8VdlPb3QxBCnDs=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr11930169edc.97.1612053592891;
 Sat, 30 Jan 2021 16:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 30 Jan 2021 16:39:41 -0800
X-Gmail-Original-Message-ID: <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
Message-ID: <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-csky@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Nadav Amit <namit@vmware.com>
>
> There are currently (at least?) 5 different TLB batching schemes in the
> kernel:
>
> 1. Using mmu_gather (e.g., zap_page_range()).
>
> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>    ongoing deferred TLB flush and flushing the entire range eventually
>    (e.g., change_protection_range()).
>
> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>
> 4. Batching per-table flushes (move_ptes()).
>
> 5. By setting a flag on that a deferred TLB flush operation takes place,
>    flushing when (try_to_unmap_one() on x86).

Are you referring to the arch_tlbbatch_add_mm/flush mechanism?
