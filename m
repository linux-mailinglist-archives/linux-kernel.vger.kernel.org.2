Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261EE308235
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhA2AEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:04:53 -0500
Received: from foss.arm.com ([217.140.110.172]:40882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhA2AEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:04:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F6413D5;
        Thu, 28 Jan 2021 16:04:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686373F66E;
        Thu, 28 Jan 2021 16:03:59 -0800 (PST)
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
To:     Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
 <20210128211020.GA3531@willie-the-truck>
 <20210128211442.GB3531@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <654abe35-bc60-741b-1238-d9c585a45c06@arm.com>
Date:   Fri, 29 Jan 2021 00:03:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128211442.GB3531@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 21:14, Will Deacon wrote:
> On Thu, Jan 28, 2021 at 09:10:20PM +0000, Will Deacon wrote:
>> On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
>>> On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
>>>> On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
>>>>> If group->default_domain exists, avoid reallocate it.
>>>>>
>>>>> In some iommu drivers, there may be several devices share a group. Avoid
>>>>> realloc the default domain for this case.
>>>>>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>   drivers/iommu/iommu.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index 3d099a31ddca..f4b87e6abe80 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
>>>>>   	 * support default domains, so the return value is not yet
>>>>>   	 * checked.
>>>>>   	 */
>>>>> -	iommu_alloc_default_domain(group, dev);
>>>>> +	if (!group->default_domain)
>>>>> +		iommu_alloc_default_domain(group, dev);
>>>>
>>>> I don't really get what this achieves, since iommu_alloc_default_domain()
>>>> looks like this:
>>>>
>>>> static int iommu_alloc_default_domain(struct iommu_group *group,
>>>> 				      struct device *dev)
>>>> {
>>>> 	unsigned int type;
>>>>
>>>> 	if (group->default_domain)
>>>> 		return 0;
>>>>
>>>> 	...
>>>>
>>>> in which case, it should be fine?
>>>
>>> oh. sorry, I overlooked this. the current code is enough.
>>> I will remove this patch. and send the next version in this week.
>>> Thanks very much.
>>
>> Actually, looking at this again, if we're dropping this patch and patch 6
>> just needs the kfree() moving about, then there's no need to repost. The
>> issue that Robin and Paul are discussing can be handled separately.

FWIW patch #6 gets dropped as well now, since Rob has applied the 
standalone fix (89c7cb1608ac).

Robin.

> Argh, except that this version of the patches doesn't apply :)
> 
> So after all that, please go ahead and post a v7 ASAP based on this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/mtk
> 
> Will
> 
