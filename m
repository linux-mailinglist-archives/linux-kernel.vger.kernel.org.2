Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC73B0643
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFVN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:57:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF559C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:55:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gt18so34638902ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtJ7IslezInr0IjO/y83W5WcZUNJEOAxkSrY2hYdtzo=;
        b=ouzNwjxRs/VrHBOHszXWY5PYOroSfuMEQLOgkPv2T2sBOAAqq1bbesJtm4/x4LeO51
         s0iC/H3jnz7pxYyEU9K2qYA2WiEhPA3Ie2IcjdFaCHe8U+Pn8B43G+c4QuwcGNmOnWzq
         79fytTdJ2RJp6CSJHX/AuhFHicasprVa7MVyTD6xUsasGN0aqGbfs5NX8gZ35EG40GnQ
         y/M98oBs7KeKKgfJ/UhqYPs8vkzUWK2OSsHn9HayOtQjKvQjYKMFKiSURfqYXfLTmsHj
         3W7LL56gEerLDVBr3/hzQVk6YwmqovsdPmu0pBNcnhjUFli5jk1XWnqJKVvNetqm4MvU
         HLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtJ7IslezInr0IjO/y83W5WcZUNJEOAxkSrY2hYdtzo=;
        b=oNKSDXh/mjj2IsQ77FbpAfQw8L9O4LOx2vEubzIXWXJdjnq39TM2cST0NcDlekchWP
         vlEftSAMbDAAB6maoLB/V0X9eEoBTyObNzmeB0o6GMkXgTswUEq6GdqN2zqLG8Vgzed3
         PYZfMZJThGXG1AMmNTANNKiGsTJ+DUz6/I5zPB6Pn+38esisKubzU/9ufiCv7jJAnzxe
         cuUK/J4K8OQC5FC9oE8jnhoBL5FsA17c2Aja92g3gbygIWJT9//6QhXpytn6Vg9bmvmc
         mSLus8tkLnP4Tm5NQbFBcTlFyMmhXp3/bOErl3AlnI6S8tJcLNZ7lTsifR/2U3/GxdtV
         PT9w==
X-Gm-Message-State: AOAM531wU0iFUGq5FRKlEOFqQMjq157Lv8GY+1nH+kK5wBB//FrYT6WX
        wu8ZvyGY5/SYgljJwZkPlDPi8J6KrLkyoSZwfE8=
X-Google-Smtp-Source: ABdhPJy9JElAxjoK8FcIuAfranbHc7RCHMPcqWtQgY9B1Es9IrHjC2++p6pEUqWueW0g9YbeuzEqNkP9tcB/MRGNCSM=
X-Received: by 2002:a17:906:17c4:: with SMTP id u4mr4217576eje.481.1624370109577;
 Tue, 22 Jun 2021 06:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Jun 2021 16:54:49 +0300
Message-ID: <CA+fCnZcSy6LqqhbYfiC8hn16+T640uw_rnUzNPg1zsvg_RwYzw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: add memory corruption identification
 support for hardware tag-based mode
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 2:48 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> Add memory corruption identification support for hardware tag-based
> mode. We store one old free pointer tag and free backtrace.

Please explain why only one.

> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  lib/Kconfig.kasan | 2 +-
>  mm/kasan/kasan.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 6f5d48832139..2cc25792bc2f 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -157,7 +157,7 @@ config KASAN_STACK
>
>  config KASAN_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
> -       depends on KASAN_SW_TAGS
> +       depends on KASAN_SW_TAGS || KASAN_HW_TAGS
>         help
>           This option enables best-effort identification of bug type
>           (use-after-free or out-of-bounds) at the cost of increased
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index b0fc9a1eb7e3..d6f982b8a84e 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,7 +153,7 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +#if defined(CONFIG_KASAN_TAGS_IDENTIFY) && defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
> --
> 2.18.0
>

Other than that:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
