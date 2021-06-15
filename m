Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFF3A8B53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFOVoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:44:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F118C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:42:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a127so481264pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA1usv2x07nLfH8hRseo7Ba/yaKQBf82k84REFaxTsU=;
        b=pnOd6B0HvYIQBjHl+7u7WPUyJIuU/apnFRwl65O3UnFZ9n06AcHoDGYo/xbiXyND73
         xvYeQVhG5B2qXPZt0g6sfkCDcrpwAv4ZmPn+FUqJwSt0eC4f/xlROmRpO3Uoessftuk7
         z66Cu5T1tC7wLTEk482pW+3W0ame9htA0Ms5/viabgMj2BOUtA9JIhXONTBBsnmZCarC
         Xs5bE42vkmhjlRXNY5j2dJ5Z9Uh4W8+UTiXO8KKWnQcmV6KI5dJ2iVMePRm42ZhIyXbS
         sUoxjZw4qdBh1QblgXg8Afzz9x34yPQEOtIhLDY2VeHS/u2BG/JfV8zie8M2fOM8xOUZ
         4rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA1usv2x07nLfH8hRseo7Ba/yaKQBf82k84REFaxTsU=;
        b=XLTkO/8fwGPhURq7WssU54CdB5zCrqCI0vz5DcrtpKLJB6z1f8s3CviPs4CMzr6Cjo
         kbSVPRcmQ2Un1oQjblI2RAsCUiHVn2txjsdVaUWYj4kpCsRbnMdD0ppk0FqEdI2GEEIu
         j9MZAj7DeGNrjOMX94V9XdNYbzsi8E+R58QHhy0GE8P9Ym/LvHjVXaJ0p3hfDT26WUPM
         ENq3OsvhHYC6HvPuE5BRwD2EcoZ/6UxkUfDDRnnNTzx2MYvpBTjRGBKnOLBa4KkuEl0Q
         Iarj6gQ67ImwHTGn0zwXKn5hiR9D1sdbgMJlnv8tJHmWM92N0PUn7i+1FHtmL8sov8sk
         kMqw==
X-Gm-Message-State: AOAM531jeb0Wp1ad4pKzz24nLLcq3NdZiblhdBo3zUukS9ejDJ4fAnKl
        YMsSzrFalpC5D6kwLX4jVrBQbDq6bbvsSJYpOb0=
X-Google-Smtp-Source: ABdhPJyO8bYDwo5PQLSq8cO82k/r4H21db/vxjvvwnWiqeZvlggvSyu39rVOxJ9Bbw1tTHA6cAOgcoq9BcdL53XGFRw=
X-Received: by 2002:a05:6a00:139c:b029:2f7:102c:5393 with SMTP id
 t28-20020a056a00139cb02902f7102c5393mr6565637pfg.40.1623793367603; Tue, 15
 Jun 2021 14:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623775748.git.chris@chrisdown.name> <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
In-Reply-To: <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Jun 2021 00:42:27 +0300
Message-ID: <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] string_helpers: Escape double quotes in escape_special
To:     Chris Down <chris@chrisdown.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 7:53 PM Chris Down <chris@chrisdown.name> wrote:

In case you will need to send a new version some nit picks below WRT
commit message. Or somebody might fix them in place when applying.

> From an abstract point of view, escape_special's counterpart,
> unescape_special, already handles the unescaping of blackslashed double
> quote sequences.
>
> As a more practical example, printk indexing is an example case where

(example example)

"As a more practical example, printk indexing is the case where..."

?

> this is already practically useful. Compare an example with
> `ESCAPE_SPECIAL | ESCAPE_SPACE`, with quotes not escaped:
>
>     [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
>     <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string "%s"\n"
>
> ...and the same after this patch:
>
>     [root@ktst ~]# grep drivers/pci/pci-stub.c:69 /sys/kernel/debug/printk/index/vmlinux
>     <4> drivers/pci/pci-stub.c:69 pci_stub_init "pci-stub: invalid ID string \"%s\"\n"

In both examples: '[root@ktst ~]#' => '#'

> One can of course, alternatively, use ESCAPE_APPEND with a quote in
> @only, but without this patch quotes are coerced into hex or octal which
> can hurt readability quite significantly.
>
> I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm

checked the uses

> pretty confident that this shouldn't affect any stable interfaces.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/string_helpers.c      |  4 ++++
>  lib/test-string_helpers.c | 14 +++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 5a35c7e16e96..3806a52ce697 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -361,6 +361,9 @@ static bool escape_special(unsigned char c, char **dst, char *end)
>         case '\e':
>                 to = 'e';
>                 break;
> +       case '"':
> +               to = '"';
> +               break;
>         default:
>                 return false;
>         }
> @@ -474,6 +477,7 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>   *             '\t' - horizontal tab
>   *             '\v' - vertical tab
>   *     %ESCAPE_SPECIAL:
> + *             '\"' - double quote
>   *             '\\' - backslash
>   *             '\a' - alert (BEL)
>   *             '\e' - escape
> diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
> index 2185d71704f0..437d8e6b7cb1 100644
> --- a/lib/test-string_helpers.c
> +++ b/lib/test-string_helpers.c
> @@ -140,13 +140,13 @@ static const struct test_string_2 escape0[] __initconst = {{
>  },{
>         .in = "\\h\\\"\a\e\\",
>         .s1 = {{
> -               .out = "\\\\h\\\\\"\\a\\e\\\\",
> +               .out = "\\\\h\\\\\\\"\\a\\e\\\\",
>                 .flags = ESCAPE_SPECIAL,
>         },{
> -               .out = "\\\\\\150\\\\\\042\\a\\e\\\\",
> +               .out = "\\\\\\150\\\\\\\"\\a\\e\\\\",
>                 .flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>         },{
> -               .out = "\\\\\\x68\\\\\\x22\\a\\e\\\\",
> +               .out = "\\\\\\x68\\\\\\\"\\a\\e\\\\",
>                 .flags = ESCAPE_SPECIAL | ESCAPE_HEX,
>         },{
>                 /* terminator */
> @@ -157,10 +157,10 @@ static const struct test_string_2 escape0[] __initconst = {{
>                 .out = "\eb \\C\007\"\x90\\r]",
>                 .flags = ESCAPE_SPACE,
>         },{
> -               .out = "\\eb \\\\C\\a\"\x90\r]",
> +               .out = "\\eb \\\\C\\a\\\"\x90\r]",
>                 .flags = ESCAPE_SPECIAL,
>         },{
> -               .out = "\\eb \\\\C\\a\"\x90\\r]",
> +               .out = "\\eb \\\\C\\a\\\"\x90\\r]",
>                 .flags = ESCAPE_SPACE | ESCAPE_SPECIAL,
>         },{
>                 .out = "\\033\\142\\040\\134\\103\\007\\042\\220\\015\\135",
> @@ -169,10 +169,10 @@ static const struct test_string_2 escape0[] __initconst = {{
>                 .out = "\\033\\142\\040\\134\\103\\007\\042\\220\\r\\135",
>                 .flags = ESCAPE_SPACE | ESCAPE_OCTAL,
>         },{
> -               .out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\015\\135",
> +               .out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\015\\135",
>                 .flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
>         },{
> -               .out = "\\e\\142\\040\\\\\\103\\a\\042\\220\\r\\135",
> +               .out = "\\e\\142\\040\\\\\\103\\a\\\"\\220\\r\\135",
>                 .flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_OCTAL,
>         },{
>                 .out = "\eb \\C\007\"\x90\r]",
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
