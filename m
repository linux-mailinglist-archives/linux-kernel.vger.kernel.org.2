Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03235F0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhDNJn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:43:26 -0400
Received: from foss.arm.com ([217.140.110.172]:54068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232167AbhDNJnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:43:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E9D11B3;
        Wed, 14 Apr 2021 02:43:02 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE123F73B;
        Wed, 14 Apr 2021 02:42:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com>
 <87y2dnn3gw.mognet@arm.com>
 <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
 <87tuobmsba.mognet@arm.com>
 <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
 <87o8eimmyw.mognet@arm.com>
 <CAG7+-3NaUAvjv9=9HZ4jQU=DVcZW6gRKZg9ZjutL3aKnnC4FLw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <74b3ff57-473f-4d5a-daf8-ecbb0761abb2@arm.com>
Date:   Wed, 14 Apr 2021 11:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG7+-3NaUAvjv9=9HZ4jQU=DVcZW6gRKZg9ZjutL3aKnnC4FLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2021 15:26, Ruifeng Zhang wrote:
> Thanks for your review. Patch-v2 that solve the capacity issue will be
> uploaded as soon as possible. : )
> 
> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月13日周二 下午7:40写道：
>>
>> On 13/04/21 14:13, Ruifeng Zhang wrote:
>>> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月12日周一 下午11:33写道：
>>>> I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), but
>>>> I couldn't find anything about MPIDR format differences:
>>>>
>>>>   DDI 0487G.a G8.2.113
>>>>   """
>>>>   AArch32 System register MPIDR bits [31:0] are architecturally mapped to
>>>>   AArch64 System register MPIDR_EL1[31:0].
>>>>   """
>>>>
>>>> Peeking at some armv7 doc and arm/kernel/topology.c the layout really looks
>>>> just the same, i.e. for both of them, with your example of:
>>>
>>> The cortex-a7 spec DDI0464F 4.3.5
>>> https://developer.arm.com/documentation/ddi0464/f/?lang=en
>>>
>>
>> Ah, so that's where the core_id=bit[1:0] comes from. That does still
>> conform to the MPIDR format, and as you point out below that's being parsed
>> the same (aff2, aff1, aff0) == mpidr([23:16][15:8][7:0])
>>
>>> The current arch/arm/kernel/topology code parse the MPIDR with a armv7 format.
>>> the parse code is:
>>> void store_cpu_topology(unsigned int cpuid)
>>> {
>>>     ...
>>>     cpuid_topo->thread_id = -1;
>>>     cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>>     cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>>     ...
>>> }
>>>>
>>>>   core0: 0000000080000000
>>>>   core1: 0000000080000100
>>>>   core2: 0000000080000200
>>>>   ...
>>>>
>>>> we'll get:
>>>>
>>>>   |       | aff2 | aff1 | aff0 |
>>>>   |-------+------+------+------|
>>>>   | Core0 |    0 |    0 |    0 |
>>>>   | Core1 |    0 |    1 |    0 |
>>>>   | Core2 |    0 |    2 |    0 |
>>>>       ...
>>>>
>>>> Now, arm64 doesn't fallback to MPIDR for topology information anymore since
>>>>
>>>>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")
>>>>
>>>> so without DT we would get:
>>>>   |       | package_id | core_id |
>>>>   |-------+------------+---------|
>>>>   | Core0 |          0 |       0 |
>>>>   | Core1 |          0 |       1 |
>>>>   | Core2 |          0 |       2 |
>>>>
>>>> Whereas with an arm kernel we'll end up parsing MPIDR as:
>>>>   |       | package_id | core_id |
>>>>   |-------+------------+---------|
>>>>   | Core0 |          0 |       0 |
>>>>   | Core1 |          1 |       0 |
>>>>   | Core2 |          2 |       0 |
>>>>
>>>> Did I get this right? Is this what you're observing?
>>>
>>> Yes, this is a problem if an armv8.2 or above cpu is running a 32-bit
>>> kernel on EL1.
>>
>>
>> With the above MPIDR(_EL1) values, you would have the same problem in
>> aarch64 mode on any kernel predating
>>
>>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")
>>
>> since all Aff0 values are 0. Arguably those MPIDR(_EL1) values don't
>> make much sense (cores in the same cluster should have different Aff0
>> values, unless SMT), but in arm64 that's usually "corrected" by DT.
>>
>> As you pointed out, arm doesn't currently leverage the cpu-map DT entry. I
>> don't see any obvious problem with adding support for it, so if you can fix
>> the capacity issue Dietmar reported, I think we could consider it.

Coming back to your original patch. You want to use parse_dt_topology()
from drivers/base/arch_topology.c to be able detect a cpu-map in dt and
so bypassing the read of mpidr in store_cpu_topology()?

Looks like sc9863a has two frequency domains (1.6 and 1.2GHz). So
technically it's a big.LITTLE system (based only on max CPU frequency
(not on uarch) differences).
But the dts file doesn't contain any `capacity-dmips-mhz` entries? So
asymmetric CPU capacity (even only based on max CPU frequency) detection
won't kick in. Since you don't have any uarch diffs, you would have to
specify `capacity-dmips-mhz = <1024>` for each CPU.
