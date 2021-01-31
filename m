Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F4309A09
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhAaC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 21:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhAaC6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 21:58:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F02B964E20
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612061891;
        bh=2ZuL0ipkHZksLJpXozGUIZWFSxAx6TjngbQg46FjVM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nDjn+UMdjG1f8RaeG7NRfTa5sthGZmBxu704daUKOBV7vqFzHbcVnU/tC+JrhdQes
         q2zFmGj79Tw8LVpmYqfeXtiX8EHeRKIjObO7WEFFRzDnzgfo7g10ieVUSA0oYaw47L
         QsEH2wz6BBjm7ra4G+59DOMncVLb7bRZ+mZwusTreVCc1oJlDUKcYWgUkPAXhHNKjC
         aft7Olq0QOOvWnDx/pWxibmoLAplDCnUXONCEiUv/WewqJ6GmKLFAsbjGwr5kW15ao
         88ffk8Rp7fdlJQSJNOH+sO7UZZT4P6Qvoq5lGbLT1UzrPDOglUkA2YHI3lu4lGZA6C
         4v5xa2Er41FSw==
Received: by mail-ej1-f54.google.com with SMTP id kg20so18903983ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 18:58:10 -0800 (PST)
X-Gm-Message-State: AOAM532x+1e5Rxlt6UNVsBfWS0zFJ5FnB96dLSynOce/fv9mo2ZhNyKr
        QF+lDhKBToKogGLsZOCOECHVsGQUwxXPkgRk5GbIFw==
X-Google-Smtp-Source: ABdhPJzuvMeoa5x43Osfwv5jGxZhV69eYEA9EJO6fmryJgk55JeUN54QNBUrDa6b4orPYL5iQvjaHV8eULSlbn7/NbA=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr11420554ejq.101.1612061889455;
 Sat, 30 Jan 2021 18:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-2-namit@vmware.com>
 <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com> <E0013E72-E192-4405-A78D-5D41069ECF76@gmail.com>
In-Reply-To: <E0013E72-E192-4405-A78D-5D41069ECF76@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 30 Jan 2021 18:57:58 -0800
X-Gmail-Original-Message-ID: <CALCETrU8DCiu7Rfqr_z-aj_pFzTid3qkaN9g-Biq_A+99NVpdQ@mail.gmail.com>
Message-ID: <CALCETrU8DCiu7Rfqr_z-aj_pFzTid3qkaN9g-Biq_A+99NVpdQ@mail.gmail.com>
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:19 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Jan 30, 2021, at 5:02 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >>
> >> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
> >> (e.g., on process exit) and can therefore allow certain optimizations.
> >> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
> >> the TLB should be fully flushed.
> >
> > Maybe also rename fullmm?
>
> Possible. How about mm_torn_down?

Sure.  Or mm_exiting, perhaps?

>
> I should have also changed the comment in tlb_finish_mmu().
