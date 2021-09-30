Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1A41D087
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbhI3AUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbhI3AUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:20:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CBC061768
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:19:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z24so17738236lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5qjTnqye3EB6haBWel1HIMAMVm5MlbG9fH8ad2RHKw=;
        b=goa3FAzvlsBIhjnZf1chDjBWKFb6Zus+AkecG4YOKTAW0Dp8XCMfMUDlhnoSQq/agD
         YqyQkKJhIQHPzibCRafo2RByPNFMDQBL7kDsfeDaXk4dDYvBPiR4scyIAQfUTrVtZY6V
         gNORCg+HlvOyyZXVMDAV3ECDernlOtbWHIEsvwR7cFNmZaPUzujhCfbW/KkNCLNGC/hB
         /1s0rWIBIUxoGUwSDX9vfmmkTisklqlrjnYFXwQd0tBUfiJXv8WW6Z9g7giu8YnU3meD
         UqMaVw61BbMx9awB340AVUfafrB36nVZ4XFcPMf1xXu5971CUIlTAd9Kck7TaxIH66/r
         lQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5qjTnqye3EB6haBWel1HIMAMVm5MlbG9fH8ad2RHKw=;
        b=D5C1CfqeNnDpTH8LyGdORC7w+MD1e/gdHGaKDa4O5y/KpnoYCs6YE/R/S2BEWAh0s7
         Br/cyQfxL1prlorHSw5SCi2xTWDEAw81ImU8BQ2VtHLKp1JavmBHWYYyexvbW7j+0+rM
         sp23pgi74sHmjFK+txTGQSErp7p+2kRFAw4waS1T2xDImQgyGsAOodprRcjQ+uN1hYyj
         xcSZH9h1m6gr3l7xqHKSPjkGrb2FeOl42TEdepI4dWMq4xZmGucTuT/N5HJEoGZv2SAx
         1MAFHul9659UItMLeMF77/GkuE3Q0NOzHlZ//f4kpGkjDi+fLK87gwy8g3N4VZxnwKTI
         NbLw==
X-Gm-Message-State: AOAM530/XPrvTohv0GubJax1Maset2P3ca+1Ih8WuR53iacDnVw5EKeK
        MHvX6JHDBXsGBYRGmHjR7XcsptGjLBtYmc2Z5qd61w==
X-Google-Smtp-Source: ABdhPJw+KvDgIruz+eY8LlRp/QXHLsE0A6K2TsYjthGZU7+4oUZcOJZhihR7Hd3hODZ0Ab6Ay/v6i16ecns32XQRqzo=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr2923418ljd.128.1632961141130;
 Wed, 29 Sep 2021 17:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210929225850.3889950-1-ndesaulniers@google.com> <CAHk-=wh0BNEDz+uOdJWG8iW=n0PeOEjZpHyuSN2g0pKSCj+6iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh0BNEDz+uOdJWG8iW=n0PeOEjZpHyuSN2g0pKSCj+6iQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 17:18:49 -0700
Message-ID: <CAKwvOdn-Z1q99zZW4GQ2aNnVMQ_JYuczrResTG7tvcfv0WLJ-w@mail.gmail.com>
Subject: Re: [PATCH] modpost: add allow list for llvm IPSCCP
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 29, 2021 at 3:59 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > +static const struct secref_exception secref_allowlist[] = {
> > +       { .fromsym = "__first_node", .tosym = "numa_nodes_parsed" },
> > +       { .fromsym = "__next_node", .tosym = "numa_nodes_parsed" },
> > +       { .fromsym = "__nodes_weight", .tosym = "numa_nodes_parsed" },
> > +       { .fromsym = "early_get_smp_config", .tosym = "x86_init" },
> > +       { .fromsym = "test_bit", .tosym = "numa_nodes_parsed" },
> > +};

Thanks for your feedback.  This has been a long-standing issue with no
clear path forward; I was looking forward to your input.

>
> This list is basically made-up and random.

Definitely brittle.  And it contains checks that are specific to
basically one set of configs for one arch. It sucks to pay that cost
for unaffected architectures.

> Why did those functions not get inlined?

$ make LLVM=1 -j72 allmodconfig
$ make LLVM=1 -j72 arch/x86/mm/amdtopology.o KCFLAGS=-Rpass-missed=inline.
...
arch/x86/mm/amdtopology.c:110:7: remark: 'test_bit' not inlined into
'amd_numa_init' because too costly to inline (cost=115, threshold=45)
[-Rpass-missed=inline]
                if (node_isset(nodeid, numa_nodes_parsed)) {
                    ^
arch/x86/mm/amdtopology.c:157:7: remark: '__nodes_weight' not inlined
into 'amd_numa_init' because too costly to inline (cost=60,
threshold=45) [-Rpass-missed=inline]
        if (!nodes_weight(numa_nodes_parsed))
             ^
arch/x86/mm/amdtopology.c:171:2: remark: 'early_get_smp_config' not
inlined into 'amd_numa_init' because too costly to inline (cost=85,
threshold=45) [-Rpass-missed=inline]
        early_get_smp_config();
        ^
arch/x86/mm/amdtopology.c:178:2: remark: '__first_node' not inlined
into 'amd_numa_init' because too costly to inline (cost=70,
threshold=45) [-Rpass-missed=inline]
        for_each_node_mask(i, numa_nodes_parsed)
        ^
arch/x86/mm/amdtopology.c:178:2: remark: '__next_node' not inlined
into 'amd_numa_init' because too costly to inline (cost=95,
threshold=45) [-Rpass-missed=inline]


ie. for allmodconfig, the sanitizers add too much instrumentation to
the callees that they become too large to be considered profitable to
inline by the cost model.  Note that LLVM's inliner works bottom up,
not top down.

Though for the defconfig case...somehow the cost is more than with the
sanitizers...

arch/x86/mm/amdtopology.c:157:7: remark: '__nodes_weight' not inlined
into 'amd_numa_init' because too costly to inline (cost=930,
threshold=45) [-Rpass-missed=inline]
        if (!nodes_weight(numa_nodes_parsed))
             ^

Looking at the output of `make LLVM=1 -j72
arch/x86/mm/amdtopology.ll`, @__nodes_weight is just some inline asm
(.altinstructions). I wonder if I need to teach the cost model about
`asm inline`...

For the allmodconfig build it looks like `__nodes_weight` calls
`__bitmap_weight` and the code coverage runtime hooks.

> Wouldn't it be better to make
> them always-inline?

Perhaps, see what that might look like:
https://github.com/ClangBuiltLinux/linux/issues/1302#issuecomment-807260475
Does that look better?

> Or, like in at least the early_get_smp_config() case, just make it be
> marked __init, so that if it doesn't get inlined it gets the right
> section?

In the case of early_get_smp_config(), that's what Boris suggested:
https://lore.kernel.org/lkml/20210225114533.GA380@zn.tnic/

>
> It seems silly to add random source mappings to a checking program.
>
> It was bad for the gcc constprop hack, but at least there it was a

Part of me feels like modpost not warning on those is permitting a
"memory leak," in so far as code that's only called from .init callers
is never reclaimed. Or leaving behind gadgets...

> clear case of "this inlining failed". This ad-hoc list has cases of
> things that are clearly wrong in general ("test_bit()" must not use
> initdata), and that "ok, the function just doesn't have the right
> section marker.

Sorry, what do you mean "test_bit() must not use initdata?" Because it
can lead to problems like this? Or...?

include/linux/nodemask.h has a comment that I'd bet predates that
modpost "Pattern 5" gcc constprop hack.
https://github.com/ClangBuiltLinux/linux/blob/83d09ad4b950651a95d37697f1493c00d888d0db/include/linux/nodemask.h#L119-L125

>
> (All of get_smp_config/early_get_smp_config/find_smp_config should be
> __init, since they most definitely cannot work after __init time - but
> why a compiler doesn't just inline them when they are one single
> indirect call, I don't really get)
>
>          Linus



-- 
Thanks,
~Nick Desaulniers
