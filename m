Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18844325DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBZGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:46:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13090 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:46:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dn0Vh0lYlz16CG8;
        Fri, 26 Feb 2021 14:43:56 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Feb 2021 14:45:26 +0800
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <ebiederm@xmission.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com> <20210225072426.GH3553@MiWiFi-R3L-srv>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <will@kernel.org>, <nsaenzjulienne@suse.de>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <horms@verge.net.au>,
        <robh+dt@kernel.org>, <arnd@arndb.de>, <james.morse@arm.com>,
        <xiexiuqi@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
Date:   Fri, 26 Feb 2021 14:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210225072426.GH3553@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/25 15:25, Baoquan He wrote:
> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
>>> function reserve_crashkernel() also used 1M alignment. So just
>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
>> [...]
>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>>>  	} else {
>>>  		unsigned long long start;
>>>  
>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>>  						  crash_base + crash_size);
>>>  		if (start != crash_base) {
>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>> There is a small functional change here for x86. Prior to this patch,
>> crash_base passed by the user on the command line is allowed to be 1MB
>> aligned. With this patch, such reservation will fail.
>>
>> Is the current behaviour a bug in the current x86 code or it does allow
>> 1MB-aligned reservations?
> Hmm, you are right. Here we should keep 1MB alignment as is because
> users specify the address and size, their intention should be respected.
> The 1MB alignment for fixed memory region reservation was introduced in
> below commit, but it doesn't tell what is Eric's request at that time, I
> guess it meant respecting users' specifying.
I think we could make the alignment unified. Why is the alignment system reserved and
user specified different? Besides, there is no document about the 1MB alignment.
How about adding the alignment size(16MB) in doc  if user specified  start address as arm64 does.

Thanks,
Chen Zhou
>
> commit 44280733e71ad15377735b42d8538c109c94d7e3
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Sun Nov 22 17:18:49 2009 -0800
>
>     x86: Change crash kernel to reserve via reserve_early()
>     
>     use find_e820_area()/reserve_early() instead.
>     
>     -v2: address Eric's request, to restore original semantics.
>          will fail, if the provided address can not be used.
>
> .
>

