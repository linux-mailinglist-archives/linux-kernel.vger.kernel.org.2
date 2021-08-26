Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C63F8828
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhHZM40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:56:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:35383 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHZM4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:56:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17QCn2jm014844;
        Thu, 26 Aug 2021 07:49:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17QCn1dS014838;
        Thu, 26 Aug 2021 07:49:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 26 Aug 2021 07:49:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
Message-ID: <20210826124901.GY1583@gate.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu> <1628834356.pr4zgn1xf1.astroid@bobo.none> <20210818150653.GJ1583@gate.crashing.org> <1629946707.f6ptz0tgle.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629946707.f6ptz0tgle.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Aug 26, 2021 at 01:26:14PM +1000, Nicholas Piggin wrote:
> Excerpts from Segher Boessenkool's message of August 19, 2021 1:06 am:
> > On Fri, Aug 13, 2021 at 04:08:13PM +1000, Nicholas Piggin wrote:
> >> This one possibly the branches end up in predictors, whereas conditional 
> >> trap is always just speculated not to hit. Branches may also have a
> >> throughput limit on execution whereas trap could be more (1 per cycle
> >> vs 4 per cycle on POWER9).
> > 
> > I thought only *taken* branches are just one per cycle?
> 
> Taken branches are fetched by the front end at one per cycle (assuming 
> they hit the BTAC), but all branches have to be executed by BR at one 
> per cycle

This is not true.  (Simple) predicted not-taken conditional branches are
just folded out, never hit the issue queues.  And they are fetched as
many together as fit in a fetch group, can complete without limits as
well.

The BTAC is a frontend thing, used for target address prediction.  It
does not limit execution.

Correctly predicted simple conditional branches just get their prediction
validated (and that is not done in the execution units).  Incorrectly
predicted branches the same, but those cause a redirect and refetch.

> > Internally *all* traps are conditional, in GCC.  It also can optimise
> > them quite well.  There must be something in the kernel macros that
> > prevents good optimisation.
> 
> I did take a look at it at one point.
> 
> One problem is that the kernel needs the address of the trap instruction 
> to create the entry for it. The other problem is that __builtin_trap 
> does not return so it can't be used for WARN. LLVM at least seems to 
> have a __builtin_debugtrap which does return.

This is <https://gcc.gnu.org/PR99299>.

> The first problem seems like the show stopper though. AFAIKS it would 
> need a special builtin support that does something to create the table
> entry, or a guarantee that we could put an inline asm right after the
> builtin as a recognized pattern and that would give us the instruction
> following the trap.

I'm not quite sure what this means.  Can't you always just put a

bla:	asm("");

in there, and use the address of "bla"?  If not, you need to say a lot
more about what you actually want to do :-/


Segher
