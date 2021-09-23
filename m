Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2A4157F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbhIWFsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 01:48:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:22514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhIWFsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:48:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="287437600"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="287437600"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 22:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="534117012"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2021 22:46:56 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3156573d-0d25-db0f-57ae-b6406763a8e9@linux.intel.com>
Date:   Thu, 23 Sep 2021 13:43:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920192349.2602141-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/21/21 3:23 AM, Fenghua Yu wrote:
> PASIDs are fundamentally hardware resources in a shared address space.
> There is a limited number of them to use ENQCMD on shared workqueue.
> They must be shared and managed. They can not, for instance, be
> statically allocated to processes.
> 
> Free PASID eagerly by sending IPIs in unbind was disabled due to locking
> and other issues in commit 9bfecd058339 ("x86/cpufeatures: Force disable
> X86_FEATURE_ENQCMD and remove update_pasid()").
> 
> Lazy PASID free is implemented in order to re-enable the ENQCMD feature.
> PASIDs are currently reference counted and are centered around device
> usage. To support lazy PASID free, reference counts are tracked in the
> following scenarios:
> 
> 1. The PASID's reference count is initialized as 1 when the PASID is first
>     allocated in bind. This is already implemented.
> 2. A reference is taken when a device is bound to the mm and dropped
>     when the device is unbound from the mm. This reference tracks device
>     usage of the PASID. This is already implemented.
> 3. A reference is taken when a task's IA32_PASID MSR is initialized in
>     #GP fix up and dropped when the task exits. This reference tracks
>     the task usage of the PASID. It is implemented here.
> 
> Once a PASID is allocated to an mm in bind, it's associated to the mm until
> it's freed lazily when its reference count is dropped to zero in unbind or
> exit(2).
> 
> ENQCMD requires a valid IA32_PASID MSR with the PASID value and a valid
> PASID table entry for the PASID. Lazy PASID free may cause the process
> still has the valid PASID but the PASID table entry is removed in unbind.
> In this case, workqueue submitted by ENQCMD cannot find the PASID table
> entry and will generate a DMAR fault.
> 
> Here is a more detailed explanation of the life cycle of a PASID:
> 
> All processes start out without a PASID allocated (because fork(2)
> clears the PASID in the child).
> 
> A PASID is allocated on the first open of an accelerator device by
> a call to:
> iommu_sva_bind_device()
> -> intel_svm_bind()
>     -> intel_svm_alloc_pasid()
>        -> iommu_sva_alloc_pasid()
>          -> ioasid_alloc()
> 
> At this point mm->pasid for the process is initialized, the reference
> count on that PASID is 1, but as yet no tasks within the process have
> set up their MSR_IA32_PASID to be able to execute the ENQCMD instruction.
> 
> When a task in the process does execute ENQCMD there is a #GP fault.
> The Linux handler notes that the process has a PASID allocated, and
> attempts to fix the #GP fault by initializing MSR_IA32_PASID for this
> task. It also increments the reference count for the PASID.
> 
> Additional threads in the task may also execute ENQCMD, and each
> will add to the reference count of the PASID.
> 
> Tasks within the process may open additional accelerator devices.
> In this case the call to iommu_sva_bind_device() merely increments
> the reference count for the PASID. Since all devices use the same
> PASID (all are accessing the same address space).
> 
> So the reference count on a PASID is the sum of the number of open
> accelerator devices plus the number of threads that have tried to
> execute ENQCMD.
> 
> The reverse happens as a process gives up resources. Each call to
> iommu_sva_unbind_device() will reduce the reference count on the
> PASID. Each task in the process that had set up MSR_IA32_PASID will
> reduce the reference count as it exits.
> 
> When the reference count is dropped to 0 in either task exit or
> unbind, the PASID will be freed.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/include/asm/iommu.h       |  6 +++++
>   arch/x86/include/asm/mmu_context.h |  2 ++
>   drivers/iommu/intel/svm.c          | 39 ++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 9c4bf9b0702f..d00f0a3f32fb 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -28,4 +28,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>   
>   bool __fixup_pasid_exception(void);
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +void pasid_put(struct task_struct *tsk, struct mm_struct *mm);
> +#else
> +static inline void pasid_put(struct task_struct *tsk, struct mm_struct *mm) { }
> +#endif
> +
>   #endif /* _ASM_X86_IOMMU_H */
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 27516046117a..3a2de87e98a9 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -12,6 +12,7 @@
>   #include <asm/tlbflush.h>
>   #include <asm/paravirt.h>
>   #include <asm/debugreg.h>
> +#include <asm/iommu.h>
>   
>   extern atomic64_t last_mm_ctx_id;
>   
> @@ -146,6 +147,7 @@ do {						\
>   #else
>   #define deactivate_mm(tsk, mm)			\
>   do {						\
> +	pasid_put(tsk, mm);			\
>   	load_gs_index(0);			\
>   	loadsegment(fs, 0);			\
>   } while (0)
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index ab65020019b6..8b6b8007ba2c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1187,6 +1187,7 @@ int intel_svm_page_response(struct device *dev,
>   bool __fixup_pasid_exception(void)
>   {
>   	u32 pasid;
> +	int ret;
>   
>   	/*
>   	 * This function is called only when this #GP was triggered from user
> @@ -1205,9 +1206,47 @@ bool __fixup_pasid_exception(void)
>   	if (current->has_valid_pasid)
>   		return false;
>   
> +	mutex_lock(&pasid_mutex);
> +	/* The mm's pasid has been allocated. Take a reference to it. */
> +	ret = iommu_sva_alloc_pasid(current->mm, PASID_MIN,
> +				    intel_pasid_max_id - 1);
> +	mutex_unlock(&pasid_mutex);
> +	if (ret)
> +		return false;
> +
>   	/* Fix up the MSR by the PASID in the mm. */
>   	fpu__pasid_write(pasid);
>   	current->has_valid_pasid = 1;
>   
>   	return true;
>   }
> +
> +/*
> + * pasid_put - On task exit release a reference to the mm's PASID
> + *	       and free the PASID if no more reference
> + * @mm: the mm
> + *
> + * When the task exits, release a reference to the mm's PASID if it was
> + * allocated and the IA32_PASID MSR was fixed up.
> + *
> + * If there is no reference, the PASID is freed and can be allocated to
> + * any process later.
> + */
> +void pasid_put(struct task_struct *tsk, struct mm_struct *mm)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return;
> +
> +	/*
> +	 * Nothing to do if this task doesn't have a reference to the PASID.
> +	 */
> +	if (tsk->has_valid_pasid) {
> +		mutex_lock(&pasid_mutex);
> +		/*
> +		 * The PASID's reference was taken during fix up. Release it
> +		 * now. If the reference count is 0, the PASID is freed.
> +		 */
> +		iommu_sva_free_pasid(mm);
> +		mutex_unlock(&pasid_mutex);
> +	}
> +}
> 

It looks odd that both __fixup_pasid_exception() and pasid_put() are
defined in the vendor IOMMU driver, but get called in the arch/x86
code.

Is it feasible to move these two helpers to the files where they are
called? The IA32_PASID MSR fixup and release are not part of the IOMMU
implementation.

Best regards,
baolu
