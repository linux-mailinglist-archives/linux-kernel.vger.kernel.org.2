Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09499320304
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 03:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBTCJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 21:09:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:44742 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBTCHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:07:09 -0500
IronPort-SDR: RB5YM33AaiNiDsE6FTu3oYYF9nPnm/EikjwHlKcjcec4trlwHI7fnNjXtJ3l6LlFAoKCV+l6cS
 dljGWcDv8kvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268884331"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="268884331"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 18:05:16 -0800
IronPort-SDR: L4szXu6McC6DCriW0XNhCH60S6/xZTDzjLsldnupGU/EfYEAErcAU5uQpZ8BIvEu6tgd1F3c8/
 1/nBEFLkwzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="420512454"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2021 18:05:09 -0800
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
Date:   Sat, 20 Feb 2021 09:56:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob and Sanjay,

On 2/19/21 5:31 AM, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In supervisor shared virtual addressing (SVA), where page tables
> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> CR0.WP bit in the CPU.
> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.

 From reading the commit message, the intention of this patch is to match
PASID entry WPE bith with CPU CR0.WP if 1) SRE is set (supervisor
pasid); 2) page table is shared between CPU and IOMMU. Do I understand
it right?

But what the real code doing is failing pasid entry setup for first
level translation if CPU CR0.WP is not set. It's not consistent with
what described above.

What I am thinking is that, as long as SRE is set, we should always set
WPE in intel_pasid_setup_first_level(). For supervisor SVA case, we
should check CPU CR0.WP in intel_svm_bind_mm() and abort binding if
CR0.WP is not set.

Thought?

Best regards,
baolu

> 
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0cceaabc3ce6..0b7e0e726ade 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct pasid_entry *pe)
>   	pasid_set_bits(&pe->val[2], 1 << 0, 1);
>   }
>   
> +/*
> + * Setup the WPE(Write Protect Enable) field (Bit 132) of a
> + * scalable mode PASID entry.
> + */
> +static inline void pasid_set_wpe(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
> +}
> +
>   /*
>    * Setup the P(Present) field (Bit 0) of a scalable mode PASID
>    * entry.
> @@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
>   	}
>   }
>   
> +static inline int pasid_enable_wpe(struct pasid_entry *pte)
> +{
> +	unsigned long cr0 = read_cr0();
> +
> +	/* CR0.WP is normally set but just to be sure */
> +	if (unlikely(!(cr0 & X86_CR0_WP))) {
> +		pr_err_ratelimited("No CPU write protect!\n");
> +		return -EINVAL;
> +	}
> +	pasid_set_wpe(pte);
> +
> +	return 0;
> +};
> +
>   /*
>    * Set up the scalable mode pasid table entry for first only
>    * translation type.
> @@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>   			return -EINVAL;
>   		}
>   		pasid_set_sre(pte);
> +		if (pasid_enable_wpe(pte))
> +			return -EINVAL;
> +
>   	}
>   
>   	if (flags & PASID_FLAG_FL5LP) {
> 
