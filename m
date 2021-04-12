Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8735C937
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbhDLOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhDLOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:52:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rRe7DVuz4nyczLVADh65ma4uSYCAgh2zkUam7lUOvyY=; b=R3LBdCUV40azrDJv++zfvrx8FB
        0bRWVwjYXBHLVYGTpAm49md6wc0enxHpgdnNinMcxVBujd28mmXjxYw5rbVPHeamE/6gVb+lt3JrY
        1zafgCfqMylsXMuPOcQ/aQX8jBOp9x/ree0Xpo11QapNfq+jo44g7rEDx6pbYZP/Ar9LneOGEnYcj
        n9oW4EHssghlrktoos+dBVg0ldRc6z1MCc/QoPvllPbKnPR1FRJ4YCwNhwCgj1e7bPyB3fW0XIah6
        1LqpEBAeH/PfA6BmGj8A2U+sNFwfiADri/A+awnNmgzXD6gsN11Dj3/2bLY1xrhG9RzPiHdtmElkF
        HJ2+HwvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVxuv-0070VF-9F; Mon, 12 Apr 2021 14:51:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6D8D300036;
        Mon, 12 Apr 2021 16:51:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8283A2040BB0F; Mon, 12 Apr 2021 16:51:55 +0200 (CEST)
Date:   Mon, 12 Apr 2021 16:51:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YHRei8/8cIe6BNtE@hirez.programming.kicks-ass.net>
References: <CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com>
 <mhng-0bf68290-a014-43d7-b193-8ac839c5433a@palmerdabbelt-glaptop>
 <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please fix your mailer to properly flow text. Reflowed it for you.

On Mon, Apr 12, 2021 at 03:32:27PM +0200, Christoph Müllner wrote:

> This discussion came up again a few weeks ago because I've been
> stumbling over the test-and-set implementation and was wondering if
> nobody cared to improve that yet.

> Then I saw, that there have been a few attempts so far, but they did
> not land.  So I brought this up in RVI's platform group meeting and
> the attendees showed big interest to get at least fairness. I assume
> Guo sent out his new patchset as a reaction to this call (1 or 2 days
> later).
> 
> We have the same situation on OpenSBI, where we've agreed (with Anup)
> to go for a ticket lock implementation.  A series for that can be
> found here (the implementation was tested in the kernel):
> http://lists.infradead.org/pipermail/opensbi/2021-April/000789.html
> 
> In the mentioned RVI call, I've asked the question if ticket locks or
> MCF locks are preferred.  And the feedback was to go for
> qspinlock/qrwlock. One good argument to do so would be, to not have to
> maintain an RV-specific implementation, but to use a well-tested
> in-kernel mechanism.

qrwlock does not depend on qspinlock; any fair spinlock implementation
works, including ticket.

> The feedback in the call is also aligned with the previous attempts to
> enable MCF-locks on RV.  However, the kernel's implementation requires
> sub-word atomics. And here is, where we are.  The discussion last week
> was about changing the generic kernel code to loosen its requirements
> (not accepted because of performance regressions on e.g. x86) and if
> RV actually can provide sub-word atomics in form of LL/SC loops (yes,
> that's possible).

So qspinlock is a complex and fickle beast. Yes it works on x86 and
arm64 (Will and Catalin put a _lot_ of effort into that), but IMO using
such a complex thing needs to be provably better than the trivial and
simple thing (tickets, test-and-set).

Part of that is fwd progress, if you don't have that, stay with
test-and-set. Will fixed a number of issues there, and -RT actually hit
at least one.

Debugging non-deterministic lock behaviour is not on the fun list.
Having something simple (ticket) to fall back to to prove it's your lock
going 'funneh' is very useful.

> Providing sub-word xchg() can be done within a couple of hours (some
> solutions are already on the list), but that was not enough from the
> initial patchset from Michael on (e.g. Christoph Hellwig asked back
> then for moving arch-independent parts into lib, which is a good idea
> given other archs do the same).  So I expect this might require some
> more time until there is a solution, that's accepted by a broad range
> of maintainers.

Using a lib/ cmpxchg based xchg16 is daft. Per the very same arguments I
made elsewhere in the thread. cmpxchg() based loops have very difficult
fwd progress guarantees, esp. so on LL/SC architectures.

What I would do is create a common inline helper to compute that {addr,
mask, val} setup with a comment on how to use it.

(As is, we have at least 2 different ways of dealing with ENDIAN-ness)

> I've been working on a new MCF-lock series last week.  It is working,
> but I did not publish it yet, because I wanted to go through the 130+
> emails on the riscv-linux list and check for overseen review comments
> and validate the patch authors.

> You can find the current state here:
> https://github.com/cmuellner/linux/pull/new/riscv-spinlocks 

That's not public. But if that's not qspinlock, how are you justifying a
complex spinlock implementation? Does it perform better than ticket?

> So, if you insist on ticket locks, then let's coordinate who will do
> that and how it will be tested (RV32/RV64, qemu vs real hw).

Real hardware is all that counts :-)

