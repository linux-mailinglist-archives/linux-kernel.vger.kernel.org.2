Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5C832ABCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839963AbhCBUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:44:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:43710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350028AbhCBRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:55:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614707591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWXPysMA7asYOTX40W9IplQ7R0vKyMtv6CPsbE1KGK8=;
        b=JVhDhE3iCr+hkgEZdFp7vvmSSDwEMxtMXF93Fvc6ZJYuytErPOT85FTpdjKYXQ6T7fcXnh
        SF3nCseXkJJlcSsTpZ0e02GEyWIIioog5ScNvJwmLXvH0Kn2vhBpGQl1CT9Q3jZCuqCrSo
        SGGLn8MZdWCeAbANr/afcSLqwlibeIE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23258AEA3;
        Tue,  2 Mar 2021 17:53:11 +0000 (UTC)
Date:   Tue, 2 Mar 2021 18:53:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
Message-ID: <YD57hjaSmsYapHnQ@alley>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley>
 <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-02 14:49:42, Geert Uytterhoeven wrote:
> Hi Vlastimil, Petr,
> 
> On Tue, Mar 2, 2021 at 2:37 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 3/2/21 2:29 PM, Petr Mladek wrote:
> > > On Tue 2021-03-02 13:51:35, Geert Uytterhoeven wrote:
> > >> > > > +
> > >> > > > +       pr_warn("**********************************************************\n");
> > >> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > >> > > > +       pr_warn("**                                                      **\n");
> > >> > > > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > >> > > > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > >> > > > +       pr_warn("** might reduce the security of your system.            **\n");
> > >> > > > +       pr_warn("**                                                      **\n");
> > >> > > > +       pr_warn("** If you see this message and you are not debugging    **\n");
> > >> > > > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> > >> > > > +       pr_warn("** administrator!                                       **\n");
> > >> > > > +       pr_warn("**                                                      **\n");
> > >> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > >> > > > +       pr_warn("**********************************************************\n");
> > >> > > > +
> > >> > > > +       return 0;
> > >> > > > +}
> > >> > > > +early_param("no_hash_pointers", no_hash_pointers_enable);
> > >> > >
> > >> > > While bloat-o-meter is not smart enough to notice the real size impact,
> > >> > > this does add more than 500 bytes of string data to the kernel.
> > >> > > Do we really need such a large message?
> > >> > > Perhaps the whole no_hash_pointers machinery should be protected by
> > >> > > "#ifdef CONFIG_DEBUG_KERNEL"?
> >
> > I think it's a no-go only when enabling such option equals to "no_hash_pointers"
> > being always passed. What Geert suggests is that you need both
> > CONFIG_DEBUG_KERNEL *and* no_hash_pointers and that's different.
> 
> Exactly.
> 
> > So this is basically a kernel tinyfication issue, right? Is that still pursued
> > today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?
> 
> As long as I hear about products running Linux on SoCs with 10 MiB of
> SRAM, I think the answer is yes.
> I'm not immediately aware of a better config option.  There are no more
> TINY options left, and EXPERT selects DEBUG_KERNEL.

DEBUG_KERNEL might actually makes sense. A possibility to see real
pointers might be pretty useful for the other debugging code.
It is a common thing.

DEBUG_KERNEL is even needed for many basics debugging helpers,
for example, for FRAME_POINTERS.

So, if it would be good for SoCs...


> > >> > Would placing the strings into an __initconst array help?
> > >>
> > >> That would indeed help to reduce run-time memory consumption.
> > >
> > > Sure. We could do this. Do you want to send a patch, please?
> 
> Added to my list.
> 
> > >> It would not solve the raw kernel size increase.
> > >
> > > I see. Well, the compression should be pretty efficient
> > > for a text (with many spaces).
> 
> My worry is not about the medium for storing the kernel image, but the
> RAM where the kernel image is loaded.  The former is usually less
> restricted in size, and easier to expand, than the latter,

Well, the __initconst might be enough then.

I personally do not have any preference whether to do __initconst
or DEBUG_KERNEL or both. We should just keep it simple and
do not over engineer it.

Best Regards,
Petr
