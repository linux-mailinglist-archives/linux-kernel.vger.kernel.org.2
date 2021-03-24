Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3270347888
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhCXMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCXMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:32:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D6C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ffc7nYszRPIxKliihnC5n90uCSWD4QXn2lTh95xNgA=; b=Qxr93f8l7eWrgFSC9F99sXFzXQ
        lC0604zmLZikerou9UaWz9R67NWKWhURTC2ORD5Oq9YMMwSvVYQJm5d5NuR8+/bMdULyw5eLEkslF
        M5LP/RLoRrBPX6G94aoG6mKJlqUGgdBoi/OiRJfm7GXhofAVBxZe+F/C2qwS5vPnjHgmW+lHp2HtP
        umiGhP4zSz9ZS9nXRp0PCmhcOjEl/pVh7dFfJS4EzZnrsBcucvxKcqaTIFISe20vBYrCXRMSTA/bj
        CqVMXS9uBeC9caiYK9zcL2TIrfMIYiBcaDsRlPSCyi5iKJ0j0AR4smCRkKfBkt5qlB85Nk/hWnscI
        AZMYQylg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP2fS-00BKqV-6p; Wed, 24 Mar 2021 12:31:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E60330377D;
        Wed, 24 Mar 2021 13:31:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44F6D2BF5B73E; Wed, 24 Mar 2021 13:31:21 +0100 (CET)
Date:   Wed, 24 Mar 2021 13:31:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YFsxGZ6RJilO6OUl@hirez.programming.kicks-ass.net>
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
 <CAM4kBBK7_s9U2vJbq68yC8WdDEfPQTaCOvn1xds3Si5B-Wpw+A@mail.gmail.com>
 <CAJF2gTSmrZ4iVnoHJ8w5U8ZxxeN=9r5iu9m37ZLNGPp0Q+6wMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSmrZ4iVnoHJ8w5U8ZxxeN=9r5iu9m37ZLNGPp0Q+6wMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:24:34PM +0800, Guo Ren wrote:
> On Wed, Mar 24, 2021 at 7:16 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> >
> >
> > On Wed, Mar 24, 2021, 11:16 AM <guoren@kernel.org> wrote:
> >>
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> This patch introduces a ticket lock implementation for riscv, along the
> >> same lines as the implementation for arch/arm & arch/csky.
> >
> >
> > Could you please provide a rationale for this? Like, what is wrong with the current implementation.
> Ticket based spinlock's principle is here:
> https://lwn.net/Articles/267968/
> 
> Current implementation will cause cache line bouncing when many harts
> are acquiring the same spinlock.
> I'm seeking a solution, maybe not fitting the current RISC-V base ISA.

Ticket locks as such don't solve the cacheline bouncing part, since
they're all still spinning on the same line. The big improvement ticket
locks bring is that the lock acquisition time becomes a function of the
longest hold time, instead of being unbounded.

However, combine it with the WFE (preferably the ARM64 variant) and you
can avoid the worst of the bouncing.

If you really want to get rid of the bouncing, go with qspinlock, which
will spin on a cpu local line. That said, qspinlock is quite gnarly
code, and only really wins from ticket when you have NUMA.
