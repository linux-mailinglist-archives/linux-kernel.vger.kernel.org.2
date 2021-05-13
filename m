Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57537F47A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhEMIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhEMIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:55:38 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73308C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:54:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v22so19865224oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jG12S413O8fUiJ8iykc3p7wvxXhef9ESdPVA0acK7/k=;
        b=NDyBX09Om2k3j1J6yBIltr0QKv4OUv8wA0NvZw9OdVOa8L4npbuGF1BDzMwBnDlcFZ
         Emb2fYN5KnXR76wk9o6ekppMI2W02qXSielDjKiz5A9HWTDAsqY6IEUj/iq1zYpf0ZuO
         HT7HGrSG+U6CkeBqg9IRNWEKaqFdWKFZIpdNq7Kv/osIe24YLUttO+KE6LIq8rZHo+AQ
         V3c7QCOxyC8eAMi4Tx9XCh5dlaFDBoKvcv9OUpZnPFUeK7A1Ip4XFavPbBrEfCv3AIjT
         CUoMXrjvc51Y6VaEUD3KTznAsmgh+J5UGPXOrcs+8MGp9Lhca21EuNpoigsG1En/TsSS
         6LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG12S413O8fUiJ8iykc3p7wvxXhef9ESdPVA0acK7/k=;
        b=sLQ194e4LeIduHhBNYSEl1mgwKqg201GwpfGU2s5Ka6PUUGZTcVbXkK6ncbCSgTZKp
         5E3bjzlAQTdAxh7q9TNOz9bwJdbjlZnSB1E7Oov9FfoKa57+pcbJM1OLqfi9AKUpjldU
         hoZ9puCNsoUfz2V1eGPnRUCJ7NCfDIYZci1XoBpOOacc+5Nd6MIDZNP3k+4ZHTtW8k9B
         fancnPxb92RVrjhm6gikh8psVf8p+A3gwNTosyXft6Ic75jzeLVNXylgVS/+giHys2s8
         jjiF8FdlAkPpRuBjbydVsHf1p/IVM53zysJe+2OsFHjbXandlzYL/ylmUNKOQ5T46jmQ
         AwGA==
X-Gm-Message-State: AOAM532IQOFQhEkXRHYuhMBdrxrwbTprf9a0b4nVyccgkvybqPkCNrf4
        Y8jzemwI8RrgU0nkk2JmaiCCi4FhC2upiMHBCVmEIg==
X-Google-Smtp-Source: ABdhPJzHbpIRee5o3M7Noz/2xtZ/nvLm3qNZBmwciNfe+ShxEPtJ4vKwUXcLPEDWB5FuedQBvKHbHbp+yAy/eLxI/jI=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr29564018oif.121.1620896064734;
 Thu, 13 May 2021 01:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210511150734.3492-1-glittao@gmail.com> <20210511150734.3492-2-glittao@gmail.com>
 <20210512214440.e2cb47f751137db9802da62e@linux-foundation.org>
In-Reply-To: <20210512214440.e2cb47f751137db9802da62e@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 May 2021 10:54:13 +0200
Message-ID: <CANpmjNPWh0CB7VvuHVZs_dsGYqifPSZ17RChHvmGC6m8wd1Zfg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oliver Glitta <glittao@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 06:44, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 11 May 2021 17:07:33 +0200 glittao@gmail.com wrote:
> > From: Oliver Glitta <glittao@gmail.com>
> >
> > SLUB has resiliency_test() function which is hidden behind #ifdef
> > SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> > runs it. KUnit should be a proper replacement for it.
> >
> > Try changing byte in redzone after allocation and changing
> > pointer to next free node, first byte, 50th byte and redzone
> > byte. Check if validation finds errors.
> >
> > There are several differences from the original resiliency test:
> > Tests create own caches with known state instead of corrupting
> > shared kmalloc caches.
> >
> > The corruption of freepointer uses correct offset, the original
> > resiliency test got broken with freepointer changes.
> >
> > Scratch changing random byte test, because it does not have
> > meaning in this form where we need deterministic results.
> >
> > Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
> > Tests next_pointer, first_word and clobber_50th_byte do not run
> > with KASAN option on. Because the test deliberately modifies non-allocated
> > objects.
> >
> > Use kunit_resource to count errors in cache and silence bug reports.
> > Count error whenever slab_bug() or slab_fix() is called or when
> > the count of pages is wrong.
> >
> > ...
> >
> >  lib/slub_kunit.c  | 155 ++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/slab.h         |   1 +
> >  mm/slub.c         |  46 +++++++++++++-
> >  5 files changed, 212 insertions(+), 3 deletions(-)
> >  create mode 100644 lib/slub_kunit.c
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 678c13967580..7723f58a9394 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2429,6 +2429,18 @@ config BITS_TEST
> >
> >         If unsure, say N.
> >
> > +config SLUB_KUNIT_TEST
> > +     tristate "KUnit test for SLUB cache error detection" if !KUNIT_ALL_TESTS
>
> This means it can be compiled as a kernel module.  Did you runtime test the
> code as a module?
>
> ERROR: modpost: "kasan_enable_current" [lib/slub_kunit.ko] undefined!
> ERROR: modpost: "kasan_disable_current" [lib/slub_kunit.ko] undefined!
>
> --- a/mm/kasan/common.c~a
> +++ a/mm/kasan/common.c
> @@ -51,11 +51,14 @@ void kasan_enable_current(void)
>  {
>         current->kasan_depth++;
>  }
> +EXPORT_SYMBOL(kasan_enable_current);
>
>  void kasan_disable_current(void)
>  {
>         current->kasan_depth--;
>  }
> +EXPORT_SYMBOL(kasan_disable_current);
> +
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  void __kasan_unpoison_range(const void *address, size_t size)
> _

Acked-by: Marco Elver <elver@google.com>
