Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12041415C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhIVFxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:53:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:14430 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhIVFxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:53:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="309075071"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="309075071"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="533570512"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 22:52:08 -0700
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] iommu/vt-d: Drop "0x" prefix from PCI bus & device
 addresses
To:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20210903193711.483999-1-helgaas@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f40e9455-c773-4edf-0b35-f86a30a4757f@linux.intel.com>
Date:   Wed, 22 Sep 2021 13:48:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903193711.483999-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 9/4/21 3:37 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault") changed
> the DMA fault reason from hex to decimal.  It also added "0x" prefixes to
> the PCI bus/device, e.g.,
> 
>    - DMAR: [INTR-REMAP] Request device [00:00.5]
>    + DMAR: [INTR-REMAP] Request device [0x00:0x00.5]
> 
> These no longer match dev_printk() and other similar messages in
> dmar_match_pci_path() and dmar_acpi_insert_dev_scope().
> 
> Drop the "0x" prefixes from the bus and device addresses.
> 
> Fixes: 719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you for this fix. I have queued it for v5.15.

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d66f79acd14d..8647a355dad0 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1944,18 +1944,18 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>   
>   	if (fault_type == INTR_REMAP)
> -		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr >> 48,
>   		       fault_reason, reason);
>   	else if (pasid == INVALID_IOASID)
> -		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
>   		       fault_reason, reason);
>   	else
> -		pr_err("[%s PASID 0x%x] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write", pasid,
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
> 
