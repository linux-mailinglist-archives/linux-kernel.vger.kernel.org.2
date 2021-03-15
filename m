Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B033CA40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhCPAEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 20:04:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:54045 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhCPAEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 20:04:23 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12FNxmMm004591;
        Mon, 15 Mar 2021 18:59:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12FNxlbU004590;
        Mon, 15 Mar 2021 18:59:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 15 Mar 2021 18:59:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Rasmus Villemoes'" <rasmus.villemoes@prevas.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
Message-ID: <20210315235947.GD16691@gate.crashing.org>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu> <20210312022940.GO29191@gate.crashing.org> <023afd0c-dc61-5891-5145-5bcdce8227be@prevas.dk> <14e2cfb8c3f141aaba8fe0fb2d8f1885@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e2cfb8c3f141aaba8fe0fb2d8f1885@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:38:52PM +0000, David Laight wrote:
> From: Rasmus Villemoes
> > Sent: 15 March 2021 16:24
> > On 12/03/2021 03.29, Segher Boessenkool wrote:
> > > On Tue, Mar 09, 2021 at 06:19:30AM +0000, Christophe Leroy wrote:
> > >> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> > >> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> > >> generates a call to _restgpr_31_x.
> > >
> > >> I don't know if there is a way to tell GCC not to emit that call, because at the end we get more
> > instructions than needed.
> > >
> > > The function is required by the ABI, you need to have it.
> > >
> > > You get *fewer* insns statically, and that is what -Os is about: reduce
> > > the size of the binaries.
> > 
> > Is there any reason to not just always build the vdso with -O2? It's one
> > page/one VMA either way, and the vdso is about making certain system
> > calls cheaper, so if unconditional -O2 could save a few cycles compared
> > to -Os, why not? (And if, as it seems, there's only one user within the
> > DSO of _restgpr_31_x, yes, the overall size of the .text segment
> > probably increases slightly).
> 
> Sometimes -Os generates such horrid code you really never want to use it.
> A classic is on x86 where it replaces 'load register with byte constant'
> with 'push byte' 'pop register'.
> The code is actually smaller but the execution time is horrid.
> 
> There are also cases where -O2 actually generates smaller code.

Yes, as with all heuristics it doesn't always work out.  But usually -Os
is smaller.

> Although you may need to disable loop unrolling (often dubious at best)
> and either force or disable some function inlining.

The cases where GCC does loop unrolling at -O2 always help quite a lot.
Or, do you have a counter-example?  We'd love to see one.

And yup, inlining is hard.  GCC's heuristics there are very good
nowadays, but any single decision has big effects.  Doing the important
spots manually (always_inline or noinline) has good payoff.


Segher
