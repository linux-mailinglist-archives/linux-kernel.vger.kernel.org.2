Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78132E3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEIho convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Mar 2021 03:37:44 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:44088 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCEIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:37:22 -0500
Received: by mail-ua1-f42.google.com with SMTP id a31so512673uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 00:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7zv3r/5nAW4SKt/gk+0/eFOEnDTQYyH1IAk/jHyqg5U=;
        b=E2ras17/18QkByFw7b7glvbZozCJVB4mxooN0+YTLNHgMwzO1rO2M5nV3bJjZ6NYHT
         UdYzQ02QhkTiOm826z3sQrS73D9BwvBdF9p9GbFNsswWjfi+9AVjcCM+sWSC6rkYL5MK
         yqSlIDaMSccRLZFLOI+qbYaHvfq/P/ivgBWqfvGVGhtbqRbSK+9tGHtv+pcNth1i/7SH
         ohgRnTo5rHiWJGQ9mUdI5rBnIh4wgNNSV7lUKmV4OznwRBcdmGA0KWY1MSPyq7BfTRjt
         BskcikvrMd/dgZuHFtDw08JKpB2BjHGfH/7CYX9kdfXpeUBiqK6E8Qc2vMGpzeps1JVO
         4c6A==
X-Gm-Message-State: AOAM532JJy6W64uuKKA4ytXWhi0X/gvDLfqC0Eo3wgyKoCtC7LsB4486
        g130tVquIa/Gw+pH2FrULPfTYm0Nwy8QOf8EGtjBhKcE
X-Google-Smtp-Source: ABdhPJy9MILHLJ+5toJvVLImvyRtboqHCRqxcd4t70AtkDTc8Byp/YJg3KWM/j4M09oO03l8rWSoBlTdSx4LSEjEJ9k=
X-Received: by 2002:a9f:35a1:: with SMTP id t30mr5016837uad.106.1614933441427;
 Fri, 05 Mar 2021 00:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20210223104957.2209219-1-geert@linux-m68k.org>
In-Reply-To: <20210223104957.2209219-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Mar 2021 09:37:10 +0100
Message-ID: <CAMuHMdV-HL0RvE9o70N_QZk93avxi5+7zxagEFhK=DyPjwCsGQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix virt_addr_valid() W=1 compiler warnings
To:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> If CONFIG_DEBUG_SG=y, and CONFIG_MMU=y:
>
>     include/linux/scatterlist.h: In function ‘sg_set_buf’:
>     arch/m68k/include/asm/page_mm.h:174:49: warning: ordered comparison of pointer with null pointer [-Wextra]
>       174 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
>           |                                                 ^~
>
> or CONFIG_MMU=n:
>
>     include/linux/scatterlist.h: In function ‘sg_set_buf’:
>     arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
>        33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
>           |                                                  ^~
>
> Fix this by doing the comparison in the "unsigned long" instead of the
> "void *" domain.
>
> Note that for now this is only seen when compiling btrfs, due to commit
> e9aa7c285d20a69c ("btrfs: enable W=1 checks for btrfs"), but as people
> are doing more W=1 compile testing, it will start to show up elsewhere,
> too.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Probably we want this as a fix for v5.12, to avoid the build bots
> nagging about it all the time?
>
>  arch/m68k/include/asm/page_mm.h | 2 +-
>  arch/m68k/include/asm/page_no.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
> index 7f5912af2a52ea0a..9b1672f9b2e22cdf 100644
> --- a/arch/m68k/include/asm/page_mm.h
> +++ b/arch/m68k/include/asm/page_mm.h
> @@ -171,7 +171,7 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
>  #include <asm-generic/memory_model.h>
>  #endif
>
> -#define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
> +#define virt_addr_valid(kaddr) ((unsigned long)(kaddr) >= PAGE_OFFSET && ((unsigned long)kaddr) < (unsigned long)high_memory)

While preparing the pull request, I noticed I misplaced the braces in
the second part.
Will send a v2...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
