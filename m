Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39B3D8C00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhG1Kiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:38:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3510 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhG1Kio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:38:44 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZVFj46N2z6L9kY;
        Wed, 28 Jul 2021 18:26:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 12:38:41 +0200
Received: from [10.47.27.80] (10.47.27.80) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 11:38:41 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Message-ID: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
Date:   Wed, 28 Jul 2021 11:38:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.80]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 02:32, Ming Lei wrote:
> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>> On 23/07/2021 11:21, Ming Lei wrote:
>>>> Thanks, I was also going to suggest the latter, since it's what
>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>> indicative of where the slowness most likely stems from.
>>> The improvement from 'iommu.strict=0' is very small:
>>>
>> Have you tried turning off the IOMMU to ensure that this is really just
>> an IOMMU problem?
>>
>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>> disabling for kernel drivers).
> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> on this issue.

A ~90% throughput drop still seems to me to be too high to be a software 
issue. More so since I don't see similar on my system. And that 
throughput drop does not lead to a total CPU usage drop, from the fio log.

Do you know if anyone has run memory benchmark tests on this board to 
find out NUMA effect? I think lmbench or stream could be used for this.

Testing network performance in an equivalent fashion to storage could 
also be an idea.

Thanks,
John

> 
> And from fio log, submission latency is good, but completion latency
> is pretty bad,
> and maybe it is something that writing to PCI memory isn't committed to HW in
> time?

