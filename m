Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535BC41B6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhI1SwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:52:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:29085 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhI1SwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:52:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204269370"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="204269370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:50:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="519215652"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:50:29 -0700
Date:   Tue, 28 Sep 2021 11:50:26 -0700
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
Message-ID: <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:51:25PM -0700, Dave Hansen wrote:
> That's close to what we want.
> 
> The size should probably be implicit.  If it isn't implicit, it needs to
> at least be double-checked against the state sizes.
> 
> Not to get too fancy, but I think we also want to have a "replace"
> operation which is separate from the "update".  Think of a case where
> you are trying to set a bit:
> 
> 	struct pkru_state *pk = start_update_xstate(tsk, XSTATE_PKRU);
> 	pk->pkru |= 0x100;
> 	finish_update_xstate(tsk, XSTATE_PKRU, pk);
> 
> versus setting a whole new value:
> 
> 	struct pkru_state *pk = start_replace_xstate(tsk, XSTATE_PKRU);
> 	memset(pkru, sizeof(*pk), 0);
> 	pk->pkru = 0x1234;
> 	finish_replace_xstate(tsk, XSTATE_PKRU, pk);
> 
> They look similar, but they actually might have very different costs for
> big states like AMX.  We can also do some very different debugging for
> them.  In normal operation, these _can_ just return pointers directly to
> the fpu...->xstate in some case.  But, if we're debugging, we could
> kmalloc() a buffer and do sanity checking before it goes into the task
> buffer.
> 
> We don't have to do any of that fancy stuff now.  We don't even need to
> do an "update" if all we need for now for XFEATURE_PASID is a "replace".
> 
> 1. Hide whether we need to write to real registers
> 2. Hide whether we need to update the in-memory image
> 3. Hide other FPU infrastructure like the TIF flag.
> 4. Make the users deal with a *whole* state in the replace API

Is that difference just whether you need to save the
state from registers to memory (for the "update" case)
or not (for the "replace" case ... where you can ignore
the current register, overwrite the whole per-feature
xsave area and mark it to be restored to registers).

If so, just a "bool full" argument might do the trick?

Also - you have a "tsk" argument in your pseudo code. Is
this needed? Are there places where we need to perform
these operations on something other than "current"?

pseudo-code:

void *begin_update_one_xsave_feature(enum xfeature xfeature, bool full)
{
	void *addr;

	BUG_ON(!(xsave->header.xcomp_bv & xfeature));

	addr = __raw_xsave_addr(xsave, xfeature);

	fpregs_lock();

	if (full)
		return addr;

	if (xfeature registers are "live")
		xsaves(xstate, 1 << xfeature);

	return addr;
}

void finish_update_one_xsave_feature(enum xfeature xfeature)
{
	mark feature modified
	set TIF bit
	fpregs_unlock();
}

-Tony
