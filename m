Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2300F40B675
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhINSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:03:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC71C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:01:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y6so298745lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ib9hM4SdwqyHHEn/wkrupMf2QmzPr/LZkXrSoaMswps=;
        b=Xidz1rsc+T9svtmTJD7hvN6YJvyHBodIjNvg1pVxXgWpIQu9qZHaboKpNrR10ArmB9
         KciJDw3aX4E9V3B1SXCL6oD25Qzs6+gqzoIH6yXrLe8GTshqXeeBfT4oQVYvZwjqsJH0
         WznTWkD7Km8Gj4P5r+1XSzUHpgd7Xqj364k4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ib9hM4SdwqyHHEn/wkrupMf2QmzPr/LZkXrSoaMswps=;
        b=PpocKeWiTwnvb7Q6ptnrSQeYiA7ttBNimkiJdDpp/4WcVDHQr6dJZQuBF8Sd78RSQN
         DvuA1LTUxGjtyjkZn0tBKRUHpeKBoL7bWQ0ZzZTgLiJD38l5znTpN5cTiQ0fEr6si5Zc
         oEGJf8eOiiOFP1/dTDxR/8nuYtEpZ9em1xX+IobpMZeo7MqtRfGOXrYPC7M09ToX2scG
         8tcaK6L2h8YAbce94P2iMELOKNxunnZi15aKnZw8ZB+sGTCJkOjc/VW2AYh8/iLjx1xQ
         jGC3xJEU3WvfJ4LUf/5KU/0//o/iNdS6Kk2pd74U5ignHDbwCPYt9iOsO3NKJxbOO1VX
         Sn1g==
X-Gm-Message-State: AOAM533VNgZZkw67tt3IGaTFGFIxn2HKU49WqWQdiLofAFc34hACHmHa
        Tm5nWCUeWdraIatY0GfuNxMg4E4HVjK3dEzkqzI=
X-Google-Smtp-Source: ABdhPJypQU33uGIyyeMsNQOLk6KdDk1qMa2BYLjJ1zBRGcO3E9MYy0WoUuGu9Tm4n/a/jZwc6B2QGA==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr16977049lji.441.1631642509581;
        Tue, 14 Sep 2021 11:01:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 203sm1452803ljf.63.2021.09.14.11.01.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:01:48 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id f2so310852ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:01:48 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr17033299ljg.68.1631642507876;
 Tue, 14 Sep 2021 11:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home>
In-Reply-To: <20210914105620.677b90e5@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 11:01:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
Message-ID: <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 7:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> A couple of memory management fixes to the bootconfig code

These may be fixes, but they are too ugly to merit the tiny
theoretical leak fix.

All of these are just plain wrong:

> +static void *init_xbc_data_copy __initdata;
> +static phys_addr_t init_xbc_data_size __initdata;
> +               init_xbc_data_copy = copy;
> +               init_xbc_data_size = size + 1;
> +       memblock_free(__pa(init_xbc_data_copy), init_xbc_data_size);

because the xbc code already saves these as xbc_data/xbc_data_size and
that final free should just be done in xbc_destroy_all().

So this fix is pointlessly ugly to begin with.

But what I _really_ ended up reacting to was that

> +               memblock_free(__pa(copy), size + 1);

where that "copy" was allocated with

        copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);

so it should damn well be free'd without any crazy "__pa()" games.

This is a memblock interface bug, plain and simple.

Mike - this craziness needs to just be fixed. If memblock_alloc()
returns a virtual address, then memblock_free() should take one.

And if somebody has physical addresses because they aren't freeing
previously allocated resources, but because they are initializing the
memblock data from physical resources, then it shouldn't be called
"memblock_free()".

Alternatively, it should just _all_ be done in physaddr_t - that would
at least be consistent. But it would be *bad*.

Let's just get these interfaces fixed. It might be as simple as having
a "memblock_free_phys()" interface, and doing a search-and-replace
with coccinelle of

     memblock_free(__pa(xyz), .. -> memblock_free(xyz, ...
     memblock_free(other, .. -> memblock_free_phys(other, ..

and adding the (trivial) internal helper functions to memblock,
instead of making the atcual _users_ of memblock do insanely stupid
and confusing things.

Doing that automatic replacement might need an intermediate to avoid
the ambiguous case - first translate

     memblock_free(__pa(xyz), .. -> memblock_free_sane(xyz, ..

and then do any remaining

     memblock_free(xyz, .. -> memblock_free_phys(xyz, ..

and then when there are no remaining cases of 'memblock_free()' left,
do a final rename

     memblock_free_sane(.. -> memblock_free(..

but the actual commit can and should be just a single commit that just
fixes 'memblock_free()' to have sane interfaces.

Happily at least the type ends up making sure that we don't have
subtle mistakes (ie physaddr_t is an integer type, and a virtual
pointer is a pointer, so any missed conversions would cause nice
compile-time errors).

I hadn't noticed this insanity until now, but now that I do, I really
don't want to add to the ugliness for some unimportant theoretical
leak fix.

The memblock code has had enough subtleties that having inconsistent
and illogical basic interfaces is certainly not a good idea.

               Linus
