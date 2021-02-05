Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB983311013
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhBEQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhBEQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:52:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:33:53 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m22so8930080ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2QQGa7WmUtOnh1lnM8t/aGQgM70oTQkAKJTNVCw1J0=;
        b=oh+oZFzjEuM+WbroVeB3HQV7hp2UCvADxOpOuw/cUcJTqpwumRgyw3gbB++TWQaGwZ
         e5VWAU63IaiI8ZtEQsfv6l0CJ+PBEKZSJnFumrGK5urxe7vi93WBugqZhQHtBKJf0Wcl
         a22kxN8KCmc3cuM9+Br4GjvzGhleotknV3rdlcKMFEGwSnVu+p9X4eQXT5jYyFA7o9w0
         LgfPIQRHj28tLA4ugPIpQr/y6c1IZxsVkAMGY0MkdMnGSJyPBS18qUQlrDt+QRXHvHnG
         XhU2Ll4ZTjCmZhGPk7wuKDQWC9frJH7BTz8xW6GwqO5Q0h8mCNegD/NHVVUu1pW/l3Ju
         Dwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2QQGa7WmUtOnh1lnM8t/aGQgM70oTQkAKJTNVCw1J0=;
        b=HeO63FHtd2jLwS4ueUSfFHxI5tlTBQgsas5K++gnAzAbXoqagKmDHIXB6LpuEWQECl
         9scr9LCAi5v/5fUb8NpaSwM50ofiA16MmcUaSpVzR9BWfni+X0GUEVvbOm3oA9xjHO42
         5qDHKXMB6KmNT864bbQMGUIAVr2qDa6jI72qlWNy2hT9glpdHoxT2CTRPh5k/kt0MXnO
         mkQ23+BtzbvkZo9eBLoyy7O3Ul1g2ux3p3kHAW3sDayZvxg82WFMVL+Cqf7GgeC2GLGz
         Or6p7bu33s5c2zVngqkBgV/rs0Z7aYVQYXXBpeh/U9epfvWyzUENmRYb0W7UdunrqbfQ
         eejQ==
X-Gm-Message-State: AOAM533HLL/tvCQGQoRyXbw1S1kdNUyuMGtKkq5BKgT1qrfrLlx6/7Fw
        f6Jht5hlPnLYW2/XYkfEmhfEkLT8q9iojYanZUyc4w==
X-Google-Smtp-Source: ABdhPJywatE7yc2UsD9fVqwCCiumk5bBJtELN+1itqTf5Df3lBAQZy/8ldu4LxetnWwOMwoKCP051SKEcDaqaI5LnbI=
X-Received: by 2002:a2e:1519:: with SMTP id s25mr3379949ljd.495.1612550032109;
 Fri, 05 Feb 2021 10:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20201230154104.522605-1-arnd@kernel.org>
In-Reply-To: <20201230154104.522605-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 10:33:39 -0800
Message-ID: <CAKwvOdkSyP-eZT=GGpg7z_C5z0GUsfLRHN2HOn8JgoTT_XrfGA@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 7:41 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang cannt evaluate this function argument at compile time
> when the function is not inlined, which leads to a link
> time failure:
>
> ld.lld: error: undefined symbol: __compiletime_assert_414
> >>> referenced by mremap.c
> >>>               mremap.o:(get_extent) in archive mm/built-in.a
>
> Mark the function as __always_inline to avoid it.
>
> Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  mm/mremap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c5590afe7165..1cb464a07184 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -336,8 +336,9 @@ enum pgt_entry {
>   * valid. Else returns a smaller extent bounded by the end of the source and
>   * destination pgt_entry.
>   */
> -static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
> -                       unsigned long old_end, unsigned long new_addr)
> +static __always_inline unsigned long get_extent(enum pgt_entry entry,
> +                       unsigned long old_addr, unsigned long old_end,
> +                       unsigned long new_addr)
>  {
>         unsigned long next, extent, mask, size;
>
> --
> 2.29.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201230154104.522605-1-arnd%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
