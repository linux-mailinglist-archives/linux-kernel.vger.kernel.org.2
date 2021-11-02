Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECD4435AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhKBSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:38:38 -0400
Received: from mail-out2.in.tum.de ([131.159.0.36]:48714 "EHLO
        mail-out2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhKBSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:38:37 -0400
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mail-out2.informatik.tu-muenchen.de (Postfix) with ESMTP id 69C4A2400D6;
        Tue,  2 Nov 2021 19:36:00 +0100 (CET)
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 6736C466; Tue,  2 Nov 2021 19:36:00 +0100 (CET)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 460C645A;
        Tue,  2 Nov 2021 19:36:00 +0100 (CET)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 43455451;
        Tue,  2 Nov 2021 19:36:00 +0100 (CET)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 4067A4A0620; Tue,  2 Nov 2021 19:36:00 +0100 (CET)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id ADD754A0115;
        Tue,  2 Nov 2021 19:35:59 +0100 (CET)
        (Extended-Queue-bit tech_cgasm@fff.in.tum.de)
Date:   Tue, 2 Nov 2021 19:35:57 +0100
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        elver@google.com, charalampos.mainas@gmail.com,
        pramod.bhatotia@in.tum.de
Subject: Re: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Message-ID: <YYGFDUR5dJ784P88@Pauls-MacBook-Pro>
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
 <20211027142720.GB1319606@rowland.harvard.edu>
 <YXqZm6XTlMGDSpMT@Pauls-MacBook-Pro>
 <20211028143446.GA1351384@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028143446.GA1351384@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:34:46AM -0400, Alan Stern wrote:
> On Thu, Oct 28, 2021 at 02:37:47PM +0200, Paul Heidekrüger wrote:
> > On Wed, Oct 27, 2021 at 10:27:20AM -0400, Alan Stern wrote:
> > > On Wed, Oct 27, 2021 at 12:19:48PM +0200, Paul Heidekrüger wrote:
> 
> > > > Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:
> > > > 
> > > > > [...]
> > > > >   index = READ_ONCE(ac->alist->preferred);
> > > > >   if (test_bit(index, &set))
> > > > >     goto selected;
> > > > > [...]
> > > > 
> > > > where test_bit() expands to the following in 
> > > > include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> > > > 
> > > > > static __always_inline int
> > > > > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > > > > {
> > > > >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > > > > }
> > > > > #define test_bit arch_test_bit
> 
> > > However, I can't follow the IR code.  Can you please explain in ordinary 
> > > English how the LLVM compiler manages to lose track of this dependency?
> > > 
> > > Alan Stern
> > 
> > Here's what we think might be going on:
> > - In 'arch_test_bit()', 'addr[BIT_WORD(nr)]' expands to 'addr[(nr) / 64]'.
> > - Since 'addr' points to an 'unsigned long', any other result than '0' for
> >   '(nr) / 64' would be out of bounds and therefore undefined.
> > - We assume LLVM is able to figure this out and use it to get rid of the
> >   address computation all together.
> 
> Ah, that explains it.  Yes, when set is a single unsigned long (or an 
> array of length 1), the address dependency is only syntactic, not 
> semantic.  As a result, we should expect that compilers will sometimes 
> not preserve it.

In LKMM's explanation.txt, lines 450 - 453 state:

> A read event and another memory access event are linked by an address
> dependency if the value obtained by the read affects the location
> accessed by the other event.

If we understand correctly, the ambiguity you're pointing out is that by
looking at 'addr[BIT_WORD(nr)]', one could deduce an address dependency by
seeing an array subscript operator, using a value which can be traced back to a
'READ_ONCE()' (syntactic).

However, since 'addr' points to an 'unsigned long', the 'READ_ONCE()' never
affects the location accessed in 'arch_test_bit()' as the offset computed in
the subscript operator can only be, as clang identified, '0' (semantic).

> The danger, of course, is that people relying on an ordering prescribed
> by the LKMM may get fooled because (unbeknownst to them) the dependency
> in question is not semantic.

Do you think this would warrant a change to LKMM's explanation.txt to make this
more explicit?

> It would be great if a static checker
> could detect such things -- but this would require some way for us to
> inform the checker about when the code does rely on a dependency
> ordering.

The compiler passes we're working on will hopefully be able to do exactly that,
not taking into account the programmer's intent of course.

Many thanks,
Paul
