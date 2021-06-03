Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4306439A49E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFCPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:34:32 -0400
Received: from foss.arm.com ([217.140.110.172]:44144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFCPec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:34:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7598D11B3;
        Thu,  3 Jun 2021 08:32:47 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7263F73D;
        Thu,  3 Jun 2021 08:32:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 00/10] irqchip/irq-gic: Optimize masking by leveraging EOImode=1
In-Reply-To: <87tumhg9vm.mognet@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com> <87zgwgs9x0.wl-maz@kernel.org> <87tumhg9vm.mognet@arm.com>
Date:   Thu, 03 Jun 2021 16:32:41 +0100
Message-ID: <878s3rezfq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/21 11:25, Valentin Schneider wrote:
> On 27/05/21 12:17, Marc Zyngier wrote:
>> On Tue, 25 May 2021 18:32:45 +0100,
>> Valentin Schneider <valentin.schneider@arm.com> wrote:
>>> Benchmark
>>> +++++++++
>>>
>>> Finding a benchmark that leverages a force-threaded IRQ has proved to be
>>> somewhat of a pain, so I crafted my own. It's a bit daft, but so are most
>>> benchmarks (though this one might win a prize).
>>
>> I love it (and wrote similar hacks in my time)! :D
>
> Yay!
>
>> Can you put that up
>> somewhere so that I can run the same test on my own zoo and find out
>> how it fares?
>>
>
> The setup part is really fugly and I was too ashamed of it to link it in
> the cover letter; for ACPI I could simply use acpi_register_gsi() since
> that uses the right domain by default, but for DT I ended up adding a DT
> entry and a match table.
>
> I'll see about unifying this and I'll send it out your way.

Scratch the unification, but at least I cleaned up some of the
initialization horrors. Patches + benchmark module are at:

https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/irq/eoimodness-v2

Note: I re-ran that on Juno/eMAG to make sure I didn't bust anything, and
while the eMAG improvements are still there, now I get pretty much zilch on
the Juno :/

I use the below script to drive the testing

---
#!/bin/bash

get_irq_count () {
    cat /proc/interrupts | grep irq-prod | awk '{ print $2; }'
}

for f in $(find /sys/devices/system/cpu/cpufreq/ -name "policy*"); do
    echo "performance" > "$f"/scaling_governor
done

KTHREAD_PID=$(ps -aux | grep irq-prod/ | head -n 1 | awk '{ print $2; }')
taskset -pc 0 $KTHREAD_PID

for ((i=0; i < 20; i++)); do
    base_val=$(get_irq_count)

    now=$(date +%s%3N)
    echo 1 > /sys/kernel/irq_prod/active
    sleep 5
    echo 0 > /sys/kernel/irq_prod/active
    end=$(date +%s%3N)

    end_val=$(get_irq_count)
    delta=$((end_val - base_val))
    duration=$((end - now))

    echo $((delta / (duration / 1000))) > $1/$i
done
---

This gives you a file per iteration with irqs/sec in it, and you can
collate that however you wish - I use python + pandas:

---
#!/usr/bin/env python3

import pandas as pd

keys = ["tip", "patch"]
data = {k : [] for k in keys}

for i in range(20):
    for k in keys:
        with open("/path/to/results/{}/{}".format(k, i), "r") as fh:
            data[k].append(int(fh.read()))

df = pd.DataFrame(data)
df_stats = df.describe(percentiles=[.5, .9, .99])
df_stats["delta"] = (df_stats["patch"] - df_stats["tip"]) / df_stats["tip"]
print(df_stats)
---

i.e.

<load tip/irq/core>
./bench_irq.sh tip
<load series>
./bench_irq.sh patch

./compare.py
