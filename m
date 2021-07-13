Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC593C7645
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhGMSNg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jul 2021 14:13:36 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:33571 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:13:36 -0400
Received: by mail-vs1-f53.google.com with SMTP id j8so12855414vsd.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlhl2E4nqEvej10lWriIdCXDfOfI/z5zwQZ0hljp3Qc=;
        b=baWQAcbEN26/xaDaeP8sVQl7wX7hBxHEFYH9DcN+pge2ORvARzAVQadZbp+c4WHk9E
         sCzrcKjr59TZtHKyhIRhuoJMYViZgfsRBsSLd5obMCz6O0mixeqv1oeibwOwXDKTkqo8
         1pb9nc/Fv//J4W0bSIFZKBqBiOOSUsuKiVrWdzQKQnp4zoNNzxO6aKrXKTrIdnzog4HR
         31E/At3TfC7TNwvG19rrOloNC0ZeTtjSGcp3iGyY7FyDz3FIEKhm3dapl89QuGJ5JaRC
         17syXduwVR3DxrxwnAghZYJ008eEwPTizOtYEtPsuIEex8Isc8VFK6Nfzd7czqXhXo3X
         H8/Q==
X-Gm-Message-State: AOAM532kLldWTVQ3CkzPo1xO18Dx3wZuWf4KCAV7+DCyZghYN9bu1937
        SmeHXX19fFKW1eNKcozeVHDNoFO+iq9xm0mL2cY=
X-Google-Smtp-Source: ABdhPJzePsGsxOA9mqBP7SE9ett5dB4ezFPwOrW7KOdf7lH79pezfcjEWLC1BHM6GAPhc1Dl5k1pOmVQ5W5h+wTAFeY=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr7981244vsd.42.1626199844405;
 Tue, 13 Jul 2021 11:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <3e1dbea4-3b0f-de32-5447-2e23c6d4652a@gmail.com>
 <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com> <20210710014915.GA149706@roeck-us.net>
In-Reply-To: <20210710014915.GA149706@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jul 2021 20:10:33 +0200
Message-ID: <CAMuHMdWrrP37Kfp4yC8G5f6SvMtD6u_=JkqX-Nd97FS_mayYWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Guenter Roeck <linux@roeck-us.net>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter, Tsukamoto-san,

On Sat, Jul 10, 2021 at 3:50 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jun 23, 2021 at 09:40:39PM +0900, Akira Tsukamoto wrote:
> > This patch will reduce cpu usage dramatically in kernel space especially
> > for application which use sys-call with large buffer size, such as network
> > applications. The main reason behind this is that every unaligned memory
> > access will raise exceptions and switch between s-mode and m-mode causing
> > large overhead.
> >
> > First copy in bytes until reaches the first word aligned boundary in
> > destination memory address. This is the preparation before the bulk
> > aligned word copy.
> >
> > The destination address is aligned now, but oftentimes the source address
> > is not in an aligned boundary. To reduce the unaligned memory access, it
> > reads the data from source in aligned boundaries, which will cause the
> > data to have an offset, and then combines the data in the next iteration
> > by fixing offset with shifting before writing to destination. The majority
> > of the improving copy speed comes from this shift copy.
> >
> > In the lucky situation that the both source and destination address are on
> > the aligned boundary, perform load and store with register size to copy the
> > data. Without the unrolling, it will reduce the speed since the next store
> > instruction for the same register using from the load will stall the
> > pipeline.
> >
> > At last, copying the remainder in one byte at a time.
> >
> > Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>
> This patch causes all riscv32 qemu emulations to stall during boot.
> The log suggests that something in kernel/user communication may be wrong.
>
> Bad case:
>
> Starting syslogd: OK
> Starting klogd: OK
> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
> Starting network: /bin/sh: syntax error: unterminated quoted string

> # first bad commit: [ca6eaaa210deec0e41cbfc380bf89cf079203569] riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall

Same here on vexriscv. Bisected to the same commit.

The actual scripts look fine when using "cat", but contain some garbage
when executing them using "sh -v".

Tsukamoto-san: glancing at the patch:

+       addi    a0, a0, 8*SZREG
+       addi    a1, a1, 8*SZREG

I think you forgot about rv32, where registers cover only 4
bytes each?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
