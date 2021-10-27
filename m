Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236D843C7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhJ0Kb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:31:29 -0400
Received: from mail-out1.in.tum.de ([131.159.0.8]:46884 "EHLO
        mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhJ0Kb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:31:28 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 06:31:27 EDT
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mail-out1.informatik.tu-muenchen.de (Postfix) with ESMTP id C77A12401CC;
        Wed, 27 Oct 2021 12:19:51 +0200 (CEST)
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id C482F172; Wed, 27 Oct 2021 12:19:51 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id A18D216F;
        Wed, 27 Oct 2021 12:19:51 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 9E068B7;
        Wed, 27 Oct 2021 12:19:51 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 99BF84A046E; Wed, 27 Oct 2021 12:19:51 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 836554A040D;
        Wed, 27 Oct 2021 12:19:50 +0200 (CEST)
        (Extended-Queue-bit tech_zfnoy@fff.in.tum.de)
Date:   Wed, 27 Oct 2021 12:19:48 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     elver@google.com, charalampos.mainas@gmail.com,
        pramod.bhatotia@in.tum.de
Subject: Potentially Broken Address Dependency via test_bit() When Compiling
 With Clang
Message-ID: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

For my bachelor thesis, I have been working on the infamous problem of 
potentially broken dependency orderings in the Linux kernel. I'm being 
advised by Marco Elver, Charalampos Mainas, Pramod Bhatotia (Cc'd).

For context, see: 
https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf

Our approach consists of two LLVM compiler passes which annotate 
dependencies in unoptimised intermediate representation (IR) and verify 
the annotated dependencies in optimised IR. ATM, the passes only 
recognise a subset of address dependencies - everything is still WIP ;-)

We have been cross-compiling with a slightly modified version of 
allyesconfig for arm64, and the passes have now found a case that we 
would like to share with LKML for feedback: an address dependency being 
broken (?) through compiler optimisations in 
fs/afs/addr_list.c::afs_iterate_addresses().

Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.c:

> [...]
>   index = READ_ONCE(ac->alist->preferred);
>   if (test_bit(index, &set))
>     goto selected;
> [...]

where test_bit() expands to the following in 
include/asm-generic/bitops/non-atomic.h, lines 115 - 122:

> static __always_inline int
> arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> {
>   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> }
> #define test_bit arch_test_bit

The address dependency gets preserved in unoptimised IR since the virtual register %33 transitively depends on %28:

> %28 = load volatile i8, i8* %preferred, align 2, !annotation !15
> store i8 %28, i8* %tmp21, align 1
> %29 = load i8, i8* %tmp21, align 1
> %conv23 = zext i8 %29 to i32
> store i32 %conv23, i32* %index, align 4
> %30 = load i32, i32* %index, align 4
> store i32 %30, i32* %nr.addr.i, align 4
> store i64* %set, i64** %addr.addr.i, align 8
> %31 = load i64*, i64** %addr.addr.i, align 8
> %32 = load i32, i32* %nr.addr.i, align 4
> %div.i = udiv i32 %32, 64
> %idxprom.i = zext i32 %div.i to i64
> %arrayidx.i = getelementptr i64, i64* %31, i64 %idxprom.i
> %33 = load volatile i64, i64* %arrayidx.i, align 8, !annotation !16

In optimised IR, there is no dependency between the two volatile loads 
anymore:

> %11 = load volatile i8, i8* %preferred, align 2, !annotation !19
> %conv25 = zext i8 %11 to i32
> %set.0. = load volatile i64, i64* %set, align 8

Now, since @nr traces back to the READ_ONCE() to @index, does this make 
the load from @addr in test_bit() address-dependent on that READ_ONCE()? 
Should the load from @addr therefore be ordered against the READ_ONCE()?

Many thanks,
Paul
