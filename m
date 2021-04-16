Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E2361E37
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhDPKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:48:00 -0400
Received: from foss.arm.com ([217.140.110.172]:38542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhDPKr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:47:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC96106F;
        Fri, 16 Apr 2021 03:47:33 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11B2F3F85F;
        Fri, 16 Apr 2021 03:47:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
In-Reply-To: <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com> <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com> <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com> <87wnt2lglo.mognet@arm.com> <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
Date:   Fri, 16 Apr 2021 11:47:29 +0100
Message-ID: <87r1jald4u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 12:39, Dietmar Eggemann wrote:
> On 16/04/2021 11:32, Valentin Schneider wrote:
>> On 16/04/21 15:47, Ruifeng Zhang wrote:
>>> For more requirements, if all cores in one physical cluster, the
>>> {aff2} of all cores are the same value.
>>> i.e. the sc9863a,
>>> core0: 0000000081000000
>>> core1: 0000000081000100
>>> core2: 0000000081000200
>>> core3: 0000000081000300
>>> core4: 0000000081000400
>>> core5: 0000000081000500
>>> core6: 0000000081000600
>>> core7: 0000000081000700
>>>
>>> According to MPIDR all cores will parse to the one cluster, but it's
>>> the big.LITTLE system, it's need two logic cluster for schedule or
>>> cpufreq.
>>> So I think it's better to add the logic of parse topology from DT.
>>
>> Ah, so it's a slightly different issue, but still one that requires a
>> different means of specifying topology.
>
> I'm confused. Do you have the MT bit set to 1 then? So the issue that
> the mpidr handling in arm32's store_cpu_topology() is not correct does
> not exist?
>
> With DynamIQ you have only *one* cluster, you should also be able to run
> your big.LITTLE system with only an MC sched domain.
>
> # cat /proc/schedstat
> cpu0 ....
> domain0 ff ... <- MC
> ...
>

You're right, this is actually a DynamIQ system, not a (legacy) big.LITTLE
one, so all CPUs are under the same LLC (the DSU). I probably should have
checked this earlier on, but this is quite obvious from sc9863a.dtsi:

                cpu-map {
                        cluster0 {
                                core0 {
                                        cpu = <&CPU0>;
                                };
                                core1 {
                                        cpu = <&CPU1>;
                                };
                                core2 {
                                        cpu = <&CPU2>;
                                };
                                core3 {
                                        cpu = <&CPU3>;
                                };
                                core4 {
                                        cpu = <&CPU4>;
                                };
                                core5 {
                                        cpu = <&CPU5>;
                                };
                                core6 {
                                        cpu = <&CPU6>;
                                };
                                core7 {
                                        cpu = <&CPU7>;
                                };
                        };
                };

All CPUs are in the same cluster, and the MPIDR values actually match that.

> You can introduce a cpu-map to create what we called Phantom Domains in
> Android products.
>
> # cat /proc/schedstat
>
> cpu0 ....
> domain0 0f ... <- MC
> domain1 ff ... < DIE
>
> Is this what you need for your arm32 kernel system? Adding the
> possibility to parse cpu-map to create Phantom Domains?
