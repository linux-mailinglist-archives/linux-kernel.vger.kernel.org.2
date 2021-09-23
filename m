Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829B94164A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbhIWRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbhIWRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:49:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26CDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:48:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632419292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI90BA5MPkAckY4vCCiww4UBg58P9vuxvJTxiYDoROo=;
        b=0UJ1kq8zXk/55UFzhAZk8Pa/XZuXjzCVfxiIxP2wPsrRq/WS8NctFN9pPIrs3nmofqPIP7
        H2aPjzRh9GR+G9Cdb8xTKWQufz1VHAQ6dujOII5dU+SvvFZ6ykivpnYLA/Ah1uTOZt/ulB
        kNKfoZsD3Kb4/+Vx0LNVNygBQ0+ky6S5krGcltgbWTDxsI4dzNlM68MNSkDxrHF0QykUAA
        O9pkfxEdPXUb/iI1LEehs5tBa8v8bTd9tEmIovUEIpBseIU/ZySvqgn8125Dhvh8w0phry
        n1W85HXgx53+fXcgANboDgJUTbFKkNRPO1pfr3pzAHoKKz5LPPteZ7/TGQJxSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632419292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jI90BA5MPkAckY4vCCiww4UBg58P9vuxvJTxiYDoROo=;
        b=ORk/j6uylsTqc5jG0yKd1pGXrqufsWVy4PgKm8KzRi0t/b5TInyrmgTwhDGlN5E+6QEECX
        z2wrzbL+gvYV1XCQ==
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
Date:   Thu, 23 Sep 2021 19:48:11 +0200
Message-ID: <87o88jfajo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
> On Thu, Sep 23, 2021 at 04:36:50PM +0200, Thomas Gleixner wrote:
>> This code is again defining that PASID is entirely restricted to
>> INTEL. It's true, that no other vendor supports this, but PASID is
>> a non-vendor specific concept.
>> 
>> Sticking this into INTEL code means that any other PASID implementation
>> has to rip it out again from INTEL code and make it a run time property.
>> 
>> The refcounting issue should be the same for all PASID mechanisms which
>> attach PASID to a mm. What's INTEL specific about that?
>> 
>> So can we pretty please do that correct right away?
>
> It's a bit messy (surprise).
>
> There are two reasons to hold a refcount on a PASID
>
> 1) The process has done a bind on a device that uses PASIDs
>
> 	This one isn't dependent on Intel.

Yep.

> 2) A task within a process is using ENQCMD (and thus holds
>    a reference on the PASID because IA32_PASID MSR for this
>    task has the PASID value loaded with the enable bit set).
>
> 	This is (currently) Intel specific (until others
> 	implement an ENQCMD-like feature to allow apps to
> 	access PASID enabled devices without going through
> 	the OS).

Right, but all it does is to grab another reference on the PASID and if
the task exits it needs to be dropped, right?

So you already added 'has_valid_pasid' to task_struct, which is a
misnomer btw. The meaning of this flag is that the task is actually
using the PASID (in the ENQCMD case written to the MSR) beyond the
purposes of the PASID which is attached to current->mm.

But the information which is important from a pasid resource management
POV is whether the task actually holds a seperate refcount on the PASID
or not. That's completely generic. It does not matter whether the task
uses it to populate the IA32_PASID_MSR or to just keeps it in memory
just because it can. The point is that is holds a refcount.

So we can have a generic interface:

int iommu_pasid_get_task_ref()
{
        if (current->holds_pasid_ref)
        	return -EYOUGOTONEALREADY;

	if (!has_pasid(current->mm)
		return -EWHATAREYOUASKINGFOR;

	if (!iommu->pasid_get_ref)
		return -EHOWDIDYOUMAKEUPAPASID;

	if (iommu->pasid_get_ref())
        	return -ETHEIOMMUDOESNOTLIKEYOU;
        
        current->holds_pasid_ref = true;
        return 0;
}

Actually letting this return a bool should be good enough, but you get
the idea.

void iommu_pasid_put_task_ref()
{
        if (!current->holds_pasid_ref)
        	return;
        current->holds_pasid_ref = false;
	iommu->pasid_put_ref();
}

Which makes the exception handling in traps.c the real x86/intel
specific muck:

bool fixup_pasid_exception(...)
{
        /* ENCQMD and future muck */
	if (!per_task_pasid_usage_enabled())
        	return false;
        if (iommu_pasid_get_ref())
        	return false;
        fpu_write_task_pasid();
        return true;
}

fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
and be done with it.

The task exit code can just call iommu_pasid_put_task_ref() from the
generic code and not from within x86.

That means you want in Kconfig:

     PASID_TASK_REFS
     bool

and select that when a IOMMU supporting it is enabled and provide either
the proper protypes or stub functions depending on that.

Hmm?

Thanks,

        tglx




