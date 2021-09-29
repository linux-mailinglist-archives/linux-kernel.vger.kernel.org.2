Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076741CAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbhI2RB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344809AbhI2RBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40053613D1;
        Wed, 29 Sep 2021 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632934783;
        bh=NIb8p1udmU2cyyxgdKTASy2CHdIukYGs/zoSTQfFkTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JUXaf/PU8zljz7WC6Nq05HvgArXrLqToUQ1ZwS6h6AisXMXNfCYy1rRmH/E9gILcm
         fBe8b58GTWuoDqSGlWgsbKMZAX0BSNwQBPuQgZ+yIlXKCSA7MUZkL1fqld8f8nY3JK
         72grjrOBGxS4d74bnNQ2kyZR8nSEZ9PmcUSts6Janc2AADE1d/g/ZcZ8MNvkxc4OuX
         lIFCscyzIf6jaD200C6wFbHJ9qEUj/lzukmjwSpfBAdRsZmrko55fyRgg62RhP/0no
         AHV/HzoAzi8A/LxCNU+iYq3GB2898pCWft87k/IL9O5AGmVIyiZlwXLhUeUxjs2Gtp
         QcK7gWdplJdNw==
Message-ID: <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
Date:   Wed, 29 Sep 2021 09:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
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
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <87r1d78t2e.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/21 05:28, Thomas Gleixner wrote:
> On Wed, Sep 29 2021 at 11:54, Peter Zijlstra wrote:
>> On Fri, Sep 24, 2021 at 04:03:53PM -0700, Andy Lutomirski wrote:
>>> I think the perfect and the good are a bit confused here. If we go for
>>> "good", then we have an mm owning a PASID for its entire lifetime.  If
>>> we want "perfect", then we should actually do it right: teach the
>>> kernel to update an entire mm's PASID setting all at once.  This isn't
>>> *that* hard -- it involves two things:
>>>
>>> 1. The context switch code needs to resync PASID.  Unfortunately, this
>>> adds some overhead to every context switch, although a static_branch
>>> could minimize it for non-PASID users.
>>
>>> 2. A change to an mm's PASID needs to sent an IPI, but that IPI can't
>>> touch FPU state.  So instead the IPI should use task_work_add() to
>>> make sure PASID gets resynced.
>>
>> What do we need 1 for? Any PASID change can be achieved using 2 no?
>>
>> Basically, call task_work_add() on all relevant tasks [1], then IPI
>> spray the current running of those and presto.
>>
>> [1] it is nigh on impossible to find all tasks sharing an mm in any sane
>> way due to CLONE_MM && !CLONE_THREAD.
> 
> Why would we want any of that at all?
> 
>    Process starts, no PASID assigned.
> 
>    bind to device -> PASID is allocated and assigned to the mm
> 
>    some task of the process issues ENQCMD -> #GP -> write PASID MSR
> 
>    After that the PASID is saved and restored as part of the XSTATE and
>    there is no extra overhead in context switch or return to user space.
> 
>    All tasks of the process which did never use ENQCMD don't care and their
>    PASID xstate is in init state.
> 
> There is absolutely no point in enforcing that all tasks of the process
> have the PASID activated immediately when it is assigned. If they need
> it they get it via the #GP fixup and everything just works.
> 
> Looking at that patch again, none of this muck in fpu__pasid_write() is
> required at all. The whole exception fixup is:
> 
>      if (!user_mode(regs))
>               return false;
> 
>      if (!current->mm->pasid)
>               return false;
> 
>      if (current->pasid_activated)
>      	     return false;

<-- preemption or BH here: kaboom.

> 
>      wrmsrl(MSR_IA32_PASID, current->mm->pasid);

This needs the actual sane fpstate writing helper -- see other email.
