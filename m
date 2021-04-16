Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA22362915
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbhDPUMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDPUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:12:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9742C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:11:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 65so31457283ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzdJn/Q16Eep/81wUMqsJd8vfyBz4vwOCErhGAmHKTg=;
        b=TBHeMpajO2+25yRUvsuIBQwizDSHJLNzB+yKR0aFiVj/HWSZOJ/+wPi7iTGyATOAfZ
         /6A/8XA0kyerHMgcB5p7Fn0ccNF634eZ6e1FduIJDgxyhBtZc6hZKag10A8QGrnWqMag
         5p3D+QejKADFVk8YI2wgi9Np8e4+Sty6QsA1M2aahquWlALZNfqWVhE1Ec82EFS0+XWP
         fRZBNAN3pDl2oI91SEkHOyI7i1zriSaXjc3yd0Te+HeUAYUXNwTT1vmbO2cLOQz/Dfid
         bOGykk/8AMT1Cspsgwy9w+SJz27Cd3YPGH3MPysV0MKDZXqctRvN0LpIzyMPfN10l4jC
         TC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzdJn/Q16Eep/81wUMqsJd8vfyBz4vwOCErhGAmHKTg=;
        b=EMC/+k9cv3WU2/d0XkPgFPAASBJczVJHcxvLz9bv0L7M8WtxOF/PYA93Za9JbDUSgy
         9/2K1YsE3DmK5xbKpaU7ym45tHUR0GgpsIT1JSApOi3PfsOEFNVXDUXXDt74SAQ5NjjF
         /pcD3D+p3BVNL2M3V28W1oaVgLIW9e1z+XhJFkqe4SQpCs66D1m5wZ/sS4OYfy0l5Y+N
         eRnsejXaMqMQNz/pOVLlfQ/MNiJ8fNgUvTessqcfy4qA+r5+1X16bWNdHLWfrW06OTfm
         9ureeltLJE/eihy8SFYCjm2hzIDoGZP0oQ3gW6q6Z797JbrViWNQcsSK9CdH+QG02yJl
         N5sQ==
X-Gm-Message-State: AOAM532xs0cHhSRSl5sa/rozLoDtxNq8K2prL4NUCLjBIekoY/e02D1H
        mSu6lWvncLdr6ldDJU0SSdr1L2+qH/5PNyZMZpxDUQ==
X-Google-Smtp-Source: ABdhPJxgXE27EItc28o951Czcqko0Ot5y3qRWIIpIfgDfqzR12Sa2QBgMnElKrCWhgUa6lWVDvHsBfPm7U2GvWMHC0c=
X-Received: by 2002:a25:6a88:: with SMTP id f130mr1227903ybc.234.1618603897688;
 Fri, 16 Apr 2021 13:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com> <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk>
In-Reply-To: <YHnpBm36PcIINhWi@zeniv-ca.linux.org.uk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 16 Apr 2021 22:11:26 +0200
Message-ID: <CANn89i+mWh3=36R8Y8Fra0wQY4p82EPDNgZ=O5P7+d8meGxsiA@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 9:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Apr 16, 2021 at 12:24:13PM -0700, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > We have to loop only to copy u64 values.
> > After this first loop, we copy at most one u32, one u16 and one byte.
>
> Does it actually yield a better code?
>

Yes, my patch gives a better code, on actual kernel use-case

(net-next tree, look at put_cmsg())

5ca: 48 89 0f              mov    %rcx,(%rdi)
 5cd: 89 77 08              mov    %esi,0x8(%rdi)
 5d0: 89 57 0c              mov    %edx,0xc(%rdi)
 5d3: 48 83 c7 10          add    $0x10,%rdi
 5d7: 48 83 c1 f0          add    $0xfffffffffffffff0,%rcx
 5db: 48 83 f9 07          cmp    $0x7,%rcx
 5df: 76 40                jbe    621 <put_cmsg+0x111>
 5e1: 66 66 66 66 66 66 2e data16 data16 data16 data16 data16 nopw
%cs:0x0(%rax,%rax,1)
 5e8: 0f 1f 84 00 00 00 00
 5ef: 00
 5f0: 49 8b 10              mov    (%r8),%rdx
 5f3: 48 89 17              mov    %rdx,(%rdi)
 5f6: 48 83 c7 08          add    $0x8,%rdi
 5fa: 49 83 c0 08          add    $0x8,%r8
 5fe: 48 83 c1 f8          add    $0xfffffffffffffff8,%rcx
 602: 48 83 f9 07          cmp    $0x7,%rcx
 606: 77 e8                ja     5f0 <put_cmsg+0xe0>
 608: eb 17                jmp    621 <put_cmsg+0x111>
 60a: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
 610: 41 8b 10              mov    (%r8),%edx
 613: 89 17                mov    %edx,(%rdi)
 615: 48 83 c7 04          add    $0x4,%rdi
 619: 49 83 c0 04          add    $0x4,%r8
 61d: 48 83 c1 fc          add    $0xfffffffffffffffc,%rcx
 621: 48 83 f9 03          cmp    $0x3,%rcx
 625: 77 e9                ja     610 <put_cmsg+0x100>
 627: eb 1a                jmp    643 <put_cmsg+0x133>
 629: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
 630: 41 0f b7 10          movzwl (%r8),%edx
 634: 66 89 17              mov    %dx,(%rdi)
 637: 48 83 c7 02          add    $0x2,%rdi
 63b: 49 83 c0 02          add    $0x2,%r8
 63f: 48 83 c1 fe          add    $0xfffffffffffffffe,%rcx
 643: 48 83 f9 01          cmp    $0x1,%rcx
 647: 77 e7                ja     630 <put_cmsg+0x120>
 649: eb 15                jmp    660 <put_cmsg+0x150>
 64b: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
 650: 41 0f b6 08          movzbl (%r8),%ecx
 654: 88 0f                mov    %cl,(%rdi)
 656: 48 83 c7 01          add    $0x1,%rdi
 65a: 49 83 c0 01          add    $0x1,%r8
 65e: 31 c9                xor    %ecx,%ecx
 660: 48 85 c9              test   %rcx,%rcx
 663: 75 eb                jne    650 <put_cmsg+0x140>


> FWIW, this
> void bar(unsigned);
> void foo(unsigned n)
> {
>         while (n >= 8) {
>                 bar(n);
>                 n -= 8;
>         }
>         while (n >= 4) {
>                 bar(n);
>                 n -= 4;
>         }
>         while (n >= 2) {
>                 bar(n);
>                 n -= 2;
>         }
>         while (n >= 1) {
>                 bar(n);
>                 n -= 1;
>         }
> }
>
> will compile (with -O2) to
>         pushq   %rbp
>         pushq   %rbx
>         movl    %edi, %ebx
>         subq    $8, %rsp
>         cmpl    $7, %edi
>         jbe     .L2
>         movl    %edi, %ebp
> .L3:
>         movl    %ebp, %edi
>         subl    $8, %ebp
>         call    bar@PLT
>         cmpl    $7, %ebp
>         ja      .L3
>         andl    $7, %ebx
> .L2:
>         cmpl    $3, %ebx
>         jbe     .L4
>         movl    %ebx, %edi
>         andl    $3, %ebx
>         call    bar@PLT
> .L4:
>         cmpl    $1, %ebx
>         jbe     .L5
>         movl    %ebx, %edi
>         andl    $1, %ebx
>         call    bar@PLT
> .L5:
>         testl   %ebx, %ebx
>         je      .L1
>         addq    $8, %rsp
>         movl    $1, %edi
>         popq    %rbx
>         popq    %rbp
>         jmp     bar@PLT
> .L1:
>         addq    $8, %rsp
>         popq    %rbx
>         popq    %rbp
>         ret
>
> i.e. loop + if + if + if...
