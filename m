Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0680638DC84
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhEWTF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:05:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231857AbhEWTF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:05:26 -0400
Received: from zn.tnic (p200300ec2f2b61005704d7abf9db126c.dip0.t-ipconnect.de [IPv6:2003:ec:2f2b:6100:5704:d7ab:f9db:126c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87EBD1EC0246;
        Sun, 23 May 2021 21:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621796638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Oq23oAI7RjigdklR/0NDVVuAn8CdBc+CrtvFbupT1xQ=;
        b=lWoeZ4QLzRbGdKieGXDRvEx7JeDUQfOx1ieICAJwhoevO8r2x0tI9SQXscQA6xIDN1WOFt
        yaXbIhBWyUxSgXc5xhsMlCxOYj6WqAaW5fSWuNkzMzB/i3KMpG/O2gDYRqV7YWa4dgbmyD
        4Z3HV5jH9F0dZtwxXEXYey+dO63E9Pg=
Date:   Sun, 23 May 2021 21:03:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Samuel Neves <sneves@dei.uc.pt>
Cc:     x86@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/usercopy: speed up 64-bit __clear_user() with
 stos{b,q}
Message-ID: <YKqnGA4t9hEizb62@zn.tnic>
References: <20210523180423.108087-1-sneves@dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210523180423.108087-1-sneves@dei.uc.pt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 07:04:23PM +0100, Samuel Neves wrote:
> The current 64-bit implementation of __clear_user consists of a simple loop
> writing an 8-byte register per iteration. On typical x86_64 chips, this will
> result in a rate of ~8 bytes per cycle.
> 
> On those same typical chips, much better is often possible, ranging from 16
> to 32 to 64 bytes per cycle. Here we want to avoid bringing vector
> instructions for this, but we can still achieve something close to those fill
> rates using `rep stos{b,q}`. This is actually how it is already done in
> usercopy_32.c.
> 
> This patch does precisely this. But because `rep stosb` can be slower for
> short fills, I've retained the old loop for sizes below 256 bytes.

Oh yes, you wanna retain the old code for old machines.

But instead of adding more unreadable asm, you can test the size and if
it is > 256 or whatever we decide is the magic value, call a separate
function which contains the ERMS alternative. Similar to how those
different functions are done in arch/x86/lib/copy_user_64.S.

> This is a somewhat arbitrary threshold; some documents say that `rep
> stosb` should be faster after 128 bytes, whereas glibc puts the
> threshold at 2048 bytes (but there it is competing against vector
> instructions). My measurements on various (but not an exhaustive
> variety of) machines suggest this is a reasonable threshold, but I
> could be mistaken.

Those measurements should be part of this commit message. Also, you
wanna test on the currently widely used microarchitectures.

> It should also be mentioned that the existent code contains a bug. In the loop
> 
>     "0: movq $0,(%[dst])\n"
>     "   addq   $8,%[dst]\n"
>     "   decl %%ecx ; jnz   0b\n"
> 
> The `decl %%ecx` instruction truncates the register containing `size/8` to
> 32 bits, which means that calling __clear_user on a buffer longer than 32 GiB
> would leave part of it unzeroed.

That needs to be a separate pre-patch fixing only this.

> This change is noticeable from userspace. That is in fact how I spotted it; in
> a hashing benchmark that read from /dev/zero, around 10-15% of the CPU time
> was spent in __clear_user. After this patch, on a Skylake CPU, these are the
> before/after figures:

I'm guessing you got those 10-15% with perf profiles?

It is a lot more persuasive when you have a before/after perf profile in
your commit message showing how __clear_user() disappears from the list
of hot functions.

> $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
> 
> $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s

As said, you wanna test a couple of currently widespread architectures
and also use a proper benchmark (not dd) to make sure you're not
introducing regressions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
