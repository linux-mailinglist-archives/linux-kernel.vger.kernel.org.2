Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7F43DF31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJ1Kvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:51:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1Kvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:51:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273AF1FB;
        Thu, 28 Oct 2021 03:49:05 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CFBD3F5A1;
        Thu, 28 Oct 2021 03:49:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, peterz@infradead.org,
        namit@vmware.com, mingo@kernel.org, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v3] cpumask: Fix implicit type conversion
In-Reply-To: <1635404811-2992370-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1635404811-2992370-1-git-send-email-jiasheng@iscas.ac.cn>
Date:   Thu, 28 Oct 2021 11:48:56 +0100
Message-ID: <871r45whk7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/21 07:06, Jiasheng Jiang wrote:
> The description of the macro in `include/linux/cpumask.h` says the
> variable 'cpu' can be int, whose value ranges from (-2^31) to
> (2^31 - 1).
> However in the for_each_cpu(), 'nr_cpu_ids' and the return value of
> cpumask_next() is unsigned int, whose value ranges from 0 to
> (2^32 - 1).
> If return value of cpumask_next() is (2^31), the restrict
> 'cpu < nr_cpu_ids' can also be statisfied, but the actual value
> of 'cpu' is (-2^31).
> Take amd_pmu_cpu_starting() in `arch/x86/events/amd/core.c` as an
> example. When value of 'cpu' is (-2^31), then in the per_cpu(),
> there will apear __per_cpu_offset[-2^31], which is array out of
> bounds error.
> Moreover, the num of cpu to be the negative doesn't make sense and
> may easily causes trouble.
> It is universally accepted that the implicit type conversion is
> terrible.
> Also, having the good programming custom will set an example for
> others.
> Thus, it might be better to fix the macro description of 'cpu' and
> deal with all the existing issues.
>

AFAIA the upper bounds for NR_CPUS are around 2^12 (arm64) and 2^13 (x86);
I don't think we're anywhere near supporting such massive systems.

I got curious and had a look at the size of .data..percpu on a defconfig
arm64 kernel - I get about ~40KB. So purely on the percpu data side of
things, we're talking about 100TB of RAM...

Trying to improve the code is laudable, but I don't see much incentive in
the churn ATM.

> Fixes: c743f0a ("sched/fair, cpumask: Export for_each_cpu_wrap()")
> Fixes: 8bd93a2 ("rcu: Accelerate grace period if last non-dynticked CPU")
> Fixes: 984f2f3 ("cpumask: introduce new API, without changing anything, v3")

Where's the v1->v2->v3 changelog? This is merely fiddling with doc headers,
what's being fixed here?
