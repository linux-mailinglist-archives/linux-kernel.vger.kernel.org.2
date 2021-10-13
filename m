Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC142C222
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhJMOJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:09:44 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44234 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhJMOJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:09:42 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19DE7Ngc008526;
        Wed, 13 Oct 2021 16:07:23 +0200
Date:   Wed, 13 Oct 2021 16:07:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Michael Matz <matz@suse.de>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <20211013140723.GE5485@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbZz7gHBV18QJC3@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:06:23PM +0200, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 02:51:42PM +0200, Willy Tarreau wrote:
> > > > "Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
> > > > would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.
> > > 
> > > It is not about what happens in practice but what the contract is:
> > > syscall argument registers can potentially get clobbered and userspace
> > > should treat them as such. Because if the kernel decides to actually
> > > clobber them for whatever reason and some userspace thing thinks
> > > otherwise, then it is the userspace thing's problem as it doesn't adhere
> > > to the well known ABI.
> > 
> > I agree and that's why my question was about that authoritative doc, to
> > know the contract (since this one will not change under our feet). But
> > according to the doc you pointed, here the contract for syscalls is that
> > only rcx and r11 are clobbered (and rax gets the result). If so, I'm
> > personally fine with this.
> 
> Well, I guess that doc could probably state explicitly that argument
> registers are callee-clobbered.
> 
> The way I'm reading that doc is, as already pasted:
> 
> "The Linux AMD64 kernel uses internally the same calling conventions as
> user-level applications (see section 3.2.3 for details).
> 
> ...
> 
> The interface between the C library and the Linux kernel is the same as
> for the user-level applications with the following differences:
> 
> The kernel interface uses %rdi , %rsi , %rdx , %r10 , %r8 and %r9."
> 
> So, calling conventions in the kernel are the same as for user-level
> apps with the register difference. And argument registers are
> callee-clobbered.
> 
> Now, when you look at section 3.2.3 Parameter Passing and scroll to
> Figure 3.4: Register Usage, it'll give you the info that those argument
> registers are not callee-saved.
> 
> They appear to be but that's not in the contract. Which means that they
> can *potentially* get clobbered. The stress being on "potentially".

Yes I agree with the "potentially" here. If it can potentially be (i.e.
the kernel is allowed by contract to later change the way it's currently
done) then we have to save them even if it means lower code efficiency.

If, however, the kernel performs such savings on purpose because it is
willing to observe a stricter saving than the AMD64 ABI, we can follow
it but only once it's written down somewhere that it is by contract and
will not change.

> And just to make sure I'm reading this correctly, I've asked one of the
> authors of that document (CCed) and he confirmed what I'm stating above.

Thank you!

Willy
