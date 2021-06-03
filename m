Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02772399711
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFCAmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:42:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:39200 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFCAm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:42:27 -0400
IronPort-SDR: GGionNQvg+GYWF0JfYblB7iRUNvsKrTyK6OlrQ3sT+wOH6g01moQBrK8j4ZBNZjCKrGM6b/yp5
 r9mAhl1G9b8w==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203744510"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203744510"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:40:41 -0700
IronPort-SDR: Zuk+nNOCyvGKNhXUc2GuhSRJJq7uWU0Z2qGQgUjj3tsrsLZtCpucKreWSZa8oFeMkPS9WLWbpW
 pdMsgDgnlHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="633512059"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2021 17:40:39 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
 <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
 <1cbf8cc2-8cee-0579-2514-56f664baa9cd@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e6ff4d6-cd67-d4ab-814c-e10a258191b1@linux.intel.com>
Date:   Thu, 3 Jun 2021 08:39:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1cbf8cc2-8cee-0579-2514-56f664baa9cd@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 3:48 PM, John Garry wrote:
> On 02/06/2021 05:37, Lu Baolu wrote:
>> On 6/1/21 10:29 PM, John Garry wrote:
>>> For streaming DMA mappings involving an IOMMU and whose IOVA len 
>>> regularly
>>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>>> performance can be reduced.
>>>
>>> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: 
>>> Retry
>>> from last rb tree node if iova search fails"), as discussed at [0].
>>>
>>> IOVAs which cannot be cached are highly involved in the IOVA ageing 
>>> issue,
>>> as discussed at [1].
>>>
>>> This series allows the IOVA rcache range be configured, so that we may
>>> cache all IOVAs per domain, thus improving performance.
>>>
>>> A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
>>> indirectly to configure the IOVA rcache range:
>>> /sys/kernel/iommu_groups/X/max_opt_dma_size
>>>
>>> This file is updated same as how the IOMMU group default domain type is
>>> updated, i.e. must unbind the only device in the group first.
>>
>> Could you explain why it requires singleton group and driver unbinding
>> if the user only wants to increase the upper limit? I haven't dived into
>> the details yet, sorry if this is a silly question.
> 
> Hi Baolu,
> 
> I did actually try increasing the range for a 'live' domain in the v1 
> series, but it turned out too messy. First problem is reallocating the 
> memory to hold the rcaches. Second problem is that we need to deal with 
> the issue that all IOVAs in the rcache need to be a pow-of-2, which is 
> difficult to enforce for IOVAs which weren't being cached before, but 
> now would be.
> 
> So now I changed to work similar to how we change the default domain 
> type, i.e. don't operate on a 'live' domain.

If these hard restrictions on users are just to walk around the messy
code in kernel, I would rather solve those messy code to achieve a
better user experience. :-)

Best regards,
baolu


