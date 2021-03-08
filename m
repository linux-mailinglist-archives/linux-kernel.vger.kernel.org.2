Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D595331091
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCHOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:14:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986B6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:14:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso1374343pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw2zAlnEvV8GmMv5rpZu0isYBOrALdBIALM778oYDbQ=;
        b=PVVo8+KwgkIH14fT6zZn7SWmQIG6hT4lQcWpMRyFkRHYymWycNwu1GmHW8VV1Rn+Ic
         pjG+NUM0FIOyCuPjuoxCixxmMoy01TmvG2szp96o6F1VmPbucm77SBAjUiMd8MnLnJQm
         OQxBvMZukbTKCSaEFzRKsATCWKgvQPZX1+djycAP86AB6RHVMqVUTHDkXsI135EY5mto
         ygdazUk1kuQT2XVPQJDBNdWaBqU8T/EXvs+x83qE+zOzhpXX9PyhA7e/w7fV1OH9iImH
         GIaA1x74J1U3vQJtwbIbZkyp+Qu+11cZEpRGVMbyGLeqN7DSCzq5Kp2hnQ8dkILChPlY
         r0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw2zAlnEvV8GmMv5rpZu0isYBOrALdBIALM778oYDbQ=;
        b=soFID7opmRLxHEnfpZk1qe3KoK2J7xg8aMOcaArQtB8dkHkE7RVbTOfG2CFoPKrLzm
         2ZllSVEmLaz8N+MzbF4Zonxm/7YDyuKPU1WABV6tzwNPLYN6zIL/cmVhnaSFPk+lbzI6
         9fahA06kDSrGamjMBc6m2VAFzsAryUVJJbwvDM8QuXJQg/pS52tJeg7F9AY5OHMAZugQ
         cM4rWmBx9qGpizT3CjuigqUyo3BEMnEnCGh88VxVOdZjAWlsnkyQBuJLCdwRmo4aw4CO
         7N0yQVk1dXTzeYWR8AD+CNugRvucSffrraYQwUGqPcKoEL9VTKzTbcZ2fT2/3cdOx0LP
         iHEQ==
X-Gm-Message-State: AOAM530j7shL4rOlhgO8cEeH7jytkug+qOjLw8IPyKUlstu9BiMnZEcO
        3crZR6d0hgE5X5awOCb/7BPJVVkX4sbLtqgfK/xNuQ==
X-Google-Smtp-Source: ABdhPJwQLOEsO6igg+U6iMFD+X/dVMrg/U1V1ChGDrskM8X1TXNS6EhiRPpXVDYrHGOap6Ggho8cp4rTMfIaRvHJ3fw=
X-Received: by 2002:a17:903:31ca:b029:e6:65f:ca87 with SMTP id
 v10-20020a17090331cab02900e6065fca87mr11507964ple.85.1615212872017; Mon, 08
 Mar 2021 06:14:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614989433.git.andreyknvl@google.com> <a7f1d687b0550182c7f5b4a47c277a61425af65f.1614989433.git.andreyknvl@google.com>
 <YEYMDn/9zQI8g+3o@elver.google.com>
In-Reply-To: <YEYMDn/9zQI8g+3o@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 8 Mar 2021 15:14:21 +0100
Message-ID: <CAAeHK+zGDDhpzHqBrKcYhY3UvDG8iXfkCBVQ-5Se0QyESpQ91Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] kasan, mm: integrate page_alloc init with HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 12:35 PM Marco Elver <elver@google.com> wrote:
>
> > -     kasan_free_nondeferred_pages(page, order, fpi_flags);
> > +     init = want_init_on_free();
> > +     if (init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>
> Doing the !IS_ENABLED(CONFIG_KASAN_HW_TAGS) check is awkward, and
> assumes internal knowledge of the KASAN implementation and how all
> current and future architectures that support HW_TAGS work.
>
> Could we instead add a static inline helper to <linux/kasan.h>, e.g.
> kasan_supports_init() or so?
>
> That way, these checks won't grow uncontrollable if a future
> architecture implements HW_TAGS but not init.

Good idea, I'll add a helper in v2.

> Hmm, KASAN certainly "supports" memory initialization always. So maybe
> "kasan_has_accelerated_init()" is more accurate?  I leave it to you to
> decide what the best option is.

Let's call it kasan_has_integrated_init().

Thanks!
