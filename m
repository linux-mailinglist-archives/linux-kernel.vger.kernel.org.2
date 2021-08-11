Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C43E87D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhHKCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:07:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13412 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhHKCHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:07:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GktQt1SnGzdZh1;
        Wed, 11 Aug 2021 10:03:50 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 10:07:29 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 10:07:28 +0800
Subject: Re: [PATCH RFC 0/8] iommu/arm-smmu-v3: add support for ECMDQ register
 mode
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210810183529.GC3296@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <af0c3116-c110-095d-d250-0b6d56614a0b@huawei.com>
Date:   Wed, 11 Aug 2021 10:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210810183529.GC3296@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/11 2:35, Will Deacon wrote:
> On Sat, Jun 26, 2021 at 07:01:22PM +0800, Zhen Lei wrote:
>> SMMU v3.3 added a new feature, which is Enhanced Command queue interface
>> for reducing contention when submitting Commands to the SMMU, in this
>> patch set, ECMDQ is the abbreviation of Enhanced Command Queue.
>>
>> When the hardware supports ECMDQ and each core can exclusively use one ECMDQ,
>> each core does not need to compete with other cores when using its own ECMDQ.
>> This means that each core can insert commands in parallel. If each ECMDQ can
>> execute commands in parallel, the overall performance may be better. However,
>> our hardware currently does not support multiple ECMDQ execute commands in
>> parallel.
>>
>> In order to reuse existing code, I originally still call arm_smmu_cmdq_issue_cmdlist()
>> to insert commands. Even so, however, there was a performance improvement of nearly 12%
>> in strict mode.
>>
>> The test environment is the EMU, which simulates the connection of the 200 Gbit/s NIC.
>> Number of queues:    passthrough   lazy   strict(ECMDQ)  strict(CMDQ)
>>       6                  188        180       162           145        --> 11.7% improvement
>>       8                  188        188       184           183        --> 0.55% improvement
> 
> Sorry, I don't quite follow the numbers here. Why does the number of queues
> affect the classic "CMDQ" mode? We only have one queue there, right?

These queues indicates the network concurrency, maybe I should use channels or threads.
6 means six threads are deployed on different cores using their own channels to send
and receive network packets.

> 
>> In recent days, I implemented a new function without competition with other
>> cores to replace arm_smmu_cmdq_issue_cmdlist() when a core can have an ECMDQ.
>> I'm guessing it might get better performance results. Because the EMU is too
>> slow, it will take a while before the relevant data is available.
> 
> I'd certainly prefer to wait until we have something we know is
> representative. 

Yes, it would be better to have an actual set of performance data. Now the EMU is
used to analyze hardware problems. This test has not been numbered yet.

> However, I can take the first four prep patches now if you
> respin the second one. At least that's then less for you to carry.

Great. Thank you. I will respin the second one.

> 
> I'd also like review from the Arm side on this (and thank you for adopting
> the architecture unlike others seem to have done judging by the patches
> floating around).
> 
> Will
> .
> 
