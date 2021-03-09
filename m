Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8303332291
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCIKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:07:19 -0500
Received: from foss.arm.com ([217.140.110.172]:50832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCIKGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:06:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3167B31B;
        Tue,  9 Mar 2021 02:06:45 -0800 (PST)
Received: from [10.37.8.8] (unknown [10.37.8.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EFC73F71B;
        Tue,  9 Mar 2021 02:06:42 -0800 (PST)
Subject: Re: [PATCH v14 0/8] arm64: ARMv8.5-A: MTE: Add async mode support
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
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
 <CAAeHK+xEc8spQWh9Mz7z-mVQRavD2y84ufnGx6cm-gK3AkJfAw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <723ec86a-75be-e0e3-e4a9-b3d40d69e238@arm.com>
Date:   Tue, 9 Mar 2021 10:11:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xEc8spQWh9Mz7z-mVQRavD2y84ufnGx6cm-gK3AkJfAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 3/8/21 9:02 PM, Andrey Konovalov wrote:
> On Mon, Mar 8, 2021 at 5:14 PM Vincenzo Frascino
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
>> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v12.async.akpm
> 
> Hi Vincenzo,
> 
> As previously discussed, here's the tree with tests support added to
> this series:
> 
> https://github.com/xairy/linux/tree/vf-v12.async.akpm-tests
> 
> Please take a look at the last two patches. Feel free to include them
> into v15 if they look good.
> 
> Thanks!
> 

Thank you for this. I will definitely have a look and include them.
Based on the review process, I am planning to have another version early next week.

-- 
Regards,
Vincenzo
