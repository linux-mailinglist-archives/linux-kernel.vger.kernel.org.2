Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1730998C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhAaBDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhAaBDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:03:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E33064E17
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 01:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612054949;
        bh=d0735n6S/Vm5Q8cSSbumHsQrStTHOJtD0MC5+xI4v2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TRt+2gfRF55vRA4ZYI+7bti3FB92qTfJN9Ri5+/0PziY3lTJpJ6VNQnkOO0l2SSHr
         F1tfVyu2W0ayplfrflQApRI8fEEEmA+QRyU2XdOyuf7x56e/pHGQNKo39yUvKRTMQ0
         HUwpSwVg3926TJHX9MO6JdiUDihqbz1MKoqgGb9/XhkJUeI365X7t+pTBflx8QI4qv
         cQ4Q9nc1UaJW+h5ypfWrmhofz5M6EnT70LOWOv//igikmEeQL8Pf72wT+USgq/PnKg
         oyAsBj9GZYT4721F3FGDxXqIV5spPWz2i+DTIajM3Fhfu9oVbq9peJ0tRyzL/TrQU7
         7alZHZ11nscuw==
Received: by mail-ej1-f44.google.com with SMTP id kg20so18723261ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:02:29 -0800 (PST)
X-Gm-Message-State: AOAM530a4P3qzfySMSLksIXGp3QE3Ny6yry7aF2sFCgMxO1Wz8Cl2V4H
        r53V2lG6y6bnAIKoUCcBqMOFdXvw1/qa8E6uy+JNiw==
X-Google-Smtp-Source: ABdhPJwnWrOJS0MPqnl4YTkmZ8VNRJauXOuZtdE2Ab4udtV8dDodM9sQHb6yipm15L/pVa5j7OVUOLDNj6P/iI2J1io=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr11140726ejq.101.1612054947857;
 Sat, 30 Jan 2021 17:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20210131001132.3368247-1-namit@vmware.com> <20210131001132.3368247-2-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-2-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 30 Jan 2021 17:02:16 -0800
X-Gmail-Original-Message-ID: <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com>
Message-ID: <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com>
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
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
> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
> (e.g., on process exit) and can therefore allow certain optimizations.
> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
> the TLB should be fully flushed.

Maybe also rename fullmm?
