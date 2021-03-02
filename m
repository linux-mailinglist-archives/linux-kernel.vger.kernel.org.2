Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4532A86E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbhCBRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:37:10 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:45211 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384553AbhCBPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:20 -0500
Received: by mail-pl1-f170.google.com with SMTP id u18so5997704plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3D/HygHM2s+B6WKXxJW0gcme/YrKFpE/BZDVmFOXmQ=;
        b=NiZarwH5IpCJp+U+uWnqs9OOtUZEO6+M7apZvEUXLpwW1SdAaVFvnbHOR0QJt719fH
         YKyirTUkBtFiVdYiOFs6s43VUvvmL+EgrIvpaporMICV+0NYQVZzptSZYHVKgD7hLUQL
         HFFbC9shBTUkMzPhatTu6OIAQefRDSZouWN6zoHbPdOENPl6rdk5HWl+kL4F2+ERpqKB
         +ydDM5bxT6l454rglntcKIbHKdvlX04T2usbFskhyWFrxI3TapDdrnXNc3RDbt5+y93+
         X4Nwhg1w0XcvfwkaKtQrt//lbTc0DigUIh7nnCBmH/ofJhd3c0uLXzqgXVlyrrWuhKwP
         Ivpw==
X-Gm-Message-State: AOAM533EHAD00x5XtknH/8PYpvt2iroK0hYHUZtZMefBBVIl4AgS1Bqp
        7OE74d/b1QM4dheVJy7gFVkBd8yeD0yvDsD5M1YoJBiP
X-Google-Smtp-Source: ABdhPJw1jM5JpKvKQapQ9Rs7SNql7MW5tlyO9yX/7Nr8OAiDAp7sVMIwEtQ1GtZMcXVYRbWnMbZoO/zxBcFb/v7UiD4=
X-Received: by 2002:a1f:2502:: with SMTP id l2mr2306082vkl.5.1614696934432;
 Tue, 02 Mar 2021 06:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home> <YD5LKqtSz5r1Xp7B@elver.google.com>
 <20210302143516.GY2723601@casper.infradead.org> <CANpmjNNMFtJvkVBhjpp=YqFb3ck8Q4Ak8nGtB21XMd9ds_APFA@mail.gmail.com>
In-Reply-To: <CANpmjNNMFtJvkVBhjpp=YqFb3ck8Q4Ak8nGtB21XMd9ds_APFA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 15:55:23 +0100
Message-ID: <CAMuHMdXAH9tVX9Fz2X3L4+e9DkdFoy1qhmEocY69DKJXBQjexQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Marco Elver <elver@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Tue, Mar 2, 2021 at 3:40 PM Marco Elver <elver@google.com> wrote:
> On Tue, 2 Mar 2021 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Mar 02, 2021 at 03:26:50PM +0100, Marco Elver wrote:
> > > +static const char no_hash_pointers_warning[9][55] __initconst = {
> > > +     "******************************************************",
> > > +     "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> > > +     "                                                      ",
> > > +     " This system shows unhashed kernel memory addresses   ",
> > > +     " via the console, logs, and other interfaces. This    ",
> > > +     " might reduce the security of your system.            ",
> > > +     " If you see this message and you are not debugging    ",
> > > +     " the kernel, report this immediately to your system   ",
> > > +     " administrator!                                       ",
> > > +};
> > > +
> > >  static int __init no_hash_pointers_enable(char *str)
> > >  {
> > > +     const int lines[] = { 0, 1, 2, 3, 4, 5, 2, 6, 7, 8, 2, 1, 0 };
> > > +     int i;
> > > +
> > >       no_hash_pointers = true;
> > >
> > > -     pr_warn("**********************************************************\n");
> > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > -     pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > -     pr_warn("** might reduce the security of your system.            **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("** If you see this message and you are not debugging    **\n");
> > > -     pr_warn("** the kernel, report this immediately to your system   **\n");
> > > -     pr_warn("** administrator!                                       **\n");
> > > -     pr_warn("**                                                      **\n");
> > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -     pr_warn("**********************************************************\n");
> > > +     for (i = 0; i < ARRAY_SIZE(lines); i++)
> > > +             pr_warn("**%s**\n", no_hash_pointers_warning[lines[i]]);
> >
> > +       for (i = 0; i < 3; i++)
> > +               pr_warn("**%s**\n", no_hash_pointers_warning[lines[2 - i]]);
>
> Yeah, I had that before, but then wanted to deal with the blank line
> in the middle of the thing. So I just went with the lines array above,
> which seemed cleanest for dealing with the middle blank line and
> footer. Or maybe there's something even nicer I missed? :-)

Gcc deduplicates the identical strings, so you don't have to go through
a double indirection at all?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
