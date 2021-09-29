Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9D41C4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbhI2M3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbhI2M3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:29:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED51C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:28:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632918490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1BMtnJgV70KLngTKgu2ZON12D6kuHuc1YBGUlYYeH4=;
        b=Zig++SWZv0uFvNn6iGF13hJygMX5H996xpm+TsQquNkXhCAmVkqTaO9mbz8DV2f/X/auqo
        gUm0Ss4GO8/nlt+ATF4qvB1V4XsR7HAUeJ57s5CtiWn5ahPg/us3yQPPK3FX1v4rcrAnwk
        rAALyWUnPCCw3LSPtmT54SScsGe1MYpPPmDUe4ZPRFW8BC8roV/YbHkUhPE47Am9hIgvCF
        nRy2uMjRf6Rg3E5PcPrARtPJ5pLWJMRMP6EzoqOwbcF1NOzoIMtUoxOQX+E66dKctUPRMZ
        l1p+xUwEYPnAxjpLh4KCF/MSU4n9rZ4YD3tJFHFvvbW1EodR0jR24DNSaGWT0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632918490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1BMtnJgV70KLngTKgu2ZON12D6kuHuc1YBGUlYYeH4=;
        b=OVL3UJh7xDcOsC045ZS9rtxR4krp71fKnSTY/BYUAQF7wAfq7q4/bwyT+V0XI9fr4dGDlf
        DzTdxqe9f01dfrDA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
Date:   Wed, 29 Sep 2021 14:28:09 +0200
Message-ID: <87r1d78t2e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29 2021 at 11:54, Peter Zijlstra wrote:
> On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
>> I think the perfect and the good are a bit confused here. If we go for
>> "good", then we have an mm owning a PASID for its entire lifetime.  If
>> we want "perfect", then we should actually do it right: teach the
>> kernel to update an entire mm's PASID setting all at once.  This isn't
>> *that* hard -- it involves two things:
>> 
>> 1. The context switch code needs to resync PASID.  Unfortunately, this
>> adds some overhead to every context switch, although a static_branch
>> could minimize it for non-PASID users.
>
>> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
>> touch FPU state.  So instead the IPI should use task_work_add() to
>> make sure PASID gets resynced.
>
> What do we need 1 for? Any PASID change can be achieved using 2 no?
>
> Basically, call task_work_add() on all relevant tasks [1], then IPI
> spray the current running of those and presto.
>
> [1] it is nigh on impossible to find all tasks sharing an mm in any sane
> way due to CLONE_MM && !CLONE_THREAD.

Why would we want any of that at all?

  Process starts, no PASID assigned.

  bind to device -> PASID is allocated and assigned to the mm

  some task of the process issues ENQCMD -> #GP -> write PASID MSR

  After that the PASID is saved and restored as part of the XSTATE and
  there is no extra overhead in context switch or return to user space.

  All tasks of the process which did never use ENQCMD don't care and their
  PASID xstate is in init state.

There is absolutely no point in enforcing that all tasks of the process
have the PASID activated immediately when it is assigned. If they need
it they get it via the #GP fixup and everything just works.

Looking at that patch again, none of this muck in fpu__pasid_write() is
required at all. The whole exception fixup is:

    if (!user_mode(regs))
             return false;

    if (!current->mm->pasid)
             return false;

    if (current->pasid_activated)
    	     return false;

    wrmsrl(MSR_IA32_PASID, current->mm->pasid);
    current->pasid_activated = true;
    return true;

There is zero requirement to look at TIF_NEED_FPU_LOAD or
fpregs_state_valid() simply because the #GP comes straight from user
space which means the FPU registers contain the current tasks user space
state.

If TIF_NEED_FPU_LOAD would be set or fpregs_state_valid() would be false
after the user_mode() check then this would simply be a bug somewhere
else and has nothing to do with this PASID fixup.

So no need for magic update_one_xstate_feature() wrappers, no
concurrency concerns, nothing.

It's that simple, really. Anything more complex is just a purely
academic exercise which creates more problems than it solves.

Thanks,

        tglx
