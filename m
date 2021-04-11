Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0435B6F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhDKVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhDKVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:11:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01312C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:11:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d124so7839867pfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6xOdm+Zk4/ZZ/vvuWQaRhSpOzrzYPOE+3wRzoAL0QmI=;
        b=v/tHpZPS+OJvJQ4G+VIJMcUyV5j85u/apZQ0K7QaKLveC1QbRSZ+L6qYrvc8Bqsfpl
         HOYzLz3xv1iJBYs8XqHGCBQrMC0HPXNBSQWoNi7lIYGzwn+6OZAtXbFTSReUPQ92Xn1D
         w1LVzXtRqt+1pdYMx/qniqq1IyT+YwCgT6GhcCu4urKSDSzaIUANKYGZNDk4gX7UGTWY
         ftIbP8qJPm8neCnzIRDBSF8Y2E+Eawi5rCeT6r1sqaU6osptDjJD+9kpRjTWd0MC7alT
         pF6C+JOhNWBmPJHQV0c5nPjCtxGSjSLLsQVJlxgQesNUHL3ZowCUyTVzCOkyuWNdu7JT
         T1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6xOdm+Zk4/ZZ/vvuWQaRhSpOzrzYPOE+3wRzoAL0QmI=;
        b=PtpQUZ21C2IgnoIY4DJaDdVtk+4aAxKSG6AEy/2SbDl11Fu4aT5QU9Z3TUE37BZPY+
         PD5bj4H1nzkXPvfOuYvdTAC0Tujh26HYIeLEqSaLbDKZWQTbCW4+CudurYzf7Ev077UB
         yGj7uLtnRQtV2LPhytGM4ihklnZywan32NOnAi+SRxN5QuITC1dVJoLxEd1TihS2Q0Qi
         iZqslf+h9Jq7wnEbVv+HuEhLMZqVyinQGbXs3QNLDIqCvWaLeNvcpKKBAJ6uUoA29XqF
         XCaebr4wn1PToOAZIAcfZGk7/SazTBqR6aDpPa6nho+CW+7A7MUDsdrpIy5ag82ZNwHE
         M8PA==
X-Gm-Message-State: AOAM532T6ghaaNkucOXt/K+d/Onifm+Mdb8TyCOIf6AhZ2N56noR0e9Y
        ai3GHUMRE0hsGFVjVRSP5OL5GAyQ6+clJg==
X-Google-Smtp-Source: ABdhPJw4gxZir6kSGD3JTBMYlSDlpics5szHwKrwILMYiVM3H0WGzXT1v2ibASqqnkrWcGvmR5V2zw==
X-Received: by 2002:a63:f008:: with SMTP id k8mr23555000pgh.15.1618175500173;
        Sun, 11 Apr 2021 14:11:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t5sm2582384pjy.8.2021.04.11.14.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 14:11:39 -0700 (PDT)
Date:   Sun, 11 Apr 2021 14:11:39 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 14:11:37 PDT (-0700)
Subject:     Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
In-Reply-To: <CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com>
CC:     peterz@infradead.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-0bf68290-a014-43d7-b193-8ac839c5433a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 05:53:51 PDT (-0700), anup@brainfault.org wrote:
> On Wed, Mar 24, 2021 at 6:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Mar 24, 2021 at 05:58:58PM +0530, Anup Patel wrote:
>> > On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
>> > >
>> > > From: Guo Ren <guoren@linux.alibaba.com>
>> > >
>> > > This patch introduces a ticket lock implementation for riscv, along the
>> > > same lines as the implementation for arch/arm & arch/csky.
>> > >
>> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > > Cc: Will Deacon <will.deacon@arm.com>
>> > > Cc: Peter Zijlstra <peterz@infradead.org>
>> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>> > > Cc: Anup Patel <anup@brainfault.org>
>> > > Cc: Arnd Bergmann <arnd@arndb.de>
>> > > ---
>> > >  arch/riscv/Kconfig                      |   1 +
>> > >  arch/riscv/include/asm/Kbuild           |   1 +
>> > >  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
>> > >  arch/riscv/include/asm/spinlock_types.h |  19 ++--
>> >
>> > NACK from myside.
>> >
>> > Linux ARM64 has moved away from ticket spinlock to qspinlock.
>> >
>> > We should directly go for qspinlock.
>>
>> I think it is a sensible intermediate step, even if you want to go
>> qspinlock. Ticket locks are more or less trivial and get you fairness
>> and all that goodness without the mind bending complexity of qspinlock.
>>
>> Once you have the ticket lock implementation solid (and qrwlock) and
>> everything, *then* start to carefully look at qspinlock.
>
> I do understand qspinlock are relatively complex but the best thing
> about qspinlock is it tries to ensure each CPU spins on it's own location.
>
> Instead of adding ticket spinlock now and later replacing it with qspinlock,
> it is better to straight away explore qspinlock hence my NACK.
>
>>
>> Now, arguably arm64 did the heavy lifting of making qspinlock good on
>> weak architectures, but if you want to do it right, you still have to
>> analyze the whole thing for your own architecture.
>
> Most of the RISC-V implementations are weak memory ordering so it
> makes more sense to explore qspinlock first.

I know I'm somewhat late to the party here.  I talked with Will (and 
to a lesser extent Peter) about this a week or two ago and it seems the 
best way to go here is to start with ticket locks.  They're simpler, and 
in Arm land they performed better until we got to the larger systems.  
Given that we don't have any high performance implementations of the 
RISC-V memory model (and likely won't any time soon) it's hard to reason 
about the performance of anything like this, but at a bare minimum 
having fair locks is a pretty big positive and ticket locks should have 
very little overhead while providing fairness.

IMO the decision between ticket and queueing locks is really more of a 
property of the hardware/workload than the ISA, though there are of 
course some pretty deep ISA dependencies than can make one saner than 
the other.  It seems best to me to just allow users to pick their own 
flavor of locks, and at least PPC is already doing that.  I threw 
together a quick asm-generic ticket lock that can be selected at compile 
time, but I want to spend some more time playing with the other 
architectures before sending anything out.
