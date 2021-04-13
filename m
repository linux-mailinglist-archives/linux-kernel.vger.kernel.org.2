Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE335D992
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhDMIEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbhDMIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:04:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E64C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EnKXc9MyKt8KwG88hNnmZM4WoYVgifTso8nPtyQrrDE=; b=G5uyAk07S3x0AChMVtkKUBLpqZ
        Gn7M6bRBRz8DPDFaR9H0C4ojHbPyb4HQRe11meEx+p2vL7vHh2xH8zC1cKDQXNzaiW1tCGh/MYZYh
        s/MN/De2KT9KSGigjH4qClaUn6BqwRiCpYs0axr0cypoiLVRoosI4oAaeR6IEDNIltHxSUGEjS+KD
        F+4jcsouimD3F5BbZikkxZ431vqboyiagJkjPV2OpuCinEDlRtaXiFvej9M5qCkuoKHl7Bi0zBAQM
        M6JKI57lou1HGBOSMjnueE/lMcs5y9cjH98fbSt7zypAnG6cr1XkMH/tSKnhmEi280+lfsLzWRGPj
        aPhz9owg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWE0k-008Ybv-LJ; Tue, 13 Apr 2021 08:03:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ACBB300036;
        Tue, 13 Apr 2021 10:03:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FF6D200CF8CA; Tue, 13 Apr 2021 10:03:01 +0200 (CEST)
Date:   Tue, 13 Apr 2021 10:03:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:54:55PM +0200, Christoph Müllner wrote:
> On Mon, Apr 12, 2021 at 7:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:

> > My plan is to add a generic ticket-based lock, which can be selected at
> > compile time.  It'll have no architecture dependencies (though it'll
> > likely have some hooks for architectures that can make this go faster).
> > Users can then just pick which spinlock flavor they want, with the idea
> > being that smaller systems will perform better with ticket locks and
> > larger systems will perform better with queued locks.  The main goal
> > here is to give the less widely used architectures an easy way to have
> > fair locks, as right now we've got a lot of code duplication because any
> > architecture that wants ticket locks has to do it themselves.
> 
> In the case of LL/SC sequences, we have a maximum of 16 instructions
> on RISC-V. My concern with a pure-C implementation would be that
> we cannot guarantee this (e.g. somebody wants to compile with -O0)
> and I don't know of a way to abort the build in case this limit exceeds.
> Therefore I have preferred inline assembly for OpenSBI (my initial idea
> was to use closure-like LL/SC macros, where you can write the loop
> in form of C code).

For ticket locks you really only needs atomic_fetch_add() and
smp_store_release() and an architectural guarantees that the
atomic_fetch_add() has fwd progress under contention and that a sub-word
store (through smp_store_release()) will fail the SC.

Then you can do something like:

void lock(atomic_t *lock)
{
	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
	u16 ticket = val >> 16;

	for (;;) {
		if (ticket == (u16)val)
			break;
		cpu_relax();
		val = atomic_read_acquire(lock);
	}
}

void unlock(atomic_t *lock)
{
	u16 *ptr = (u16 *)lock + (!!__BIG_ENDIAN__);
	u32 val = atomic_read(lock);

	smp_store_release(ptr, (u16)val + 1);
}

That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
on x86 for not being allowed to use a memop on unlock, since its being
forced into a load-store because of all the volatile, but whatever.
