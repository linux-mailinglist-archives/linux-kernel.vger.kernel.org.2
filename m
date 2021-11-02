Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18632443637
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKBTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:04:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58477 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229530AbhKBTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:04:14 -0400
Received: (qmail 1498121 invoked by uid 1000); 2 Nov 2021 15:01:38 -0400
Date:   Tue, 2 Nov 2021 15:01:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        elver@google.com, charalampos.mainas@gmail.com,
        pramod.bhatotia@in.tum.de
Subject: Re: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
Message-ID: <20211102190138.GA1497378@rowland.harvard.edu>
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
 <20211027142720.GB1319606@rowland.harvard.edu>
 <YXqZm6XTlMGDSpMT@Pauls-MacBook-Pro>
 <20211028143446.GA1351384@rowland.harvard.edu>
 <YYGFDUR5dJ784P88@Pauls-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYGFDUR5dJ784P88@Pauls-MacBook-Pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:35:57PM +0100, Paul Heidekrüger wrote:
> On Thu, Oct 28, 2021 at 10:34:46AM -0400, Alan Stern wrote:
> > On Thu, Oct 28, 2021 at 02:37:47PM +0200, Paul Heidekrüger wrote:
> > > On Wed, Oct 27, 2021 at 10:27:20AM -0400, Alan Stern wrote:
> > > > On Wed, Oct 27, 2021 at 12:19:48PM +0200, Paul Heidekrüger wrote:
> > 
> > > > > Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:
> > > > > 
> > > > > > [...]
> > > > > >   index = READ_ONCE(ac->alist->preferred);
> > > > > >   if (test_bit(index, &set))
> > > > > >     goto selected;
> > > > > > [...]
> > > > > 
> > > > > where test_bit() expands to the following in 
> > > > > include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> > > > > 
> > > > > > static __always_inline int
> > > > > > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > > > > > {
> > > > > >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > > > > > }
> > > > > > #define test_bit arch_test_bit
> > 
> > > > However, I can't follow the IR code.  Can you please explain in ordinary 
> > > > English how the LLVM compiler manages to lose track of this dependency?
> > > > 
> > > > Alan Stern
> > > 
> > > Here's what we think might be going on:
> > > - In 'arch_test_bit()', 'addr[BIT_WORD(nr)]' expands to 'addr[(nr) / 64]'.
> > > - Since 'addr' points to an 'unsigned long', any other result than '0' for
> > >   '(nr) / 64' would be out of bounds and therefore undefined.
> > > - We assume LLVM is able to figure this out and use it to get rid of the
> > >   address computation all together.
> > 
> > Ah, that explains it.  Yes, when set is a single unsigned long (or an 
> > array of length 1), the address dependency is only syntactic, not 
> > semantic.  As a result, we should expect that compilers will sometimes 
> > not preserve it.
> 
> In LKMM's explanation.txt, lines 450 - 453 state:
> 
> > A read event and another memory access event are linked by an address
> > dependency if the value obtained by the read affects the location
> > accessed by the other event.
> 
> If we understand correctly, the ambiguity you're pointing out is that by
> looking at 'addr[BIT_WORD(nr)]', one could deduce an address dependency by
> seeing an array subscript operator, using a value which can be traced back to a
> 'READ_ONCE()' (syntactic).

Exactly.  The syntax of the expression apparently indicates that the 
address to be dereferenced depends on the value of nr.

> However, since 'addr' points to an 'unsigned long', the 'READ_ONCE()' never
> affects the location accessed in 'arch_test_bit()' as the offset computed in
> the subscript operator can only be, as clang identified, '0' (semantic).

Again correct.  Although the address to be dereferenced may seem to 
depend on nr, in fact it doesn't because in any valid execution nr must 
not contain any value other than 0 (and the compiler knows this).

> > The danger, of course, is that people relying on an ordering prescribed
> > by the LKMM may get fooled because (unbeknownst to them) the dependency
> > in question is not semantic.
> 
> Do you think this would warrant a change to LKMM's explanation.txt to make this
> more explicit?

It wouldn't hurt.  Note that explanation.txt does already include a 
section talking about address dependencies from marked loads to plain 
reads (line 2260 et seq).  It also talks about the possibility of the 
compiler undermining the memory model in this regard (line 2308).

However, it doesn't mention the difference between syntactic and 
semantic dependencies.  If you would like to submit a patch adding an 
explicit description of this, please feel free to do so.

> > It would be great if a static checker
> > could detect such things -- but this would require some way for us to
> > inform the checker about when the code does rely on a dependency
> > ordering.
> 
> The compiler passes we're working on will hopefully be able to do exactly that,
> not taking into account the programmer's intent of course.

Good luck!

Alan
