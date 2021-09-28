Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5641BAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbhI1XMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:12:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:65166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243196AbhI1XMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:12:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224862672"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224862672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 16:10:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="478985758"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 16:10:41 -0700
Date:   Tue, 28 Sep 2021 16:10:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
Message-ID: <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving beyond pseudo-code and into compiles-but-probably-broken-code.


The intent of the functions below is that Fenghua should be able to
do:

void fpu__pasid_write(u32 pasid)
{
	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
	struct ia32_pasid_state *addr;

	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
	addr->pasid = msr_val;
	finish_update_one_xsave_feature(current);
}

So here's the two new functions that would be added to
arch/x86/kernel/fpu/xstate.c

----

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

	/* could optimize some cases where xsaves() isn't fastest option */
        if (!(xsave->header.xfeatures & fmask))
                xsaves(xsave, fmask);

out:
        xsave->header.xfeatures |= fmask;
        return addr;
}

void finish_update_one_xsave_feature(struct task_struct *tsk)
{
        set_ti_thread_flag(task_thread_info(tsk), TIF_NEED_FPU_LOAD);
        fpregs_unlock();
}

----

-Tony
