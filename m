Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD134383D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJWNql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:46:41 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44472 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhJWNqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:46:40 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19NDhNMg005918;
        Sat, 23 Oct 2021 15:43:23 +0200
Date:   Sat, 23 Oct 2021 15:43:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Message-ID: <20211023134323.GA5881@1wt.eu>
References: <20211023090246.GA4323@1wt.eu>
 <20211018045828.GA15329@1wt.eu>
 <O2kEogG8Ln8uUQ-ammarfaizi2@gnuweeb.org>
 <v9gnbpcz7rxYUfmUijR-ammarfaizi2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v9gnbpcz7rxYUfmUijR-ammarfaizi2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 08:27:15PM +0700, Ammar Faizi wrote:
> Sorry for the delay, I got extra activities this week. Sorry for not
> giving any update lately.

No, really, don't be sorry, I'm myself quite busy, so I understnad, I
was just inquiring to arrange my time, nothing more.

>   1) I can send the %rsp alignment fix patch. I will send it today or
>      tomorrow (GMT+07 time).

OK, no rush anyway. Even early next week is okay for me.

>   2) I can't send the syscall change used for exit. Because I only
>      have x86 machine. So I can't apply the changes to other arch(s).

I see. I can do it for the various archs then, as the ones that are
supported are essentially the ones I can test.

> For (2), basically sys_exit doesn't close the entire process. Instead
> it only closes specific thread that calls that syscall. The libc uses
> sys_exit_group to close the process and its threads.
> 
> ^ It's not really an urgent thing, because the nolibc.h may not be
> used for multithreaded app. Even so, I don't see something dangerous.

Yep that's what I understood as well, so we may easily postpone this.

> For (1), it's urgent, because the alignment violation causes segfault
> if the compiler generates aligned move, often when we compile it
> with -O3, usually that happens with SSE instructions, like `movdqa`,
> `movaps`.

Yes, that's what I saw from the other reports, I didn't notice it myself
but I probably faced it and attributed it to anything else.

> Preparing the patch...

Great, thank you!
Willy
