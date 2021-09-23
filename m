Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6269416379
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhIWQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:42:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:64344 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhIWQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:42:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="284901791"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="284901791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 09:40:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="551214763"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 09:40:51 -0700
Date:   Thu, 23 Sep 2021 09:40:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y27nfjel.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:36:50PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 20 2021 at 19:23, Fenghua Yu wrote:
> >  
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +void pasid_put(struct task_struct *tsk, struct mm_struct *mm);
> > +#else
> > +static inline void pasid_put(struct task_struct *tsk, struct mm_struct *mm) { }
> > +#endif
> 
> This code is again defining that PASID is entirely restricted to
> INTEL. It's true, that no other vendor supports this, but PASID is
> a non-vendor specific concept.
> 
> Sticking this into INTEL code means that any other PASID implementation
> has to rip it out again from INTEL code and make it a run time property.
> 
> The refcounting issue should be the same for all PASID mechanisms which
> attach PASID to a mm. What's INTEL specific about that?
> 
> So can we pretty please do that correct right away?

It's a bit messy (surprise).

There are two reasons to hold a refcount on a PASID

1) The process has done a bind on a device that uses PASIDs

	This one isn't dependent on Intel.

2) A task within a process is using ENQCMD (and thus holds
   a reference on the PASID because IA32_PASID MSR for this
   task has the PASID value loaded with the enable bit set).

	This is (currently) Intel specific (until others
	implement an ENQCMD-like feature to allow apps to
	access PASID enabled devices without going through
	the OS).

Perhaps some better function naming might help?  E.g. have
a task_pasid_put() function that handles the process exit
case separatley from the device unbind case.

void task_pasid_put(void)
{
	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
		return;

	if (current->has_valid_pasid) {
		mutex_lock(&pasid_mutex);
		iommu_sva_free_pasid(mm);
		mutex_unlock(&pasid_mutex);
	}
}

-Tony
