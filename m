Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D2320382
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 04:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBTD0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 22:26:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12929 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTD0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 22:26:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DjDM00FpZzjP9W;
        Sat, 20 Feb 2021 11:24:12 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Feb 2021 11:25:20 +0800
Subject: Re: [PATCH v14 11/11] kdump: update Documentation about crashkernel
To:     Baoquan He <bhe@redhat.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-12-chenzhou10@huawei.com>
 <20210218083822.GL2871@MiWiFi-R3L-srv>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <4fbc4cdc-9888-bf34-1fcc-f5bcb0349042@huawei.com>
Date:   Sat, 20 Feb 2021 11:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210218083822.GL2871@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/18 16:40, Baoquan He wrote:
> On 01/30/21 at 03:10pm, Chen Zhou wrote:
>> For arm64, the behavior of crashkernel=X has been changed, which
>> tries low allocation in DMA zone and fall back to high allocation
>> if it fails.
>>
>> We can also use "crashkernel=X,high" to select a high region above
>> DMA zone, which also tries to allocate at least 256M low memory in
>> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
>> specified size low memory.
>>
>> So update the Documentation.
> Nice document adding which also takes care of x86 code implementation,
> thanks. By the way, maybe you can remove John's 'Tested-by' since it
> doesn't make much sense to test a document patch.
I will remove the Tested-by in next version.
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst     | 22 ++++++++++++++++---
>>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
>>  2 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 75a9dd98e76e..0877c76f8015 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -299,7 +299,16 @@ Boot into System Kernel
>>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>>  
>> -   On x86 and x86_64, use "crashkernel=64M@16M".
>> +   On x86 use "crashkernel=64M@16M".
>> +
>> +   On x86_64, use "crashkernel=X" to select a region under 4G first, and
>> +   fall back to reserve region above 4G. And go for high allocation
>> +   directly if the required size is too large.
>> +   We can also use "crashkernel=X,high" to select a region above 4G, which
>> +   also tries to allocate at least 256M below 4G automatically and
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from specified
>> +   start address X.
>>  
>>     On ppc64, use "crashkernel=128M@32M".
>>  
>> @@ -316,8 +325,15 @@ Boot into System Kernel
>>     kernel will automatically locate the crash kernel image within the
>>     first 512MB of RAM if X is not given.
>>  
>> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
>> +   fall back to high allocation if it fails.
>> +   We can also use "crashkernel=X,high" to select a high region above
>> +   DMA zone, which also tries to allocate at least 256M low memory in
>> +   DMA zone automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>>  
>>  Load the Dump-capture Kernel
>>  ============================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a10b545c2070..908e5c8b61ba 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -738,6 +738,9 @@
>>  			[KNL, X86-64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>> +			[KNL, arm64] Try low allocation in DMA zone and fall back
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
>> +			This one let user to specify a low range in DMA zone for
>> +			crash dump kernel.
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>>  
>> -- 
>> 2.20.1
>>
> .
>

