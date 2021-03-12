Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B09339083
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCLO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:57:05 -0500
Received: from foss.arm.com ([217.140.110.172]:55038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhCLO4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A43D1FB;
        Fri, 12 Mar 2021 06:56:33 -0800 (PST)
Received: from [10.37.8.6] (unknown [10.37.8.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FDBB3F7D7;
        Fri, 12 Mar 2021 06:56:31 -0800 (PST)
Subject: Re: [PATCH v15 0/8] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
 <CAAeHK+wFT7Z5_Jg-8afdu8=mVqTwcnZY65Cgywxbd_0ui+1BEQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7e14b0ae-8aa5-549c-ef77-5f040e0d3813@arm.com>
Date:   Fri, 12 Mar 2021 14:56:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wFT7Z5_Jg-8afdu8=mVqTwcnZY65Cgywxbd_0ui+1BEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 2:50 PM, Andrey Konovalov wrote:
> On Fri, Mar 12, 2021 at 3:22 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> This patchset implements the asynchronous mode support for ARMv8.5-A
>> Memory Tagging Extension (MTE), which is a debugging feature that allows
>> to detect with the help of the architecture the C and C++ programmatic
>> memory errors like buffer overflow, use-after-free, use-after-return, etc.
>>
>> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
>> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
>> subset of its address space that is multiple of a 16 bytes granule. MTE
>> is based on a lock-key mechanism where the lock is the tag associated to
>> the physical memory and the key is the tag associated to the virtual
>> address.
>> When MTE is enabled and tags are set for ranges of address space of a task,
>> the PE will compare the tag related to the physical memory with the tag
>> related to the virtual address (tag check operation). Access to the memory
>> is granted only if the two tags match. In case of mismatch the PE will raise
>> an exception.
>>
>> The exception can be handled synchronously or asynchronously. When the
>> asynchronous mode is enabled:
>>   - Upon fault the PE updates the TFSR_EL1 register.
>>   - The kernel detects the change during one of the following:
>>     - Context switching
>>     - Return to user/EL0
>>     - Kernel entry from EL1
>>     - Kernel exit to EL1
>>   - If the register has been updated by the PE the kernel clears it and
>>     reports the error.
>>
>> The series is based on linux-next/akpm.
>>
>> To simplify the testing a tree with the new patches on top has been made
>> available at [1].
>>
>> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v13.async.akpm
> 
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> 
> for the series.
> 
> Thank you, Vincenzo!
> 

Thanks to you!

-- 
Regards,
Vincenzo
