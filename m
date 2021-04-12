Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A5935CF84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhDLReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbhDLReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:34:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC0DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:33:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t140so9933928pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8iuKW2KQroXTx15eBRI3lOHf/h1ChA0TwMv2sOKRwlo=;
        b=Gt8M4z+fVRfihR4j4IeFcJwQjL4tmyAMcKitcBljkVYQ5Ev//ZS8kmjUzUOmsv+PLx
         n7JETJFhhd0Aoe5wu4eqhVIIuEmH0FFKJ/xlskJjkQiumaFb8AFzQDust7tGAzSTIirM
         L3atLzgwBF1AT4ci+7o1rpvfRDNBt0dBCeHfb7Ig00xP3rU6DAAWOqvZwC1E36DyzLBF
         ZCctBt40L2yPX5Rt7pEmAUBLabOL0TqRMHtzn/jneIgea5QuA1Vj/VKY5SeobFVD5sn6
         hfRMCX/6c76HJrik1kBNbzca+Hyojg6PNzaMh/Rg8HaJ6C52Venq8fob7m/q9v4AjZ7m
         mwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8iuKW2KQroXTx15eBRI3lOHf/h1ChA0TwMv2sOKRwlo=;
        b=Jk0ZXdDRipMIQbnGLW86WNH5YpCtYSBg/GQoHiM6rTXuMo+uB8rbalmeclLVqAIn1U
         oYVTaDBh0TYjb3ocECgOUoxwd+vOfSQ3B9a5fEe9G84ldQemvAzv1SyjQ2Q7ij/K/j2p
         VtDM6mdLEqQpABIssOUAJkdmA7GH+5dhqojQ8pxd80U4wBSk0JynrNG65L7hpEYFWCGQ
         FBiJg0NbptIoCWLPQznLUeR4ru/M07c3Y78oQTJnsjlUIEQRk7lsNUP+jFCCXLl1A8SI
         HCvwkxs2YyPxl0fO/3PUZ/7UEwDrit6rPBtIZNwCa+9CJI0LEY2pw8FP9H1I79TeulcJ
         b9vQ==
X-Gm-Message-State: AOAM532R61Ds+es3zJWZZ0P6BrRz7FKdxNKKQ79Y0s5TtHOTQFU4K+Fz
        mGXzY9ELQPteraXRyZm4hYprJNYJpLZTGQ==
X-Google-Smtp-Source: ABdhPJyrsy7N+0wJigHYjefpbY0i6SQtDY/GqVwgVSB1eCLqDoR7v/iQS/icAy0h6EDw/id+kvuoLg==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr26814645pgm.135.1618248837074;
        Mon, 12 Apr 2021 10:33:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q17sm11428634pfq.171.2021.04.12.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:33:56 -0700 (PDT)
Date:   Mon, 12 Apr 2021 10:33:56 -0700 (PDT)
X-Google-Original-Date: Mon, 12 Apr 2021 10:33:54 PDT (-0700)
Subject:     Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
In-Reply-To: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
CC:     anup@brainfault.org, peterz@infradead.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     christophm30@gmail.com
Message-ID: <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 06:32:27 PDT (-0700), christophm30@gmail.com wrote:
> On Sun, Apr 11, 2021 at 11:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 24 Mar 2021 05:53:51 PDT (-0700), anup@brainfault.org wrote:
>> > On Wed, Mar 24, 2021 at 6:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> >>
>> >> On Wed, Mar 24, 2021 at 05:58:58PM +0530, Anup Patel wrote:
>> >> > On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
>> >> > >
>> >> > > From: Guo Ren <guoren@linux.alibaba.com>
>> >> > >
>> >> > > This patch introduces a ticket lock implementation for riscv, along the
>> >> > > same lines as the implementation for arch/arm & arch/csky.
>> >> > >
>> >> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> >> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> > > Cc: Will Deacon <will.deacon@arm.com>
>> >> > > Cc: Peter Zijlstra <peterz@infradead.org>
>> >> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>> >> > > Cc: Anup Patel <anup@brainfault.org>
>> >> > > Cc: Arnd Bergmann <arnd@arndb.de>
>> >> > > ---
>> >> > >  arch/riscv/Kconfig                      |   1 +
>> >> > >  arch/riscv/include/asm/Kbuild           |   1 +
>> >> > >  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
>> >> > >  arch/riscv/include/asm/spinlock_types.h |  19 ++--
>> >> >
>> >> > NACK from myside.
>> >> >
>> >> > Linux ARM64 has moved away from ticket spinlock to qspinlock.
>> >> >
>> >> > We should directly go for qspinlock.
>> >>
>> >> I think it is a sensible intermediate step, even if you want to go
>> >> qspinlock. Ticket locks are more or less trivial and get you fairness
>> >> and all that goodness without the mind bending complexity of qspinlock.
>> >>
>> >> Once you have the ticket lock implementation solid (and qrwlock) and
>> >> everything, *then* start to carefully look at qspinlock.
>> >
>> > I do understand qspinlock are relatively complex but the best thing
>> > about qspinlock is it tries to ensure each CPU spins on it's own location.
>> >
>> > Instead of adding ticket spinlock now and later replacing it with qspinlock,
>> > it is better to straight away explore qspinlock hence my NACK.
>> >
>> >>
>> >> Now, arguably arm64 did the heavy lifting of making qspinlock good on
>> >> weak architectures, but if you want to do it right, you still have to
>> >> analyze the whole thing for your own architecture.
>> >
>> > Most of the RISC-V implementations are weak memory ordering so it
>> > makes more sense to explore qspinlock first.
>>
>> I know I'm somewhat late to the party here.  I talked with Will (and
>> to a lesser extent Peter) about this a week or two ago and it seems the
>> best way to go here is to start with ticket locks.  They're simpler, and
>> in Arm land they performed better until we got to the larger systems.
>> Given that we don't have any high performance implementations of the
>> RISC-V memory model (and likely won't any time soon) it's hard to reason
>> about the performance of anything like this, but at a bare minimum
>> having fair locks is a pretty big positive and ticket locks should have
>> very little overhead while providing fairness.
>>
>> IMO the decision between ticket and queueing locks is really more of a
>> property of the hardware/workload than the ISA, though there are of
>> course some pretty deep ISA dependencies than can make one saner than
>> the other.  It seems best to me to just allow users to pick their own
>> flavor of locks, and at least PPC is already doing that.  I threw
>> together a quick asm-generic ticket lock that can be selected at compile
>> time, but I want to spend some more time playing with the other
>> architectures before sending anything out.
>
> This discussion came up again a few weeks ago because I've been stumbling over
> the test-and-set implementation and was wondering if nobody cared to
> improve that yet.
> Then I saw, that there have been a few attempts so far, but they did not land.
> So I brought this up in RVI's platform group meeting and the attendees
> showed big
> interest to get at least fairness. I assume Guo sent out his new
> patchset as a reaction
> to this call (1 or 2 days later).
>
> We have the same situation on OpenSBI, where we've agreed (with Anup)
> to go for a ticket lock implementation.
> A series for that can be found here (the implementation was tested in
> the kernel):
> http://lists.infradead.org/pipermail/opensbi/2021-April/000789.html
>
> In the mentioned RVI call, I've asked the question if ticket locks or
> MCF locks are preferred.
> And the feedback was to go for qspinlock/qrwlock. One good argument to
> do so would be,
> to not have to maintain an RV-specific implementation, but to use a
> well-tested in-kernel mechanism.
>
> The feedback in the call is also aligned with the previous attempts to
> enable MCF-locks on RV.
> However, the kernel's implementation requires sub-word atomics. And
> here is, where we are.
> The discussion last week was about changing the generic kernel code to
> loosen its requirements
> (not accepted because of performance regressions on e.g. x86) and if
> RV actually can provide
> sub-word atomics in form of LL/SC loops (yes, that's possible).
> Providing sub-word xchg() can be done within a couple of hours (some
> solutions are already on the list),
> but that was not enough from the initial patchset from Michael on
> (e.g. Christoph Hellwig asked back then
> for moving arch-independent parts into lib, which is a good idea given
> other archs do the same).
> So I expect this might require some more time until there is a
> solution, that's accepted by
> a broad range of maintainers.
>
> I've been working on a new MCF-lock series last week.
> It is working, but I did not publish it yet, because I wanted to go
> through the 130+ emails
> on the riscv-linux list and check for overseen review comments and
> validate the patch authors.
> You can find the current state here:
> https://github.com/cmuellner/linux/pull/new/riscv-spinlocks
> So, if you insist on ticket locks, then let's coordinate who will do
> that and how it will be tested
> (RV32/RV64, qemu vs real hw).

My plan is to add a generic ticket-based lock, which can be selected at 
compile time.  It'll have no architecture dependencies (though it'll 
likely have some hooks for architectures that can make this go faster).  
Users can then just pick which spinlock flavor they want, with the idea 
being that smaller systems will perform better with ticket locks and 
larger systems will perform better with queued locks.  The main goal 
here is to give the less widely used architectures an easy way to have 
fair locks, as right now we've got a lot of code duplication because any 
architecture that wants ticket locks has to do it themselves.

I'm not really convinced we have the ability to discuss the performance 
of locks on RISC-V right now, at least in any meaningful capacity.  The 
set of systems we have right now are just so far off from having a 
competitive memory system that optimizing for them doesn't seem to be 
worth the time, and as there really aren't any users we don't know what 
workloads people care about.  I'm mostly interested in just keeping the 
implementation simple, and ticket locks are the simplest spinlock flavor 
I know of that's fair (I think we can all agree that unfair locks are 
going to be a disaster).

There are certainly classes of systems for which ticket locks will be 
the wrong choice, and for those it makes sense to use the generic 
qspinlock implementation.  We'll likely need some changes to make that 
go fast on RISC-V, but we won't know what those are until we have 
hardware.  For now just having something that works (while staying away 
from anything that's obviously horribly inefficient) is as good as we 
can do, so I'm perfectly happy to take whatever we need to enable 
qspinlock on RISC-V.

I'll likely default to the ticket locks on RISC-V as it's simpler, but 
my main goal is to just get rid of the code duplication.  IMO the 
correct lock flavor is really something that's tightly coupled to both 
the microarchitecture and workload, but given how poorly the current 
crop of implementations performs on anything parallel I'm more swayed by 
simplicity.  When we end up with real hardware I'll be happy to 
re-evaluate that choice, but I don't think it's all that important today 
because we're going to need a whole new generation of implementations 
(and likely at least some ISA clarifications, as whether anything based 
on cmpxchg can be fair right now is still an open question) before we 
have anything competitive.

If you guys want to go throw a "thou shalt make queued spinlocks better 
than ticket spinlocks" (or the other way around, I don't really 
personally care all that much about spinlock flavors) in the platform 
spec that's fine.  Performance knobs are always a headache so getting 
rid of one would be great, but ultimately this is a microarchitecture 
thing so we'll have to see what gets implemented.
