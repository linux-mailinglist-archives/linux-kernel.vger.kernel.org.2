Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B53A4C34
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFLCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 22:16:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:55622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLCQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 22:16:47 -0400
IronPort-SDR: 1+K/mIiIqc8HcvBcGYMuDmuZMZysPDi4hSgJmGT8ntYIWZbhbdkzBV4KlruYFJKqH2wmSfp+b3
 4vCiEZCgWFQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205666199"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="205666199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:14:48 -0700
IronPort-SDR: zFoT6/2u2LKVQcB4dM1HXOmKvoCHyY0If2ZNmOSdEuMOQYuur6hisdLmnKeigQAH7F1iSht3LE
 vlMF1SL7U7MA==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="483472737"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.238.4.20]) ([10.238.4.20])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:14:45 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
Date:   Sat, 12 Jun 2021 10:14:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/11 20:20, John Garry wrote:
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2a71347611d4..4467353f981b 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -94,6 +94,7 @@ choice
>   	prompt "IOMMU default DMA mode"
>   	depends on IOMMU_DMA
>   
> +	default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>   	default IOMMU_DEFAULT_STRICT

If two default values are different. Which one will be overridden?

Best regards,
baolu
