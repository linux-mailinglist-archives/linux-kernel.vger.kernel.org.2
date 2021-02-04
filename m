Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3730E9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhBDByv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:54:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12414 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhBDByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:54:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWM5C1KzbzjH1h;
        Thu,  4 Feb 2021 09:53:03 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 09:53:59 +0800
Subject: Re: [PATCH v14 11/11] kdump: update Documentation about crashkernel
To:     Randy Dunlap <rdunlap@infradead.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <rppt@kernel.org>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-12-chenzhou10@huawei.com>
 <686c331c-8009-1203-e8fe-b1ae67ae9652@infradead.org>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <d8c1ed02-4f9a-12cc-d6ff-762dfb80ed42@huawei.com>
Date:   Thu, 4 Feb 2021 09:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <686c331c-8009-1203-e8fe-b1ae67ae9652@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,


On 2021/1/31 1:53, Randy Dunlap wrote:
> Hi--
>
> On 1/29/21 11:10 PM, Chen Zhou wrote:
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst     | 22 ++++++++++++++++---
>>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
>>  2 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a10b545c2070..908e5c8b61ba 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> All of the "arm64" instances in [square brackets] should be "ARM64".
Got it, thanks for your review.

Thanks,
Chen Zhou
>
>> @@ -738,6 +738,9 @@
>>  			[KNL, X86-64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>> +			[KNL, arm64] Try low allocation in DMA zone and fall back
> 			      here
>
>> +			to high allocation if it fails when '@offset' hasn't been
>> +			specified.
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>>  
>>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>> @@ -754,6 +757,8 @@
>>  			Otherwise memory region will be allocated below 4G, if
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>> +			[KNL, arm64] range in high memory.
> 			      here
>
>> +			Allow kernel to allocate physical memory region from top.
>>  	crashkernel=size[KMG],low
>>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>>  			is passed, kernel could allocate physical memory region
>> @@ -762,13 +767,15 @@
>>  			requires at least 64M+32K low memory, also enough extra
>>  			low memory is needed to make sure DMA buffers for 32-bit
>>  			devices won't run out. Kernel would try to allocate at
>> -			at least 256M below 4G automatically.
>> +			least 256M below 4G automatically.
>>  			This one let user to specify own low range under 4G
>>  			for second kernel instead.
>>  			0: to disable low allocation.
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>> -
>> +			[KNL, arm64] range in low memory.
> 			      here
>
>> +			This one let user to specify a low range in DMA zone for
>> +			crash dump kernel.
>
> Thanks.
>

