Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034A935C671
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbhDLMks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:40:48 -0400
Received: from foss.arm.com ([217.140.110.172]:49574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238587AbhDLMkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:40:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9587C31B;
        Mon, 12 Apr 2021 05:40:23 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F0A3F793;
        Mon, 12 Apr 2021 05:40:21 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <121d5639-b827-937f-1cf0-e6c256e306db@arm.com>
Date:   Mon, 12 Apr 2021 14:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG7+-3MsjuChoEOj11VAMX9W61UY6MmphkxWDF=-_R1A8sfvpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 14:20, Ruifeng Zhang wrote:
> Valentin Schneider <valentin.schneider@arm.com> 于2021年4月12日周一 下午7:32写道：
>>
>>
>> Hi,
>>
>> On 12/04/21 15:08, Ruifeng Zhang wrote:
>>> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>>>
>>> The arm topology still parse from the MPIDR, but it is incomplete.  When
>>> the armv8.3 cpu runs in aarch32 mode, it will parse out the wrong topology.
>>>
>>> armv7 (A7) mpidr is:
>>> [11:8]      [7:2]       [1:0]
>>> cluster     reserved    cpu
>>>
>>> armv8.3 (A55) mpidr is:
>>> [23:16]     [15:8]      [7:0]
>>> cluster     cpu         thread
>>>
>>> For compatibility to keep the function of get capacity from default
>>> cputype, renamed arm parse_dt_topology to get_cputype_capacity and delete
>>> related logic of parse from dt.
>>> Arm using the same parse_dt_topology function as arm64.
>>>
>>> The arm device boot step is to look for the default cputype and get cpu
>>> capacity firstly. Then parse the topology and capacity from dt to replace
>>> default values.
>>>
>>
>> I'm afraid I don't get it.
>>
>> CONFIG_COMPAT lets you run 32-bit stuff at EL0, but the kernel is still
>> arm64. So if you take your armv8.3 system, the topology parsed by the
>> kernel will be the same regardless of CONFIG_COMPAT.
>>
>> Could you elaborate on what problem you are trying to fix here?
> 
> There is a armv8.3 cpu which should work normally both on aarch64 and aarch32.
> The MPIDR has been written to the chip register in armv8.3 format.
> For example,
> core0: 0000000080000000
> core1: 0000000080000100
> core2: 0000000080000200
> ...
> 
> Its cpu topology can be parsed normally on aarch64 mode (both
> userspace and kernel work on arm64).
> 
> The problem is when it working on aarch32 mode (both userspace and
> kernel work on arm 32-bit), the cpu topology
> will parse error because of the format is different between armv7 and armv8.3.
> The arm 32-bit driver, arch/arm/kernel/topology will parse the MPIDR
> and store to the topology with armv7,
> and the result is all cpu core_id is 0, the bit[1:0] of armv7 MPIDR format.
> 
> In addition, I think arm should also allow customers to configure cpu
> topologies via DT.

This patch ruins the CPU capacity detection based on capacity-dmips-mhz
(Documentation/devicetree/bindings/arm/cpu-capacity.txt) on my TC2 [L B
B L L] (armv7).

tip/sched/core with *mainline* multi_v7_defconfig:

root@linaro-nano:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
516
1024
1024
516
516

your patch with mainline multi_v7_defconfig:

root@linaro-nano:~#  cat /sys/devices/system/cpu/cpu*/cpu_capacity
1024
1024
1024
1024
1024


There are 2 capacity detection mechanism in arch/arm/kernel/topology.c:

(1) cpu_efficiency (only for armv7 a15 and a7) based, relies on
clock-frequency dt property

(2) capacity-dmips-mhz dt property based

I currently don't see how this different MPIDR layout leads to you code
changes.


