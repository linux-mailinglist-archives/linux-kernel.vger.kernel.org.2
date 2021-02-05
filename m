Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B02311729
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBEXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBEOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CBC0611BC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:49:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l18so4013230pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d23/bHc5IAw+57pFfXazVH986BI0xYsnbVaaC5Mmtdw=;
        b=oWjE1+8QDE+rZiWqDDGKA7fq0kbSoR5pzMxXsMis6aLzIiGNv8Pjv0IDzjCZz40bOt
         NLXP8w1Z7TvTdemP4qtqZNnzNG/b/VlW/ChHTqMhO+EkCr6GjgJlOCxfQLMvgkS+6kpT
         IJdtmlT4TSlh7qnFaMtdla1u1l5fWormjjAyMcb+GSZR5HFXCWkT6C1a4eZtXWY1pRzI
         3bcNnRI7V9JpzfqYE1vLwyt7GhlxPO6gQq4+jm3h/aIs5CEhm8Vb9egtU0tLVNHTN7/r
         SCTiOo/0T20prGy37N6KZTqZdbvAOGYgTZ/m7iDRWi5u7yAbYArCw8SqHI/oYt5oz4b9
         dSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d23/bHc5IAw+57pFfXazVH986BI0xYsnbVaaC5Mmtdw=;
        b=Wx3Guw8fPj9mGGjzJJuXqmmL9RWe+LIhbZwLaRHeUgd9uHqHrvE+vHTBkMEqg2wBjJ
         uXV6BCNCir19fBKJeJU6C44psrfjlmU3tZ44slRRrEOaWUDYzAJRbNjHw1yFLAxFSAVW
         2RS+aOUjyPPZ9+Vwmtj9llMBqkcO2s6CWDbwL2HMg3MwjNfG5jIFILGADuCer9GFVZe7
         8Sl+cl8n7yyvap+T4Fgnvt761+IJxJjVXqVHEniF2DYJYazZ3SaTZ3YZ2MfH69bIbz38
         4HvN+1ZPBvh1+ow6l8NSIaDnpmwL00VxWaQLZ/Jnteq66fHgG4S6mgsym45j/LBmPpy4
         4+GQ==
X-Gm-Message-State: AOAM531EJVe0JLfD8xvTb+w3n/afpDtJwnhUUem+Q1SCCKtpf+zEAF8+
        MsRYOAbpfjDIrrPAAGjBef6TVsb9bjmb6wdXmMI2RMJRSPFWFw==
X-Google-Smtp-Source: ABdhPJxclJuAwBv6+C3AXNZAqBy+XjezEawT+aG9g2J0xC6r9Av9xLHomj5RYXHbffxGnIE7OrOl+UPZIBis4IoXG+k=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr4437121plp.57.1612540175353; Fri, 05 Feb
 2021 07:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-3-vincenzo.frascino@arm.com> <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
In-Reply-To: <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Feb 2021 16:49:23 +0100
Message-ID: <CAAeHK+wdPDZkUSu+q1zb=YWxVD68mXqde9c+gYB4bb=zCsvbZw@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] kasan: Add KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:04 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Sat, Jan 30, 2021 at 5:52 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > @@ -45,6 +52,9 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> >  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >  EXPORT_SYMBOL(kasan_flag_enabled);
> >
> > +/* Whether the asynchronous mode is enabled. */
> > +bool kasan_flag_async __ro_after_init;
>
> Just noticed that we need EXPORT_SYMBOL(kasan_flag_async) here.

Hi Vincenzo,

If you post a new version of this series, please include
EXPORT_SYMBOL(kasan_flag_async).

Thanks!

>
> There are also a few arm64 mte functions that need to be exported, but
> I've addressed that myself here:
>
> https://lore.kernel.org/linux-arm-kernel/cover.1612208222.git.andreyknvl@google.com/T/#m4746d3c410c3f6baddb726fc9ea9dd1496a4a788
