Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9F3BED03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhGGR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:28:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B633C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:26:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ga42so4503574ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEEWx+Agfci6msVOCtYXN5NDbieVyI/f3RzczKPLAFU=;
        b=inZbLvGxVf98FTFjF604VAc9h6LIwYGerIC20fPdGfRlHRphgzkCwPYgZOSrcHr0i5
         O93C6SkdIyxWevCOcuFqJmCq2LJBjjaOdc7bqEtmTKKjW8PrngSZozTJvcI44sEskyGy
         9r34zyULZ8nSh8rvxMBc/v888UUHVPT6KcYNzF2qsuptvFXn6sIT9Ohi0Rwpxhz4wO8s
         LnbuyXM3BCYzXnSOONQAYsP/5LBm16dTl51q0tM/mpfIXgBwPOrTMGaFpkMBDLYcWVjV
         L4Eby3RS7EXSE6HAdTc3j/DBFTrQ16XkMDFDc6MqgwZgU1AjFUQpl9QioPCiafb+QdX0
         qYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEEWx+Agfci6msVOCtYXN5NDbieVyI/f3RzczKPLAFU=;
        b=KaHOLGW/EEsTjo09ILQpysHr7QV5pCQvoyKYMCouQm3n68siJej/vtx0SYPJdgB7PL
         A7b5mYQZzlpx+aw/ur1lWTMgDPjmfn7pNwlnf1wtE9aBV9mrBpufIwbIcPAcrT2JB0Cw
         Z3gRCQggATWbN9NfBG3mMOiVjaeNgxl3aw2Oq9RmMpDmU1HpprUt2UUsa+/CUXDB9T/4
         AICKE7Ntu84D3M+71iqB76GYMs8z0II7GPvjfV6/5Wu8e0wbzrjPDKQpxeTLrGmbsKTc
         YrxFo4zyNb5kznJVQDvYf8MYZGDOssUKIX3YfYbCVa9QhZG63t9UN08H5Lp8lDVJQ1dj
         QwdA==
X-Gm-Message-State: AOAM5313FzHcBZeCEG5myYWC4Gh3M9Jj4x8HhrbSqarsr7zhJR+dzHQQ
        cMfuXFYF9ty+C6bKgPr/XNc45gtNYjb5yb+X8q4=
X-Google-Smtp-Source: ABdhPJxw1Jhg9j+lPF+XGBUe2mopy0bQo5zSumCrBkebSru5fpRDg9IVmCv6iRtxuosl+CJo4B1qZz58jvl4aDESZXM=
X-Received: by 2002:a17:906:c148:: with SMTP id dp8mr24709133ejc.507.1625678761411;
 Wed, 07 Jul 2021 10:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210707161614.13001-1-rdunlap@infradead.org>
In-Reply-To: <20210707161614.13001-1-rdunlap@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Jul 2021 10:25:49 -0700
Message-ID: <CAHbLzkrux+MUof_d-6OmuEYJ-V1k4V_3BY45HafjLoN_9TRQ8g@mail.gmail.com>
Subject: Re: [PATCH] mm: try_to_unmap() is now void
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 9:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix the "CONFIG_MMU is not set" case of converting
> try_to_unmap() from bool to void.
> (as seen on m68k/coldfire)
>
> In file included from ../mm/vmscan.c:33:
> ../mm/vmscan.c: In function 'shrink_page_list':
> ../include/linux/rmap.h:294:34: warning: statement with no effect [-Wunused-value]
>   294 | #define try_to_unmap(page, refs) false
>       |                                  ^~~~~
> ../mm/vmscan.c:1508:4: note: in expansion of macro 'try_to_unmap'
>  1508 |    try_to_unmap(page, flags);
>       |    ^~~~~~~~~~~~
>

Thanks for the patch. hch sent a similar patch
(https://lore.kernel.org/linux-mm/20210705053944.885828-1-hch@lst.de/)
and it has been in -mm tree.

> Fixes: 1fb08ac63bee ("mm: rmap: make try_to_unmap() void function")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: uclinux-dev@uclinux.org
> ---
> v2: add linux-mm m.l.
>     add M68K/Coldfire Cc's
>     change to static inline function.
>
>  include/linux/rmap.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- linux-next-20210701.orig/include/linux/rmap.h
> +++ linux-next-20210701/include/linux/rmap.h
> @@ -291,7 +291,8 @@ static inline int page_referenced(struct
>         return 0;
>  }
>
> -#define try_to_unmap(page, refs) false
> +static inline void try_to_unmap(struct page *page, enum ttu_flags flags)
> +{}
>
>  static inline int page_mkclean(struct page *page)
>  {
