Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5832A683
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574284AbhCBPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:14:54 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40979 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447342AbhCBMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:52:29 -0500
Received: by mail-vs1-f54.google.com with SMTP id b6so10511672vsf.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 04:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oC/5xTWIunPgjaWCLEZDHZBr0HOKs+Yshteow6l6/r8=;
        b=EDjcE0qqiR6/ckuCXWeS+wG7thLIbAe8znDtrmlG7K3pIcW3a31WbQBLq/7bGKXQCE
         0Zao1UO3k5QXMnUXk4XWrtz6Tk97jJ6IMYMmqNLwkjC0YsihllmWbSgSxJHkQwZ8W6CB
         a+Ir9VJbqPEM3qIX2Z9x1h5HZYKKdyQ6sXVQVoKmvDR+iL+SAC3Hk1WdcihWLMwRIm8s
         89Ae+VTEZOTEUfk95VIFpQuxiSEBw4G0+GnqctuLlVTkhb9EC5cf7m4nsV6g5Q7N2g6S
         hEijHKE3JREP73+rAOYD9iaCZV23cZ1qUr2389kOoexe3grFMLibsl5Alo5uwgHJrARt
         YTCg==
X-Gm-Message-State: AOAM531CQ2AfH60lpVMMSgCX+eRHdY7KCUb23qWAoETgSvsiniH85+Q2
        g36u+MQTLOl5xpNhC7GHCuKEa7ttSkQs1HHD+uI=
X-Google-Smtp-Source: ABdhPJzpQW7TCnVlmNlBcbJmT2ctH6s1bOOJBOKoXjL3xfDuiJFQszwvTieY3jOxnWM/QDiZFrduzJhWC3/j/Ecp3IQ=
X-Received: by 2002:a05:6102:2403:: with SMTP id j3mr1730433vsi.40.1614689506514;
 Tue, 02 Mar 2021 04:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com> <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
In-Reply-To: <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 13:51:35 +0100
Message-ID: <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Marco Elver <elver@google.com>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Mar 2, 2021 at 1:45 PM Marco Elver <elver@google.com> wrote:
> On Tue, 2 Mar 2021 at 12:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, Feb 14, 2021 at 5:17 PM Timur Tabi <timur@kernel.org> wrote:
> > > If the no_hash_pointers command line parameter is set, then
> > > printk("%p") will print pointers as unhashed, which is useful for
> > > debugging purposes.  This change applies to any function that uses
> > > vsprintf, such as print_hex_dump() and seq_buf_printf().
> > >
> > > A large warning message is displayed if this option is enabled.
> > > Unhashed pointers expose kernel addresses, which can be a security
> > > risk.
> > >
> > > Also update test_printf to skip the hashed pointer tests if the
> > > command-line option is set.
> > >
> > > Signed-off-by: Timur Tabi <timur@kernel.org>
> >
> > Thanks for your patch, which is now commit 5ead723a20e0447b
> > ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed") in
> > v5.12-rc1.
> >
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -2090,6 +2090,32 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> > >         return widen_string(buf, buf - buf_start, end, spec);
> > >  }
> > >
> > > +/* Disable pointer hashing if requested */
> > > +bool no_hash_pointers __ro_after_init;
> > > +EXPORT_SYMBOL_GPL(no_hash_pointers);
> > > +
> > > +static int __init no_hash_pointers_enable(char *str)
> > > +{
> > > +       no_hash_pointers = true;
> > > +
> > > +       pr_warn("**********************************************************\n");
> > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > +       pr_warn("**                                                      **\n");
> > > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > +       pr_warn("** might reduce the security of your system.            **\n");
> > > +       pr_warn("**                                                      **\n");
> > > +       pr_warn("** If you see this message and you are not debugging    **\n");
> > > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> > > +       pr_warn("** administrator!                                       **\n");
> > > +       pr_warn("**                                                      **\n");
> > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > +       pr_warn("**********************************************************\n");
> > > +
> > > +       return 0;
> > > +}
> > > +early_param("no_hash_pointers", no_hash_pointers_enable);
> >
> > While bloat-o-meter is not smart enough to notice the real size impact,
> > this does add more than 500 bytes of string data to the kernel.
> > Do we really need such a large message?
> > Perhaps the whole no_hash_pointers machinery should be protected by
> > "#ifdef CONFIG_DEBUG_KERNEL"?
>
> We recently stumbled across this, and it appears an increasing number
> of production kernels enable CONFIG_DEBUG_KERNEL [1], so it likely
> isn't the solution (we tried to use CONFIG_DEBUG_KERNEL in similar

I guess the people who do care about kernel size do know to disable
CONFIG_DEBUG_KERNEL, so it would help them.
The everything-but-the-kitchen-sink distro people don't care about kernel
size anyway.

> way, and it wasn't reliable). Having no_hash_pointers frees us of
> having to rely on CONFIG_DEBUG_KERNEL. (Perhaps somebody else will
> comment, but I believe there were strong objections to making the
> pointer hashing dependent on more Kconfig options.)
>
> [1] https://lkml.kernel.org/r/20210223082043.1972742-1-elver@google.com
>
> Would placing the strings into an __initconst array help?

That would indeed help to reduce run-time memory consumption.
It would not solve the raw kernel size increase.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
