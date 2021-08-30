Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341CE3FBE59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhH3VcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:32:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45546 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbhH3VcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:32:09 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKorr-00HP00-D9; Mon, 30 Aug 2021 21:30:59 +0000
Date:   Mon, 30 Aug 2021 21:30:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 02:26:12PM -0700, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 2:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Incidentally, why do we bother with negation in those?  Why not have
> > user_insn(), XSTATE_OP() and kernel_insn_err() return 0 or trap number...
> 
> I really wish we didn't have that odd _ASM_EXTABLE_FAULT/
> ex_handler_fault() special case at all.
> 
> It's *very* confusing, and it actually seems to be mis-used. It looks
> like the "copy_mc_fragile" code uses it by mistake, and doesn't
> actually want that "modify %%rax" behavior of that exception handler
> AT ALL.
> 
> If I read that code correctly, it almost by mistake doesn't actually
> care, and will overwrite %%rax with the right result, but it doesn't
> look like the "fault code in %eax" was ever *intentional*. There's no
> mention of it.
> 
> Maybe I'm misreading that code, but I look at it and just go "Whaa?"
> 
> The code in user_insn() clearly *does* use that fault number (and, as
> you say, inverts it for some reason), but I wonder how much it really
> cares? Could we get rid of it, and just set a fixed error code?
> 
> I only checked one user, but that one didn't actually care which fault
> it was, it only cared about fault-vs-no-fault.

There's a place where we care about #PF vs. #MC (see upthread)...
