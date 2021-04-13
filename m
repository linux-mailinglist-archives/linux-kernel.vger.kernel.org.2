Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3976035DDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhDMLlJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Apr 2021 07:41:09 -0400
Received: from foss.arm.com ([217.140.110.172]:41208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhDMLlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:41:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C88113E;
        Tue, 13 Apr 2021 04:40:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A96E03F73B;
        Tue, 13 Apr 2021 04:40:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm: topology: parse the topology from the dt
In-Reply-To: <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
References: <20210412070819.23493-1-ruifeng.zhang0110@gmail.com> <87y2dnn3gw.mognet@arm.com> <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com> <87tuobmsba.mognet@arm.com> <CAG7+-3OMYVTc+ja9CK+94X8XtKq3hbRb+XOEv7xOeuXgNm0BHQ@mail.gmail.com>
Date:   Tue, 13 Apr 2021 12:40:39 +0100
Message-ID: <87o8eimmyw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/21 14:13, Ruifeng Zhang wrote:
> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月12日周一 下午11:33写道：
>> I'm not fluent at all in armv7 (or most aarch32 compat mode stuff), but
>> I couldn't find anything about MPIDR format differences:
>>
>>   DDI 0487G.a G8.2.113
>>   """
>>   AArch32 System register MPIDR bits [31:0] are architecturally mapped to
>>   AArch64 System register MPIDR_EL1[31:0].
>>   """
>>
>> Peeking at some armv7 doc and arm/kernel/topology.c the layout really looks
>> just the same, i.e. for both of them, with your example of:
>
> The cortex-a7 spec DDI0464F 4.3.5
> https://developer.arm.com/documentation/ddi0464/f/?lang=en
>

Ah, so that's where the core_id=bit[1:0] comes from. That does still
conform to the MPIDR format, and as you point out below that's being parsed
the same (aff2, aff1, aff0) == mpidr([23:16][15:8][7:0])

> The current arch/arm/kernel/topology code parse the MPIDR with a armv7 format.
> the parse code is:
> void store_cpu_topology(unsigned int cpuid)
> {
>     ...
>     cpuid_topo->thread_id = -1;
>     cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>     cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>     ...
> }
>>
>>   core0: 0000000080000000
>>   core1: 0000000080000100
>>   core2: 0000000080000200
>>   ...
>>
>> we'll get:
>>
>>   |       | aff2 | aff1 | aff0 |
>>   |-------+------+------+------|
>>   | Core0 |    0 |    0 |    0 |
>>   | Core1 |    0 |    1 |    0 |
>>   | Core2 |    0 |    2 |    0 |
>>       ...
>>
>> Now, arm64 doesn't fallback to MPIDR for topology information anymore since
>>
>>   3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")
>>
>> so without DT we would get:
>>   |       | package_id | core_id |
>>   |-------+------------+---------|
>>   | Core0 |          0 |       0 |
>>   | Core1 |          0 |       1 |
>>   | Core2 |          0 |       2 |
>>
>> Whereas with an arm kernel we'll end up parsing MPIDR as:
>>   |       | package_id | core_id |
>>   |-------+------------+---------|
>>   | Core0 |          0 |       0 |
>>   | Core1 |          1 |       0 |
>>   | Core2 |          2 |       0 |
>>
>> Did I get this right? Is this what you're observing?
>
> Yes, this is a problem if an armv8.2 or above cpu is running a 32-bit
> kernel on EL1.


With the above MPIDR(_EL1) values, you would have the same problem in
aarch64 mode on any kernel predating

  3102bc0e6ac7 ("arm64: topology: Stop using MPIDR for topology information")

since all Aff0 values are 0. Arguably those MPIDR(_EL1) values don't
make much sense (cores in the same cluster should have different Aff0
values, unless SMT), but in arm64 that's usually "corrected" by DT.

As you pointed out, arm doesn't currently leverage the cpu-map DT entry. I
don't see any obvious problem with adding support for it, so if you can fix
the capacity issue Dietmar reported, I think we could consider it.
