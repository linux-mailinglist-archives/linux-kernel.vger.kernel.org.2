Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94A3DB94D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhG3N1N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jul 2021 09:27:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhG3N1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:27:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8027B6D;
        Fri, 30 Jul 2021 06:27:07 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E553F70D;
        Fri, 30 Jul 2021 06:27:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Abdul Anshad Azeez <aazees@vmware.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "peterz\@infradead.org" <peterz@infradead.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt\@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: [Linux Kernel 5.13 GA] ESXi Performance regression
In-Reply-To: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
References: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
Date:   Fri, 30 Jul 2021 14:26:56 +0100
Message-ID: <87a6m4kk4f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/21 12:27, Abdul Anshad Azeez wrote:
> As part of VMware's performance regression testing for Linux Kernel
> upstream releases, we evaluated the performance of Linux kernel 5.13
> against the 5.12 release. Our evaluation revealed performance
> regressions in ESXi Compute workloads up to 3x and ESXi Networking
> workloads up to 40%.
>
> After performing the bisect between kernel 5.13 and 5.12, we
> identified the root cause behavior to be a “Scheduler” related commit
> from Peter Zijlstra's "8a99b6833c884fa0e7919030d93fecedc69fc625 (
> sched: Move SCHED_DEBUG sysctl to debugfs)". It appears that the
> issue arose due to Peter's commit changing the default value of
> "sched_wakeup_granularity_ns" and more details are below.
>
> Impacted test case details:
>
> 1. Compute:
> - VM Config - RHEL 8.1 - 1VM with 8vCPU & 16G Memory
> - Benchmark - kernel compile
> - Measures time taken to compile Linux kernel source code (Linux
> kernel version used - 4.9.24)
> - make -j 2xVCPU - This uses all the available CPU threads to achieve
> 100% CPU utilization
>
> 2. Networking:
> - VM Config - RHEL 8.1 - 1VM with 8vCPU & 16G Memory and 8VM with
> 4vCPU & 8G Memory
> - Benchmark - Netperf
> - Netperf TCP_STREAM RECV small (8K socket & 256B message)(
> TCP_NODELAY set) packets – Throughput (1VM)
> - Netperf UDP_STREAM RECV (256K socket & 256B message) – Packet rate (
> 8VM)
>
> From our testing, overall results indicate that the above-mentioned
> commit has introduced performance regressions in kernel compile
> workload for Compute area and in Networking, test cases with high
> packet rates were impacted.
>
> We noticed that Peter Zijlstra's commit has moved the Scheduler
> tunables to debugfs file system. And on taking a closer look, the
> values of two such tunables are different between before and after
> the above-mentioned commit.
>
> 1. Before:
> sched_min_granularity_ns    - 10000000 (10ms)
> sched_wakeup_granularity_ns - 15000000 (15ms)
>
> 2. After:
> sched_min_granularity_ns    - 3000000 (3ms)
> sched_wakeup_granularity_ns - 4000000 (4ms)
>
> With further experiments, we have confirmed that the value of
> "sched_wakeup_granularity_ns" is influencing these performance
> regressions. And, on setting the "sched_wakeup_granularity_ns" value
> back to "15000000" in Peter Zijlstra's commit, we are able to gain
> back the lost performance in our Compute & Networking workloads.
>

sysctl_sched_wakeup_granularity's default value hasn't been touched since
2009:

  172e082a9111 ("sched: Re-tune the scheduler latency defaults to decrease worst-case latencies")

and the automagic scaling (see kernel/sched/fair.c::update_sysctl()) hasn't
changed much either.

What's likely to happen here is that you have a service in your distro (or
somesuch) tweaking those values, and since the incriminated commit moves
those files to /sys/kernel/debug/sched/, said service doesn't do anything
anymore.
