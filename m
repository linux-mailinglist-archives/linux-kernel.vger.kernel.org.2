Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A3364D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhDSV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:28:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhDSV2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:28:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E051435;
        Mon, 19 Apr 2021 14:27:53 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD143F792;
        Mon, 19 Apr 2021 14:27:51 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
 <CAG7+-3OgN4Kx3Md1tOmqHDLs94DSv2puh=kA0oFMw+aZGnb3iw@mail.gmail.com>
 <2a4efeea-cc70-ca0a-81fd-84d8b54586c0@arm.com>
 <CAG7+-3MX8Ntzh-fiTFZq-d9EO4GNpY2b3AuAOZPxVmxA=jNtNg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <31faf969-c8fe-1acf-e78f-793a37b8d0b2@arm.com>
Date:   Mon, 19 Apr 2021 23:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG7+-3MX8Ntzh-fiTFZq-d9EO4GNpY2b3AuAOZPxVmxA=jNtNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2021 04:55, Ruifeng Zhang wrote:
> Dietmar Eggemann <dietmar.eggemann@arm.com> 于2021年4月17日周六 上午1:00写道：
>>
>> On 16/04/2021 13:04, Ruifeng Zhang wrote:
>>> Dietmar Eggemann <dietmar.eggemann@arm.com> 于2021年4月16日周五 下午6:39写道：
>>>>
>>>> On 16/04/2021 11:32, Valentin Schneider wrote:
>>>>> On 16/04/21 15:47, Ruifeng Zhang wrote:

[...]

>> I'm afraid that this is now a much weaker case to get this into
>> mainline.
> 
> But it's still a problem and it's not break the original logic ( parse
> topology from MPIDR or parse capacity ), only add the support for
> parse topology from DT.
> I think it should still be merged into the mainline. If don't, the
> DynamIQ SoC has some issue in sched and cpufreq.

IMHO, not necessarily. Your DynamIQ SoC is one cluster with 8 CPUs. It's
subdivided into 2 Frequency Domains (FDs).

CFS Energy-Aware-Scheduling (EAS, find_energy_efficient_cpu()) and
Capacity-Aware-Scheduling (CAS, select_idle_sibling() ->
select_idle_capacity()) work correctly even in case you only have an MC
sched domain (sd).
No matter which sd (MC, DIE) the sd_asym_cpucapacity is, we always
iterate over all CPUs. Per Performance Domains (i.e. FDs) in EAS and
over sched_domain_span(sd) in CAS.

CFS load-balancing (in case your system is `over-utilized`) might work
slightly different due to the missing DIE sd but not inevitably worse.

Do you have benchmarks or testcases in mind which convince you that
Phantom Domains is something you would need? BTW, they are called
Phantom since they let you use uarch and/or max CPU frequency domain to
fake real topology (like LLC) boundaries.

[...]

> Why do you keep the logic of topology_parse_cpu_capacity in arm
> get_coretype_capacity function? The capacity-dmips-mhz will be parsed
> by drivers/base/arch_topology.c as following:
> parse_dt_topology
>     parse_cluster
>         parse_core
>             get_cpu_for_node
>                 topology_parse_cpu_capacity

I think we still need it for systems out there w/o cpu-map in dt, like
my arm32 TC2 with mainline vexpress-v2p-ca15_a7.dts.

It's called twice on each CPU in case I add the cpu-map dt entry though.
