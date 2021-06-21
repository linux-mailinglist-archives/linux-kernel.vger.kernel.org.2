Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804283AEB59
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:34:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:23931 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUOem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:34:42 -0400
IronPort-SDR: uKDcpUG8rmEejBglAC+D+ZplvlyaVUqP6/CH5vYAf1IjkRn1S+1oOCRAFskCk0PQyKPBygWiVe
 DDRmzxdo478A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194166731"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="194166731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 07:32:27 -0700
IronPort-SDR: cfhxQQ5ewZfVr+5/hQUnHw/3u4dWOLVNI2UCwgbLVYWO71pF34FtHl/G+gqIyXbe9r1OMtNXqN
 293YgkrRky2w==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486509598"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.249]) ([10.254.211.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 07:32:23 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
To:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Message-ID: <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
Date:   Mon, 21 Jun 2021 22:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2021/6/21 19:59, Robin Murphy wrote:
> On 2021-06-21 11:34, John Garry wrote:
>> On 21/06/2021 11:00, Lu Baolu wrote:
>>>> void iommu_set_dma_strict(bool force)
>>>> {
>>>>           if (force == true)
>>>>          iommu_dma_strict = true;
>>>>      else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>>>          iommu_dma_strict = true;
>>>> }
>>>>
>>>> So we would use iommu_set_dma_strict(true) for a) and b), but 
>>>> iommu_set_dma_strict(false) for c).
>>>
>>> Yes. We need to distinguish the "must" and "nice-to-have" cases of
>>> setting strict mode.
>>>
>>>>
>>>> Then I am not sure what you want to do with the accompanying print 
>>>> for c). It was:
>>>> "IOMMU batching is disabled due to virtualization"
>>>>
>>>> And now is from this series:
>>>> "IOMMU batching disallowed due to virtualization"
>>>>
>>>> Using iommu_get_dma_strict(domain) is not appropriate here to know 
>>>> the current mode (so we know whether to print).
>>>>
>>>> Note that this change would mean that the current series would 
>>>> require non-trivial rework, which would be unfortunate so late in 
>>>> the cycle.
>>>
>>> This patch series looks good to me and I have added by reviewed-by.
>>> Probably we could make another patch series to improve it so that the
>>> kernel optimization should not override the user setting.
>>
>> On a personal level I would be happy with that approach, but I think 
>> it's better to not start changing things right away in a follow-up 
>> series.
>>
>> So how about we add this patch (which replaces 6/6 "iommu: Remove mode 
>> argument from iommu_set_dma_strict()")?
>>
>> Robin, any opinion?
> 
> For me it boils down to whether there are any realistic workloads where 
> non-strict mode *would* still perform better under virtualisation. The 

At present, we see that strict mode has better performance in the
virtualization environment because it will make the shadow page table
management more efficient. When the hardware supports nested
translation, we may have to re-evaluate this since there's no need for
a shadowing page table anymore.

> only reason for the user to explicitly pass "iommu.strict=0" is because 
> they expect it to increase unmap performance; if it's only ever going to 
> lead to an unexpected performance loss, I don't see any value in 
> overriding the kernel's decision purely for the sake of subservience.
> 
> If there *are* certain valid cases for allowing it for people who really 
> know what they're doing, then we should arguably also log a counterpart 
> message to say "we're honouring your override but beware it may have the 
> opposite effect to what you expect" for the benefit of other users who 
> assume it's a generic go-faster knob. At that point it starts getting 
> non-trivial enough that I'd want to know for sure it's worthwhile.
> 
> The other reason this might be better to revisit later is that an AMD 
> equivalent is still in flight[1], and there might be more that can 
> eventually be factored out. I think both series are pretty much good to 
> merge for 5.14, but time's already tight to sort out the conflicts which 
> exist as-is, without making them any worse.

Agreed. We could revisit it later.

Best regards,
baolu


