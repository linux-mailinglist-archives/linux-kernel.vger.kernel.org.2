Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2642EDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhJOJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhJOJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:43:41 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625B6C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:41:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s17so6953059ioa.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/9Cjwbow4gQwX9XQhOljIzy+rv03aN7aFZ2XRfJ3dw=;
        b=SQmyqjdhNlZzfunv4WhO/v7IvIaQOSz5mrD0KgdA4IyH7HaS1yQ6UK+RvonPj6gNV6
         fnxihMFImVsytVdsP8DxqM36FoB05+m9tlpdO2OMRTgjghO0Zh6gb78TUa9SoBvGe9bD
         PtFkq8V+CDd2p9iwN6/VaRJkFuTiYo06nRU+WGChVZv6EYdhRfDseVK8BO9xuvXubbhM
         pNFNOWGR4akZ+vgcDgcNHr1aZJsBp7Bjww96Yv/biCQit/u90yWaeSYsc+h2HeZenBNK
         ktu6XOFzHC7LjvkBC80A1pDznz7FcoHxvyHRpiqihJoocSf8aGkrRU0nJN9oEhZTWQl1
         ik0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/9Cjwbow4gQwX9XQhOljIzy+rv03aN7aFZ2XRfJ3dw=;
        b=EKF0TLlVCXar45lYxMqr0lkwrGwHiiEyMhZ4dilTxzK4gsq/Np+Q3yV59QjPk74OIz
         XxOrVYpIlyckoqz3+3PcxN/agKCl0Kv80pWoqka+LKK+TmV1FotSpdzluLR/q6xpeMrQ
         Dedb4r+RqaCSKh6Eutd0m5IhpuY8sseiyrjKxjtbsRgwaXS2bPFjLmBwZiSARaC9D6Tu
         q+OM44EBHoUQqpTzCGBJuDpwVmZp7E+JBKpskOHp7Yvx8oQhBbUZqv4dyJwiPAablRBM
         iOZViFGvxESDQBQeQbkoXVsafDJBVyfeHMesJqVU6RF+RzrcdJdT06oqSmZcdVLxEDsA
         8H0w==
X-Gm-Message-State: AOAM533zAnuh8y9VlpdP4ahLFhxI1vizgIE/PmlRf6Ckrw279piaBNSa
        IVk43fMP9ZBE/XaceolxKYtP65wTWp1LMI330Vc=
X-Google-Smtp-Source: ABdhPJxu5BMdOXsp7NDP24Ux0EvjITerC6WK7GEyqP9R2UlWAg0bSfZABhzh9s81GieX0Fdak7DLoQl0vE0+5HKYcAM=
X-Received: by 2002:a05:6602:148b:: with SMTP id a11mr3078869iow.85.1634290894846;
 Fri, 15 Oct 2021 02:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org> <6sZ9qpcJvtqCksJQVaiZyA-ammarfaizi2@gnuweeb.org>
In-Reply-To: <6sZ9qpcJvtqCksJQVaiZyA-ammarfaizi2@gnuweeb.org>
From:   Louvian Lyndal <louvianlyndal@gmail.com>
Date:   Fri, 15 Oct 2021 16:41:20 +0700
Message-ID: <CAP2ubg+p9sxJRKVhRAqYE0RKVU0Xz81YYy+=fysRiScMtAV2LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@aculab.com>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 3:57 PM Ammar Faizi wrote:
>
> Hi,
>
> This is a code to test.
>
> Compile with:
>   gcc -O3 -ggdb3 -nostdlib -o test test.c
>
> Technical explanation:
> The System V ABI mandates the %rsp must be 16-byte aligned before
> performing a function call, but the current nolibc.h violates it.
>
> This %rsp alignment violation makes the callee can't align its stack
> properly. Note that the callee may have a situation where it requires
> vector aligned move. For example, `movaps` with memory operand w.r.t.
> xmm registers, it requires the src/dst address be 16-byte aligned.
>
> Since the callee can't align its stack properly, it will segfault when
> executing `movaps`. The following C code is the reproducer and test
> to ensure the bug really exists and this patch fixes it.

Hello,
With the current nolibc.h, the program segfault on movaps:
Program received signal SIGSEGV, Segmentation fault.
0x0000555555555032 in dump_argv (argv=0x7fffffffe288, argc=1) at test.c:15
15        const char str[] = "\nDumping argv...\n";
(gdb) x/20i main
   0x555555555000 <main>:    endbr64
   0x555555555004 <main+4>:    push   %r14
   0x555555555006 <main+6>:    push   %r13
   0x555555555008 <main+8>:    mov    %edi,%r13d
   0x55555555500b <main+11>:    push   %r12
   0x55555555500d <main+13>:    push   %rbp
   0x55555555500e <main+14>:    mov    %rdx,%rbp
   0x555555555011 <main+17>:    mov    $0xa,%edx
   0x555555555016 <main+22>:    push   %rbx
   0x555555555017 <main+23>:    mov    %rsi,%rbx
   0x55555555501a <main+26>:    sub    $0x8,%rsp
   0x55555555501e <main+30>:    movdqa 0xffa(%rip),%xmm0        # 0x555555556020
   0x555555555026 <main+38>:    mov    %dx,-0x68(%rsp)
   0x55555555502b <main+43>:    lea    -0x78(%rsp),%r12
   0x555555555030 <main+48>:    xor    %edx,%edx
=> 0x555555555032 <main+50>:    movaps %xmm0,-0x78(%rsp)
   0x555555555037 <main+55>:    nopw   0x0(%rax,%rax,1)
   0x555555555040 <main+64>:    add    $0x1,%rdx
   0x555555555044 <main+68>:    cmpb   $0x0,(%r12,%rdx,1)
   0x555555555049 <main+73>:    jne    0x555555555040 <main+64>
(gdb) p $rsp-0x78
$1 = (void *) 0x7fffffffe1c8
(gdb)

Apparently it's because $rsp-0x78 is not multiple of 16. After this
patchset, it works fine. gcc version 11.1.0

Tested-by: Louvian Lyndal <louvianlyndal@gmail.com>
