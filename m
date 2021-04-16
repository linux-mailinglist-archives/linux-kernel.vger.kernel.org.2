Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97EC3629AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbhDPU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhDPU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:57:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:57:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v72so10841554ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9B9ShPNjuZj2201nZeGg99lf5OylZCy6RADuhffUkM=;
        b=RDs43hC4IsAkFX/6QYHL9RcKFHLHl0iZTJep4C9vaVW3lQXfVKOaXMwFxgVPswY4YW
         Xco/8yrGJ7MlXHYxkrCmO4Ut2mlzvfbGVdExlbTKYdNivgsKWS9HmArOZQ30XyR9U618
         q9IOhKL5dn0pNF2D15PQtFhKsBMy6fhRObHHG4lFqIxeId21F8HlGyfsGbxEBL1eQ+4J
         1pB6SNezCNeuXixKtRm7WLJBgngRO6VA9ZgDipC//ISkuq88CtUjtTrGy+zU3vTpykLZ
         V96PUBXHb9LElNDAWHN+Md0JDVkZTbl7SAEMII2t9XGIeFr8NICfPqA6nsKStVYvLmqR
         yzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9B9ShPNjuZj2201nZeGg99lf5OylZCy6RADuhffUkM=;
        b=J/sltrESItlJh9mWwj2ZkjW8l++2B+23azhj/HAbpVGmTcdyJzu9pKPdO9eWe4h4qn
         GCaOC/uPaUzoB+hulYSec4k9zhPAqJjd7IeXPKZEiv+iNDRtvBPnIgswZu1IX6k/hY8M
         rMReol/b/w4hbG3f/tXB/fNw1yDdDUlxMRuJ8bcpZEBrQOl8RANAGBSE+hyweV2sr7M5
         E1gecToKZQM6lpCvxKpPGWJ/pWoiMdVa7GFasG3GXtv1CoI0AXZRmDh/QR5C8W3/Qz4i
         T4stg9WGKNgUDBgMK78G4RSkVagoUhOtrCXeQZLJ1y8dhtMiL4LtYa/NBuvKtfgCAkdm
         Qe6A==
X-Gm-Message-State: AOAM532qb35tRe48WW3sNpKVBo+hu5zkU0cst82xdv4nV6WVVcLQA7YQ
        ZyUK4fRxbHTh0vT21vgrHFLqTJDcD5NOg+7rn5rWqc2aXlkOcOL4
X-Google-Smtp-Source: ABdhPJzvXHpfwb7YKnxPkdK8z5gc4EhU4YMKi8uQCMu0NVfRJ5h3dp+DvMYAAr7WWWC1O4tZmDfnyJ5iUww5cnTh0I4=
X-Received: by 2002:a5b:e90:: with SMTP id z16mr1414723ybr.303.1618606632363;
 Fri, 16 Apr 2021 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk> <CANn89i+mWh3=36R8Y8Fra0wQY4p82EPDNgZ=O5P7+d8meGxsiA@mail.gmail.com>
In-Reply-To: <CANn89i+mWh3=36R8Y8Fra0wQY4p82EPDNgZ=O5P7+d8meGxsiA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 16 Apr 2021 22:57:00 +0200
Message-ID: <CANn89iLDov_F+VWmnx8q=pnM7LGcwu_JfoQ4ftGYygLAno3taQ@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:11 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Apr 16, 2021 at 9:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Apr 16, 2021 at 12:24:13PM -0700, Eric Dumazet wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > We have to loop only to copy u64 values.
> > > After this first loop, we copy at most one u32, one u16 and one byte.
> >
> > Does it actually yield a better code?
> >
>
> Yes, my patch gives a better code, on actual kernel use-case
>
> (net-next tree, look at put_cmsg())
>
> 5ca: 48 89 0f              mov    %rcx,(%rdi)
>  5cd: 89 77 08              mov    %esi,0x8(%rdi)
>  5d0: 89 57 0c              mov    %edx,0xc(%rdi)
>  5d3: 48 83 c7 10          add    $0x10,%rdi
>  5d7: 48 83 c1 f0          add    $0xfffffffffffffff0,%rcx
>  5db: 48 83 f9 07          cmp    $0x7,%rcx
>  5df: 76 40                jbe    621 <put_cmsg+0x111>
>  5e1: 66 66 66 66 66 66 2e data16 data16 data16 data16 data16 nopw
> %cs:0x0(%rax,%rax,1)
>  5e8: 0f 1f 84 00 00 00 00
>  5ef: 00
>  5f0: 49 8b 10              mov    (%r8),%rdx
>  5f3: 48 89 17              mov    %rdx,(%rdi)
>  5f6: 48 83 c7 08          add    $0x8,%rdi
>  5fa: 49 83 c0 08          add    $0x8,%r8
>  5fe: 48 83 c1 f8          add    $0xfffffffffffffff8,%rcx
>  602: 48 83 f9 07          cmp    $0x7,%rcx
>  606: 77 e8                ja     5f0 <put_cmsg+0xe0>
>  608: eb 17                jmp    621 <put_cmsg+0x111>
>  60a: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
>  610: 41 8b 10              mov    (%r8),%edx
>  613: 89 17                mov    %edx,(%rdi)
>  615: 48 83 c7 04          add    $0x4,%rdi
>  619: 49 83 c0 04          add    $0x4,%r8
>  61d: 48 83 c1 fc          add    $0xfffffffffffffffc,%rcx
>  621: 48 83 f9 03          cmp    $0x3,%rcx
>  625: 77 e9                ja     610 <put_cmsg+0x100>
>  627: eb 1a                jmp    643 <put_cmsg+0x133>
>  629: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>  630: 41 0f b7 10          movzwl (%r8),%edx
>  634: 66 89 17              mov    %dx,(%rdi)
>  637: 48 83 c7 02          add    $0x2,%rdi
>  63b: 49 83 c0 02          add    $0x2,%r8
>  63f: 48 83 c1 fe          add    $0xfffffffffffffffe,%rcx
>  643: 48 83 f9 01          cmp    $0x1,%rcx
>  647: 77 e7                ja     630 <put_cmsg+0x120>
>  649: eb 15                jmp    660 <put_cmsg+0x150>
>  64b: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>  650: 41 0f b6 08          movzbl (%r8),%ecx
>  654: 88 0f                mov    %cl,(%rdi)
>  656: 48 83 c7 01          add    $0x1,%rdi
>  65a: 49 83 c0 01          add    $0x1,%r8
>  65e: 31 c9                xor    %ecx,%ecx
>  660: 48 85 c9              test   %rcx,%rcx
>  663: 75 eb                jne    650 <put_cmsg+0x140>

After the change code is now what we would expect (no jmp around)
 5db: 48 83 f9 08          cmp    $0x8,%rcx
 5df: 72 27                jb     608 <put_cmsg+0xf8>
 5e1: 66 66 66 66 66 66 2e data16 data16 data16 data16 data16 nopw
%cs:0x0(%rax,%rax,1)
 5e8: 0f 1f 84 00 00 00 00
 5ef: 00
 5f0: 49 8b 10              mov    (%r8),%rdx
 5f3: 48 89 17              mov    %rdx,(%rdi)
 5f6: 48 83 c7 08          add    $0x8,%rdi
 5fa: 49 83 c0 08          add    $0x8,%r8
 5fe: 48 83 c1 f8          add    $0xfffffffffffffff8,%rcx
 602: 48 83 f9 08          cmp    $0x8,%rcx
 606: 73 e8                jae    5f0 <put_cmsg+0xe0>
 608: 48 83 f9 04          cmp    $0x4,%rcx
 60c: 72 11                jb     61f <put_cmsg+0x10f>
 60e: 41 8b 10              mov    (%r8),%edx
 611: 89 17                mov    %edx,(%rdi)
 613: 48 83 c7 04          add    $0x4,%rdi
 617: 49 83 c0 04          add    $0x4,%r8
 61b: 48 83 c1 fc          add    $0xfffffffffffffffc,%rcx
 61f: 48 83 f9 02          cmp    $0x2,%rcx
 623: 72 13                jb     638 <put_cmsg+0x128>
 625: 41 0f b7 10          movzwl (%r8),%edx
 629: 66 89 17              mov    %dx,(%rdi)
 62c: 48 83 c7 02          add    $0x2,%rdi
 630: 49 83 c0 02          add    $0x2,%r8
 634: 48 83 c1 fe          add    $0xfffffffffffffffe,%rcx
 638: 48 85 c9              test   %rcx,%rcx
 63b: 74 05                je     642 <put_cmsg+0x132>
 63d: 41 8a 08              mov    (%r8),%cl
 640: 88 0f                mov    %cl,(%rdi)

As I said, its minor, I am sure you can come up to something much better !

Thanks !

>

>
> > FWIW, this
> > void bar(unsigned);
> > void foo(unsigned n)
> > {
> >         while (n >= 8) {
> >                 bar(n);
> >                 n -= 8;
> >         }
> >         while (n >= 4) {
> >                 bar(n);
> >                 n -= 4;
> >         }
> >         while (n >= 2) {
> >                 bar(n);
> >                 n -= 2;
> >         }
> >         while (n >= 1) {
> >                 bar(n);
> >                 n -= 1;
> >         }
> > }
> >
> > will compile (with -O2) to
> >         pushq   %rbp
> >         pushq   %rbx
> >         movl    %edi, %ebx
> >         subq    $8, %rsp
> >         cmpl    $7, %edi
> >         jbe     .L2
> >         movl    %edi, %ebp
> > .L3:
> >         movl    %ebp, %edi
> >         subl    $8, %ebp
> >         call    bar@PLT
> >         cmpl    $7, %ebp
> >         ja      .L3
> >         andl    $7, %ebx
> > .L2:
> >         cmpl    $3, %ebx
> >         jbe     .L4
> >         movl    %ebx, %edi
> >         andl    $3, %ebx
> >         call    bar@PLT
> > .L4:
> >         cmpl    $1, %ebx
> >         jbe     .L5
> >         movl    %ebx, %edi
> >         andl    $1, %ebx
> >         call    bar@PLT
> > .L5:
> >         testl   %ebx, %ebx
> >         je      .L1
> >         addq    $8, %rsp
> >         movl    $1, %edi
> >         popq    %rbx
> >         popq    %rbp
> >         jmp     bar@PLT
> > .L1:
> >         addq    $8, %rsp
> >         popq    %rbx
> >         popq    %rbp
> >         ret
> >
> > i.e. loop + if + if + if...
