Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1B31A694
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhBLVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhBLVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:11:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4049C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:10:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so450345pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmK+2FrtXJ1N8kjX/gksPRqXGNz83KFxwR+0lffrQZo=;
        b=XXg0m272x1WI56bZ8GIw9LVpCXloxCywCAK6XXcGhREYdrMQVY/aa3YrTBqZkHVVxr
         F25JDtkf47Tw4yT4y/XEkQFQ+lC3+cxeKX4T8Xy5BtMzQ63tRrkELL1wT8SyV9fJJEFf
         bBATruXfXRJM3CElB1sw8DoOIBohZX3caXzNrLZDEMX+4zk9ezrlE0sMiI3DQ+gIcT20
         jy55JIl1OhhzYxwNjmUT0fJaHHEQB5AXJtshiF/Tc+927lEvBv2wLeuDpFVFdzYM4uvD
         3MkBuzB/3K+gGjGIrd+Aj/wmRM1jKl6Lb2/LrV5Q/8wSdhaQMHw1JXGkHqWk8U7sYCrc
         l+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmK+2FrtXJ1N8kjX/gksPRqXGNz83KFxwR+0lffrQZo=;
        b=qW5y8qhtnCYokcxRUqIw6KxhJnj1LFibBjTODQjd4xBmwCeCsCAsbzm5VQ/umRKQsy
         G9KwbncWyJJphaWcXrjucySMmKEpLHrt1sAht0mLHVm7y5X051WpXhnbVaFdqhSZCOWg
         fxZnAljfOmirky4COG9shewyIiVXwD2EBSkhjyv06llWF7Y9XEbeuILB3Cky22afCa2j
         caPFh/JydzLdibfCiq51T8t6Ly00LvvXUysZxUQ1qIhMTXdbqw8GAgONEHMOam0DW00t
         YBjNblPVEIfjZ2lbOqlddZj9wzA5OT8+MtPro/Qq8+N5FVej05NbyW4c1MnCiSVW+QJ5
         hBFw==
X-Gm-Message-State: AOAM532O0PGepToMNlTfPU0kW9xJwZw/PPG8FD+EuD7xzADyQerGcDaS
        a9cOuvZXdrJxJNwl7zHNo1HScLuoptJntJE9KaCiTQ==
X-Google-Smtp-Source: ABdhPJxpjRQi+/iBpnYIYuNhQKpMWlytaPRwxHuLWfQ2pZ0wSfB8qmhAeTmJcA7x51TuxoQdupVQPT5jCJDOVn/MXAk=
X-Received: by 2002:a62:8cd7:0:b029:1d9:447c:e21a with SMTP id
 m206-20020a628cd70000b02901d9447ce21amr4821819pfd.2.1613164235762; Fri, 12
 Feb 2021 13:10:35 -0800 (PST)
MIME-Version: 1.0
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
 <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
 <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com>
 <20210212125454.b660a3bf3e9945515f530066@linux-foundation.org>
 <CAAeHK+w6znh95iHY496B15Smtoaun73yLYLCBr+FBu3J57knzQ@mail.gmail.com> <20210212130816.cde26643a6b9b24007be4e54@linux-foundation.org>
In-Reply-To: <20210212130816.cde26643a6b9b24007be4e54@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 22:10:24 +0100
Message-ID: <CAAeHK+y20nuSLs1bQO2wyND5S1xFRDHNvvL07Jk8y72tF11O_w@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: export HW_TAGS symbols for KUnit tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Fri, Feb 12, 2021 at 10:08 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 12 Feb 2021 22:01:38 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > On Fri, Feb 12, 2021 at 9:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 12 Feb 2021 21:21:39 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > > > > The wrappers aren't defined when tests aren't enabled to avoid misuse.
> > > > > > The mte_() functions aren't exported directly to avoid having low-level
> > > > > > KASAN ifdefs in the arch code.
> > > > > >
> > > > >
> > > > > Please confirm that this is applicable to current Linus mainline?
> > > >
> > > > It's not applicable. KUnit tests for HW_TAGS aren't supported there,
> > > > the patches for that are in mm only. So no need to put it into 5.11.
> > >
> > > So... which -mm patch does this patch fix?
> >
> > "kasan, arm64: allow using KUnit tests with HW_TAGS mode".
> >
> > There will be some minor adjacent-line-changed conflicts if you decide
> > to squash it.
> >
> > Alternatively, this can go as a separate patch after the tests series
> > (after "kasan: don't run tests when KASAN is not enabled").
>
> Thanks - it wasn't obvious.
>
> I staged it as a fix against "kasan, arm64: allow using KUnit tests
> with HW_TAGS mode".  To make the series as nice as we can, and to avoid
> bisection holes.

Sounds good, thank you!
