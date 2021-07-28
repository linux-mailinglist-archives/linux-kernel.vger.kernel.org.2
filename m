Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECED53D8E15
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhG1MoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbhG1Mny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:43:54 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E30C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:43:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso1933027ota.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8JopdaUBmz7iXRtArgg3xHwWvgUd1IpWAikP8/7uLI=;
        b=hHX52BoT5mvsWaw+jIRYoR2Rq+qYRXIzlDDOh91WdbkCp7WfevrqT5bUmx3TR2tZ4W
         rHoAbJBWFF7xLvhYcXT0dVleOhCskofJQ0AUDqKOuBS9/rhnz8BqAZlIt5HMDpihm9pv
         L+yNTo02wEDNNqgW0U9jIeG5hKO8QkH/rMfeH5FI+8dHKmw4Img4jrCuOYK7czpFZcsZ
         FVscVQS+u7o39JdI7SN9bnKhsa5a+if/auPUGjZjznsRvcO8+koJbgNcbXiKDHjWFmqJ
         4GS4DELsbRPCyMZgDLQVI+3u/9S6t8SskGregZGblGaUEB6j5AmYIdw4BUR61/XNbfnA
         KSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8JopdaUBmz7iXRtArgg3xHwWvgUd1IpWAikP8/7uLI=;
        b=d3XrsQmnphGR0RYUmXi9QqEo0QAGUblDx9c9iti+HFlQHzs3AMNWwKclbe+Spp9fGc
         PuhKaUbNw2lDDh3l02MOCaaEKkhf40A1DcGZdEEl+sn0JDyZ0E1UrmgEm6JLCW6JZGXO
         fMsRF6lvdYwXwv5vBDcv7kpzx12MESmfdo35JpHZMaoJbcQOkSoGNz+FCShGofEQvOg1
         Q/3L+MA65mr6Wmgsqq/ETsynCrHmwDXpgSp7ULm9bGsekdZNCGmdUp/wQQxeW6im4uSZ
         JdoKJ5IXAMprsL1hYLsc62gkOgn9jVYPS/ZvZkLeq5IFpvUNKXxFuh2Shkdct7C0osu3
         jPqA==
X-Gm-Message-State: AOAM533JMTcn89iNTjwplVmT91VEu9R4Rny2jBFVF+kK35WCxMh6qXet
        Ugxs5GkkGuaCI5AK6Sjhr2l075YbWUp6tMhpbGyomw==
X-Google-Smtp-Source: ABdhPJzhOrOWLA4RPWj30Wiy+9Zw3F5RKbHYFHAqOwKOZWucLtAfuUNLgPxj9dvD4Pk3+Y8aQB9oXucDocLmRymC7ro=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr19173472otl.233.1627476231336;
 Wed, 28 Jul 2021 05:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
 <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com> <CANpmjNM03Pag9OvBBVnWnSBePRxsT+BvZtBwrh_61Qzmvp+dvA@mail.gmail.com>
 <b6b96caf30e62996fa3b75ae8d146c9cc0dcbbf6.camel@mediatek.com>
 <20210727192217.GV13920@arm.com> <29f4844b1af163b0ec463fccbc9b902b3150f5c1.camel@mediatek.com>
In-Reply-To: <29f4844b1af163b0ec463fccbc9b902b3150f5c1.camel@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 28 Jul 2021 14:43:39 +0200
Message-ID: <CANpmjNNhSauZEp9W48WcrjK3w5-3cV5Rk4oc=Ci+h04+T2jsAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan, mm: reset tag when access metadata
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 13:05, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Tue, 2021-07-27 at 20:22 +0100, Catalin Marinas wrote:
> > On Tue, Jul 27, 2021 at 04:32:02PM +0800, Kuan-Ying Lee wrote:
> > > On Tue, 2021-07-27 at 09:10 +0200, Marco Elver wrote:
> > > > +Cc Catalin
> > > >
> > > > On Tue, 27 Jul 2021 at 06:00, Kuan-Ying Lee <
> > > > Kuan-Ying.Lee@mediatek.com> wrote:
> > > > >
> > > > > Hardware tag-based KASAN doesn't use compiler instrumentation,
> > > > > we
> > > > > can not use kasan_disable_current() to ignore tag check.
> > > > >
> > > > > Thus, we need to reset tags when accessing metadata.
> > > > >
> > > > > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > > >
> > > > This looks reasonable, but the patch title is not saying this is
> > > > kmemleak, nor does the description say what the problem is. What
> > > > problem did you encounter? Was it a false positive?
> > >
> > > kmemleak would scan kernel memory to check memory leak.
> > > When it scans on the invalid slab and dereference, the issue
> > > will occur like below.
> > >
> > > So I think we should reset the tag before scanning.
> > >
> > > # echo scan > /sys/kernel/debug/kmemleak
> > > [  151.905804]
> > > ==================================================================
> > > [  151.907120] BUG: KASAN: out-of-bounds in scan_block+0x58/0x170
> > > [  151.908773] Read at addr f7ff0000c0074eb0 by task kmemleak/138
> > > [  151.909656] Pointer tag: [f7], memory tag: [fe]
> >
> > It would be interesting to find out why the tag doesn't match.
> > Kmemleak
> > should in principle only scan valid objects that have been allocated
> > and
> > the pointer can be safely dereferenced. 0xfe is KASAN_TAG_INVALID, so
> > it
> > either goes past the size of the object (into the red zone) or it
> > still
> > accesses the object after it was marked as freed but before being
> > released from kmemleak.
> >
> > With slab, looking at __cache_free(), it calls kasan_slab_free()
> > before
> > ___cache_free() -> kmemleak_free_recursive(), so the second scenario
> > is
> > possible. With slub, however, slab_free_hook() first releases the
> > object
> > from kmemleak before poisoning it. Based on the stack dump, you are
> > using slub, so it may be that kmemleak goes into the object red
> > zones.
> >
> > I'd like this clarified before blindly resetting the tag.
>
> This kasan issue only happened on hardware tag-based kasan mode.
> Because kasan_disable_current() works for generic and sw tag-based
> kasan.
>
> HW tag-based kasan depends on slub so slab will not hit this
> issue.
> I think we can just check if HW tag-based kasan is enabled or not
> and decide to reset the tag as below.
>
> if (kasan_has_integrated_init()) // slub case, hw-tag kasan
>         pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
> else
>         pointer = *ptr; // slab

This is redundant. kasan_reset_tag() is a noop if
!IS_ENABLED(CONFIG_KASAN_HW_TAGS).

> Is this better or any other suggestions?
> Any suggestion is appreciated.

The current version is fine. But I think Catalin's point about why
kmemleak accesses the data in the first place still deserves some
investigation. Could it be a race between free and kmemleak scan?
