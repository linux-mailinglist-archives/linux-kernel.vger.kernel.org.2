Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA83F5EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhHXNWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:22:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:54608 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237455AbhHXNWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:22:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17ODG1TV005019;
        Tue, 24 Aug 2021 08:16:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17ODG02l005018;
        Tue, 24 Aug 2021 08:16:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 Aug 2021 08:16:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs
Message-ID: <20210824131600.GF1583@gate.crashing.org>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu> <20210823184648.GY1583@gate.crashing.org> <9bbc9797-cfc7-1484-90ad-2146ff1a5e18@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bbc9797-cfc7-1484-90ad-2146ff1a5e18@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Aug 24, 2021 at 07:54:22AM +0200, Christophe Leroy wrote:
> Le 23/08/2021 à 20:46, Segher Boessenkool a écrit :
> >On Mon, Aug 23, 2021 at 03:29:12PM +0000, Christophe Leroy wrote:
> >>Instructions lmw/stmw are interesting for functions that are rarely
> >>used and not in the cache, because only one instruction is to be
> >>copied into the instruction cache instead of 19. However those
> >>instruction are less performant than 19x raw lwz/stw as they require
> >>synchronisation plus one additional cycle.
> >
> >lmw takes N+2 cycles for loading N words on 603/604/750/7400, and N+3 on
> >7450.  stmw takes N+1 cycles for storing N words on 603, N+2 on 604/750/
> >7400, and N+3 on 7450 (load latency is 3 instead of 2 on 7450).
> >
> >There is no synchronisation needed, although there is some serialisation,
> >which of course doesn't mean much since there can be only 6 or 8 or so
> >insns executing at once anyway.
> 
> Yes I meant serialisation, isn't it the same as synchronisation ?

Ha no, synchronisation are insns like sync and eieio :-)  Synchronisation
is architectural, serialisation is (mostly) not, it is a feature of the
specific core.

> >So, these insns are almost never slower, they can easily win cycles back
> >because of the smaller code, too.
> >
> >What 32-bit core do you see where load/store multiple are more than a
> >fraction of a cycle (per memory access) slower?
> >
> >>SAVE_NVGPRS / REST_NVGPRS are used in only a few places which are
> >>mostly in interrupts entries/exits and in task switch so they are
> >>likely already in the cache.
> >
> >Nothing is likely in the cache on the older cores (except in
> >microbenchmarks), the caches are not big enough for that!
> 
> Even syscall entries/exit pathes and/or most frequent interrupts entries 
> and interrupt exit ?

It has to be measured.  You are probably right for programs that use a
lot of system calls, and (unmeasurably :-) ) wrong for those that don't.

So that is a good argument: it speeds up some scenarios, and does not
make any real impact on anything else.

This also does not replace all {l,st}mw in the kernel, only those on
interrupt paths.  So it is not necessarily bad :-)

> >>Using standard lwz improves null_syscall selftest by:
> >>- 10 cycles on mpc832x.
> >>- 2 cycles on mpc8xx.
> >
> >And in real benchmarks?
> 
> Don't know, what benchmark should I use to evaluate syscall entry/exit if 
> 'null_syscall' selftest is not relevant ?

Some real workload (something that uses memory and computational insns a
lot, in addition to many syscalls).

> >On mpccore both lmw and stmw are only N+1 btw.  But the serialization
> >might cost another cycle here?
> 
> That coherent on MPC8xx, that's only 2 cycles.
> But on the mpc832x which has a e300c2 core, it looks like I have 10 cycles 
> difference. Is anything wrong ?

I don't know that core very well, I'll have a look.


Segher
