Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4F3DBB77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhG3O7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbhG3O6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:58:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4687C0617BF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:57:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y7so11340749eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FskvzB/Uu7kITCTpEs9Kzb0h3ZTsKYWrhXodwFjiIk=;
        b=qdwGk32T8LIniVGMFzFAJe6RX68qQNMkrxYLkZOSF0T3vabQA/oH99TgvDLAWpUnVw
         EMBEBrTyyu0bszCCLjMP+rMRob7mlE+AovtCZo27qSMkPTfe3g4yfg3QDpcCqjJ89AuG
         5iZit8yuHeSIYaG0jTc9sVQLYXBZw3Oj72RnERwCr0dEmHLBHAXxmyrR6JdjEoMnNvM2
         oy8pFEKMaJ0In9p6GeDe3RQvqg0ySFCkiFuMb0Me2Voz97GzdR0EOgdUS19VKNUiQBYH
         8vYVD3AOWJfaGfatwjNQbmUH4uofJCPG5u97wjWpuM3UV+70caNlBUULFH5JOjXfwi1q
         iRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FskvzB/Uu7kITCTpEs9Kzb0h3ZTsKYWrhXodwFjiIk=;
        b=TXuR8BHwgPaK2NfTtZ4Ja4/V3GSF2MSJRvCcpjp6wSO67KBpCWIR1Y6Tz9hHR8Oe05
         S/nOWMb/mekFxwOcI4gJoJA0AxRd/rhaE61FUHWTaIw6nvUYPNnOrZUde/840dVEYobX
         S4XUjsf6JDbmbaoZzDTtg1v+Aszj09w28kWhJ5nB9si3sgaQPQmo76c2cPM1mxqk/Mz9
         jWugPl1bH4sFNnhqEwHxXEp/QIToxafXFfEB691n9iPWr0N0UYA/Ak8JFZ6xeQ4wNzNk
         sKzRnAnprM8PqkORxSHKmuaxtmjZ8ORwlz24NoVOWSAcVmFONM+BH/y100VyzqJ6G7Ot
         9rXg==
X-Gm-Message-State: AOAM531Pd9+D8lxUYVU+7F2qUgo5C+KQ397pBY28hJDxOwCCVNWhO9HH
        dgFOCLAu6ss5QKeikWmpJ97dhGCZI0SOa4OjvBFVS7hd5BQ=
X-Google-Smtp-Source: ABdhPJwSaMVLnatukbBUZ5bbG5wTLiLIbZNXBz6UHbZ62TjHZpcXELPVn/H+RxE5RRcBCR7Zb+SxC2GibF9zBMAwoE0=
X-Received: by 2002:a50:eb88:: with SMTP id y8mr3436558edr.70.1627657051382;
 Fri, 30 Jul 2021 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
 <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com> <CANpmjNM03Pag9OvBBVnWnSBePRxsT+BvZtBwrh_61Qzmvp+dvA@mail.gmail.com>
 <b6b96caf30e62996fa3b75ae8d146c9cc0dcbbf6.camel@mediatek.com> <20210727192217.GV13920@arm.com>
In-Reply-To: <20210727192217.GV13920@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 30 Jul 2021 16:57:20 +0200
Message-ID: <CA+fCnZdprormHJHHuEMC07+OnHdC9MLb9PLpBnE1P9TvrVisfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan, mm: reset tag when access metadata
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Marco Elver <elver@google.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 9:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jul 27, 2021 at 04:32:02PM +0800, Kuan-Ying Lee wrote:
> > On Tue, 2021-07-27 at 09:10 +0200, Marco Elver wrote:
> > > +Cc Catalin
> > >
> > > On Tue, 27 Jul 2021 at 06:00, Kuan-Ying Lee <
> > > Kuan-Ying.Lee@mediatek.com> wrote:
> > > >
> > > > Hardware tag-based KASAN doesn't use compiler instrumentation, we
> > > > can not use kasan_disable_current() to ignore tag check.
> > > >
> > > > Thus, we need to reset tags when accessing metadata.
> > > >
> > > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > >
> > > This looks reasonable, but the patch title is not saying this is
> > > kmemleak, nor does the description say what the problem is. What
> > > problem did you encounter? Was it a false positive?
> >
> > kmemleak would scan kernel memory to check memory leak.
> > When it scans on the invalid slab and dereference, the issue
> > will occur like below.
> >
> > So I think we should reset the tag before scanning.
> >
> > # echo scan > /sys/kernel/debug/kmemleak
> > [  151.905804]
> > ==================================================================
> > [  151.907120] BUG: KASAN: out-of-bounds in scan_block+0x58/0x170
> > [  151.908773] Read at addr f7ff0000c0074eb0 by task kmemleak/138
> > [  151.909656] Pointer tag: [f7], memory tag: [fe]
>
> It would be interesting to find out why the tag doesn't match. Kmemleak
> should in principle only scan valid objects that have been allocated and
> the pointer can be safely dereferenced. 0xfe is KASAN_TAG_INVALID, so it
> either goes past the size of the object (into the red zone) or it still
> accesses the object after it was marked as freed but before being
> released from kmemleak.
>
> With slab, looking at __cache_free(), it calls kasan_slab_free() before
> ___cache_free() -> kmemleak_free_recursive(), so the second scenario is
> possible. With slub, however, slab_free_hook() first releases the object
> from kmemleak before poisoning it. Based on the stack dump, you are
> using slub, so it may be that kmemleak goes into the object red zones.
>
> I'd like this clarified before blindly resetting the tag.

AFAIK, kmemleak scans the whole object including the leftover redzone
for kmalloc-allocated objects.

Looking at the report, there are 11 0xf7 granules, which amounts to
176 bytes, and the object is allocated from the kmalloc-256 cache. So
when kmemleak accesses the last 256-176 bytes, it causes faults, as
those are marked with KASAN_KMALLOC_REDZONE == KASAN_TAG_INVALID ==
0xfe.

Generally, resetting tags in kasan_disable/enable_current() section
should be fine to suppress MTE faults, provided those sections had
been added correctly in the first place.
