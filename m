Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A6A40F2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhIQHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:11:56 -0400
Received: from foss.arm.com ([217.140.110.172]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238288AbhIQHLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:11:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0B931B;
        Fri, 17 Sep 2021 00:10:31 -0700 (PDT)
Received: from [10.163.71.122] (unknown [10.163.71.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC843F59C;
        Fri, 17 Sep 2021 00:10:29 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm/hotplug: Warn when memory limit has been reduced
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <1631602270-29215-1-git-send-email-anshuman.khandual@arm.com>
 <YUNV8fOxfSSFKZBK@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d9ecfa61-cc02-a419-a571-6972cdc22e02@arm.com>
Date:   Fri, 17 Sep 2021 12:41:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YUNV8fOxfSSFKZBK@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/21 8:04 PM, Catalin Marinas wrote:
> On Tue, Sep 14, 2021 at 12:21:10PM +0530, Anshuman Khandual wrote:
>> If the max memory limit has been reduced with 'mem=' kernel command line
>> option, there might be UEFI memory map described memory beyond that limit
>> which could be hot removed. This might be problematic for subsequent kexec
>> kernel which could just access such removed memory.
>>
>> Memory offline notifier exists because there is no other way to block the
>> removal of boot memory, only the offlining (which isn't actually a problem)
>> But with 'mem=', there is no chance to stop such boot memory being offlined
>> as it where never in use by the kernel. As 'mem=' is a debug only option on
>> arm64 platform, just warn for such a situation and move on.
> 
> Just to make sure I understand, is the memory beyond the mem= limit
> considered online by the core code and it can be subsequently offlined?

No, those memory (beyond the mem= limit) would never be part of the memblock
itself during boot, and hence cannot be onlined or used. But these can come
back into the kernel via a hot add operation after boot, it may be onlined
and possibly removed afterwards. But the reason for not being able to stop
such removal is different. Agreed, the commit message is bit misleading.

> Looking at walk_system_ram_range(), it doesn't seem to care about the
> removed memblock ranges. Would such memory beyond the mem= limit need to
> have been onlined first?

The problem here is bit different and the description in the commit message
is not very clear. Lets consider the following scenario.

1. UEFI boot memory map has got X amount of memory
2. The kernel boots with just (X - Y) memory via mem=X-Y option
3. Platform hot adds Y after the boot
4. Memory ranges in Y gets onlined (and repurposed)
5. Platform hot removes Y subsequently

Because the kernel originally booted with (mem=X-Y) option, all the memory
sections in Y, never got marked with SECTION_IS_EARLY. Subsequent hot add
operation would create memblock entries but could not mark SECTION_IS_EARLY
either. Hence those sections even after being onlined, can now be removed.
The existing notifier can not prevent this because these sections dont have
SECTION_IS_EARLY flag. The intent here is to warn users about the inability
of the notifier to deal with boot memory that comes back later via hot plug
after being carved out first via the 'mem=' command line option. The kexec
problem is just an side effect.

Interestingly, the kexec problem would still persist even without the memory
hotplug (and hot remove) being enabled. What if the platform just choose to
re-purposes Y for some thing else and then the kernel does a kexec afterwards
? The new kernel would seamlessly try to use Y causing further problem.

Another warning would be needed during memory init for any potential kexec
problems, regardless whether hotplug is enabled or not. A separate patch might
be required for that.

But this proposal here is intended to just warn the user that memory hotremove
notifier could not prevent potential boot memory being removed, if mem= option
has already reduced the boot memory range during boot. Probably the warning
message and documentation here need some changes to reflect it better.

> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index cfd9deb347c3..7ac39ee876c3 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1627,6 +1627,18 @@ static int __init prevent_bootmem_remove_init(void)
>>  	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>>  		return ret;
>>  
>> +	if (has_mem_limit_reduced()) {
>> +		/*
>> +		 * Physical memory limit has been reduced via the 'mem=' kernel
>> +		 * command line option. Memory beyond reduced limit could now be
>> +		 * removed and reassigned (guest ?) transparently to the kernel.
>> +		 * This might cause subsequent kexec kernel to crash or at least
>> +		 * corrupt the memory when accessing UEFI memory map enumerated
>> +		 * boot memory which might have been repurposed.
>> +		 */
>> +		pr_warn("Memory limit reduced, kexec might be problematic\n");
>> +	}
> 
> I'd actually move the warning to hotplug notifier callback rather than
> the init function. I'd also make it pr_warn_once().
> 
Okay, will change.
