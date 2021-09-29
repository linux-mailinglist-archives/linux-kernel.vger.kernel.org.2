Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B341BB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 02:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhI2AJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 20:09:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:35948 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243331AbhI2AJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 20:09:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224899512"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224899512"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 17:08:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="486731358"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 17:08:02 -0700
Date:   Tue, 28 Sep 2021 17:08:00 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <YVOuYAFaTG6Khotb@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
 <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVOp60LOL+bfh3iT@otcwcpicx3.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:50:37PM +0000, Fenghua Yu wrote:
> If xfeatures's feature bit is 0, xsaves will not write its init value to the
> memory due to init optimization. So the xsaves will do nothing and the
> state is not initialized and may have random data.

> Setting TIF_NEED_FPU_LOAD cannot guaranteed to execute XRSTORS on exiting
> to user. In fpregs_restore_userregs():
> 	if (!fpregs_state_valid(fpu, cpu)) {
> 		...
>                 __restore_fpregs_from_fpstate(&fpu->state, mask);
> 		...
> 	}
> 
> fpregs state should be invalid to get the XRSTROS executed.
> 
> So setting TIF_NEED_FPU_LOAD may get the FPU register unchanged on exiting
> to user.

Does this help?
Changed lines marked with //<<<<<

-Tony

void *begin_update_one_xsave_feature(struct task_struct *tsk,
				     enum xfeature xfeature, bool full)
{
	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
	struct xregs_state *xinit = &init_fpstate.xsave;
	u64 fmask = 1ull << xfeature;
	void *addr;

	BUG_ON(!(xsave->header.xcomp_bv & fmask));

	fpregs_lock();

	addr = __raw_xsave_addr(xsave, xfeature);

	if (full || tsk != current) {
		memcpy(addr, __raw_xsave_addr(xinit, xfeature), xstate_sizes[xfeature]);
		goto out;
	}

	if (!(xsave->header.xfeatures & fmask)) {
		xsave->header.xfeatures |= fmask;	//<<<<<
		xsaves(xsave, fmask);
	}

out:
	xsave->header.xfeatures |= fmask;
	return addr;
}

void finish_update_one_xsave_feature(struct task_struct *tsk)
{
	set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);
	if (tsk == current)				//<<<<<
		__cpu_invalidate_fpregs_state();	//<<<<<
	fpregs_unlock();
}
