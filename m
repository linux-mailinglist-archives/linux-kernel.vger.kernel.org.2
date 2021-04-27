Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F125C36C9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhD0QvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:51:03 -0400
Received: from foss.arm.com ([217.140.110.172]:55028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhD0Quu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FBCCD6E;
        Tue, 27 Apr 2021 09:50:06 -0700 (PDT)
Received: from [10.57.61.101] (unknown [10.57.61.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5790D3F694;
        Tue, 27 Apr 2021 09:50:05 -0700 (PDT)
Subject: Re: [PATCH] arm64:align function __arch_clear_user
To:     Kai Shen <shenkai8@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, xuwei5@hisilicon.com,
        hewenliang4@huawei.com, wuxu.wu@huawei.com
References: <58fecb22-f932-cb6e-d996-ca75fe26a75d@huawei.com>
 <20210414104144.GB8320@arm.com>
 <6829062c-a2d4-57da-4037-269fb7508993@huawei.com>
 <20210423153701.GP18757@arm.com>
 <b7ed22f7-2c89-c67d-5e06-380964371150@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3fde204b-5dfd-f7dd-cdc9-37c2fabdd723@arm.com>
Date:   Tue, 27 Apr 2021 17:50:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <b7ed22f7-2c89-c67d-5e06-380964371150@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-25 03:07, Kai Shen wrote:
> On 2021/4/23 23:37, Catalin Marinas wrote:
>> On Mon, Apr 19, 2021 at 10:05:16AM +0800, Kai Shen wrote:
>>> On 2021/4/14 18:41, Catalin Marinas wrote:
>>>> On Wed, Apr 14, 2021 at 05:25:43PM +0800, Kai Shen wrote:
>>>>> Performance decreases happen in __arch_clear_user when this
>>>>> function is not correctly aligned on HISI-HIP08 arm64 SOC which
>>>>> fetches 32 bytes (8 instructions) from icache with a 32-bytes
>>>>> aligned end address. As a result, if the hot loop is not 32-bytes
>>>>> aligned, it may take more icache fetches which leads to decrease
>>>>> in performance.
>>>>> Dump of assembler code for function __arch_clear_user:
>>>>>          0xffff0000809e3f10 :    nop
>>>>>          0xffff0000809e3f14 :    mov x2, x1
>>>>>          0xffff0000809e3f18 :    subs x1, x1, #0x8
>>>>>          0xffff0000809e3f1c :    b.mi 0xffff0000809e3f30 
>>>>> <__arch_clear_user+3
>>>>> -----  0xffff0000809e3f20 :    str    xzr, [x0],#8
>>>>> hot    0xffff0000809e3f24 :    nop
>>>>> loop   0xffff0000809e3f28 :    subs x1, x1, #0x8
>>>>> -----  0xffff0000809e3f2c :    b.pl  0xffff0000809e3f20 
>>>>> <__arch_clear_user+1
>>>>> The hot loop above takes one icache fetch as the code is in one
>>>>> 32-bytes aligned area and the loop takes one more icache fetch
>>>>> when it is not aligned like below.
>>>>>          0xffff0000809e4178 :   str    xzr, [x0],#8
>>>>>          0xffff0000809e417c :   nop
>>>>>          0xffff0000809e4180 :   subs x1, x1, #0x8
>>>>>          0xffff0000809e4184 :   b.pl  0xffff0000809e4178 
>>>>> <__arch_clear_user+
>>>>> Data collected by perf:
>>>>>                            aligned   not aligned
>>>>>             instructions   57733790     57739065
>>>>>          L1-dcache-store   14938070     13718242
>>>>> L1-dcache-store-misses     349280       349869
>>>>>          L1-icache-loads   15380895     28500665
>>>>> As we can see, L1-icache-loads almost double when the loop is not
>>>>> aligned.

Sure, if the function spans two cache lines, and I$ pressure is so high 
that it gets evicted between each call, then indeed one would expect 
about twice as many fetches in total compared to if the function fits in 
a single line. However, that's not necessarily indicative of visible 
performance - if the predictors and prefetchers can do their jobs well 
enough there could still be little to no impact on actual execution latency.

If you want to use perf to try to justify this, at least drill down into 
more specific events to show that you're really stalling on I$ misses. 
The most convincing argument, though, would be a measured difference in 
actual user-memory-zeroing bandwidth - the fact that you haven't shared 
that, even for your synthetic test, makes me suspect that it's probably 
not as significant and exciting as a supposed "2x" figure... ;)

>>>>> This problem is found in linux 4.19 on HISI-HIP08 arm64 SOC.
>>>>> Not sure what the case is on other arm64 SOC, but it should do
>>>>> no harm.
>>>>> Signed-off-by: Kai Shen <shenkai8@huawei.com>
>>>>
>>>> Do you have a real world workload that's affected by this function?
>>>>
>>>> I'm against adding alignments and nops for specific hardware
>>>> implementations. What about lots of other loops that the compiler may
>>>> generate or that we wrote in asm?
>>>
>>> The benchmark we used which suffer performance decrease:
>>>      https://github.com/redhat-performance/libMicro
>>>      pread $OPTS -N "pread_z1k"    -s 1k    -I 300  -f /dev/zero
>>>      pread $OPTS -N "pread_z10k"    -s 10k    -I 1000 -f /dev/zero
>>>      pread $OPTS -N "pread_z100k"    -s 100k    -I 2000 -f /dev/zero
>>
>> Is there any real world use-case that would benefit from this
>> optimisation? Reading /dev/zero in a loop hardly counts as a practical
>> workload.
>>
> Operations like "dd if=/dev/zero of=/dev/sda1" ?

Surely the write() side of that operation is still going to dominate 
either way? What kind of device would sda be for the whole operation to 
be significantly bottlenecked on *instruction fetch bandwidth* in read()!?

FWIW I'm currently playing about with some changes to this code anyway - 
I'll make sure to check whether function alignment has any noticeable 
impact on the microarchitectures I have to hand.

Robin.
