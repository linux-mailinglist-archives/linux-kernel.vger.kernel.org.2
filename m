Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F7330D69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCHMXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:23:02 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:38791 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhCHMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:22:52 -0500
Received: by mail-vs1-f43.google.com with SMTP id e21so2709358vsh.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 04:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLC/tgI64EEsWSU2GUD0WY3ILds+TQ6RTHmx4L/R/8s=;
        b=NDPtbZvUqJ+0kZcEGgK1MJUiqw/emjlUOXHFmBMslVZaOygmJ+7vdkaokChd/+ADZZ
         ad7q8v8L1wNQO8NP96Ble7tZy2oCXsU8AYdsJl/FNuvWfX9y757+WW90ueID5OGEqfrR
         x45BKgAL0dGAQhqJ2eIedTO7VJVXeCDaYTlvGI//cxlHYElqUmQEcAv1MBa8YYQ5+2wH
         aPkI8C24bSLH2tEh5iBeDrLhb/43p4wHXk2vr947ueJMGlrpQplAvm1Eldsfi6IKV7BB
         n1YJLlh84cGe1818RhZ6TbKzc0xVM6gEMtcJ8E/MbwQEAJJ6jRBkkSYqPr1WuNUoxMES
         qJbw==
X-Gm-Message-State: AOAM531lllFnLNJ4rpAj0wHsKL9nP/8ZQpUtr12nqLRkvBRkPkY25z5Q
        cPP9eJzWULQnnWeMbxxIf6zO0Q5nC7fxqOM6SF8=
X-Google-Smtp-Source: ABdhPJxmNBbkgCiHQ4+r/cRZ/et+7Ff7jGGXBLH7sL1NfISu4mKEJu/dnBKW04brnl6oUESlUWmRHD9wPdlNS+5WATo=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr13045613vsr.40.1615206172118;
 Mon, 08 Mar 2021 04:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley>
In-Reply-To: <YEX5fyB16dF6N4Iu@alley>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Mar 2021 13:22:40 +0100
Message-ID: <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
To:     Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Mon, Mar 8, 2021 at 11:16 AM Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2021-03-05 20:42:06, Marco Elver wrote:
> > Move the no_hash_pointers warning string into __initconst section, so
> > that it is discarded after init. Remove common start/end characters.
> > Also remove repeated lines from the array, since the compiler can't
> > remove duplicate strings for us since the array must appear in
> > __initconst as defined.
> >
> > Note, a similar message appears in kernel/trace/trace.c, but compiling
> > the feature is guarded by CONFIG_TRACING. It is not immediately obvious
> > if a space-concious kernel would prefer CONFIG_TRACING=n. Therefore, it
> > makes sense to keep the message for no_hash_pointers as __initconst, and
> > not move the NOTICE-printing to a common function.
> >
> > Link: https://lkml.kernel.org/r/CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  lib/vsprintf.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 4a14889ccb35..1095689c9c97 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -2094,26 +2094,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> >  bool no_hash_pointers __ro_after_init;
> >  EXPORT_SYMBOL_GPL(no_hash_pointers);
> >
> > +static const char no_hash_pointers_warning[8][55] __initconst = {
> > +     "******************************************************",
> > +     "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> > +     " This system shows unhashed kernel memory addresses   ",
> > +     " via the console, logs, and other interfaces. This    ",
> > +     " might reduce the security of your system.            ",
> > +     " If you see this message and you are not debugging    ",
> > +     " the kernel, report this immediately to your system   ",
> > +     " administrator!                                       ",
> > +};
> > +
> >  static int __init no_hash_pointers_enable(char *str)
> >  {
> > +     /* Indices into no_hash_pointers_warning; -1 is an empty line. */
> > +     const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };
> > +     int i;
> > +
> >       if (no_hash_pointers)
> >               return 0;
> >
> >       no_hash_pointers = true;
> >
> > -     pr_warn("**********************************************************\n");
> > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > -     pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > -     pr_warn("** might reduce the security of your system.            **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("** If you see this message and you are not debugging    **\n");
> > -     pr_warn("** the kernel, report this immediately to your system   **\n");
> > -     pr_warn("** administrator!                                       **\n");
> > -     pr_warn("**                                                      **\n");
> > -     pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -     pr_warn("**********************************************************\n");
> > +     for (i = 0; i < ARRAY_SIZE(lines); i++)
> > +             pr_warn("**%54s**\n", i == -1 ? "" : no_hash_pointers_warning[lines[i]]);
>
> Is this worth it, please? Could anyone provide some numbers how

Yeah, the code indeed starts to look a bit cumbersome...

> the kernel size increases between releases?

I'd say 20 KiB per release, on average.

> The number of code lines is basically just growing. The same is true
> for the amount of printed messages.

Yeah, we keep on adding more messages.
But do we really need to print a message of 13 lines?
If you consider this critical for security, perhaps it should use pr_crit(),
or pr_alert()? But please don't print more than a single line.

<sarcastic>
Perhaps it should print a URL to a message instead, like the
"software license" option in Android systems and apps?
</sarcastic>

> This patch is saving some lines of text that might be effectively
> compressed. But it adds some code and array with indexes. Does it
> make any significant imrovement in the compressed kernel image?
>
> Geert was primary concerned about the runtime memory consuption.
> It will be solved by the  __initconst. The rest affects only
> the size of the compressed image on disk.

I'm actually concerned about both.  Platforms (and boot loaders) may
have limitations for kernel image size, too.
Static memory consumption is also more easily measured, so I tend
to run bloat-o-meter, and dive into anything that adds more than 1 KiB.
And yes, this message is a low-hanging fruit...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
