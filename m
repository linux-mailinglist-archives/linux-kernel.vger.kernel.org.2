Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C552D41BFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbhI2Hgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:36:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:47668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243249AbhI2Hgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:36:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="211965594"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="211965594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 00:34:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="563039522"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.53]) ([10.254.210.53])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 00:34:53 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] iommu/vt-d: Clean up unused PASID updating functions
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
 <20210920192349.2602141-2-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2f2ab378-9967-ff84-18f1-c48ddeb0ceb6@linux.intel.com>
Date:   Wed, 29 Sep 2021 15:34:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920192349.2602141-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 2021/9/21 3:23, Fenghua Yu wrote:
> update_pasid() and its call chain are currently unused in the tree because
> Thomas disabled the ENQCMD feature. The feature will be re-enabled shortly
> using a different approach and update_pasid() and its call chain will not
> be used in the new approach.
> 
> Remove the useless functions.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks for this cleanup. I have queued it for v5.16.

Best regards,
baolu

> ---
>   arch/x86/include/asm/fpu/api.h |  2 --
>   drivers/iommu/intel/svm.c      | 24 +-----------------------
>   2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 23bef08a8388..ca4d0dee1ecd 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -106,6 +106,4 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
>    */
>   #define PASID_DISABLED	0
>   
> -static inline void update_pasid(void) { }
> -
>   #endif /* _ASM_X86_FPU_API_H */
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 0c228787704f..5b5d69b04fcc 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -505,21 +505,6 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>   	return ret;
>   }
>   
> -static void _load_pasid(void *unused)
> -{
> -	update_pasid();
> -}
> -
> -static void load_pasid(struct mm_struct *mm, u32 pasid)
> -{
> -	mutex_lock(&mm->context.lock);
> -
> -	/* Update PASID MSR on all CPUs running the mm's tasks. */
> -	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
> -
> -	mutex_unlock(&mm->context.lock);
> -}
> -
>   static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
>   				 unsigned int flags)
>   {
> @@ -614,10 +599,6 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   	if (ret)
>   		goto free_sdev;
>   
> -	/* The newly allocated pasid is loaded to the mm. */
> -	if (!(flags & SVM_FLAG_SUPERVISOR_MODE) && list_empty(&svm->devs))
> -		load_pasid(mm, svm->pasid);
> -
>   	list_add_rcu(&sdev->list, &svm->devs);
>   success:
>   	return &sdev->sva;
> @@ -670,11 +651,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   			kfree_rcu(sdev, rcu);
>   
>   			if (list_empty(&svm->devs)) {
> -				if (svm->notifier.ops) {
> +				if (svm->notifier.ops)
>   					mmu_notifier_unregister(&svm->notifier, mm);
> -					/* Clear mm's pasid. */
> -					load_pasid(mm, PASID_DISABLED);
> -				}
>   				pasid_private_remove(svm->pasid);
>   				/* We mandate that no page faults may be outstanding
>   				 * for the PASID when intel_svm_unbind_mm() is called.
> 
