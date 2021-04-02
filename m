Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F83528ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhDBJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhDBJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:38:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D6C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:38:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f29so801188pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCYt8AyoLESpC6wcEtE5CllNvHeSvHW195OfYbQzzA0=;
        b=OLoCUBIJIt5VGQ3Wvhu+rs3rDbrwCUr3Mvq24JYcmyXBl+lgICsY98zNmsJX7m95V4
         AmYY7KAtHw63NvsBi0ksSAMueLw9ipOktRhmsdiCNPtBgZf5gymjSKmpZhRpN0TReI4M
         azYs2HFSaeItGRGWXzdpxUxABQ3myTngbNZ+9HhEFlsubLZNsqIAU2fRlsDTliLN5Rkz
         1QuUMu+y6trQoykF7D6C3pp6MOM7Q/E0Zt49lgnvNujDydXsUv7jbyK8q+YUpPIp8ZHe
         4ECJ8spVnR1STEifrdR3J3UI40q5BOx3mpagJuPSvxAgkZOujudUbYxA6SJw500ehK2x
         SP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCYt8AyoLESpC6wcEtE5CllNvHeSvHW195OfYbQzzA0=;
        b=kOsbc+szXMVaUb5ZvXEz47JY7RcBLNKlMeGeuVLQrsYccHUXOtkRz/LNH076srdMdU
         NLkQyaq3rJabcgM1rkGWLUXFErb/7zZKREO/w2nNTzcJbowEfggcnZycZ57sNAtrQN3/
         SC4zbin3WYmHUtH4/qHKD6RiTyR3t8oyLZy32QgLWVdK6gRYylEKeWsjCX6Sl6zHpIxC
         7dcMVkdGsKAIXqLxwX2sHhJmzs2DoZOazaYZ4GLJmm5dG3PN6bohNW4p1NtyByBjLJ0y
         hO5mzRDiB8zbF28BAOu1acMRu43vBDjS6zZwnzzIJphhtz9JDiDQpR4shyGvlFCzOCH9
         MtzA==
X-Gm-Message-State: AOAM533FFFBe6e/CCqz21RtzYEcF2+yEIxqNvxFhFqAwO89ZzVykDvqI
        57Jkz5CYRiDyoOE/02XK/sX8vs7SBWdl6RkiUL/51w==
X-Google-Smtp-Source: ABdhPJxuU4DZ10EV1TbNi6URByJ3kNd7ZsEQOL6TH6BdZr9sN1GV2yWW2N8hSiJGHsvrvdzzaezSPFwLRA2947Ypyyw=
X-Received: by 2002:aa7:9619:0:b029:1fa:ed79:b724 with SMTP id
 q25-20020aa796190000b02901faed79b724mr11348345pfg.38.1617356316475; Fri, 02
 Apr 2021 02:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210331085156.5028-1-glittao@gmail.com> <YGWPdFywfNUl4d3S@elver.google.com>
 <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
In-Reply-To: <CAGS_qxpWtNLJ7_i5pDYhiGq_Jy+oPPc+HpWjNTJKAPyvQf+gsQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 2 Apr 2021 02:38:25 -0700
Message-ID: <CAFd5g45h46ozAaDunBhxM-ianoo7_aVCK09o-9Otd5fBJU5L2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: add a KUnit test for SLUB debugging functionality
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Marco Elver <elver@google.com>, glittao@gmail.com, cl@linux.com,
        penberg@kernel.org, David Rientjes <rientjes@google.com>,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 12:04 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, Apr 1, 2021 at 2:16 AM 'Marco Elver' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
[...]
> >         #else
> >         static inline bool slab_add_kunit_errors(void) { return false; }
> >         #endif
> >
> > And anywhere you want to increase the error count, you'd call
> > slab_add_kunit_errors().
> >
> > Another benefit of this approach is that if KUnit is disabled, there is
> > zero overhead and no additional code generated (vs. the current
> > approach).
>
> The resource approach looks really good, but...
> You'd be picking up a dependency on
> https://lore.kernel.org/linux-kselftest/20210311152314.3814916-2-dlatypov@google.com/
> current->kunit_test will always be NULL unless CONFIG_KASAN=y &&
> CONFIG_KUNIT=y at the moment.
> My patch drops the CONFIG_KASAN requirement and opens it up to all tests.
>
> At the moment, it's just waiting another look over from Brendan or David.
> Any ETA on that, folks? :)

I just gave a "Reviewed-by" and sent it off to Shuah. Should be
available in 5.13.

Cheers
