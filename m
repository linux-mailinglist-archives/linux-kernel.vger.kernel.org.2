Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2676B33262E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCINKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCINJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:09:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:09:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so5990265pfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbY3FA8sDFV7e3j6jkZbThLGcOzdkl8VfF99h6lt0u4=;
        b=l11KSv0zg+2YJuuDbZPziDASpY94KOCCb1Ju/OdwxwdDJOFNUrF3T2pJT9hadUG0Mm
         TrDDsIuLmkJCtcA+Bl1yt7BYP21O6asGSIfID4JKBT9L/JVrJDuyeDoEXCKVlnRfBped
         lFMFzepHhKeAYaKHYbogkMAM6ZUoVTpql6DdIPgTZNjN+mkjOWyN5kuP+i8fUt2mKEKv
         sF733SdATvAd8DAl3pzDFVygPsnqjdsDrytz2hGN0CnBC//L5GBhnA56v/xvho1VOeSg
         sWhjWN9DcW3Fg4dhW/7wFIH5dUSDbSNDoMWSSL7Wa90KeRJzVKDhxXurH+c37xGTv0K8
         1qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbY3FA8sDFV7e3j6jkZbThLGcOzdkl8VfF99h6lt0u4=;
        b=sDBWRt1ZgMMTsyZgUX7N3WwKjGXnXtAJcnloX2c8j26/6uICa6ezOO2o//rnde0x35
         VyKhzmpQQrFEPFaekSKMDKEWcIYmR3+QWZ8GYldIuyhNcVVW3CKD6dbKXTkvV+MjDOo9
         ZFn3aKu7DXcudY6I9dHeYT6Go9YXWBCZ0wi0oCaz+/uqWwSyDYDkQGNR4ewvhtuiQWLF
         WLUP0DQeuNZ8CpK2PGOi6x/P9h/1UeJQE6Av8hnuKOn0vsUeUzYIBSkOr1J/71x0LSc7
         mSVZNYyWI2kp1bHlIz0PrQEvcg61eWdBryEmqsWFVkrnapgIg20kcRPgOs3XFs7iijaf
         neUw==
X-Gm-Message-State: AOAM532Z1pe/GTAsvjPC33PoOwur83Dm+aKbPJCAPB9Q3S3oYvJhYM+v
        +q2I/YC6nzyy/a+HZ2gzYKltkcWB+6jf9dLAQxt71g==
X-Google-Smtp-Source: ABdhPJygcj+LM4wMSd3XhfXC3Q2AAC770v3u6KN+vIc/41bqqdgwzMKkgzGsNy2LWb689JQTvYOzzXm62FKwGegdBzo=
X-Received: by 2002:a63:455d:: with SMTP id u29mr24462220pgk.286.1615295372295;
 Tue, 09 Mar 2021 05:09:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615218180.git.andreyknvl@google.com> <755161094eac5b0fc15273d609c78a459d4d07b9.1615218180.git.andreyknvl@google.com>
 <20210308165847.GF15644@arm.com>
In-Reply-To: <20210308165847.GF15644@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Mar 2021 14:09:21 +0100
Message-ID: <CAAeHK+yaHufdycvawHAQ-Lt9GHKrGkzKkdJnTA3qN1MTtwiS5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: kasan: allow to init memory when setting tags
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

On Mon, Mar 8, 2021 at 5:58 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Mar 08, 2021 at 04:55:14PM +0100, Andrey Konovalov wrote:
> > @@ -68,10 +69,16 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >                * 'asm volatile' is required to prevent the compiler to move
> >                * the statement outside of the loop.
> >                */
> > -             asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> > -                          :
> > -                          : "r" (curr)
> > -                          : "memory");
> > +             if (init)
> > +                     asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
> > +                                  :
> > +                                  : "r" (curr)
> > +                                  : "memory");
> > +             else
> > +                     asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> > +                                  :
> > +                                  : "r" (curr)
> > +                                  : "memory");
> >
> >               curr += MTE_GRANULE_SIZE;
> >       } while (curr != end);
>
> Is 'init' always a built-in constant here? If not, checking it once
> outside the loop may be better (or check the code generation, maybe the
> compiler is smart enough).

I think it's worth moving the init check outside the loop anyway. Will do in v3.

Thanks!
