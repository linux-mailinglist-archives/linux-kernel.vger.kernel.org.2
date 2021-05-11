Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4637A399
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEKJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:29:04 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39503 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEKJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:29:03 -0400
Received: by mail-vs1-f45.google.com with SMTP id v188so9861524vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jm/AD7ayc9IZjTKCnS+p+8DytAX/uGO/+aOztTY9HLY=;
        b=S28tPzizlbDjlCGklqhWJJSYp502nFEhW7ixPm14roDf+QM8lJf1GVApK83Zkm4Bgw
         1eoLZZysG0TCwHw+7vBdbPGkdJrRctAVkLOzwUqt579wAGM/Geet54aXMGIOVuQyQFWa
         KTM20zDvl7V754eisvDYzvwi1BlyBxftSAGwC1D6v2UimK63+PLAs2S3d/ltLXQBLIqC
         KvCLmJVJmi+O9rmlWpQDywSFztvHRT5+BhDHxYuu9NF9pHtxrvC4fKXHzuG2tU7lws4b
         51gKEGxnubY4QpB65evPvIPawdasKSj8ZE+e1qA4R2fCma4mJV52QtfithI7kOHGe3zm
         +Qkg==
X-Gm-Message-State: AOAM530I/5qYbLv8pFUPRGio+jolxr4tGCPcL/SwQT4RjEyD7YZs8hdH
        RYgF6sqgiTN+FAVmJcjMg74JoI/MMxtM9AdUJ9I=
X-Google-Smtp-Source: ABdhPJxgeV0LlF1txVEIfV/80dAE9f/Fr7NVtiuskYQ6Ym/9W6Hi49TokwjhogXCVzi7TjFDvmP87S1mf4Rh5AX+Rb8=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr24519460vsq.40.1620725276793;
 Tue, 11 May 2021 02:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-21-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-21-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 11:27:45 +0200
Message-ID: <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com>
Subject: Re: [PATCH 20/33] locking/atomic: m68k: move to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, May 10, 2021 at 11:42 AM Mark Rutland <mark.rutland@arm.com> wrote:
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
>
> As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> code wraps these with optional instrumentation to provide the regular
> functions.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I even gave this series a spin on ARAnyM and QEMU, and everything
seems to be fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
