Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9043C96B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhJ0MUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhJ0MU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:20:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A234C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0z5NDzCtlOwHHhgAD3ly37TdTgkGBv/4gSMBHNMsdKY=; b=q9Q8ekM+UaM+xr6OfbQ3V1wXrr
        modZ8Ej3QQc+Jk4aOob2UIx4RIYG40EUZKwOID49pYacuSnEpkempHjDuJrGB7D3rNFyZ1DcSJQ3X
        FoPV3LReAWmlkS71Q8GxIKgDTsUpHcXMIEAFS8h3cd7UUCUU7u9Mys40x9v3DVaZLV74Bbpc6TDdH
        qgOQSu7uFM2+MVLFczcLbfiAhH4GUxC7glAO7ORi338xrFnzjWiiOv3Koozc6AePu3fTSDfbALoIM
        CqPrWAKbiaZpoEL2+DogKfJloLnyyfNX8MCJIB1jE6pJvsHgSTh64e5rpaxtfGaqm1tWm5gqiDlH0
        adGZMw3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfhsL-00CYHg-K7; Wed, 27 Oct 2021 12:17:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BB39981FD2; Wed, 27 Oct 2021 14:17:48 +0200 (CEST)
Date:   Wed, 27 Oct 2021 14:17:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     paulmck@kernel.org, will@kernel.org, boqun.feng@gmail.com,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        elver@google.com, charalampos.mainas@gmail.com,
        pramod.bhatotia@in.tum.de
Subject: Re: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Message-ID: <20211027121747.GI174703@worktop.programming.kicks-ass.net>
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:19:48PM +0200, Paul Heidekrüger wrote:
> Hi all,
> 
> For my bachelor thesis, I have been working on the infamous problem of 
> potentially broken dependency orderings in the Linux kernel. I'm being 
> advised by Marco Elver, Charalampos Mainas, Pramod Bhatotia (Cc'd).

Nice! Great to see someone working on this!

> For context, see: 
> https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> 
> Our approach consists of two LLVM compiler passes which annotate 
> dependencies in unoptimised intermediate representation (IR) and verify 
> the annotated dependencies in optimised IR. ATM, the passes only 
> recognise a subset of address dependencies - everything is still WIP ;-)
> 
> We have been cross-compiling with a slightly modified version of 
> allyesconfig for arm64, and the passes have now found a case that we 
> would like to share with LKML for feedback: an address dependency being 
> broken (?) through compiler optimisations in 
> fs/afs/addr_list.c::afs_iterate_addresses().
> 
> Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:
> 
> > [...]
> >   index = READ_ONCE(ac->alist->preferred);
> >   if (test_bit(index, &set))
> >     goto selected;
> > [...]
> 
> where test_bit() expands to the following in 
> include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> 
> > static __always_inline int
> > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > {
> >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > }
> > #define test_bit arch_test_bit
> 
> The address dependency gets preserved in unoptimised IR since the virtual register %33 transitively depends on %28:
> 
> > %28 = load volatile i8, i8* %preferred, align 2, !annotation !15
> > store i8 %28, i8* %tmp21, align 1
> > %29 = load i8, i8* %tmp21, align 1
> > %conv23 = zext i8 %29 to i32
> > store i32 %conv23, i32* %index, align 4
> > %30 = load i32, i32* %index, align 4
> > store i32 %30, i32* %nr.addr.i, align 4
> > store i64* %set, i64** %addr.addr.i, align 8
> > %31 = load i64*, i64** %addr.addr.i, align 8
> > %32 = load i32, i32* %nr.addr.i, align 4
> > %div.i = udiv i32 %32, 64
> > %idxprom.i = zext i32 %div.i to i64
> > %arrayidx.i = getelementptr i64, i64* %31, i64 %idxprom.i
> > %33 = load volatile i64, i64* %arrayidx.i, align 8, !annotation !16
> 
> In optimised IR, there is no dependency between the two volatile loads 
> anymore:
> 
> > %11 = load volatile i8, i8* %preferred, align 2, !annotation !19
> > %conv25 = zext i8 %11 to i32
> > %set.0. = load volatile i64, i64* %set, align 8
> 
> Now, since @nr traces back to the READ_ONCE() to @index, does this make 
> the load from @addr in test_bit() address-dependent on that READ_ONCE()? 
> Should the load from @addr therefore be ordered against the READ_ONCE()?

I would personally not consider this a dependend load. The result
depends on two loads, but there is no actual ordering between them.

  r1 = *x
  r2 = *y
  b = 1 & (r1 >> r2);

(more or less)

A dependent load would be something where the address of the second load
depends on the value of the first load, eg:

  r1 = *x;
  r2 = *(y + r1);

typically derefencing or array accesses have this pattern. The canonical
example being rcu_dereference(), and is the reason Paul Mckenney is
arguing that pointers should carry dependecies; I'll let him refer to
the many C language papers on this.

Other examples, ones we're actually worried about the compiler breaking,
are, for example, the array access as found in __ktime_get_fast_ns():

	seq = READ_ONCE(tkf->seq);
	tkr = tkf->base + (seq & 1);
	now = tkr->...

Here the dependency is on an integer (seq), and worse, only a single bit
of it. If the compiler were this to transform into something like:

	seq = READ_ONCE(tkf->seq)
	if (seq & 1) {
		// use tkf->base[1]
	} else {
		// use tkf->base[0]
	}

Then it would be broken, since the condition doesn't order the two loads
and they can be re-ordered. Which in turn breaks the premise of the
seqcount_latch construct -- see the comment that goes with
raw_write_seqcount_latch() in seqlock.h.

hth,

~Peter

