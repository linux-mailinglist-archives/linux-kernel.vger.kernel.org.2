Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCC34C1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2CfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:35:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15026 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2CfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:35:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F7xSC6NJ1zPk4n;
        Mon, 29 Mar 2021 10:32:27 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 10:34:53 +0800
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
To:     Baoquan He <bhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com> <20210225072426.GH3553@MiWiFi-R3L-srv>
 <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
 <m14khykfeq.fsf@fess.ebiederm.org> <20210302074327.GC13714@MiWiFi-R3L-srv>
CC:     Catalin Marinas <catalin.marinas@arm.com>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <rppt@kernel.org>, <dyoung@redhat.com>,
        <will@kernel.org>, <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <5cde3992-96cf-5d7d-a252-30d1d2847b59@huawei.com>
Date:   Mon, 29 Mar 2021 10:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210302074327.GC13714@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/2 15:43, Baoquan He wrote:
> On 02/26/21 at 09:38am, Eric W. Biederman wrote:
>> chenzhou <chenzhou10@huawei.com> writes:
>>
>>> On 2021/2/25 15:25, Baoquan He wrote:
>>>> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
>>>>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
>>>>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
>>>>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
>>>>>> function reserve_crashkernel() also used 1M alignment. So just
>>>>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
>>>>> [...]
>>>>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>>>>>>  	} else {
>>>>>>  		unsigned long long start;
>>>>>>  
>>>>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>>>>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>>>>>  						  crash_base + crash_size);
>>>>>>  		if (start != crash_base) {
>>>>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>>>>> There is a small functional change here for x86. Prior to this patch,
>>>>> crash_base passed by the user on the command line is allowed to be 1MB
>>>>> aligned. With this patch, such reservation will fail.
>>>>>
>>>>> Is the current behaviour a bug in the current x86 code or it does allow
>>>>> 1MB-aligned reservations?
>>>> Hmm, you are right. Here we should keep 1MB alignment as is because
>>>> users specify the address and size, their intention should be respected.
>>>> The 1MB alignment for fixed memory region reservation was introduced in
>>>> below commit, but it doesn't tell what is Eric's request at that time, I
>>>> guess it meant respecting users' specifying.
>>
>>> I think we could make the alignment unified. Why is the alignment system reserved and
>>> user specified different? Besides, there is no document about the 1MB alignment.
>>> How about adding the alignment size(16MB) in doc  if user specified
>>> start address as arm64 does.
>> Looking at what the code is doing.  Attempting to reserve a crash region
>> at the location the user specified.  Adding unnecessary alignment
>> constraints is totally broken. 
>>
>> I am not even certain enforcing a 1MB alignment makes sense.  I suspect
>> it was added so that we don't accidentally reserve low memory on x86.
>> Frankly I am not even certain that makes sense.
>>
>> Now in practice there might be an argument for 2MB alignment that goes
>> with huge page sizes on x86.  But until someone finds that there are
>> actual problems with 1MB alignment I would not touch it.
>>
>> The proper response to something that isn't documented and confusing is
>> not to arbitrarily change it and risk breaking users.  Especially in
>> this case where it is clear that adding additional alignment is total
>> nonsense.  The proper response to something that isn't clear and
>> documented is to dig in and document it, or to leave it alone and let it
> Sounds reasonable. Then adding document or code comment around looks
> like a good way to go further so that people can easily get why its
> alignment is different than other reservation.
Hi Baoquan & Eric,

Sorry for late reply, i missed it earlier.

Thanks for your explanation, i will just leave the 1MB alignment here as is.

I will introduce CRASH_ALIGN_SPECIFIED to help make function reserve_crashkernel generic.
CRASH_ALIGN_SPECIFIED is used for user specified start address which is distinct from
default CRASH_ALIGN.

Thanks,
Chen Zhou
>
>> be the next persons problem.
>>
>> In this case there is no reason for changing this bit of code.
>> All CRASH_ALIGN is about is a default alignment when none is specified.
>> It is not a functional requirement but just something so that things
>> come out nicely.
>>
>>
>> Eric
>>
> .
>

