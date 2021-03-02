Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298A32A56A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444844AbhCBMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:40:29 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40291 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243566AbhCBMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:00:20 -0500
Received: by mail-pl1-f177.google.com with SMTP id z7so11897723plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 03:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPMYrPE53JPDiUgSdMHwbiAuGODFtR/r/Eavu/kjlTE=;
        b=eG/AQNkW2s9thvAZyqYKtR+1Oeo4/HJR0ygHthCQQlyH6iCocDLPbv/hu4Onkdqty7
         rXUAFJ+ZENZfMQ3l+CjOwF8CufU7sG3csfk9D65XJ0WMXe/6JcIlI7iFyfQH0ydQZYEc
         LFW1rxJfRAnpdVk71EnjHiUHTTSOf5rxhMUV7DF/3QqmXsGgwn5T6xKG+sYzAr2lO2XS
         k4kmBZHZk9+BGULhE/N51cA4eIVsoqVnlqSslL2dSjbbe1roSQV5erB6xVsG4QiVjkUl
         jXWibmos6lEMyjKNAWeEPoAtb65jR7JGhNnCySO9RrvcdiD95MmRRiuBjG9iM7bK7wjA
         Y5xQ==
X-Gm-Message-State: AOAM533f+tB5gvjQ1dPKRHgXFXqy4Uow89dfGESI2ORzHyNhi6HNeeSl
        UfPHUHn+P+KSTDxqX+nwwXsXDObSGO3iKKXrNn+WY3nzQGc=
X-Google-Smtp-Source: ABdhPJw4msoZHSxz1MJmsEugh4lqV4KC4DUiNKDmynjUUxz0nDJKTkw9uam3ESVyzlOdrxzmsaRqZ2WIU+GRtIiGP/0=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr1936543vsr.40.1614685915222;
 Tue, 02 Mar 2021 03:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
In-Reply-To: <20210214161348.369023-4-timur@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Mar 2021 12:51:44 +0100
Message-ID: <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timur,

On Sun, Feb 14, 2021 at 5:17 PM Timur Tabi <timur@kernel.org> wrote:
> If the no_hash_pointers command line parameter is set, then
> printk("%p") will print pointers as unhashed, which is useful for
> debugging purposes.  This change applies to any function that uses
> vsprintf, such as print_hex_dump() and seq_buf_printf().
>
> A large warning message is displayed if this option is enabled.
> Unhashed pointers expose kernel addresses, which can be a security
> risk.
>
> Also update test_printf to skip the hashed pointer tests if the
> command-line option is set.
>
> Signed-off-by: Timur Tabi <timur@kernel.org>

Thanks for your patch, which is now commit 5ead723a20e0447b
("lib/vsprintf: no_hash_pointers prints all addresses as unhashed") in
v5.12-rc1.

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,32 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>         return widen_string(buf, buf - buf_start, end, spec);
>  }
>
> +/* Disable pointer hashing if requested */
> +bool no_hash_pointers __ro_after_init;
> +EXPORT_SYMBOL_GPL(no_hash_pointers);
> +
> +static int __init no_hash_pointers_enable(char *str)
> +{
> +       no_hash_pointers = true;
> +
> +       pr_warn("**********************************************************\n");
> +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +       pr_warn("**                                                      **\n");
> +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> +       pr_warn("** might reduce the security of your system.            **\n");
> +       pr_warn("**                                                      **\n");
> +       pr_warn("** If you see this message and you are not debugging    **\n");
> +       pr_warn("** the kernel, report this immediately to your system   **\n");
> +       pr_warn("** administrator!                                       **\n");
> +       pr_warn("**                                                      **\n");
> +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +       pr_warn("**********************************************************\n");
> +
> +       return 0;
> +}
> +early_param("no_hash_pointers", no_hash_pointers_enable);

While bloat-o-meter is not smart enough to notice the real size impact,
this does add more than 500 bytes of string data to the kernel.
Do we really need such a large message?
Perhaps the whole no_hash_pointers machinery should be protected by
"#ifdef CONFIG_DEBUG_KERNEL"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
