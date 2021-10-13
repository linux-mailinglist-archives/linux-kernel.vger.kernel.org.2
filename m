Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8342C309
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhJMO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:26:49 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44247 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237322AbhJMO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:26:46 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19DEOXi9008637;
        Wed, 13 Oct 2021 16:24:33 +0200
Date:   Wed, 13 Oct 2021 16:24:33 +0200
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
Message-ID: <20211013142433.GB8557@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
 <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbrR1BqI1CxneN/@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:20:55PM +0200, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 04:07:23PM +0200, Willy Tarreau wrote:
> > Yes I agree with the "potentially" here. If it can potentially be (i.e.
> > the kernel is allowed by contract to later change the way it's currently
> > done) then we have to save them even if it means lower code efficiency.
> >
> > If, however, the kernel performs such savings on purpose because it is
> > willing to observe a stricter saving than the AMD64 ABI, we can follow
> > it but only once it's written down somewhere that it is by contract and
> > will not change.
> 
> Right, and Micha noted that such a change to the document can be done.

great.

> And we're basically doing that registers restoring anyway, in POP_REGS.

That's what I based my analysis on when I wanted to verify Ammar's
finding. I would tend to think that if we're burning cycles popping
plenty of registers it's probably for a reason, maybe at least a good
one, which is that it's the only way to make sure we're not leaking
internal kernel data! This is not a concern for kernel->kernel nor
user->user calls but for user->kernel calls it definitely is one, and
I don't think we could relax that series of pop without causing leaks
anyway.

Willy
