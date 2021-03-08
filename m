Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F19330BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCHKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCHKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:51:46 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D487C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:51:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f33so8692953otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mh+FKbgwzXnmmNlJKmmWZgmnCj+XKwK/potDGeApFg=;
        b=o92pMCTe7BpoPCCmTM4iYChdQ8rj50Tk9wcrI2gcGA2kTRQQ3rKm3EOQwy+NM6T1Sq
         nNU/E+cQSlYU/ftLyt9uRTfLboWXDDmz+MH/66LRr+YhHmBmbqt9WvPwyjwqXi6I5OX5
         lp4AQf7CR+vb7MXi+rb1voPozPBLXiwXsd0Np6FaVX68oSG0qRYXGjSZktsYUZubYBV9
         Z43cLTTsvzXDK6Ao7ufjydLgqvcF71sGIbae7pF4ayzUlWyjk78PzLfNk9kcyqcww+nU
         cpPNpU9Md2gwSl38VMQnwyvTrN3yO4dfa+22DSL6hQBEiq/7LYMqu6uMi9Ds+RBmtQ/4
         Egwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mh+FKbgwzXnmmNlJKmmWZgmnCj+XKwK/potDGeApFg=;
        b=fz7E98lhsZtPZNOlTC42ZdTpkEMNi+I9z/nJ6pY0Xx2ZKGb2WXpBHjtyJAhqav2pC8
         Hgkxgu/Xx2MSV/jVSZyLKWZQMFvrNaig7lOhQjFbCJ/MiaROTyycDiuczwjv5exTNosY
         h79IAQMPY10R9t2QvM0nt8/BO8JBdxdPki2xq4OSMD65rLoU89hNA7wB66jlrNPDBqdo
         MuS+5RZ4ZNDw9ReTiyrhn6yWvpeb3wF2MIcmkr+jMlzT9kw8TLbbNR7+ZiWn5xQaTDl4
         YC0jzTuUDtUMDYvfkf21tdfyB/ZNVleR+zWUT7RuydpIntzlMu3aG/1y9YK/1kTUHFBe
         ydQA==
X-Gm-Message-State: AOAM532fJZjZcss3u0JuZdMi33gH/y9iCTdGQ+IsaJN05vg8uQRl3CeK
        PTzMW3+VZSr+UqboLoO9pSDnMXnVHzMht9pbgsKaYg==
X-Google-Smtp-Source: ABdhPJzonEUeM2OlrUBXYvFDGcu7eTmPoa+uQOVEwRPqq8/VESYUAkT3qmSBv9nE+bZhwIaRZlHVahNW5JN4OHxvt3Y=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr3656133otg.17.1615200704419;
 Mon, 08 Mar 2021 02:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley>
In-Reply-To: <YEX5fyB16dF6N4Iu@alley>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Mar 2021 11:51:32 +0100
Message-ID: <CANpmjNPTXPWZyPTqYZKdnvcbHP+ZOa0ce0Md5EE6GViQMyeTOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 at 11:16, Petr Mladek <pmladek@suse.com> wrote:
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
> the kernel size increases between releases?

I just posted this patch as an option to solve the problem as I had
posted in the other thread, but otherwise agree that it's questionable
if it's worth it. (I hope that Geert will post the numbers for the
arch+config he noticed that led to his report.)

> The number of code lines is basically just growing. The same is true
> for the amount of printed messages.
>
> This patch is saving some lines of text that might be effectively
> compressed. But it adds some code and array with indexes. Does it
> make any significant imrovement in the compressed kernel image?
>
> Geert was primary concerned about the runtime memory consuption.
> It will be solved by the  __initconst. The rest affects only
> the size of the compressed image on disk.

If we do __initconst change we need to manually remove the duplicate
lines because we're asking the compiler to create a large array (and
there's no more auto-dedup). If we do not remove the duplicate lines,
the __initconst-only approach would create a larger image and result
in subtly increased memory consumption during init. The additional
code together with manual dedup should offset that. (I can split this
patch as Andy suggests, but first need confirmation what people
actually want.)

I have no idea what the right trade-off is, and appeal to Geert to
suggest what would be acceptable to him.

Thanks,
-- Marco
