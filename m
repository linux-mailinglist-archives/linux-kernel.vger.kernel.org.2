Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177BB31F0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBRU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:27:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:26:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fy5so2027868pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC4n6p0kCS6da68jsD6jAKKzKuFPDfyocm7j6MYSTS8=;
        b=uInv/ZqoBJmasKXFM/O8yXdM4LTRC1zztGi57d3m+qWoPYlp4vepNpjPUOLwPS3+GY
         2l0ltb4aK3RgZ53X5mpdYs7V5ViAR49cUI65Za/4iILIlfhMvA2gQbpDSwhDplVFR+bD
         j93/IqG09Yw8LsIVnG5WotNR+D4e3gmA7GMbYdauLrjfy1KG8rrLV8j4FaKqK76uW+b2
         hAV4oQKw5d7iiK2A1s8qlr3tgO8yehsx3m8QdqY5brt3gCttkX/eTvEV3pGaVye/z5P8
         5pvw96XJr6z63Wdrb3VUBILPWqQWZ2ZAUqZj4jVqVo2202J/Mvse/lpKK5MYb2UKFPOe
         XK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC4n6p0kCS6da68jsD6jAKKzKuFPDfyocm7j6MYSTS8=;
        b=Bj12k78KIPf0OLaZPRdkwgiSyLKyFgz4mUhhxtX67NH/rLT7nnjMoU9DhAkyk/rWL1
         cYA5lBiODvTJayVkKeZLWfKi8MsG5PEAD334u/h0NvFUYyDmOhYhnH51imQ0eIFIsmiG
         0huNeR020Z9zoCfGKqg6U+p3XeWJB0XyIYt/biP6/t4ZAvc6/s16oEAKkuDbP1P17x9e
         MjHylGTbuHAYbcaRBMxPqM4KWmYC0yarMJaSVVu9diJF0hCyCBlhsHiHxJPF7xvtm4rj
         2F3pcGL2akM9HX/1TpBAQIt9CqQa7tHORrDi3t4zdcSLVSzujVs89QNZmxxk6aqxjL4p
         sRCA==
X-Gm-Message-State: AOAM531YZboVTK2of5EMR05cY7CDcxwyjr572zJ/svPWyqf6uDkCh6PH
        WnwCYXy97rWI6+uPTB3OEVNmbXo8LGFrCkvUuKIkQQ==
X-Google-Smtp-Source: ABdhPJxXYZ8X96dHztKkDqT+MVkht4oVMUav1kzWZU9nbaVtab3gCQiGMxFpmDM7RLj+0nCgOdO31NBcKYPsmKtvr/Q=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr5575629pjb.166.1613680008214;
 Thu, 18 Feb 2021 12:26:48 -0800 (PST)
MIME-Version: 1.0
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
 <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com> <CAAeHK+x2OwXXR-ci9Z+g=O6ZivM+LegxwkrpTqJLy2AZ9iW7-g@mail.gmail.com>
 <509c1c80-bb2c-0c5c-ffa3-939ca40d2646@redhat.com>
In-Reply-To: <509c1c80-bb2c-0c5c-ffa3-939ca40d2646@redhat.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Feb 2021 21:26:36 +0100
Message-ID: <CAAeHK+yuvaYxjbfPwEeeh3mMa6_1hg=5LnjogxT2Vb1a-yiOmw@mail.gmail.com>
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 8:46 PM David Hildenbrand <david@redhat.com> wrote:
>
> > 1. For KASAN_GENERIC: leave everything as is to be able to detect
> > these boot-time bugs.
> >
> > 2. For KASAN_SW_TAGS: remove boot-time poisoning via
> > kasan_free_pages(), but use the "invalid" tag as the default shadow
> > value. The end result should be the same: bad accesses will be
> > detected. For unallocated memory as it has the default "invalid" tag,
> > and for allocated memory as it's poisoned properly when
> > allocated/freed.
> >
> > 3. For KASAN_HW_TAGS: just remove boot-time poisoning via
> > kasan_free_pages(). As the memory tags have a random unspecified
> > value, we'll still have a 15/16 chance to detect a memory corruption.
> >
> > This also makes sense from the performance perspective: KASAN_GENERIC
> > isn't meant to be running in production, so having a larger perf
> > impact is acceptable. The other two modes will be faster.
>
> Sounds in principle sane to me.

I'll post a v2 soon, thanks!

> Side note: I am not sure if anybody runs KASAN in production. Memory is
> expensive. Feel free to prove me wrong, I'd be very interest in actual
> users.

We run KASAN_SW_TAGS on some dogfood testing devices, and
KASAN_HW_TAGS is being developed with the goal to be running in
production.
