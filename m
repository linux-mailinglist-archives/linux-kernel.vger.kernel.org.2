Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0A418525
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhIYXP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 19:15:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhIYXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 19:15:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632611631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J1ZoWGzgKNdZv1+1GPUZPbyfLKSZPwa1SsfVGgVfHQ=;
        b=aRMjDoovmn+6TE0WowDE7NBKLJwoTt1uwyIORPZK27b9OMiXyryB1E5SS4hw/rshuEXGye
        Ah1OKFBcr5BncroOYMPCaIHJe3+O+NUponQX2zG57PTH0f50+I7nzRa9hHgO81r/1sv2yV
        0P5v2TJwBWMsGr10qHpOhv2NCw6zjK9Jk7rXUMh3JuNOHakxqbI02i9RqL1mTMaKpPhihW
        Qck3urRos4+/D6rV/Jj26mcU6FSyRtKLgi7MrTJYXX2CTRFqybEPw4sdtA0fiGkC+ZYDi8
        sdGEmAvW7046MpL/Ls0ZC+WyXD02IAIMT1rjztCsqil/vADHfwpYVX/zW1K2ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632611631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J1ZoWGzgKNdZv1+1GPUZPbyfLKSZPwa1SsfVGgVfHQ=;
        b=2fn9k0dgSRbyGhKEwcwH3kl5WrR5oObMGA0cPN5ttKpUdYJCWHgIHtKO+PbifQ/Ymveede
        RMneKVoWKNgXQDAA==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YU34+1J4v0cn9ZRs@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU34+1J4v0cn9ZRs@otcwcpicx3.sc.intel.com>
Date:   Sun, 26 Sep 2021 01:13:50 +0200
Message-ID: <87mto0ckpd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

On Fri, Sep 24 2021 at 16:12, Fenghua Yu wrote:
> On Fri, Sep 24, 2021 at 03:18:12PM +0200, Thomas Gleixner wrote:
>> But OTOH why do you need a per task reference count on the PASID at all?
>> 
>> The PASID is fundamentaly tied to the mm and the mm can't go away before
>> the threads have gone away unless this magically changed after I checked
>> that ~20 years ago.
>
> There are up to 1M PASIDs because PASID is 20-bit. I think there are a few ways
> to allocate and free PASID:
>
> 1. Statically allocate a PASID once a mm is created and free it in mm
>    exit. No PASID allocation/free during the mm's lifetime. Then
>    up to 1M processes can be created due to 1M PASIDs limitation.
>    We don't want this method because the 1M processes limitation.

I'm not so worried about the 1M limitation, but it obviously makes sense
to avoid that because allocating stuff which is not used is pointless in
general.

> 2. A PASID is allocated to the mm in open(dev)->bind(dev, mm). There
>    are three ways to free it:
>    (a) Actively free it in close(fd)->unbind(dev, mm) by sending
>        IPIs to tell all tasks using the PASID to clear the IA32_PASID
>        MSR. This has locking issues similar to the actively loading
>        IA32_PASID MSR which was force disabled in upstream. So won't work.

Exactly.

>    (b) Passively free the PASID in destroy_context(mm) in mm exit. Once
>        the PASID is allocated, it stays with the process for the lifetime. It's
>        better than #1 because the PASID is allocated only on demand.

Which is simple and makes a lot of sense. See below.

>    (c) Passively free the PASID in deactive_mm(mm) or unbind() whenever there
>        is no usage as implemented in this series. Tracking the PASID usage
>        per task provides a chance to free the PASID on task exit. The
>        PASID has a better chance to be freed earlier than mm exit in #(b).
>
> This series uses #2 and #(c) to allocate and free the PASID for a better
> chance to ease the 1M PASIDs limitation pressure. For example, a thread
> doing open(dev)->ENQCMD->close(fd)->exit(2) will not occupy a PASID while
> its sibling threads are still running.

I'm not seeing that as a realistic problem. Applications which use this
kind of devices are unlikely to behave exactly that way.

2^20 PASIDs are really plenty and just adding code for the theoretical
case of PASID pressure is a pointless exercise IMO. It just adds
complexity for no reason.

IMO reality will be that either you have long lived processes with tons
of threads which use such devices over and over or short lived forked
processes which open the device, do the job, close and exit. Both
scenarios are fine with allocate on first use and drop on process exit.

I think with your approach you create overhead for applications which
use thread pools where the threads get work thrown at them and do open()
-> do_stuff() -> close() and then go back to wait for the next job which
will do exactly the same thing. So you add the overhead of refcounts in
general and in the worst case if the refcount drops to zero then the
next worker has to allocate a new PASID instead of just moving on.

So unless you have a really compelling real world usecase argument, I'm
arguing that the PASID pressure problem is a purely academic exercise.

I think you are conflating two things here:

  1) PASID lifetime
  2) PASID MSR overhead

Which is not correct: You still can and have to optimize the per thread
behaviour vs. the PASID MSR: Track per thread whether it ever needed the
PASID and act upon that.

If the thread just does EMQCMD once in it's lifetime, then so be
it. That's not a realistic use case, really.

And if someone does this then this does not mean we have to optimize for
that. Optimizing for possible stupid implementations is the wrong
approach. There is no technial measure against stupidity. If that would
exist the world would be a much better place.

You really have to think about the problem space you are working
on. There are problems which need a 'get it right at the first shot'
solution because they create user space ABI or otheer hard to fix
dependencies.

That's absolutely not the case here.

Get the basic simple support correct and work from there. Trying to
solve all possible theoretical problems upfront is simply not possible
and a guarantee for not making progress.

"Keep it simple" and "correctness first" are still the best working
engineering principles.

They do not prevent us from revisiting this _if_ there is a real world
problem which makes enough sense to implement a finer grained solution.

Thanks,

        tglx
