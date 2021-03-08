Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACFF3315E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhCHSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCHSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:23:47 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3BBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:23:47 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r24so3075716otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGHCLycZHBWZ0duqYIFRsUMi3zHTz7IK7hAS4RS/bmg=;
        b=Rtmi8XZTyOF53wugdQDusYWUDYYyGAE6XTRI+Dt569AF8OKWluaj+P89OlbzbQQF2n
         eQEf6EoncvhyaMctYdr3y+2yRn1GEBUL3V3cRFiH1aJrCG/CgQfdBJN8W2secDAd2jic
         9vSAV80F2FujNNWBnLc+lON9u359GJFW6lft05gzgHGsDe03pwpi4/HJMYFySyFdrgOo
         uGsJXJgQotrkIqx1zV82BwoFFQv/slZVgqREGMrFCSnLQorZGnJ7V/3kTuJ3/eS7nMFV
         WwO9mGBSd1tK0Z/HF/KFPBGwiyFvW9EIwocW5hVu8ShPIarMhWmU5QC+ZRLcFbtab8n3
         g6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGHCLycZHBWZ0duqYIFRsUMi3zHTz7IK7hAS4RS/bmg=;
        b=R5Sag3vV6a0bZlj8PfwWib8X8zb/7zJRnzzQfpUpCS/1xOdKxWGFqsUPIv+y93ZTGS
         oxrJAvKOdfzJiChfUfrZHlyzmAJZSEcLBpaT4Cdb31pvmqXaDWDuYN2zfhpvMm7kHqhh
         iuP9eWnFTeDlYzkye1Ac17mZpvHbDfvtLa5rnEo0lQ/x0jOW6t+Px/zSnsJVxoFxAnsf
         q68lQM0XwBFenQ0IdAE0azNOeJtcuGUJOU8pQH7MBxC4hVlLeGZmignQ7W8V5Idsdixh
         PUaFVoPJIbjEI2lsv5JyJYKAmPlJ+uj5N9Z6YllLEH/fcJZyt8fNQ+4w8Zq52NmjSbhG
         3zSA==
X-Gm-Message-State: AOAM533Kk4eG5/+V6xNekg0mjczi5chJqFDp6B8Enq4iRWSOFVGeqPFH
        H53ZIoukyWPwfE3/i4h1AmZ29Y5ZsJPntUJ3S4bkTcyAAF0gpw==
X-Google-Smtp-Source: ABdhPJwZw+WGwQktQsPmSG00uOfeZRVrt/a3O7PS93kZvM4f0mGfHsOWemqoCff4Den0OSKEJi46aowYWN+X/Iz+8ro=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr21357256otl.233.1615227826234;
 Mon, 08 Mar 2021 10:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley> <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
 <YEZdo0L8otuEJZNW@alley>
In-Reply-To: <YEZdo0L8otuEJZNW@alley>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Mar 2021 19:23:34 +0100
Message-ID: <CANpmjNOS86kLPexXBZPwRB9=Ej6RHycJXCw_Z7cskMC+Jwb1Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
To:     Petr Mladek <pmladek@suse.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 at 18:23, Petr Mladek <pmladek@suse.com> wrote:
[...]
> > I'm actually concerned about both.  Platforms (and boot loaders) may
> > have limitations for kernel image size, too.
> > Static memory consumption is also more easily measured, so I tend
> > to run bloat-o-meter, and dive into anything that adds more than 1 KiB.
> > And yes, this message is a low-hanging fruit...
>
> OK, I wondered how big trick does the  __initconst on its own.
>
> 1. I compiled kernel without this patchset:
>
> $# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
> -rwxr-xr-x 1 root root 18911364 Mar  8 15:58 /boot/vmlinux-5.12.0-rc2-def=
ault+.bz2
>
> 2. With this patchset:
>
> $# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
> -rwxr-xr-x 1 root root 18910767 Mar  8 16:16 /boot/vmlinux-5.12.0-rc2-def=
ault+.bz2
> $# echo $((18910767 - 18911364))
> -597
>
> 3. With the patch below:
>
> $# ll /boot/vmlinux-5.12.0-rc2-default+.bz2
> -rwxr-xr-x 1 root root 18910906 Mar  8 16:58 /boot/vmlinux-5.12.0-rc2-def=
ault+.bz2
> $# echo $((18910906 - 18911364))
> -458
>
> This patchset saves 139B more than a simple array.
>
>
> Well, I am a bit confused. I have tried to keep the strings as a
> static variable outside the function:
>
> static const char *no_hash_pointers_warning[] __initconst =3D {
>         ...
>
> and I got the following build error:
>
>   CC      lib/vsprintf.o
> lib/vsprintf.c:2097:20: error: no_hash_pointers_warning causes a section =
type conflict with __setup_str_no_hash_pointers_enable
>  static const char *no_hash_pointers_warning[] __initconst =3D {

This does not place the strings themselves into the initconst section,
but only the array of pointers to them. So, with 13 lines, we're
merely saving 13*sizeof(char*) after init, which does not resolve
Geert's problem of runtime overhead.

To dealloc the string text itself (remove the section), each line must
be placed into a 'char[N] __initconst' (or 'char [M][N] __initconst'
if we split the lines).

>                     ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/printk.h:6:0,
>                  from ./include/linux/kernel.h:16,
>                  from ./include/linux/clk.h:13,
>                  from lib/vsprintf.c:22:
> ./include/linux/init.h:315:20: note: =E2=80=98__setup_str_no_hash_pointer=
s_enable=E2=80=99 was declared here
>   static const char __setup_str_##unique_id[] __initconst  \
>                     ^
> ./include/linux/init.h:330:2: note: in expansion of macro =E2=80=98__setu=
p_param=E2=80=99
>   __setup_param(str, fn, fn, 1)
>   ^~~~~~~~~~~~~
> lib/vsprintf.c:2127:1: note: in expansion of macro =E2=80=98early_param=
=E2=80=99
>  early_param("no_hash_pointers", no_hash_pointers_enable);
>  ^~~~~~~~~~~
>
>
> I solved this be defining the array inside the function that is marked
> __init. But I am not sure if it is the correct solution. And I wonder
> why the original patch did not have this problem.
>
> Also I am curious why the array reduced the size of the binary so
> significantly in compare with the const strings used as pr_warn()
> arguments. It might depend on the compression method or???
>
>
> Anyway, here is the patch that works for me and reduced the size of
> the binary considerably:
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 4a14889ccb35..af01edae0d86 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2096,24 +2096,30 @@ EXPORT_SYMBOL_GPL(no_hash_pointers);
>
>  static int __init no_hash_pointers_enable(char *str)
>  {
> +       int i;
> +       const char *no_hash_pointers_warning[] =3D {
> +               "********************************************************=
**",
> +               "**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
**",
> +               "**                                                      =
**",
> +               "** This system shows unhashed kernel memory addresses   =
**",
> +               "** via the console, logs, and other interfaces. This    =
**",
> +               "** might reduce the security of your system.            =
**",
> +               "**                                                      =
**",
> +               "** If you see this message and you are not debugging    =
**",
> +               "** the kernel, report this immediately to your system   =
**",
> +               "** administrator!                                       =
**",
> +               "**                                                      =
**",
> +               "**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
**",
> +               "********************************************************=
**",
> +       };
> +

This has no __initconst optimization (no runtime savings), and the
compiler places these strings into the data section and the above
array is just an array of pointers to them.

>         if (no_hash_pointers)
>                 return 0;
>
>         no_hash_pointers =3D true;
>
> -       pr_warn("********************************************************=
**\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
**\n");
> -       pr_warn("**                                                      =
**\n");
> -       pr_warn("** This system shows unhashed kernel memory addresses   =
**\n");
> -       pr_warn("** via the console, logs, and other interfaces. This    =
**\n");
> -       pr_warn("** might reduce the security of your system.            =
**\n");
> -       pr_warn("**                                                      =
**\n");
> -       pr_warn("** If you see this message and you are not debugging    =
**\n");
> -       pr_warn("** the kernel, report this immediately to your system   =
**\n");

While we're here: This paragraph can be shortened by saying what
kernel/trace/trace.c says ("..., report this immediately to your
vendor!") which avoids the "administrator! <lots of wasted spaces>".

> -       pr_warn("** administrator!                                       =
**\n");
> -       pr_warn("**                                                      =
**\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
**\n");
> -       pr_warn("********************************************************=
**\n");
> +       for (i =3D 0; i < ARRAY_SIZE(no_hash_pointers_warning); i++)
> +               pr_warn("%s\n", no_hash_pointers_warning[i]);

My guess is that the savings came from repeated calls to pr_warn() and
reduction in code-size and compression working better.

>         return 0;
>  }
>
>
> Honestly, I do not want to spend much more time on this. I made the
> test out of curiosity.
>
> Feel free to provide the patch using the array, ideally with some
> numbers how it helps. But please _avoid_ the indirection via
>
>     const int lines[] =3D { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };

We can probably do without this, but we'll have duplicated lines
stored in the initconst section.

> and also _avoid_ all the hardcoded constants, like:
>
>       no_hash_pointers_warning[8][55]

We'll need this if we want __initconst. But perhaps we do not have to
split it by lines, so we can get away with a char[].

> and
>
>       pr_warn("**%54s**\n"
>
> They are error prone and hard to maintain. Such tricks are not
> worth it from my POV.

I can send the version with a single 'static char[] __initconst', but
that version doesn't dedup lines and requires more init memory. I
don't know if we can make everybody happy here, we have to sacrifice
something: readability or space.
