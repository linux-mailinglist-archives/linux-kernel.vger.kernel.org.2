Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A832AA3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581692AbhCBTQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:16:49 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:38237 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839566AbhCBQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:28 -0500
Received: by mail-vs1-f54.google.com with SMTP id l192so10913296vsd.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIHxy2MH0U5p3wSVrHtjrqodVtUE1t1KDTaIUnigDW4=;
        b=CFLcRbF419AArF8j6kYceW3Fe7wF9rzDe/aYpKGAuAAM33u3ycMHKLlrAt5NZ9UE6S
         D7U5GTvdI+AZsR/tBzN6kJ0ajFBMtBDXMQBvBEOKxgGHlxXJeSDP9g5Uu7e/togF2ny1
         IrPTcvgdcVS+tnzU8+5c3hgM2pdVCjHr2hhjS+CRgrDl4bvDpuiAqfSAsSgCeZ+s27ZJ
         3Gfz+eJBWrfVeaMk4ZVXJSs39jlLy5eOfdrSpmUQaLOhcVPiJW1fsot+sFgDfGn/K78L
         UaXKfuEIO3C8VqhT70CMGPtdvVYL46bmbTzPJE6U0KzgAu5W5Nj4Oq+To+tSnRaULEXH
         jxow==
X-Gm-Message-State: AOAM533CL+x2+tNfnlTJeSrSLEEu/0zx5VnJgOF20WaFmCAU48FQsuqs
        +GhfyUBvhvyxwJuxExspbaIXbQvzp6CCggu8cMmwQOgjf24=
X-Google-Smtp-Source: ABdhPJzrg0G5QeNeHFj1kuSdPw0AzLBz9LAImTbZlPsa0SvOOKlz2FImxa5JEylhcOwUREkyfEsRxh5TxoDWOCNX5PQ=
X-Received: by 2002:ac5:ce04:: with SMTP id j4mr7993409vki.1.1614695300432;
 Tue, 02 Mar 2021 06:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley> <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com> <20210302090811.620ae7d0@gandalf.local.home>
In-Reply-To: <20210302090811.620ae7d0@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 15:28:09 +0100
Message-ID: <CAMuHMdVYJ0ydFEZ+xPLt27J9pBW+B8pJNPBDZ2Vw5g5k1atarg@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Marco Elver <elver@google.com>, Timur Tabi <timur@kernel.org>,
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

Hi Steven,

On Tue, Mar 2, 2021 at 3:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2 Mar 2021 14:49:42 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > So this is basically a kernel tinyfication issue, right? Is that still pursued
> > > today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?
> >
> > As long as I hear about products running Linux on SoCs with 10 MiB of
> > SRAM, I think the answer is yes.
> > I'm not immediately aware of a better config option.  There are no more
> > TINY options left, and EXPERT selects DEBUG_KERNEL.
>
> Since the trace_printk() uses the same type of notice, I wonder if we could
> make this into a helper function and just pass in the top part.
>
> +       pr_warn("**********************************************************\n");
> +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +       pr_warn("**                                                      **\n");
>
>
> +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> +       pr_warn("** might reduce the security of your system.            **\n");
>
> Only the above section is really unique. The rest can be a boiler plate.

Good idea. drivers/iommu/iommu-debugfs.c has a third copy.

> +       pr_warn("**                                                      **\n");
> +       pr_warn("** If you see this message and you are not debugging    **\n");
> +       pr_warn("** the kernel, report this immediately to your system   **\n");
> +       pr_warn("** administrator!                                       **\n");
> +       pr_warn("**                                                      **\n");
> +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +       pr_warn("**********************************************************\n");

Fortunately gcc is already smart enough to deduplicate identical strings,
but only in the same source file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
