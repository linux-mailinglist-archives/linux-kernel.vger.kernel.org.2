Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6F32A79C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839417AbhCBQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:17:50 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:41722 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351262AbhCBNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:50:53 -0500
Received: by mail-vk1-f169.google.com with SMTP id f145so4426971vka.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjtQVcWD3wSHfEn//+ELPjdggKwVE6jfHqnvJy9z+Qg=;
        b=efZsjMrUPwT96XI9ikaydRQ5i7YDyJmkIJbjY8wCSEOQUzHiU5RYY5kH8O2w/SOiEC
         /RdOSnJDkYX5s7WuUdb5GFI25bWOeZElNvjoVn0ZFOchnV8d1gXTIY754Rpi+PM2RdK4
         3D+iQEiz85bEzJ9gtuMARHE1jVOWZWB/AnmQ7VSgjkBpmniUgHmpObj2w+QdBW/dfqL+
         pnFR9CHkDOpzCYwC5sRBBgFeXwL33SXKfruR4RY9u2BBYzg9EvuDt0IlCShyYk2BgVqB
         8qN3rJV1F4dOXnvgSRW9Eb1AWfT9UM/zVihDX9bzddIC9fGFsWPtzeVKU3XNH4m3EBI+
         g9jA==
X-Gm-Message-State: AOAM533Ch1gGSB6jvw1YiG4ZmQNr/KG4vhIfw8wO5F9tPvJy2IeJFtOX
        VI3ycsnbmrPVITyPjVJ2SwfRKfGOeqlKoDH6MN0=
X-Google-Smtp-Source: ABdhPJwHpunKJq4nO3oEgcNyUYzRYz8R6MrmtIYSVevs4o7NBng5oPevyT83c7yb3V6qInomZEVlci21IgIeHS1tGDA=
X-Received: by 2002:ac5:ce04:: with SMTP id j4mr7793569vki.1.1614692993460;
 Tue, 02 Mar 2021 05:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
In-Reply-To: <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 14:49:42 +0100
Message-ID: <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Vlastimil Babka <vbabka@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>, Timur Tabi <timur@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil, Petr,

On Tue, Mar 2, 2021 at 2:37 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 3/2/21 2:29 PM, Petr Mladek wrote:
> > On Tue 2021-03-02 13:51:35, Geert Uytterhoeven wrote:
> >> > > > +
> >> > > > +       pr_warn("**********************************************************\n");
> >> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> >> > > > +       pr_warn("**                                                      **\n");
> >> > > > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> >> > > > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> >> > > > +       pr_warn("** might reduce the security of your system.            **\n");
> >> > > > +       pr_warn("**                                                      **\n");
> >> > > > +       pr_warn("** If you see this message and you are not debugging    **\n");
> >> > > > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> >> > > > +       pr_warn("** administrator!                                       **\n");
> >> > > > +       pr_warn("**                                                      **\n");
> >> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> >> > > > +       pr_warn("**********************************************************\n");
> >> > > > +
> >> > > > +       return 0;
> >> > > > +}
> >> > > > +early_param("no_hash_pointers", no_hash_pointers_enable);
> >> > >
> >> > > While bloat-o-meter is not smart enough to notice the real size impact,
> >> > > this does add more than 500 bytes of string data to the kernel.
> >> > > Do we really need such a large message?
> >> > > Perhaps the whole no_hash_pointers machinery should be protected by
> >> > > "#ifdef CONFIG_DEBUG_KERNEL"?
> >
> > This was the deal. The configure option is a no-go, see below and also
> > https://lore.kernel.org/r/CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com
>
> I think it's a no-go only when enabling such option equals to "no_hash_pointers"
> being always passed. What Geert suggests is that you need both
> CONFIG_DEBUG_KERNEL *and* no_hash_pointers and that's different.

Exactly.

> >> > We recently stumbled across this, and it appears an increasing number
> >> > of production kernels enable CONFIG_DEBUG_KERNEL [1], so it likely
> >> > isn't the solution (we tried to use CONFIG_DEBUG_KERNEL in similar
> >>
> >> I guess the people who do care about kernel size do know to disable
> >> CONFIG_DEBUG_KERNEL, so it would help them.
> >> The everything-but-the-kitchen-sink distro people don't care about kernel
> >> size anyway.
> >
> > The problem with the configure option is not about size. The problem is
> > that there would be many kernels in the wild with this option enabled.
> > People would install them without knowing that they are less secure.
>
> Same as above.
>
> > Distros would need to provide both kernels. Well, they already do.
> > But it might be worse. Some distros might even want to enable it
> > by default.
> >
> > Also many bugs might be debugged without this option. Some bugs
> > are hard to reproduce and might be visible only on production
> > systems. It should be possible to enable this only when really
> > needed and the user must be aware of the risk.
>
> So this is basically a kernel tinyfication issue, right? Is that still pursued
> today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?

As long as I hear about products running Linux on SoCs with 10 MiB of
SRAM, I think the answer is yes.
I'm not immediately aware of a better config option.  There are no more
TINY options left, and EXPERT selects DEBUG_KERNEL.

> >> > Would placing the strings into an __initconst array help?
> >>
> >> That would indeed help to reduce run-time memory consumption.
> >
> > Sure. We could do this. Do you want to send a patch, please?

Added to my list.

> >> It would not solve the raw kernel size increase.
> >
> > I see. Well, the compression should be pretty efficient
> > for a text (with many spaces).

My worry is not about the medium for storing the kernel image, but the
RAM where the kernel image is loaded.  The former is usually less
restricted in size, and easier to expand, than the latter,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
