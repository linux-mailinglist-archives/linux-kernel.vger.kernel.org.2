Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B2407BEE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 07:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhILE50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 00:57:26 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42085 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhILE50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 00:57:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18C4u9aX021946;
        Sun, 12 Sep 2021 06:56:09 +0200
Date:   Sun, 12 Sep 2021 06:56:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: how many memset(,0,) calls in kernel ?
Message-ID: <20210912045608.GB16216@1wt.eu>
References: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 11:36:07PM -0400, Douglas Gilbert wrote:
> Here is a pretty rough estimate:
> $ find . -name '*.c' -exec fgrep "memset(" {} \; > memset_in_kern.txt
> 
> $ cat memset_in_kern.txt | wc -l
>     20159
> 
> Some of those are in comments, EXPORTs, etc, but the vast majority are
> in code. Plus there will be memset()s in header files not counted by
> that find. Checking in that output file I see:
> 
> $ grep ", 0," memset_in_kern.txt | wc -l
>     18107
> $ grep ", 0" memset_in_kern.txt | wc -l
>     19349
> $ grep ", 0x" memset_in_kern.txt | wc -l
>     1210
> $ grep ", 0x01" memset_in_kern.txt | wc -l
>     3
> $ grep ", 0x0," memset_in_kern.txt | wc -l
>     199
> $ grep ",0," memset_in_kern.txt | wc -l
>     72

Note that in order to get something faster and slightly more accurate,
you can use 'git grep':

   $ git grep 'memset([^,]*,\s*0\(\|x0*\),' |wc -l
   18822

> If the BSD flavours of Unix had not given us:
>    void bzero(void *s, size_t n);
> would the Linux kernel have something similar in common usage (e.g.
> memzero() or mem0() ), that was less wasteful than the standard:
>    void *memset(void *s, int c, size_t n);
> in the extremely common case where c=0 and the return value is
> not used?

What do you mean by "wasteful" here ? What are you trying to preserve,
caracters in the source code maybe ? Because the output code is already
adapted to the context thanks to memset() being builtin. Let's take one
of the first instances I found that's easy to match against asm code:

net/core/dev.c:

  int __init netdev_boot_setup(char *str)
  {
        int ints[5];
        struct ifmap map;

        str = get_options(str, ARRAY_SIZE(ints), ints);
        if (!str || !*str)
                return 0;

        /* Save settings */
        memset(&map, 0, sizeof(map));
        ...
  }

It gives this:

  16:   e8 00 00 00 00          callq  1b <netdev_boot_setup+0x1b>
                        17: R_X86_64_PC32       get_options-0x4
  1b:   48 89 c6                mov    %rax,%rsi

note that we're zeroing %eax below in preparation for the "return 0"
statement:

  1e:   31 c0                   xor    %eax,%eax

This is the "if (!str || !*str)" :

  20:   48 85 f6                test   %rsi,%rsi
  23:   0f 84 98 00 00 00       je     c1 <netdev_boot_setup+0xc1>
  29:   80 3e 00                cmpb   $0x0,(%rsi)
  2c:   0f 84 8f 00 00 00       je     c1 <netdev_boot_setup+0xc1>

%r12 is set to &map:

  32:   4c 8d 65 d0             lea    -0x30(%rbp),%r12

And this is the memset "call" itself, which reuses the zero from
the %eax register:

  36:   b9 06 00 00 00          mov    $0x6,%ecx
  3b:   4c 89 e7                mov    %r12,%rdi
  3e:   f3 ab                   rep stos %eax,%es:(%rdi)

The last line does exactly "memset(%rdi, %eax, %ecx)". Just two bytes
for some code that modern processors are even able to optimize.

As you can see there's not much waste here in the output code, and
in fact using any dedicated function would be larger and likely
slower.

Hoping this helps,
Willy
