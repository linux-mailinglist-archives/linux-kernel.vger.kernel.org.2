Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8C387D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbhERQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhERQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:13:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E056C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:12:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y9so12256538ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryNGn3iPnypPYn2b5vg9zKKQ/b9xvDeiGVvzaVD/bEs=;
        b=EaWVhjNrNBWn6f1mh1OvKUeDE/tFuKqvgMLfofpYgBGgWg79RhbWTVMtICXNGGKhjS
         3Mq5M+u41o3/M+25Q2/C6ZfA8MHWu/DrQxEX0WIpCg+HH9Ws5sQuJVmPUoK2wkGm2nzc
         sbk5hpok8r5v8UCa0qR/IAKlL2f1Ed+l4beT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryNGn3iPnypPYn2b5vg9zKKQ/b9xvDeiGVvzaVD/bEs=;
        b=HpoyhHJ+cxFC5sejXWDvyzAeQSa9PNiZpLl9vZNdwJQWsHCGNu7QIc4pHiXdN+vFR+
         +wIb+HT6HkDi805kCL0kOGfmJ7ZkInvGNH6eagiJ2LhizAeC8FXLpA3XUo84RU3TWACD
         hcN1hPwr9Wu3QCiB9R7OUh62Rfcr/WBzbuiZ94K8Eqy8rvtSQN7/MNvgBvjZfl97PF6J
         G4nPIBuAfoEI4ydEEuxA3myoKh3BUw9Nm+E9HHKseoij6VkQq21Ki3w801F0hRS6EZqg
         zy2TYDE1tA1BK6afr5XqCr30r8z6OAFIo2srnA9IPEFQnYn5z0GzMxbTF9RWGLs5Bcew
         q71Q==
X-Gm-Message-State: AOAM532bGLCu3dugPDc2/4uEaoOZ4oBsUKfVtdfQd9Luk3llJguW3K3r
        37BeXEow1+ZJ9yaccEQi95D+MVdTxOLifg6N
X-Google-Smtp-Source: ABdhPJxJVBxzMFEmMt0MTKwZDZy2Db4w8DDNnkNi1bpV0YSPmy4no3XsdivXKYgaTOMF66aNKmV4jg==
X-Received: by 2002:a2e:7606:: with SMTP id r6mr4625981ljc.432.1621354341920;
        Tue, 18 May 2021 09:12:21 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t30sm3349888ljo.136.2021.05.18.09.12.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 09:12:20 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id h4so15043699lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:12:20 -0700 (PDT)
X-Received: by 2002:a19:ca15:: with SMTP id a21mr4619384lfg.487.1621354340156;
 Tue, 18 May 2021 09:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com> <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com> <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 06:12:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
Message-ID: <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Arnd Bergmann <arnd@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> To be on the safe side, we could pass -fno-tree-loop-vectorize along
> with -O3 on the affected gcc versions, or use a bigger hammer
> (not use -O3 at all, always set -fno-tree-loop-vectorize, ...).

I personally think -O3 in general is unsafe.

It has historically been horribly buggy. It's gotten better, but this
case clearly shows that "gotten better" really isn't that high of a
bar.

Very few projects use -O3, which is obviously part of why it's buggy.
But the other part of why it's buggy is that vectorization is simply
very complicated, and honestly, judging by the last report the gcc
people don't care about being careful. They literally are ok with
knowingly generating an off-by-one range check, because "it's
undefined behavior".

With that kind of mentality, I'm not personally all that inclined to
say "sure, use -O3". We know it has bugs even for the well-defined
cases.

> -O3 is set for the lz4 and zstd compression helpers and for wireguard.

I'm actually surprised wireguard would use -O3. Yes, performance is
important. But for wireguard, correctness is certainly important too.
Maybe Jason isn't aware of just how bad gcc -O3 has historically been?

And -O3 has often generated _slower_ code, in addition to the bugs.
It's not like it's a situation where "-O3 is obviously better than
-O2". There's a reason -O2 is the default.

And that tends to be even more true in the kernel than in many user
space programs (ie smaller loops, generally much higher I$ miss rates
etc).

Jason? How big of a deal is that -O3 for wireguard wrt the normal -O2?
There are known buggy gcc versions that aren't ancient.

Of the other cases, that xor-neon.c case actually makes sense. For
that file, it literally exists _only_ to get a vectorized version of
the trivial xor_8regs loop. It's one of the (very very few) cases of
vectorization we actually want. And in that case, we might even want
to make things easier - and more explicit - for the compiler by making
the xor_8regs loops use "restrict" pointers.

That neon case actually wants and needs that tree-vectorization to
DTRT. But maybe it doesn't need the actual _loop_ vectorization? The
xor_8regs code is literally using hand-unrolled loops already, exactly
to make it as simple as possible for the compiler (but the lack of
"restrict" pointers means that it's not all that simple after all, and
I assume the compiler generates conditionals for the NEON case?

lz4 is questionable - yes, upstream lh4 seems to use -O3 (good), but
it also very much uses unaligned accesses, which is where the gcc bug
hits. I doubt that it really needs or wants the loop vectorization.

zstd looks very similar to lz4.

End result: at a minimum, I'd suggest using
"-fno-tree-loop-vectorize", although somebody should check that NEON
case.

And I still think that using O3 for anything halfway complicated
should be considered odd and need some strong numbers to enable.

               Linus
