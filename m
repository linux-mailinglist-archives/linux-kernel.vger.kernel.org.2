Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741313B2BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhFXJuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:50:52 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:60004 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhFXJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:50:49 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id BDF14FAE32;
        Thu, 24 Jun 2021 17:48:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [10.4.23.82] (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P12363T139709716100864S1624528101387286_;
        Thu, 24 Jun 2021 17:48:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <30bebb78a40b37b42fc888ec004cb697>
X-RL-SENDER: wubian@uniontech.com
X-SENDER: wubian@uniontech.com
X-LOGIN-NAME: wubian@uniontech.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-RCPT-COUNT: 6
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH] uio: Fix bus error that access memory mapped by physical
To:     Will Deacon <will@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <20210623065214.4525-1-wubian@uniontech.com>
 <YNLfVX5YVWouP1qD@kroah.com>
 <5a2737e1-2a77-98b0-eea7-eae04d7a9fba@uniontech.com>
 <YNL99ImFxKADvDIB@kroah.com>
 <a6562bd2-9f42-1b39-bfe6-83f1cf53f72b@uniontech.com>
 <20210624082645.GA1169@willie-the-truck>
From:   wubian <wubian@uniontech.com>
Message-ID: <2a57f130-315c-7180-faba-44507cc3817a@uniontech.com>
Date:   Thu, 24 Jun 2021 17:48:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210624082645.GA1169@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/24 下午4:26, Will Deacon wrote:
> [FYI: this landed in my spam]
> 
> On Wed, Jun 23, 2021 at 08:32:55PM +0800, wubian wrote:
>> On 2021/6/23 下午5:25, Greg KH wrote:
>>> On Wed, Jun 23, 2021 at 04:49:16PM +0800, wubian wrote:
>>>> I haven’t found this problem on the x86 platform. I only found it on arm64.
>>>> I used gdb to track memset and found that the bus error in
>>>> glibc/sysdeps/aarch64/memset.S: dc zva, dst; reference "Architecture
>>>> Reference ManualArmv8, for Armv8-A architecture profile" manual found that
>>>> the dc assembly instruction（performance optimization） is related to the
>>>> operation of the cache, that is to say, there is a bus error in the
>>>> operation of the cache, and then check the "ARM Cortex-A Series Programmer's
>>>> Guide for ARMv8-A " manual, found that the armv8 architecture cache has data
>>>> cache and write buffer, and there are two operation modes write-back and
>>>> write-through, write operations in these two modes, the data flow will pass
>>>> through the write buffer, and pgprot_noncached will prohibit data Cache and
>>>> write buffer, this causes the dc command in memset to fail (bus error), and
>>>> pgprot_writecombine does not prohibit write buffer, so the dc command in
>>>> memset is successfully operated when pgprot_writecombine is used.
>>>
>>> Are you sure this is not just a specific hardware platform issue?  Are
>>> you sure this is going to be correct for _ALL_ arm64 systems?
>>>
>>> Perhaps get the arm64 developers to agree with what is happening here as
>>> this is the first time anyone has reported this problem.
>>>
>>> What specific platform are you using that this issue happens on?
>>>
>> I apologize for the kernel mail reply format problem, I will pay attention
>> to it in the future.
>>
>> I only found this problem on Huawei Kunpeng 920 cpu at present, and found
>> that some people
>> have raised similar problems on the Internet.
>> link：https://github.com/ikwzm/udmabuf/issues/31
>>
>> @Catalin Marinas @Will Deacon Has anyone reported a similar problem on the
>> arm64 platform?
> 
> The fundamental issue here (which seems related to [1]) is that you're
> mapping MMIO into userspace and then expecting to be able to use standard
> string routines such as memset and memcpy on them. This won't work, as the
> architecture (and likely the MMIO endpoint) has restrictions on things like
> unaligned accesses, access size and atomicity for MMIO that do not apply to
> normal memory.
> 
> Returning non-cacheable rather than device mappings from UIO is likely to
> cause more problems than it solves, as it permits the CPU to make
> speculative accesses to the region. If the mapped device has side-effects,
> then this will end in disaster.
> 
> So I don't think this patch is correct, and I think that if you're exposing
> MMIO to userspace then you need to be very careful about what you do with
> it rather than blindly pass MMIO pointers into standard routines that expect
> to operate on normal memory. There's a reason drivers usually live in the
> kernel :)
> 
> Thanks,
> 
> Will
> 
> [1] https://lore.kernel.org/r/da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com
> 
> 

Thank you very much for your reply,It gave me a deeper understanding of 
this problem.

-- 
Best regards,

wubian


