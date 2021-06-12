Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A573A4C18
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFLBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 21:24:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:27949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLBYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:24:04 -0400
IronPort-SDR: SHfz12V4XM5GN/V3nwuTVG1Wmh7khPlWkwM6xa0ally7u2cMlRA9cuyPXkAnOf0uhr+WdOuanJ
 zffATOqw/iEg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205453110"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="205453110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 18:22:05 -0700
IronPort-SDR: HGSyKzehp43FjYp0rgwHlcVfxC/9mqaKeNAcAIonOHPHnDnfDerhV26RKa823oHg4ZqVAypTei
 ihffYAKT/tTA==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="483464843"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.238.4.20]) ([10.238.4.20])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 18:22:02 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-3-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v12 2/5] iommu: Enhance IOMMU default DMA mode build
 options
Message-ID: <a4c85f00-918b-5952-7585-8e1110ac5195@linux.intel.com>
Date:   Sat, 12 Jun 2021 09:21:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/11 20:20, John Garry wrote:
> +config IOMMU_DEFAULT_LAZY
> +	bool "lazy"
> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused.
> +
> +	  The isolation provided in this mode is not as secure as STRICT mode,
> +	  such that a vulnerable time window may be created between the DMA
> +	  unmap and the mapping finally being torn down in the IOMMU, where the
> +	  device can still access the system memory. However this mode may

" ... and the mappings cached in the IOMMU IOTLB or device TLB finally
being invalidated, where the device probably can still access the memory
which has already been unmapped by the device driver."

Best regards,
baolu
