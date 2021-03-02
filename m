Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3669F32A967
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580886AbhCBSWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578856AbhCBP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:03 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1512C061A2D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:57:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 21so12605478oiq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmUWdxYWY4JnxgM68Ep5fyjuN1K6LUQgUumR1JHhFjM=;
        b=ucOUGXgcAKZ8z8MoWdcXzhM1S9Akea7eRUv41rR9DdvWJtN77xqeADIfnnZ0xNl5sz
         3tm7ONDrz/dAAFAzucZm0ba211M6sE3b3XvvbsrYllCMPwNVsiG/4z16LwN2XyemUrzZ
         03gngD7beCxhGjEpSDqn7mQB2D3gpWmn9j60jl4vV1WA8iLp9jkUHyTRKq5jNptyEbAW
         ZOv8gdrbIJZXIcJ7pvS+ahd7XDS355kpmmG+ampCHPCm/ejY6FdXxlr4zNyqSV68CcD/
         Rxq5ooblk+N/ejzdmBv6LLrVdvhRI3tERs3EFe+idAMXqt2XJ3j4CHcf9b3GBf6MbW34
         UR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmUWdxYWY4JnxgM68Ep5fyjuN1K6LUQgUumR1JHhFjM=;
        b=fRJEvyEdkh1EJRngk1CcGIFgTWMCsdy2ssfzbX4hYMK5e8wJCrXqaQJz+k4Ny+2Kb0
         Lchd1+yXMhCmoPkYDC2gVJhA9IbXA8426MezcaiwQ0XKxWexcOijmzs/cjEnxbSnGGYV
         i0FHxOY3An4a8FJZRMFGC9B5TdB+V8JmU7KK/iZqB9RPhPKdL6y5SYsO+KKb/GQD87k+
         2pQTffQlXfm0DwxsDXgfg6Yd8BHOQlTMC1LD6qW0jTE3b3M5DmPtWKFbivOTm6gcZwX+
         eDLb+2FB4W9tRK9zqaJinqbZT2ubnXrJgmCLNFthx/3hKtV6woPNSZaP+w3CfQiutv2g
         TgjQ==
X-Gm-Message-State: AOAM532rih6qgyszCah5CQomOqAgGfzPBJHqdvxCtlxjZXOWZ0wIupxF
        vE7ruxPAZR2cr5VRvietzY+Fg6+UTmX5sLtS+aCDPA==
X-Google-Smtp-Source: ABdhPJwLwbBM3NS+I9Xhcy1DO7959Zl+cml3b3a5uuRHoowSmVvD41Ot3ignp1wWvmr7W3kU7ZPHuHcgWcmnqSxfwhw=
X-Received: by 2002:aca:5fd4:: with SMTP id t203mr3439866oib.121.1614697032814;
 Tue, 02 Mar 2021 06:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home> <YD5LKqtSz5r1Xp7B@elver.google.com>
 <20210302143516.GY2723601@casper.infradead.org> <CANpmjNNMFtJvkVBhjpp=YqFb3ck8Q4Ak8nGtB21XMd9ds_APFA@mail.gmail.com>
 <CAMuHMdXAH9tVX9Fz2X3L4+e9DkdFoy1qhmEocY69DKJXBQjexQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXAH9tVX9Fz2X3L4+e9DkdFoy1qhmEocY69DKJXBQjexQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Mar 2021 15:57:01 +0100
Message-ID: <CANpmjNP2Z7O-2GhsjiHtTFzHGEryQPGdjHN6EeGweLWZHq-u2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, 2 Mar 2021 at 15:55, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Marco,
>
> On Tue, Mar 2, 2021 at 3:40 PM Marco Elver <elver@google.com> wrote:
> > On Tue, 2 Mar 2021 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Mar 02, 2021 at 03:26:50PM +0100, Marco Elver wrote:
> > > > +static const char no_hash_pointers_warning[9][55] __initconst = {
> > > > +     "******************************************************",
> > > > +     "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> > > > +     "                                                      ",
> > > > +     " This system shows unhashed kernel memory addresses   ",
> > > > +     " via the console, logs, and other interfaces. This    ",
> > > > +     " might reduce the security of your system.            ",
> > > > +     " If you see this message and you are not debugging    ",
> > > > +     " the kernel, report this immediately to your system   ",
> > > > +     " administrator!                                       ",
> > > > +};
> > > > +
> > > >  static int __init no_hash_pointers_enable(char *str)
> > > >  {
> > > > +     const int lines[] = { 0, 1, 2, 3, 4, 5, 2, 6, 7, 8, 2, 1, 0 };
> > > > +     int i;
> > > > +
> > > >       no_hash_pointers = true;
> > > >
> > > > -     pr_warn("**********************************************************\n");
> > > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > > -     pr_warn("**                                                      **\n");
> > > > -     pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > > -     pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > > -     pr_warn("** might reduce the security of your system.            **\n");
> > > > -     pr_warn("**                                                      **\n");
> > > > -     pr_warn("** If you see this message and you are not debugging    **\n");
> > > > -     pr_warn("** the kernel, report this immediately to your system   **\n");
> > > > -     pr_warn("** administrator!                                       **\n");
> > > > -     pr_warn("**                                                      **\n");
> > > > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > > -     pr_warn("**********************************************************\n");
> > > > +     for (i = 0; i < ARRAY_SIZE(lines); i++)
> > > > +             pr_warn("**%s**\n", no_hash_pointers_warning[lines[i]]);
> > >
> > > +       for (i = 0; i < 3; i++)
> > > +               pr_warn("**%s**\n", no_hash_pointers_warning[lines[2 - i]]);
> >
> > Yeah, I had that before, but then wanted to deal with the blank line
> > in the middle of the thing. So I just went with the lines array above,
> > which seemed cleanest for dealing with the middle blank line and
> > footer. Or maybe there's something even nicer I missed? :-)
>
> Gcc deduplicates the identical strings, so you don't have to go through
> a double indirection at all?

In this case I think we do, because we're asking the compiler to
create a giant array char[9][55]. If we had char*[9], then you're
right, but in that case we would not benefit from __initconst for the
majority of the data.

Thanks,
-- Marco
