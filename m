Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB12389713
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhESTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhESTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:54:12 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339ECC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:52:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j12so2316110vsq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVSoUhFkNVU1wGDCrOEIUWeMZbbqgNel6ArZ5B6BHME=;
        b=j02T5iH/g5OOJT+qVHaMYNg3RoPC1IDqKx39RRzdSiwkV1p59kLzicfMf6q5Ei2GJI
         cVyPAoDWT1w6RFW2J6NWxdN8fAJjbiiaq3kMjni9oaKat7Y8FDAbqimnVqBHT+Xtac4n
         AQryv0hNLkHLrfYbVs1hTrFgix/eqx9ivJkzd40LM+d8piUt8bXvPz6r6dMOC5JADamA
         Vk4+3D8bpwPKYXUUp+SR2ORtN++HlijTUgAPbA2elleeVyR5rQ63RCfGPBgKo7e9Z/yV
         AjOob1HpwEg/7CE2TxmKsqZZrpy1yaEJFGUczUDXQknDSWjgllEz17zCunoKwpCUFhaC
         BPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVSoUhFkNVU1wGDCrOEIUWeMZbbqgNel6ArZ5B6BHME=;
        b=Lr9qxwW7o/1OPDfMx27+FgwRQ71Ok//TY98xYpJtyp/nrvo4LyIFtxU7R4iY6tn4kP
         mHYZmnJzsFlDQlj6lEPgFJ25+YeJgxq8XVDd5EUC/GmmkLkNVv59LcAzSkUFq6Ao2ozS
         Y8VnxFpCTnC1Ra94256Ze8qslZKGH1KqZvo6iCqyYXLytJbVTUKFh3qgn2KfnYhBDQSk
         qMMc5d9UiDnG/LY+raP5+s4DYzqeczs656JInB0JkzyVxvxMOjduUP1V9Z3M/vkSHiR4
         RqYw6kHd+L8P4P06F9liIb5q9UA2Zevng3miWNt+ubwDmrFxQfgflODQnZ43x9Sbq0yf
         DaSw==
X-Gm-Message-State: AOAM532KOxL/ZpxmRPihDdDefy/aPFleNFV6uQ1BcNnSHEIFmCY5Gsh1
        BYrisZoXdJpEFcfRgnPaVIBQOpQvGx7PhbcJaW7V8Q==
X-Google-Smtp-Source: ABdhPJxxoWS3DTZv/NUY1sMiill0r2SxFo+/QHsrv0FtFmIaOP1OH4+BDNxiNuZytI/FAQXMJfYgTt07UaJhe43EgaI=
X-Received: by 2002:a05:6102:7d8:: with SMTP id y24mr935834vsg.2.1621453968723;
 Wed, 19 May 2021 12:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210517235546.3038875-1-eugenis@google.com> <20210518174439.GA28491@arm.com>
 <CAMn1gO5TmJZ4M4EyQ60VMc2-acUZSYkaB9M0C9kOv_dXQe54Ug@mail.gmail.com> <20210519181225.GF21619@arm.com>
In-Reply-To: <20210519181225.GF21619@arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Wed, 19 May 2021 12:52:36 -0700
Message-ID: <CAFKCwrjH1FEKqeQyKxXacQVk_034NCtsF+rAwTvb4jZwK7a+nA@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: speed up mte_set_mem_tag_range
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:13 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, May 18, 2021 at 11:11:52AM -0700, Peter Collingbourne wrote:
> > On Tue, May 18, 2021 at 10:44 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > If we want to get the best performance out of this, we should look at
> > > the memset implementation and do something similar. In principle it's
> > > not that far from a memzero, though depending on the microarchitecture
> > > it may behave slightly differently.
> >
> > For Scudo I compared our storeTags implementation linked above against
> > __mtag_tag_zero_region from the arm-optimized-routines repository
> > (which I think is basically an improved version of that memset
> > implementation rewritten to use STG and DC GZVA), and our
> > implementation performed better on the hardware that we have access
> > to.
>
> That's the advantage of having hardware early ;).
>
> > > Anyway, before that I wonder if we wrote all this in C + inline asm
> > > (three while loops or maybe two and some goto), what's the performance
> > > difference? It has the advantage of being easier to maintain even if we
> > > used some C macros to generate gva/gzva variants.
> >
> > I'm not sure I agree that it will be easier to maintain. Due to the
> > number of "unusual" instructions required here it seems more readable
> > to have the code in pure assembly than to require readers to switch
> > contexts between C and asm. If we did move it to inline asm then I
> > think it should basically be a large blob of asm like the Scudo code
> > that I linked.
>
> I was definitely not thinking of a big asm block, that's even less
> readable than separate .S file. It's more like adding dedicated macros
> for single STG or DC GVA uses and using them in while loops.

I've got a C version with 4 single-instruction asm blocks, and it
looks pretty nice. The assembly is almost identical to the hand
written variant, and performance is 3% better, presumably because of
the inlining. Also, the C version allows more potential optimizations,
like specialization on the value of "init" - which is not happening
right now because it is not constant in any of the callers.

I'll upload a v4 shortly.

>
> Anyway, let's see a better commented .S implementation first. Given that
> tagging is very sensitive to the performance of this function, we'd
> probably benefit from a (few percent I suspect) perf improvement with
> the hand-coded assembly.
>
> --
> Catalin
