Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E570043E110
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ1MkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:40:20 -0400
Received: from mail-out1.in.tum.de ([131.159.0.8]:42751 "EHLO
        mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhJ1MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:40:19 -0400
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mail-out1.informatik.tu-muenchen.de (Postfix) with ESMTP id D290F2400D4;
        Thu, 28 Oct 2021 14:37:50 +0200 (CEST)
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id CA53416F; Thu, 28 Oct 2021 14:37:50 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 86AA6C3;
        Thu, 28 Oct 2021 14:37:50 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 7F860B7;
        Thu, 28 Oct 2021 14:37:50 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 795CB4A0531; Thu, 28 Oct 2021 14:37:50 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 9FFDA4A006E;
        Thu, 28 Oct 2021 14:37:49 +0200 (CEST)
        (Extended-Queue-bit tech_joqtw@fff.in.tum.de)
Date:   Thu, 28 Oct 2021 14:37:47 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        elver@google.com, charalampos.mainas@gmail.com,
        pramod.bhatotia@in.tum.de
Subject: Re: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Message-ID: <YXqZm6XTlMGDSpMT@Pauls-MacBook-Pro>
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
 <20211027142720.GB1319606@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027142720.GB1319606@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:27:20AM -0400, Alan Stern wrote:
> On Wed, Oct 27, 2021 at 12:19:48PM +0200, Paul Heidekrüger wrote:
> > Hi all,
> > 
> > For my bachelor thesis, I have been working on the infamous problem of 
> > potentially broken dependency orderings in the Linux kernel. I'm being 
> > advised by Marco Elver, Charalampos Mainas, Pramod Bhatotia (Cc'd).
> > 
> > For context, see: 
> > https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > 
> > Our approach consists of two LLVM compiler passes which annotate 
> > dependencies in unoptimised intermediate representation (IR) and verify 
> > the annotated dependencies in optimised IR. ATM, the passes only 
> > recognise a subset of address dependencies - everything is still WIP ;-)
> > 
> > We have been cross-compiling with a slightly modified version of 
> > allyesconfig for arm64, and the passes have now found a case that we 
> > would like to share with LKML for feedback: an address dependency being 
> > broken (?) through compiler optimisations in 
> > fs/afs/addr_list.c::afs_iterate_addresses().
> > 
> > Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:
> > 
> > > [...]
> > >   index = READ_ONCE(ac->alist->preferred);
> > >   if (test_bit(index, &set))
> > >     goto selected;
> > > [...]
> > 
> > where test_bit() expands to the following in 
> > include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> > 
> > > static __always_inline int
> > > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > > {
> > >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > > }
> > > #define test_bit arch_test_bit
> > 
> > The address dependency gets preserved in unoptimised IR since the virtual register %33 transitively depends on %28:
> > 
> > > %28 = load volatile i8, i8* %preferred, align 2, !annotation !15
> > > store i8 %28, i8* %tmp21, align 1
> > > %29 = load i8, i8* %tmp21, align 1
> > > %conv23 = zext i8 %29 to i32
> > > store i32 %conv23, i32* %index, align 4
> > > %30 = load i32, i32* %index, align 4
> > > store i32 %30, i32* %nr.addr.i, align 4
> > > store i64* %set, i64** %addr.addr.i, align 8
> > > %31 = load i64*, i64** %addr.addr.i, align 8
> > > %32 = load i32, i32* %nr.addr.i, align 4
> > > %div.i = udiv i32 %32, 64
> > > %idxprom.i = zext i32 %div.i to i64
> > > %arrayidx.i = getelementptr i64, i64* %31, i64 %idxprom.i
> > > %33 = load volatile i64, i64* %arrayidx.i, align 8, !annotation !16
> > 
> > In optimised IR, there is no dependency between the two volatile loads 
> > anymore:
> > 
> > > %11 = load volatile i8, i8* %preferred, align 2, !annotation !19
> > > %conv25 = zext i8 %11 to i32
> > > %set.0. = load volatile i64, i64* %set, align 8
> > 
> > Now, since @nr traces back to the READ_ONCE() to @index, does this make 
> > the load from @addr in test_bit() address-dependent on that READ_ONCE()? 
> > Should the load from @addr therefore be ordered against the READ_ONCE()?
> 
> As others have pointed out, there really is an address dependency here 
> (although it's not a very useful one and the code doesn't rely on it).
> 
> However, I can't follow the IR code.  Can you please explain in ordinary 
> English how the LLVM compiler manages to lose track of this dependency?
> 
> Alan Stern

Here's what we think might be going on:
- In 'arch_test_bit()', 'addr[BIT_WORD(nr)]' expands to 'addr[(nr) / 64]'.
- Since 'addr' points to an 'unsigned long', any other result than '0' for
  '(nr) / 64' would be out of bounds and therefore undefined.
- We assume LLVM is able to figure this out and use it to get rid of the
  address computation all together.

We ran some experiments to see how optimisations behave when 'set' is in fact
an array and / or in global scope.

1. Insert a 'barrier()' in 'arch_test_bit()' before the 'return':
The dependency gets broken.

2. Make 'set' an 'unsigned long' array of size '42', keep local scope: 
The dependency gets preserved.

3. Keep 'set' as 'unsigend long', move to global scope: 
The dependency gets preserved.

4. Make 'set' an 'unsigned long' array of size '42', move to global scope: 
The dependency gets preserved.

Many thanks,
Paul
