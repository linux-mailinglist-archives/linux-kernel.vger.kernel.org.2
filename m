Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC17F45341F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhKPO25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:28:57 -0500
Received: from foss.arm.com ([217.140.110.172]:45848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhKPO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:28:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B4A6D;
        Tue, 16 Nov 2021 06:25:57 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8BF3F766;
        Tue, 16 Nov 2021 06:25:55 -0800 (PST)
Message-ID: <cf539ded-5c9b-38b9-ad8f-a2ea4b28ec37@arm.com>
Date:   Tue, 16 Nov 2021 14:25:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
 <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-16 14:21, John Garry wrote:
> On 04/10/2021 12:44, Will Deacon wrote:
>> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>>> The IOVA domain structure is a bit overloaded, holding:
>>> - IOVA tree management
>>> - FQ control
>>> - IOVA rcache memories
>>>
>>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>>> uses the FQ feature.
>>>
>>> This series separates out that structure. In addition, it moves the FQ
>>> code into dma-iommu.c . This is not strictly necessary, but it does make
>>> it easier for the FQ domain lookup the rcache domain.
>>>
>>> The rcache code stays where it is, as it may be reworked in future, so
>>> there is not much point in relocating and then discarding.
>>>
>>> This topic was initially discussed and suggested (I think) by Robin 
>>> here:
>>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/ 
>>>
>> It would be useful to have Robin's Ack on patches 2-4. The implementation
>> looks straightforward to me, but the thread above isn't very clear about
>> what is being suggested.
> 
> Hi Robin,
> 
> Just wondering if you had made any progress on your FQ code rework or 
> your own re-org?

Hey John - as it happens I started hacking on that in earnest about half 
an hour ago, aiming to get something out later this week.

Cheers,
Robin.

> I wasn't planning on progressing 
> https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/ 
> until this is done first (and that is still a big issue), even though 
> not strictly necessary.
> 
> Thanks,
> John
