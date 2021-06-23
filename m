Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BA3B1646
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFWI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:58:20 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:38010 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:58:19 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 04:58:18 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 5483D1FCF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [10.4.23.82] (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P12363T139710738269952S1624438156826560_;
        Wed, 23 Jun 2021 16:49:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <22711c7911fd7c8150801411bd65f3f9>
X-RL-SENDER: wubian@uniontech.com
X-SENDER: wubian@uniontech.com
X-LOGIN-NAME: wubian@uniontech.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 2
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210623065214.4525-1-wubian@uniontech.com>
 <YNLfVX5YVWouP1qD@kroah.com>
From:   wubian <wubian@uniontech.com>
Message-ID: <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
Date:   Wed, 23 Jun 2021 16:49:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YNLfVX5YVWouP1qD@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First,thanks for your reply

I haven’t found this problem on the x86 platform. I only found it on 
arm64. I used gdb to track memset and found that the bus error in 
glibc/sysdeps/aarch64/memset.S: dc zva, dst; reference "Architecture 
Reference ManualArmv8, for Armv8-A architecture profile" manual found 
that the dc assembly instruction（performance optimization） is related to 
the operation of the cache, that is to say, there is a bus error in the 
operation of the cache, and then check the "ARM Cortex-A Series 
Programmer's Guide for ARMv8-A " manual, found that the armv8 
architecture cache has data cache and write buffer, and there are two 
operation modes write-back and write-through, write operations in these 
two modes, the data flow will pass through the write buffer, and 
pgprot_noncached will prohibit data Cache and write buffer, this causes 
the dc command in memset to fail (bus error), and pgprot_writecombine 
does not prohibit write buffer, so the dc command in memset is 
successfully operated when pgprot_writecombine is used.

Regarding the bugfix issue, this is my first kernel patch submission, I 
may not be too clear about the boundary of the kernel bugfix. I think 
this issue is a bug, so I classify this submission as a bugfix.  At last 
hope to get your suggestion.

thanks,

wubian

On 2021/6/23 下午3:14, Greg KH wrote:
> On Wed, Jun 23, 2021 at 02:52:14PM +0800, wubian wrote:
>> On the arm64, register the uio driver and map a physical space
>> on the pci device to user space, then use memset write data to
>> the address space, a bus error will occur. This error is due to
>> the dc instruction(cache operation) used in the assembly of memset,
>> uio mapping physical memory will call pgprot_noncached() to set
>> non-cached and non-buffered, while pgprot_writecombine() has fewer
>> restrictions. It does not prohibit write buffer, so replacing
>> pgprot_noncached() with pgprot_writecombine() can solve this problem.
>>
>> Signed-off-by: wubian <wubian@uniontech.com>
>> ---
>>   drivers/uio/uio.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
>> index ea96e319c8a0..09b04b20fa30 100644
>> --- a/drivers/uio/uio.c
>> +++ b/drivers/uio/uio.c
>> @@ -739,7 +739,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>>   
>>   	vma->vm_ops = &uio_physical_vm_ops;
>>   	if (idev->info->mem[mi].memtype == UIO_MEM_PHYS)
>> +#if defined(CONFIG_ARM64)
>> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> +#else
>>   		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +#endif
> This feels really wrong, shouldn't stuff like this be handled in the
> platform itself and not in the driver?
>
> And why is ARM64 special here?  Why not other arches?  What is odd about
> this platform?  We almost never want to use #if in .c files, why is it
> ok to do that here?
>
> And is this a bugfix?  If so, what commit does it fix?  Should it go to
> stable kernels, and if so, how far back?
>
> I need more information here :)
>
> thanks,
>
> greg k-h
>
>


