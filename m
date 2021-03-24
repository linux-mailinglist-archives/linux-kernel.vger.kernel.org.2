Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14E43478EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhCXMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhCXMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:54:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131CC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:54:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so31780479lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x8/eOR8jBnzEM8stTetLIzcLMcnZLJokgA4zekf+j0=;
        b=IUsdx7gTHzToc2R8nVOw084aJxUAVpPQdGLRVFk3aSkpDZRQUSJ7a/f9KkLbM81RWy
         ceXojVRk5jfbOgZI4gNUC5KLnSkNaKvNLPG9EsNqDPkvoSkgbIyfJnCjCaciZyj0b7C8
         DHGsVCyQPXK+pMNgaJy2znETUe1ALYjz1yzJ+WCyiWjjqCx9tteYZREiYyBVMnLM7wP6
         HfAJrFlJe2QBlLD9FT+d5es32brgS9c5cY8ZUkfU6St8WIfre30ui1IRi0K1RYdxHBGC
         xl99QutYbN0T7beWSQ+/NZCv+1oLh9FOfwsokyVxcNNr7p6t54wtrrSB16IRoc8etrbi
         Ibew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x8/eOR8jBnzEM8stTetLIzcLMcnZLJokgA4zekf+j0=;
        b=gSSam/LsufQHdvWm5Jv9WFV0MEYuXMb3MdGoxhwHCZu6Y0kzyWO11KIpXgrqZfFeLG
         rq+NqKmx/VEOgxqPqeSSk/pLa9eLG9b0kUsCoi6cgcib2eX2yt7mW0fuMV+kX1c/AHlQ
         UsuvA/zBIqr4VmujICMz3fd8cxRZy3V/lRVp98dE4OrEXlXLpxy2rbk19gCL7QrGQUbg
         DOecYgS3NFhpJH99Ywo4ylBp9u3LOhDs4M09nz47Ou0cjxuyNjfLnZNL1zkc6GMMMtk4
         0yD9GDq24qBgzOkBaJf7noLTxwr7wURSBM7apj1DWp0O/40EjI6S4dMRzd5f5+89Vsk0
         tpfA==
X-Gm-Message-State: AOAM531iyLGe0F3nAmpRrU8ec95rxLYzuHyM0UCFj4pgdHhsLnkHljKE
        OIfVs+mw5cZV1tf+AKlb0l42sNPiqq0EWoVx9qHfnw==
X-Google-Smtp-Source: ABdhPJw3zXWj17ytjGUcJXrPBhqSrf/SVUB//Qqzw55UnOxrq3HR3/eH04quGqhpPfVKlJ6pV8HKE+t1UT6KCYmskaE=
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr1917793lfm.369.1616590443029;
 Wed, 24 Mar 2021 05:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
 <CAAhSdy2FPHX7Mhg5bRUOTk8SAw+jfWxhKquGZpC6YD0MPLSu0A@mail.gmail.com> <YFsylL7cJqVtVqBI@hirez.programming.kicks-ass.net>
In-Reply-To: <YFsylL7cJqVtVqBI@hirez.programming.kicks-ass.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Mar 2021 18:23:51 +0530
Message-ID: <CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 6:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 24, 2021 at 05:58:58PM +0530, Anup Patel wrote:
> > On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > This patch introduces a ticket lock implementation for riscv, along the
> > > same lines as the implementation for arch/arm & arch/csky.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/riscv/Kconfig                      |   1 +
> > >  arch/riscv/include/asm/Kbuild           |   1 +
> > >  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
> > >  arch/riscv/include/asm/spinlock_types.h |  19 ++--
> >
> > NACK from myside.
> >
> > Linux ARM64 has moved away from ticket spinlock to qspinlock.
> >
> > We should directly go for qspinlock.
>
> I think it is a sensible intermediate step, even if you want to go
> qspinlock. Ticket locks are more or less trivial and get you fairness
> and all that goodness without the mind bending complexity of qspinlock.
>
> Once you have the ticket lock implementation solid (and qrwlock) and
> everything, *then* start to carefully look at qspinlock.

I do understand qspinlock are relatively complex but the best thing
about qspinlock is it tries to ensure each CPU spins on it's own location.

Instead of adding ticket spinlock now and later replacing it with qspinlock,
it is better to straight away explore qspinlock hence my NACK.

>
> Now, arguably arm64 did the heavy lifting of making qspinlock good on
> weak architectures, but if you want to do it right, you still have to
> analyze the whole thing for your own architecture.

Most of the RISC-V implementations are weak memory ordering so it
makes more sense to explore qspinlock first.

Regards,
Anup
