Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDA3BB9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGEJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:04:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 02:01:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so17683605oti.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi5VhRb63QYKLkBHNkU2ZBerPCcgeUsVkfNp8aUI108=;
        b=EScxNMFd9uw0mfB5IMHJEQ7Vh+bzQe/gdYLsmhyz37yTL3xZJyjL0ZL1i9UY1Ig8dg
         HOcx3WmLqKYJCAUHCoLewkUm4f52YDNAtUB60dkDTeYcO8a20M8hWaOUNfBOfNRLZpTI
         /dzQzzulNCoJPxvU/j6IFVM2I4393glUrJspiO9ZRL/O0/+kTJe1kuIS3znCT1JaktA6
         nvH1RTRfCCCI3KsjknUQI0bE8/vDkd1mRA+tO5qTv5z8iMf96ztPwpHlu4QUKXBg0+3j
         EfWkEMgIfQVU2mzF0OVkP5xoanSUpF7kXIEbIrNtbTZtlo7VImybLsRh4dVQvh/55oWS
         J4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi5VhRb63QYKLkBHNkU2ZBerPCcgeUsVkfNp8aUI108=;
        b=k7tT4NXh87M+vZJpRy57ourdav93c7J8rCI8Y9JVQTWZK3YZ3tbrnp0H9XP99Sb+vi
         C60Fepr+ZnLuggMp4CEywAkPeXG4ZfH/zATJVB+Jz70fHOkdOnYPjg/8LkflSVx6EX6A
         RLW/Coed2PE7hiF/ai3YvM9tngPvboBBMUH4vC/ggTigIQuvmkdZQ09pvD+kEH3VGrvT
         H8+8fsx7ZyYeb2mvCktHgxc/ABHtUZmiigIrTDYIan/VwAED9R0Esq8qKNWsknwIigod
         qN1a8Ij0ZbXCyPeWUlqMFxUoVNqKt0UO0SfDZchS4T7NJATC36bLlMJYBiyuCBqLKTib
         9XJw==
X-Gm-Message-State: AOAM531Hl2k1dLQBr0BPDzwD1kZufDepZxlPFBvDuDBd6PL/z4JC5fEC
        YH5TY3153RyWSMGum+XSxcWTPRak+TZcuJ4NM+7AWw==
X-Google-Smtp-Source: ABdhPJxLPFb6DtseNVjohvKekq8AGDXIypTgO51hjfWHG6OWJnjESD2yylsiZfBR4iUP7DLazpIAk2fl2E4+RaDiEiM=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr10450183oti.251.1625475715433;
 Mon, 05 Jul 2021 02:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210705072716.2125074-1-elver@google.com> <CAHp75VeRosmsAdCD7W7o9upb+G-de-rwhjCnPtTra2FToEmytg@mail.gmail.com>
In-Reply-To: <CAHp75VeRosmsAdCD7W7o9upb+G-de-rwhjCnPtTra2FToEmytg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Jul 2021 11:01:44 +0200
Message-ID: <CANpmjNMZTe1Vs6Xx9bC9+azeRWJc7JvT-G4O7aQAq--wAp7f=g@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix build by including kernel.h
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, pcc@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 10:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 5, 2021 at 10:28 AM Marco Elver <elver@google.com> wrote:
> > The <linux/kasan.h> header relies on _RET_IP_ being defined, and had
> > been receiving that definition via inclusion of bug.h which includes
> > kernel.h. However, since f39650de687e that is no longer the case and get
> > the following build error when building CONFIG_KASAN_HW_TAGS on arm64:
> >
> >   In file included from arch/arm64/mm/kasan_init.c:10:
> >   ./include/linux/kasan.h: In function 'kasan_slab_free':
> >   ./include/linux/kasan.h:230:39: error: '_RET_IP_' undeclared (first use in this function)
> >     230 |   return __kasan_slab_free(s, object, _RET_IP_, init);
> >
> > Fix it by including kernel.h from kasan.h.
>
> ...which I would like to avoid in the long term, but for now it's
> probably the best quick fix, otherwise it will require the real split
> of _RET_IP or at least rethinking its location.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.org>
> Thanks!

Thanks!

> > Fixes: f39650de687e ("kernel.h: split out panic and oops helpers")
>
> P.S. I have tested the initial patch against full build of x86_64, and
> it was long time available for different CIs/build bots, none
> complained so far.

It only manifests on arm64 when using CONFIG_KASAN_HW_TAGS mode
(requires Arm64 MTE extensions). The other 2 modes include
<linux/pgtable.h> in kasan.h, and that seems to include kernel.h
somewhere. The HW_TAGS mode, however, doesn't receive -next testing by
a CI system AFAIK, so this was missed because it's not yet used by
many (I'd expect that to change when CPUs with MTE are more
widespread).

Thanks,
-- Marco
