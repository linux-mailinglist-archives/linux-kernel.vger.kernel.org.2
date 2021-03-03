Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27F932BAC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358196AbhCCL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:57:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:50826 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353481AbhCCFKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:10:31 -0500
IronPort-SDR: wj1Od6u7aO6+EBwNwDXd7Ph+8uJDFybkZ86Gj0xBCAPw+CeJQeuOMh7FFT+Cq1ZWn6MZ7h0/5t
 VVtNLOtZfgzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166994474"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="166994474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:05:35 -0800
IronPort-SDR: 6N2e6t3C0vD1bK+9VPpST7R5y91de6mZdMt1BziH1esbyl/T8rJwFrl5hzdiW7ThZb24DUVddq
 Ibnt9yW1gSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="428035582"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 21:05:33 -0800
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor
 SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9190a39d-13c2-c288-e8cd-a1c8adb8e600@linux.intel.com>
Date:   Wed, 3 Mar 2021 12:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 6:13 PM, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In supervisor shared virtual addressing (SVA), where page tables
> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> CR0.WP bit in the CPU.
> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.
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

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
