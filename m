Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5932AD68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384082AbhCBVwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:52:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:44578 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581456AbhCBS5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:57:12 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 122ImlkH002242;
        Tue, 2 Mar 2021 12:48:48 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 122Imko8002241;
        Tue, 2 Mar 2021 12:48:46 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 2 Mar 2021 12:48:46 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
Message-ID: <20210302184846.GI29191@gate.crashing.org>
References: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu> <CANpmjNPOJfL_qsSZYRbwMUrxnXxtF5L3k9hursZZ7k9H1jLEuA@mail.gmail.com> <b9dc8d35-a3b0-261a-b1a4-5f4d33406095@csgroup.eu> <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com> <f806de26-daf9-9317-fdaa-a0f7a32d8fe0@csgroup.eu> <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com> <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu> <87h7ltss18.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7ltss18.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:40:03PM +1100, Michael Ellerman wrote:
> >> -- Change the unwinder, if it's possible for ppc32.
> >
> > I don't think it is possible.
> 
> I think this actually is the solution.
> 
> It seems the good architectures have all added support for
> arch_stack_walk(), and we have not.

I have no idea what arch_stack_walk does, but some background info:

PowerPC functions that do save the LR (== the return address), and/or
that set up a new stack frame, do not do this at the start of the
function necessarily (it is a lot faster to postpone this, even if you
always have to do it).  So, in a leaf function it isn't always known if
this has been done (in all callers further up it is always done, of
course).  If you have DWARF unwind info all is fine of course, but you
do not have that in the kernel.

> So I think it's probably on us to update to that new API. Or at least
> update our save_stack_trace() to fabricate an entry using the NIP, as it
> seems that's what callers expect.

This sounds very expensive?  If it is only a debug feature that won't
be used in production that does not matter, but it worries me.


Segher

