Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887FE32A6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837195AbhCBPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:54:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346256AbhCBNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:30:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614691784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16p5CIBV5FZqq7PD+aIlSBkHNAAFXoVuh32HeslQ/SQ=;
        b=gA5gYav2Hk333h8fF5E9qWN9lUs6VVCndPdoWWRkqMQUNVNqu7x8Lq8maaFNxgfWDx7pPH
        KQIRik8Udnjz0LplVgpDmOCsmr5EJalTn7APJpMw6ZjZg8luWm9/ZC43KHG7zQfXgvCUsK
        SHzk5LYrsAc7S2bjfeF0UsiES0uQkXk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7999DAAC5;
        Tue,  2 Mar 2021 13:29:44 +0000 (UTC)
Date:   Tue, 2 Mar 2021 14:29:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marco Elver <elver@google.com>, Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <YD49x/UGUq6MSE39@alley>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-02 13:51:35, Geert Uytterhoeven wrote:
> Hi Marco,
> 
> On Tue, Mar 2, 2021 at 1:45 PM Marco Elver <elver@google.com> wrote:
> > On Tue, 2 Mar 2021 at 12:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sun, Feb 14, 2021 at 5:17 PM Timur Tabi <timur@kernel.org> wrote:
> > > > If the no_hash_pointers command line parameter is set, then
> > > > printk("%p") will print pointers as unhashed, which is useful for
> > > > debugging purposes.  This change applies to any function that uses
> > > > vsprintf, such as print_hex_dump() and seq_buf_printf().
> > > >
> > > > A large warning message is displayed if this option is enabled.
> > > > Unhashed pointers expose kernel addresses, which can be a security
> > > > risk.
> > > >
> > > > --- a/lib/vsprintf.c
> > > > +++ b/lib/vsprintf.c
> > > > @@ -2090,6 +2090,32 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> > > >         return widen_string(buf, buf - buf_start, end, spec);
> > > >  }
> > > >
> > > > +/* Disable pointer hashing if requested */
> > > > +bool no_hash_pointers __ro_after_init;
> > > > +EXPORT_SYMBOL_GPL(no_hash_pointers);
> > > > +
> > > > +static int __init no_hash_pointers_enable(char *str)
> > > > +{
> > > > +       no_hash_pointers = true;
> > > > +
> > > > +       pr_warn("**********************************************************\n");
> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > > +       pr_warn("**                                                      **\n");
> > > > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > > +       pr_warn("** might reduce the security of your system.            **\n");
> > > > +       pr_warn("**                                                      **\n");
> > > > +       pr_warn("** If you see this message and you are not debugging    **\n");
> > > > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> > > > +       pr_warn("** administrator!                                       **\n");
> > > > +       pr_warn("**                                                      **\n");
> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > > +       pr_warn("**********************************************************\n");
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +early_param("no_hash_pointers", no_hash_pointers_enable);
> > >
> > > While bloat-o-meter is not smart enough to notice the real size impact,
> > > this does add more than 500 bytes of string data to the kernel.
> > > Do we really need such a large message?
> > > Perhaps the whole no_hash_pointers machinery should be protected by
> > > "#ifdef CONFIG_DEBUG_KERNEL"?

This was the deal. The configure option is a no-go, see below and also
https://lore.kernel.org/r/CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com


> > We recently stumbled across this, and it appears an increasing number
> > of production kernels enable CONFIG_DEBUG_KERNEL [1], so it likely
> > isn't the solution (we tried to use CONFIG_DEBUG_KERNEL in similar
> 
> I guess the people who do care about kernel size do know to disable
> CONFIG_DEBUG_KERNEL, so it would help them.
> The everything-but-the-kitchen-sink distro people don't care about kernel
> size anyway.

The problem with the configure option is not about size. The problem is
that there would be many kernels in the wild with this option enabled.
People would install them without knowing that they are less secure.

Distros would need to provide both kernels. Well, they already do.
But it might be worse. Some distros might even want to enable it
by default.

Also many bugs might be debugged without this option. Some bugs
are hard to reproduce and might be visible only on production
systems. It should be possible to enable this only when really
needed and the user must be aware of the risk.


> > Would placing the strings into an __initconst array help?
> 
> That would indeed help to reduce run-time memory consumption.

Sure. We could do this. Do you want to send a patch, please?

> It would not solve the raw kernel size increase.

I see. Well, the compression should be pretty efficient
for a text (with many spaces).

Best Regards,
Petr
