Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B939F3A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFHKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhFHKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:39:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 119A961249
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623148637;
        bh=nG2bDkIu2f+k3MNm7DmcSzWJPEcFqC2xDwZ8VuXoHa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LM/rwf5yD+3i7t8Io/gPX9E6eaemMVn1xipqnwFa9C1sC2WHYpj6WTeOSIQFWcG9c
         10ETSSITWHBpB+t1HevBnt8N1dDpGJUqRDhfJa8qwNm2atJqTgjTP0jdFsYlWh6BFm
         xUnaVKNhQLVYXjKh7Y48NiC5jL+3ITFgbYhhNwd9dsJ3YMOZQL6nzO/rOhz9t2hQID
         e6B0rMjDx0XSVopgRjHvLiWoWXZU57MSf2Z7AemOVcWa7eFo98Nt2a2GQ2C9NgJF32
         H3XPBhVXBzmzFCZ4CeIEgync+OUXlUU/0KcMv8wciqcaHIhLROiJ8PlXuJZZJDdyVI
         fqLpsA75JVicw==
Received: by mail-oi1-f172.google.com with SMTP id r17so10822858oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:37:17 -0700 (PDT)
X-Gm-Message-State: AOAM532EsPRBmU4e0RRe+m429LO8Bn042I9MwXLhhRo874Jdadmd6NtE
        kq/cScBon7MJHy7Nkb22/Bc0QldwQKP7PIII6Lk=
X-Google-Smtp-Source: ABdhPJwp7UbgiRDft81CGLmgoGRJl5zIqAjqK74wvt8Z/h74hjaAAXoKDalWepxfvydtWrYOiE8XvQH/fKvKTxmuMQY=
X-Received: by 2002:aca:4343:: with SMTP id q64mr2320610oia.33.1623148636415;
 Tue, 08 Jun 2021 03:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <YL9HxEc/l0yrl5o8@hirez.programming.kicks-ass.net>
In-Reply-To: <YL9HxEc/l0yrl5o8@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 8 Jun 2021 12:37:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFn7u5Mo2L-OxfTyNsfN0_Wkaa0U3Riw5PmfyCBYY_uNg@mail.gmail.com>
Message-ID: <CAMj1kXFn7u5Mo2L-OxfTyNsfN0_Wkaa0U3Riw5PmfyCBYY_uNg@mail.gmail.com>
Subject: Re: [PATCH] recordmcount: Correct st_shndx handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 at 12:34, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> One should only use st_shndx when >SHN_UNDEF and <SHN_LORESERVE. When
> SHN_XINDEX, then use .symtab_shndx. Otherwise use 0.
>
> This handles the case: st_shndx >= SHN_LORESERVE && st_shndx != SHN_XINDEX.
>
> Reported-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  scripts/recordmcount.h |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -194,13 +194,18 @@ static unsigned int get_symindex(Elf_Sym
>         unsigned long offset;
>         int index;
>
> -       if (sym->st_shndx != SHN_XINDEX)
> +       if (sym->st_shndx > SHN_UNDEF &&
> +           sym->st_shndx < SHN_LORESERVE)
>                 return w2(sym->st_shndx);
>
> -       offset = (unsigned long)sym - (unsigned long)symtab;
> -       index = offset / sizeof(*sym);
> +       if (sym->st_shndx == SHN_XINDEX) {
> +               offset = (unsigned long)sym - (unsigned long)symtab;
> +               index = offset / sizeof(*sym);
>
> -       return w(symtab_shndx[index]);
> +               return w(symtab_shndx[index]);
> +       }
> +
> +       return 0;
>  }
>
>  static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
