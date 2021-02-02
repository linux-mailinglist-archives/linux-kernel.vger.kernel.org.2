Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D230CD0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhBBU1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:27:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:33561 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232545AbhBBUSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:18:10 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 112KAiAK011475;
        Tue, 2 Feb 2021 14:10:44 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 112KAhnm011470;
        Tue, 2 Feb 2021 14:10:43 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 2 Feb 2021 14:10:43 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@ACULAB.COM>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into syscall.c
Message-ID: <20210202201042.GB30983@gate.crashing.org>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu> <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu> <1611656343.yaxha7r2q4.astroid@bobo.none> <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com> <1611791083.sqnnh21vv0.astroid@bobo.none> <0cf90825-da89-6464-98d4-dc7490bff557@csgroup.eu> <1612247170.ea0f766ml4.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612247170.ea0f766ml4.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:38:31PM +1000, Nicholas Piggin wrote:
> > So to avoid confusion, I'll rename it. But I think "interrupt" is maybe not the right name. An 
> > interrupt most of the time refers to IRQ.
> 
> That depends what you mean by interrupt and IRQ.

In the PowerPC architecture, an exception is an abnormal condition, and
that can often cause an interrupt.  What Christophe colloquially calls
an "IRQ" here is called an external exception c.q. external interrupt.

> But if you say irq it's more likely to mean
> a device interrupt, and "interrupt" usually refres to the asynch
> ones.

Power talks about "instruction-caused interrupts", for one aspect of the
difference here; and "precise" / "imprecise" interrupts for another.

> So it's really fine to use the proper arch-specific names for things
> in arch code. I'm trying to slowly change names from exception to
> interrupt.

Thanks :-)

> > For me system call is not an interrupt in the way it 
> > doesn't unexpectedly interrupt a program flow. In powerpc manuals it is generally called exceptions, 
> > no I'm more inclined to call it exception.c
> 
> Actually that's backwards. Powerpc manuals (at least the one I look at) 
> calls them all interrupts including system calls, and also the system
> call interrupt is actually the only one that doesn't appear to be
> associated with an exception.

Yeah.  You could easily make such an exception, which is set when you
execute a system call instruction, and cleared when the interrupt is
taken, of course; but the architecture doesn't.

> And on the other hand you can deal with exceptions in some cases without
> taking an interrupt at all. For example if you had MSR[EE]=0 you could
> change the decrementer or execute msgclr or change HMER SPR etc to clear
> various exceptions without ever taking the interrupt.

A well-known example is the exception bits in the FPSCR, which do not
cause an interrupt unless the corresponding enable bits are also set.


Segher
