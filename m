Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6534554C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCWCHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:07:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:32192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCWCGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:06:34 -0400
IronPort-SDR: kHlwMDKCb/F6z3k21dkAH0Q8LI2b+MZCcBPvRaFP5j3L3xr9IKlRuvMX6UmrPCagCurze36muH
 KtNQXnbDFtAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251740318"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="251740318"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 19:06:34 -0700
IronPort-SDR: 0SGTCZ4RM8Nt9ZUPWX8VYrhcTHoRFl085zSc6JqB12wAOvXBtNF8uSmc5l0c5W+X8lgwVoVlmC
 wSR2ZODFfi1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="435375555"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 19:06:31 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 2/3] iommu/vt-d: Remove IOVA domain rcache flushing for
 CPU offlining
To:     John Garry <john.garry@huawei.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <1614600741-15696-3-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f1743fc8-3968-2977-27fe-19b4a3babef9@linux.intel.com>
Date:   Tue, 23 Mar 2021 09:57:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614600741-15696-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 8:12 PM, John Garry wrote:
> Now that the core code handles flushing per-IOVA domain CPU rcaches,
> remove the handling here.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/intel/iommu.c | 31 -------------------------------
>   include/linux/cpuhotplug.h  |  1 -
>   2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..d1e66e1b07b8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4065,35 +4065,6 @@ static struct notifier_block intel_iommu_memory_nb = {
>   	.priority = 0
>   };
>   
> -static void free_all_cpu_cached_iovas(unsigned int cpu)
> -{
> -	int i;
> -
> -	for (i = 0; i < g_num_of_iommus; i++) {
> -		struct intel_iommu *iommu = g_iommus[i];
> -		struct dmar_domain *domain;
> -		int did;
> -
> -		if (!iommu)
> -			continue;
> -
> -		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
> -			domain = get_iommu_domain(iommu, (u16)did);
> -
> -			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
> -				continue;
> -
> -			iommu_dma_free_cpu_cached_iovas(cpu, &domain->domain);
> -		}
> -	}
> -}
> -
> -static int intel_iommu_cpu_dead(unsigned int cpu)
> -{
> -	free_all_cpu_cached_iovas(cpu);
> -	return 0;
> -}
> -
>   static void intel_disable_iommus(void)
>   {
>   	struct intel_iommu *iommu = NULL;
> @@ -4388,8 +4359,6 @@ int __init intel_iommu_init(void)
>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>   	if (si_domain && !hw_pass_through)
>   		register_memory_notifier(&intel_iommu_memory_nb);
> -	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
> -			  intel_iommu_cpu_dead);
>   
>   	down_read(&dmar_global_lock);
>   	if (probe_acpi_namespace_devices())
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index cedac9986557..85996494bec1 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -57,7 +57,6 @@ enum cpuhp_state {
>   	CPUHP_PAGE_ALLOC_DEAD,
>   	CPUHP_NET_DEV_DEAD,
>   	CPUHP_PCI_XGENE_DEAD,
> -	CPUHP_IOMMU_INTEL_DEAD,
>   	CPUHP_IOMMU_IOVA_DEAD,
>   	CPUHP_LUSTRE_CFS_DEAD,
>   	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
