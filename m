Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915B41A0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhI0VEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:04:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:13996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237016AbhI0VE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:04:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224599680"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="224599680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 14:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="518731694"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 14:02:50 -0700
Date:   Mon, 27 Sep 2021 14:02:48 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:17:05PM -0700, Andy Lutomirski wrote:
> > +	fpregs_lock();
> > +
> > +	/*
> > +	 * If the task's FPU doesn't need to be loaded or is valid, directly
> > +	 * write the IA32_PASID MSR. Otherwise, write the PASID state and
> > +	 * the MSR will be loaded from the PASID state before returning to
> > +	 * the user.
> > +	 */
> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD) ||
> > +	    fpregs_state_valid(fpu, smp_processor_id())) {
> > +		wrmsrl(MSR_IA32_PASID, msr_val);
> 
> Let me try to decode this.
> 
> If the current task's FPU state is live or if the state is in memory but the CPU regs just happen to match the copy in memory, then write the MSR.  Else write the value to memory.
> 
> This is wrong.  If !TIF_NEED_FPU_LOAD && fpregs_state_valid, you MUST NOT MODIFY FPU STATE.  This is not negotiable -- you will break coherence between CPU regs and the memory image.  The way you modify the current task's state is either you modify it in CPU regs (if the kernel knows that the CPU regs are the one and only source of truth) OR you modify it in memory and invalidate any preserved copies (by zapping last_cpu). 
> 
> In any event, that particular bit of logic really doesn't belong in here -- it belongs in some helper that gets it right, once.

Andy,

A helper sounds like a good idea. Can you flesh out what
you would like that to look like?

Is it just the "where is the live register state?" so the
above could be written:

	if (xsave_state_in_memory(args ...))
		update pasid bit of xsave state in memory
	else
		wrmsrl(MSR_IA32_PASID, msr_val);

Or are you thinking of a helper that does both the check
and the update ... so the code here could be:

	update_one_xsave_feature(XFEATURE_PASID, &msr_val, sizeof(msr_val));

With the helper being something like:

void update_one_xsave_feature(enum xfeature xfeature, void *data, size_t size)
{
	if (xsave_state_in_memory(args ...)) {
		addr = get_xsave_addr(xsave, xfeature);
		memcpy(addr, data, size);
		xsave->header.xfeatures |= (1 << xfeature);
		return;
	}

	switch (xfeature) {
	case XFEATURE_PASID:
		wrmsrl(MSR_IA32_PASID, *(u64 *)data);
		break;

	case each_of_the_other_XFEATURE_enums:
		code to update registers for that XFEATURE
	}
}

either way needs the definitive correct coding for xsave_state_in_memory()

-Tony
