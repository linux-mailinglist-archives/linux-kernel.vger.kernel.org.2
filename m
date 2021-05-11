Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413CD37A3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhEKJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:30:47 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:37784 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEKJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:30:46 -0400
Received: by mail-vk1-f173.google.com with SMTP id b21so3926060vkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri/VsEyJ9iCvBdMBfq5AClEwg5h2TFv5KazhQYFgC+Q=;
        b=GiNZ4kIZeElWMCNobA333l7CA51/b0JFq70D6Pl5GyI6kKLRvzZzV5RZGY76mafFRk
         6LtfIHanJsnS3VpROn4i1sxD+iAojX9r3cgoFvmwiGO3CX3EtQ+jTnIe0VMtZb5LsM4M
         dzaNvHbxQZSsyhdTO5Hw3W9HU4PLFqeEp6NDJttLHD1s9uvT1PKWKS0qfJDRAGQ+sMSw
         EY4uXOs94eNsJ1cWxCLtJy6EXlQGQOWlKx7JDCioKn3SCfLjtaRfrJxmCzoUzY/ojFDT
         XW9GciB5/nITxog8DwqdIyXyZWLbkmg1/k6K9t17sLflLtTGHEJckA5AKwNJYNCLUASH
         RYyQ==
X-Gm-Message-State: AOAM532aHbqspW7wbBSfuqbw7lUZ2vUF5AMPqnrC9/z3IrYjNWVahUM5
        ZKISLGBUvW8b8ugtvV4X0a/IMI81EAgmmBGwBME=
X-Google-Smtp-Source: ABdhPJyG5UkMQHHBhxYIf1c0EG5UM2xylsxQ4opKnhwoSt/KAdAZWizuT9yAk+f67+Imi4z+6ml5hHMX6CEcajRdm8I=
X-Received: by 2002:a1f:a388:: with SMTP id m130mr21519415vke.1.1620725380281;
 Tue, 11 May 2021 02:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-12-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-12-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 11:29:29 +0200
Message-ID: <CAMuHMdV2yChVgErXwYeMi=uNqBfjWLcVBgxbU4pfDni_oRN4ZQ@mail.gmail.com>
Subject: Re: [PATCH 11/33] locking/atomic: cmpxchg: make `generic` a prefix
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

On Mon, May 10, 2021 at 11:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> The asm-generic implementations of cmpxchg_local() and cmpxchg64_local()
> use a `_generic` suffix to distinguish themselves from arch code or
> wrappers used elsewhere.
>
> Subsequent patches will add ARCH_ATOMIC support to these
> implementations, and will distinguish more functions with a `generic`
> portion. To align with how ARCH_ATOMIC uses an `arch_` prefix, it would
> be helpful to use a `generic_` prefix rather than a `_generic` suffix.
>
> In preparation for this, this patch renames the existing functions to
> make `generic` a prefix rather than a suffix. There should be no
> functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/include/asm/cmpxchg.h     | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
