Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20BE32EF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCEPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhCEPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:43:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1EC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:43:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so2286482pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTbQ4CYrvEtOKN3sK9Cdx0Ymm+PDCdjrJdMZxf0RYq0=;
        b=lwmLF3IOiErjUcagy+4Ncf8810NXSVX+conGSxCWmNt/riBnUgVJQZVMWcg3vcnxXv
         6f6wcdEu/uIoZ0KcuP0/IjGSQ0QpIdsVeQ1JJ6TE4O1dOXtmLxvyjHSp7cqN2hvewarc
         Yw0aNC9TY9kky0pPSGWvkHljTp486c72ju0FrI7R92ojx4ZGsWQ6e/gRElVirmLIK+WQ
         hWwIyIUyssBSxqzgh8oLFNsccj6aO2DCnM77KkbqIjeUEpI0IdPH6Obwp9dF09e1z4C4
         8mlYPiPar785lv8uIL/0PMEEX7f7XAOvkdDyLc4UEfHY9daDyNe/L7+4tET/s1eLH4aT
         Nd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTbQ4CYrvEtOKN3sK9Cdx0Ymm+PDCdjrJdMZxf0RYq0=;
        b=S9rbF4LbtaybFMpf53Q2pyOzZYuW1YOzS+B+HDP0nr+8VOEXlDcH86H2X8SlMAO1Iv
         5kMQnAxb8nP+azfTXSlaBIP6gylCYvnM4ZOG7xstBZcmAn1UcVwcuhJdaK32Lm/PNKkB
         ere75y/SbvxW1b66of8hCj/hppfo2BNxRYcDDHh15bC/0zgz7JKJ7ZIScp09yu7PtttM
         Zb0Ylh6nOKIyN/gsu7u7HicKtRVCHoXdsFb5hQC2ztmUmGc6FUatpkQah6UST/a3b8kH
         9TZW7//5qxSK4YwcSUHgLkkMxXpR8aAYnL4sqwfkTqG+M7yr/v35yoAeScmxTzTLB/CH
         gonQ==
X-Gm-Message-State: AOAM532D+iwJ/lrbHkDRBZ6S2jABEUcrVYJXimm93KcOs30nNdxZSMk8
        2z3PCiORe5OGoANMHp7nufrJOhMC0E1FO4k4szuvDg==
X-Google-Smtp-Source: ABdhPJzdb3CY0QwcYOqHImrSnnH70zbmg63DQ3nvCH+FSGncxT3ZHCijk26cQodq50iP8kPOOhtL3hkAiA5TAMpm3G4=
X-Received: by 2002:a17:902:7898:b029:e4:182f:e31d with SMTP id
 q24-20020a1709027898b02900e4182fe31dmr9028328pll.13.1614959002581; Fri, 05
 Mar 2021 07:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1aa83e48627978de8068d5e3314185f3a0d7a849.1614302398.git.andreyknvl@google.com>
 <20210303152355.fa7c3bcb02862ceefea5ca45@linux-foundation.org>
In-Reply-To: <20210303152355.fa7c3bcb02862ceefea5ca45@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Mar 2021 16:43:11 +0100
Message-ID: <CAAeHK+yVG0-36TUpH8EkQ7r1DHNGTHuOfLfKBKO3aDtCV0RnRQ@mail.gmail.com>
Subject: Re: [PATCH] kasan, mm: fix crash with HW_TAGS and DEBUG_PAGEALLOC
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 26 Feb 2021 02:25:37 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > Currently, kasan_free_nondeferred_pages()->kasan_free_pages() is called
> > after debug_pagealloc_unmap_pages(). This causes a crash when
> > debug_pagealloc is enabled, as HW_TAGS KASAN can't set tags on an
> > unmapped page.
> >
> > This patch puts kasan_free_nondeferred_pages() before
> > debug_pagealloc_unmap_pages().
> >
> > Besides fixing the crash, this also makes the annotation order consistent
> > with debug_pagealloc_map_pages() preceding kasan_alloc_pages().
> >
>
> This bug exists in 5.12, does it not?
>
> If so, is cc:stable appropriate and if so, do we have a suitable Fixes:
> commit?

Sure:

Fixes: 94ab5b61ee16  ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: <stable@vger.kernel.org>
