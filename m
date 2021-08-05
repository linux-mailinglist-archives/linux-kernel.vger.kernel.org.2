Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3113E17B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhHEPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:16:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3597 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbhHEPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:16:50 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgXJ01DVKz6F8Wk;
        Thu,  5 Aug 2021 23:16:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 17:16:34 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 16:16:33 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
 <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <44c5e07b-e663-5b96-a142-ec25666e2a14@huawei.com>
Date:   Thu, 5 Aug 2021 16:16:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2021 15:41, Robin Murphy wrote:
>> I suppose they could be combined into a smaller sub-struct and loaded 
>> in a single operation, but it looks messy, and prob without much gain.
> 
> Indeed I wouldn't say that saving memory is the primary concern here, 
> and any more convoluted code is hardly going to help performance. Plus 
> it still wouldn't help the other cases where we're just copying the size 
> into a fake queue to do some prod arithmetic - I hadn't fully clocked 
> what was going on there when I skimmed through things earlier.
> 
> Disregarding the bogus layout change, though, do you reckon the rest of 
> my idea makes sense?

I tried the similar change to avoid zero-init the padding in 
arm_smmu_cmdq_write_entries() and the 
_arm_smmu_cmdq_poll_set_valid_map(), but the disassembly was the same. 
So the compiler must have got smart there.

But for the original change in this patch, it did make a difference. 
It's nice to remove what was a memcpy:

     1770: a9077eff stp xzr, xzr, [x23, #112]
}, head = llq;
     1774: 94000000 bl 0 <memcpy>

And performance was very fractionally better.

As for pre-evaluating "nents", I'm not sure how much that can help, but 
I am not too optimistic. I can try some testing when I get a chance. 
Having said that, I would need to check the disassembly also.

Thanks,
John
