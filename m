Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B776437A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhEKJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:31:52 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:34655 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhEKJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:31:48 -0400
Received: by mail-vk1-f172.google.com with SMTP id q135so3924995vke.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pIkfcmvEoi96dJ73s7ui/IZYU+awqQi3c8hAfZnptQ=;
        b=twkIaYZxF+vl+bXkv2ONP57xNBgsNosZlFd9vOt0ikPU866weYI8rOZVCswCqgjvvb
         v5TqPZ4Np+CsCu86kNhAY2XGd55ZXKJQyQSjbRgCzHCbLBGmcuDkqpA0B8sP2BO34U+6
         AYNSJ1pTbj6/UgL4SgVX8Ny/jtJBDqWThoZ4nBDjG6jiqvfDAb0EKhd81dTpHW8G/bRF
         sWrOlwH7A1jzVblumLC7dDfJvQ3QhmfPPeVlEq+B1UmcjLDiqKFfmRCWMnQrdOh1SrWv
         aObX8PufXe/xEKPOMfhd13iIqfrSRRMdsEamWymb+JfXNxwVwSUOePw6OrzMTGKnZ+NI
         7A1Q==
X-Gm-Message-State: AOAM531iszL0fQtxlHgm8q6/SnIrzHxzEmlqWo0n14GXJV2+MLqEs0F8
        Jt84lktQdpEjDWyXkeTzLtuLR8mLk2KnVyws8UU=
X-Google-Smtp-Source: ABdhPJzvwIYI6ggGA4K1217DygzIdlDcTLrvim/jgKkff1X/hnWYC0ofnZXPYpoy53uUkM/RprqEuYbZPqCMHkVnEeQ=
X-Received: by 2002:a1f:5e8c:: with SMTP id s134mr15031910vkb.1.1620725441789;
 Tue, 11 May 2021 02:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-33-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-33-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 11:30:30 +0200
Message-ID: <CAMuHMdUw2+2CRr41TqpzH+4MhcOqSXJYBqjmEbFpAWpTW_9TBQ@mail.gmail.com>
Subject: Re: [PATCH 32/33] locking/atomic: delete !ARCH_ATOMIC remnants
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

On Mon, May 10, 2021 at 11:44 AM Mark Rutland <mark.rutland@arm.com> wrote:
> Now that all architectures implement ARCH_ATOMIC, we can make it
> mandatory, removing the Kconfig symbol and logic for !ARCH_ATOMIC.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/Kconfig               |    1 -

FWIW
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
