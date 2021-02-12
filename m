Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5D31A674
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBLVCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhBLVCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:02:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:01:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t2so331378pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NT+Vr+SuI/IQr/HdheHFCPYtSKxGIwwJN+vDof64o90=;
        b=a7+YT18oLHZ5w/c8d1pHLe0BM+ns6ibIMkUvLN/LqW+1RxGRvTb+QerKdeRqTbuJSX
         kdDsvak+FMZwuz+RNTwLmQox516ga1GNPQo9TkYAzwm08jYZLw1zlOmKoCKInP0OhDxK
         /2gHziPDBZeVpAU1cj5SzDWcaE95j/342nJPoSUIzC+5GxtgZ1EC6g1FLqUcbqnilNNm
         IX+Y8k0hd/3fcWxk2DEuqA6gwae8193oHMdLYub4buQSmC5FAUcqtkAmvH/SS/7ubpl0
         OX+rQewztENUKp3SfNjPFcAoTlrCRq0AzquK7KOX5yzD8RQIQ8fI4qHOvu0XXzSFfJRE
         MXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NT+Vr+SuI/IQr/HdheHFCPYtSKxGIwwJN+vDof64o90=;
        b=hcoe9tRGl1fg+/wCGf7GS0653U4beudpatjo6Bzb4uVy/M3www6WbpiVB2xZBA2XQE
         DEH91wop5lAxQarKmSvRaahMxtRU2COZ1+iqfJBAWSFBtPhu/zl91sm8VNLB/LBcMP33
         za5fcKvt50fOLha/Q55AuhkaIp1hJROnACn14pAyl3cIQ6SZo7Ocjnu3VOLbcJVY4d5j
         uw2GWbGJRfdiBnvrBfDM/+n+VrmLvH+3ckH4awKPex9zgZfEGMZQB4JoZ2abVxDm32J1
         2WM6yf16JeqN5Z01g2HlgqNPwi4gsK8pQYEvsC2Bv1AvU65aNXGIWz4C0cUrWwPBShzz
         QS8w==
X-Gm-Message-State: AOAM532/fQUoSTuELNRZ1V7QFvScAv2bpYKMcBl/Kc7LU51FeNZe9PEX
        HqK2r3tTuRp3WVYbfhcjWyqF8aUcwAtJaGM3KRcCNw==
X-Google-Smtp-Source: ABdhPJxVIi7RVGo6x7Hy8l7XWUuFqhNVlzLeNz68scO2crocPe6nWcS/zly1uuYdwfygXW32Va+f0qPC9ZebvYE+VGo=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr4351810pjb.166.1613163709768;
 Fri, 12 Feb 2021 13:01:49 -0800 (PST)
MIME-Version: 1.0
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
 <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
 <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com> <20210212125454.b660a3bf3e9945515f530066@linux-foundation.org>
In-Reply-To: <20210212125454.b660a3bf3e9945515f530066@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 22:01:38 +0100
Message-ID: <CAAeHK+w6znh95iHY496B15Smtoaun73yLYLCBr+FBu3J57knzQ@mail.gmail.com>
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

On Fri, Feb 12, 2021 at 9:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 12 Feb 2021 21:21:39 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > > > The wrappers aren't defined when tests aren't enabled to avoid misuse.
> > > > The mte_() functions aren't exported directly to avoid having low-level
> > > > KASAN ifdefs in the arch code.
> > > >
> > >
> > > Please confirm that this is applicable to current Linus mainline?
> >
> > It's not applicable. KUnit tests for HW_TAGS aren't supported there,
> > the patches for that are in mm only. So no need to put it into 5.11.
>
> So... which -mm patch does this patch fix?

"kasan, arm64: allow using KUnit tests with HW_TAGS mode".

There will be some minor adjacent-line-changed conflicts if you decide
to squash it.

Alternatively, this can go as a separate patch after the tests series
(after "kasan: don't run tests when KASAN is not enabled").

Thanks!
