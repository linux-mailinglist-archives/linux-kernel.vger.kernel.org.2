Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0463478B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhCXMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhCXMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:39:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C282C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RrFr490dFRvD+R99oCaLdve7Nm3IkFIKrRyx/bsnPjw=; b=pCjx6OdE08VvbOSiDs5kXJYRfY
        lb6q5yV7oK21uCsJurgbts409+Y33BBPfIzSDl0cPL44qmR68W42PFq2xBQ0qGwVBugETmOVyaeot
        w1eswJnqfkAWVwstGiKCTAVFlNDVrkleJvnT+XxAU5SsNRpEGhEzIIQ7A4599wb8UzDRMpkgdU1IG
        AvWhv6UX1oD5IfuJZcBJk8R6ygN/zKr6YrqUgE+Uulzlozczzma83KFb7/s7Vi/mO81BfGLItSqux
        DI9uia8RCVxcbJr4sI09MAhA8ZTK1v/saDTRqlhCiK/sSHYl67RXk3MXvixORZZXJ+bQBVH1AedNa
        67chedKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP2lY-00BLAE-Vp; Wed, 24 Mar 2021 12:37:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60B6B301A7A;
        Wed, 24 Mar 2021 13:37:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4473E2BF5B73E; Wed, 24 Mar 2021 13:37:40 +0100 (CET)
Date:   Wed, 24 Mar 2021 13:37:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YFsylL7cJqVtVqBI@hirez.programming.kicks-ass.net>
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
 <CAAhSdy2FPHX7Mhg5bRUOTk8SAw+jfWxhKquGZpC6YD0MPLSu0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2FPHX7Mhg5bRUOTk8SAw+jfWxhKquGZpC6YD0MPLSu0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:58:58PM +0530, Anup Patel wrote:
> On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch introduces a ticket lock implementation for riscv, along the
> > same lines as the implementation for arch/arm & arch/csky.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/riscv/Kconfig                      |   1 +
> >  arch/riscv/include/asm/Kbuild           |   1 +
> >  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
> >  arch/riscv/include/asm/spinlock_types.h |  19 ++--
> 
> NACK from myside.
> 
> Linux ARM64 has moved away from ticket spinlock to qspinlock.
> 
> We should directly go for qspinlock.

I think it is a sensible intermediate step, even if you want to go
qspinlock. Ticket locks are more or less trivial and get you fairness
and all that goodness without the mind bending complexity of qspinlock.

Once you have the ticket lock implementation solid (and qrwlock) and
everything, *then* start to carefully look at qspinlock.

Now, arguably arm64 did the heavy lifting of making qspinlock good on
weak architectures, but if you want to do it right, you still have to
analyze the whole thing for your own architecture.

