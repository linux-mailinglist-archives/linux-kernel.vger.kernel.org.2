Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2061F361E19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbhDPKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:40:06 -0400
Received: from foss.arm.com ([217.140.110.172]:38402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235267AbhDPKj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A03D106F;
        Fri, 16 Apr 2021 03:39:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72573FA35;
        Fri, 16 Apr 2021 03:39:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     linux@armlinux.org.uk, sudeep.holla@arm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.p.zijlstra@chello.nl,
        mingo@kernel.org, ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com> <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
 <CAG7+-3Nv=m0pd8t0eQEUv5zSeg86hfkKcs_VLzsbzWFabYbTTQ@mail.gmail.com>
 <87wnt2lglo.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <44ab835f-3456-6bd9-97e9-5936cf5372da@arm.com>
Date:   Fri, 16 Apr 2021 12:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87wnt2lglo.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 11:32, Valentin Schneider wrote:
> On 16/04/21 15:47, Ruifeng Zhang wrote:
>> For more requirements, if all cores in one physical cluster, the
>> {aff2} of all cores are the same value.
>> i.e. the sc9863a,
>> core0: 0000000081000000
>> core1: 0000000081000100
>> core2: 0000000081000200
>> core3: 0000000081000300
>> core4: 0000000081000400
>> core5: 0000000081000500
>> core6: 0000000081000600
>> core7: 0000000081000700
>>
>> According to MPIDR all cores will parse to the one cluster, but it's
>> the big.LITTLE system, it's need two logic cluster for schedule or
>> cpufreq.
>> So I think it's better to add the logic of parse topology from DT.
> 
> Ah, so it's a slightly different issue, but still one that requires a
> different means of specifying topology.

I'm confused. Do you have the MT bit set to 1 then? So the issue that
the mpidr handling in arm32's store_cpu_topology() is not correct does
not exist?

With DynamIQ you have only *one* cluster, you should also be able to run
your big.LITTLE system with only an MC sched domain.

# cat /proc/schedstat
cpu0 ....
domain0 ff ... <- MC
...

You can introduce a cpu-map to create what we called Phantom Domains in
Android products.

# cat /proc/schedstat

cpu0 ....
domain0 0f ... <- MC
domain1 ff ... < DIE

Is this what you need for your arm32 kernel system? Adding the
possibility to parse cpu-map to create Phantom Domains?
