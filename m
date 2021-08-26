Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE473F8B34
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbhHZPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:38:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:41638 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242926AbhHZPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:38:12 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17QFUnw3025834;
        Thu, 26 Aug 2021 10:30:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17QFUmZn025833;
        Thu, 26 Aug 2021 10:30:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 26 Aug 2021 10:30:48 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
Message-ID: <20210826153048.GD1583@gate.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu> <1628834356.pr4zgn1xf1.astroid@bobo.none> <20210818150653.GJ1583@gate.crashing.org> <1629946707.f6ptz0tgle.astroid@bobo.none> <20210826124901.GY1583@gate.crashing.org> <1629983260.5jkx2jf0y8.astroid@bobo.none> <20210826143708.GC1583@gate.crashing.org> <1629989540.drlhb24t2w.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629989540.drlhb24t2w.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 01:04:36AM +1000, Nicholas Piggin wrote:
> Excerpts from Segher Boessenkool's message of August 27, 2021 12:37 am:
> >> No, they are all dispatched and issue to the BRU for execution. It's 
> >> trivial to construct a test of a lot of not taken branches in a row
> >> and time a loop of it to see it executes at 1 cycle per branch.
> > 
> > (s/dispatched/issued/)
> 
> ?

Dispatch is from decode to the issue queues.  Issue is from there to
execution units.  Dispatch is in-order, issue is not.

> >> How could it validate prediction without issuing? It wouldn't know when
> >> sources are ready.
> > 
> > In the backend.  But that is just how it worked on older cores :-/
> 
> Okay. I don't know about older cores than POWER9. Backend would normally 
> include execution though.
> Only other place you could do it if you don't
> issue/exec would be after it goes back in order, like completion.

You do not have to do the verification in-order: the insn cannot finish
until it is no longer speculative, that takes care of all ordering
needed.

> But that would be horrible for mispredict penalty.

See the previous point.  Also, any insn known to be mispredicted can be
flushed immediately anyway.

> >> >> The first problem seems like the show stopper though. AFAIKS it would 
> >> >> need a special builtin support that does something to create the table
> >> >> entry, or a guarantee that we could put an inline asm right after the
> >> >> builtin as a recognized pattern and that would give us the instruction
> >> >> following the trap.
> >> > 
> >> > I'm not quite sure what this means.  Can't you always just put a
> >> > 
> >> > bla:	asm("");
> >> > 
> >> > in there, and use the address of "bla"?
> >> 
> >> Not AFAIKS. Put it where?
> > 
> > After wherever you want to know the address after.  You will have to
> > make sure they stay together somehow.
> 
> I still don't follow.

some_thing_you_want_to_know_the_address_after_let_us_call_it_A;
empty_asm_that_we_can_take_the_address_of_known_as_B;

You have to make sure the compiler keeps A and B together, does not
insert anything between them, does put them in the assembler output in
the same fragment, etc.

> If you could give a built in that put a label at the address of the trap 
> instruction that could be used later by inline asm then that could work
> too:
> 
>     __builtin_labeled_trap("1:");
>     asm ("    .section __bug_table,\"aw\"  \n\t"
>          "2:  .4byte 1b - 2b               \n\t"
>          "    .previous");

How could a compiler do anything like that?!


Segher
