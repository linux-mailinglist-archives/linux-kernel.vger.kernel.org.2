Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3A3215B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBVMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:05:20 -0500
Received: from foss.arm.com ([217.140.110.172]:43800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhBVMEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:04:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 699E71FB;
        Mon, 22 Feb 2021 04:03:55 -0800 (PST)
Received: from [10.37.8.9] (unknown [10.37.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D31F3F70D;
        Mon, 22 Feb 2021 04:03:53 -0800 (PST)
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can read
 beyond buffer limits
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
 <20210212172128.GE7718@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
Date:   Mon, 22 Feb 2021 12:08:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212172128.GE7718@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 5:21 PM, Catalin Marinas wrote:
>> +
>> +	/*
>> +	 * This function is called on each active smp core at boot
>> +	 * time, hence we do not need to take cpu_hotplug_lock again.
>> +	 */
>> +	static_branch_enable_cpuslocked(&mte_async_mode);
>>  }
> Sorry, I missed the cpuslocked aspect before. Is there any reason you
> need to use this API here? I suggested to add it to the
> mte_enable_kernel_sync() because kasan may at some point do this
> dynamically at run-time, so the boot-time argument doesn't hold. But
> it's also incorrect as this function will be called for hot-plugged
> CPUs as well after boot.
> 
> The only reason for static_branch_*_cpuslocked() is if it's called from
> a region that already invoked cpus_read_lock() which I don't think is
> the case here.

I agree with your analysis on why static_branch_*_cpuslocked() is needed, in
fact cpus_read_lock() takes cpu_hotplug_lock as per comment on top of the line
of code.

If I try to take that lock when enabling the secondary cores I end up in the
situation below:

[    0.283402] smp: Bringing up secondary CPUs ...
....
[    5.890963] Call trace:
[    5.891050]  dump_backtrace+0x0/0x19c
[    5.891212]  show_stack+0x18/0x70
[    5.891373]  dump_stack+0xd0/0x12c
[    5.891531]  dequeue_task_idle+0x28/0x40
[    5.891686]  __schedule+0x45c/0x6c0
[    5.891851]  schedule+0x70/0x104
[    5.892010]  percpu_rwsem_wait+0xe8/0x104
[    5.892174]  __percpu_down_read+0x5c/0x90
[    5.892332]  percpu_down_read.constprop.0+0xbc/0xd4
[    5.892497]  cpus_read_lock+0x10/0x1c
[    5.892660]  static_key_enable+0x18/0x3c
[    5.892823]  mte_enable_kernel_async+0x40/0x70
[    5.892988]  kasan_init_hw_tags_cpu+0x50/0x60
[    5.893144]  cpu_enable_mte+0x24/0x70
[    5.893304]  verify_local_cpu_caps+0x58/0x120
[    5.893465]  check_local_cpu_capabilities+0x18/0x1f0
[    5.893626]  secondary_start_kernel+0xe0/0x190
[    5.893790]  0x0
[    5.893975] bad: scheduling from the idle thread!
[    5.894065] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
5.11.0-rc7-10587-g22cd50bcfcf-dirty #6

and the kernel panics.

Note: there is a look of msg drop in between enabling the secondary and the
first clean stack trace.

-- 
Regards,
Vincenzo
