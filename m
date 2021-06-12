Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04C73A4C38
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFLCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 22:24:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:55060 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhFLCYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 22:24:11 -0400
IronPort-SDR: lZdzqZRnnYGaPl7b8mVai/rhsFNORbOptwk9COSTnozOExGj9Es4ImRa3nI4sKQ24wpL3GwGpI
 EXEbJS866Ydw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="185332880"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="185332880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:22:10 -0700
IronPort-SDR: ZysiFsrZ4pWagwIqIBTg+k5Dg7ZjYlOieEOa6PckGcJsI4HMKNINe3ACibzjyuLSMgliM25Mcf
 JpQJPXoZnuVQ==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="483473788"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.238.4.20]) ([10.238.4.20])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:22:07 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
Message-ID: <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
Date:   Sat, 12 Jun 2021 10:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/11 20:20, John Garry wrote:
> @@ -453,8 +452,7 @@ static int __init intel_iommu_setup(char *str)
>   			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
>   			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
> -			pr_info("Disable batched IOTLB flush\n");
> -			intel_iommu_strict = 1;
> +			iommu_set_dma_strict(true);

I would like to deprecate this command line and ask users to use
iommu.strict instead.

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -436,7 +436,7 @@ static int __init intel_iommu_setup(char *str)
                         pr_warn("intel_iommu=forcedac deprecated; use 
iommu.forcedac instead\n");
                         iommu_dma_forcedac = true;
                 } else if (!strncmp(str, "strict", 6)) {
-                       pr_info("Disable batched IOTLB flush\n");
+                       pr_warn("intel_iommu=strict deprecated; use 
iommu.strict instead\n");
                         intel_iommu_strict = 1;

Also update Documentation/admin-guide/kernel-parameters.txt accordingly.

Best regards,
baolu
