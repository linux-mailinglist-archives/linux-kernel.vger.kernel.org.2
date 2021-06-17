Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A53AADB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFQHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:36:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:33006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhFQHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:36:00 -0400
IronPort-SDR: 68Xmcwq+MAW/emJbqbytpCANQQG1ogTCs9UvMOHEkmeCJ273tSQenI5D/5B/jazN8U3U7+tsH5
 xysCZ4WjQh7g==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206138609"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206138609"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:33:52 -0700
IronPort-SDR: a0EPFHUvIKX7PvFkzYd9iYMvL8ki0WQSXSw/R+IIa22JfeJAHEAPL0HeOks4BF+F+fP5GVsqSS
 oyXhIGw2yp1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472330380"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:33:49 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
Date:   Thu, 17 Jun 2021 15:32:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623841437-211832-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 7:03 PM, John Garry wrote:
> @@ -4382,9 +4380,9 @@ int __init intel_iommu_init(void)
>   		 * is likely to be much lower than the overhead of synchronizing
>   		 * the virtual and physical IOMMU page-tables.
>   		 */
> -		if (!intel_iommu_strict && cap_caching_mode(iommu->cap)) {
> -			pr_warn("IOMMU batching is disabled due to virtualization");
> -			intel_iommu_strict = 1;
> +		if (cap_caching_mode(iommu->cap)) {
> +			pr_warn("IOMMU batching disallowed due to virtualization\n");
> +			iommu_set_dma_strict(true);

With this change, VM guest will always show this warning. How about
removing this message? Users could get the same information through the
kernel message added by "[PATCH v13 2/6] iommu: Print strict or lazy
mode at init time".

Best regards,
baolu
