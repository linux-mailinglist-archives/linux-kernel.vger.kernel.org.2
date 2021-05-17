Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B957C382432
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhEQGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:22:54 -0400
Received: from mail-vk1-f174.google.com ([209.85.221.174]:42760 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhEQGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:22:41 -0400
Received: by mail-vk1-f174.google.com with SMTP id m129so1126168vkh.9;
        Sun, 16 May 2021 23:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+soxiwcsp656/78/AvClx6ZPB3VDNbEc7o/vVgGMog4=;
        b=V36x0EG/9K79KlcUOvZSWqcQaXL/56M80rsEWlLHqJ39f5aIErDQAogW7ouxtpgDXO
         GBIy4YIYGQiE8lyKdYJLhcjXJixJahNR8jnP2ssORM4rrDAR11uQJJh5mnYBZfZLaGAq
         ISGn6a20+vd2CLa1WKIjYs9jYZ3fWX2M/OJwdZZPz+wDUJx5Mc9tSZcBhimQRycVz0E4
         f7JIm6O2dyziHQLI5sW4g2oN1yuglkBIbvvOZj7Do7MIja5rcR07UnIb6QsaRWmhex68
         XwN7bCtfH1mrOk5cJrnpc9TXy2EWIHWg9sAyP64iy7AWhyfcM3NI/VmZ+5hI1SjXwgJ7
         Uo7w==
X-Gm-Message-State: AOAM530rTagX5Zxye/HVaM2/3oAbYqKXpNRxZtoZACAyhsdiM7N5d/8O
        1IZbxMWjFpUQZ15cn7TqFqmEtA3hg7l5B1t0vmg=
X-Google-Smtp-Source: ABdhPJxqu67241VYbrxg5v7ZVCJWJgKvmEh9hQtt3sFTA/LiQZuzefbOW0dD0vuwF5zYW6osx9/cw/4rucqOcoEGcqg=
X-Received: by 2002:a1f:a388:: with SMTP id m130mr44908380vke.1.1621232484718;
 Sun, 16 May 2021 23:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210331093104.383705-1-geert+renesas@glider.be> <20210331093104.383705-4-geert+renesas@glider.be>
In-Reply-To: <20210331093104.383705-4-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 May 2021 08:21:12 +0200
Message-ID: <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] lib/vsprintf: Use pr_crit() instead of long fancy messages
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Embedded <linux-embedded@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:59 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> While long fancy messages have a higher probability of being seen than
> small messages, they may scroll of the screen fast, if visible at all,
> and may still be missed.  In addition, they increase boot time and
> kernel size.
>
> The correct mechanism to increase importance of a kernel message is not
> to draw fancy boxes with more text, but to shout louder, i.e. increase
> the message's reporting level.  Making sure the administrator of the
> system is aware of such a message is a system policy, and is the
> responsability of a user-space log daemon.
>
> Fix this by increasing the reporting level from KERN_WARNING to
> KERN_CRIT, and removing irrelevant text and graphics.
>
> This reduces kernel size by ca. 0.5 KiB.
>
> Fixes: 5ead723a20e0447b ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

No comments?
Unlike the cases handled by the other two patches in this series,
this one cannot be configured out.

Thanks!

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2193,20 +2193,9 @@ static int __init no_hash_pointers_enable(char *str)
>
>         no_hash_pointers = true;
>
> -       pr_warn("**********************************************************\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> -       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> -       pr_warn("** might reduce the security of your system.            **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("** If you see this message and you are not debugging    **\n");
> -       pr_warn("** the kernel, report this immediately to your system   **\n");
> -       pr_warn("** administrator!                                       **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -       pr_warn("**********************************************************\n");
> -
> +       pr_crit("This system shows unhashed kernel memory addresses\n");
> +       pr_crit("via the console, logs, and other interfaces. This\n");
> +       pr_crit("might reduce the security of your system.\n");
>         return 0;
>  }
>  early_param("no_hash_pointers", no_hash_pointers_enable);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
