Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9663444D64D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhKKMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:07:41 -0500
Received: from foss.arm.com ([217.140.110.172]:38220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhKKMHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:07:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6D4101E;
        Thu, 11 Nov 2021 04:04:51 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973A53F70D;
        Thu, 11 Nov 2021 04:04:49 -0800 (PST)
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in
 remove_cpu_topology()
To:     Barry Song <21cnbao@gmail.com>,
        "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, weiyongjun1@huawei.com
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
 <CAGsJ_4wzPWnNFe4ptphVxXSz4-50-qub+H_q0woupxOM1LtqsA@mail.gmail.com>
 <943fef84-3920-42bc-b83f-4feaa3ab79f3@huawei.com>
 <CAGsJ_4xFhcUaVYzVKc2EXs9FsnmPoLmmKqxiDpExwUeTyOyDMg@mail.gmail.com>
 <CAGsJ_4yLV_-fwtH1=bmGxfcK9_TwUK5Typ_pE=zYQNt=YHoFVA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <26ed9985-24c8-b28f-44f0-caba8c7c839d@arm.com>
Date:   Thu, 11 Nov 2021 13:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4yLV_-fwtH1=bmGxfcK9_TwUK5Typ_pE=zYQNt=YHoFVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2021 10:08, Barry Song wrote:
> On Thu, Nov 11, 2021 at 10:07 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Thu, Nov 11, 2021 at 8:25 PM Wangshaobo (bobo)
>> <bobo.shaobowang@huawei.com> wrote:
>>>
>>>
>>> 在 2021/11/11 14:25, Barry Song 写道:
>>>
>>> On Wed, Nov 10, 2021 at 10:53 PM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>>>
>>> When testing cpu online and offline, warning happened like this:
>>>
>>> [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
>>> [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
>>> [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
>>> [  146.751213] Workqueue: events cpuset_hotplug_workfn
>>> [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [  146.752048] pc : build_sched_domains+0x81c/0x11b0
>>> [  146.752461] lr : build_sched_domains+0x414/0x11b0
>>> [  146.752860] sp : ffff800040a83a80
>>> [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
>>> [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
>>> [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
>>> [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
>>> [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
>>> [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
>>> [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
>>> [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
>>> [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
>>> [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
>>> [  146.757070] Call trace:
>>> [  146.757421]  build_sched_domains+0x81c/0x11b0
>>> [  146.757771]  partition_sched_domains_locked+0x57c/0x978
>>> [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
>>> [  146.758460]  rebuild_sched_domains+0x2c/0x48
>>> [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
>>> [  146.759114]  process_one_work+0x1f4/0x480
>>> [  146.759429]  worker_thread+0x48/0x460
>>> [  146.759734]  kthread+0x158/0x168
>>> [  146.760030]  ret_from_fork+0x10/0x20
>>> [  146.760318] ---[ end trace 82c44aad6900e81a ]---
>>>
>>> For some architectures like risc-v and arm64 which use common code
>>> clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
>>> is set, cluster_sibling in cpu_topology of each sibling adjacent
>>> to CPUx is missed clearing, this causes checking failed in
>>> topology_span_sane() and rebuilding topology failure at end when CPU online.
>>>
>>> Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
>>> (CPU 92, 93, 94, 95 are in one cluster):
>>>
>>> Before revision:
>>> CPU                 [92]      [93]      [94]      [95]
>>> cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
>>>
>>> After revision:
>>> CPU                 [92]      [93]      [94]      [95]
>>> cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
>>>
>>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>>>
>>> The patch looks correct. But how do you reproduce it?
>>>
>>> Hi Barry,
>>>
>>> you can try this test case in kunpeng 920:
>>>
>>>
>> echo 0 > cpu92/online
>> echo 0 > cpu93/online
>> echo 1 > cpu92/online
>>
>> Yes. I was making the whole cluster offline. this warning can only be
>> reproduced when
>> we disable a part of CPUs in one cluster, then enable one of the disabled CPUs.

I was asking myself the same question. When does this warning
`WARN_ON(!topology_span_sane(tl, cpu_map, i)` in build_sched_domains()
actually barf? Agree with what's said above.

echo 1 > cpu92/online:

...
[  113.841009] Detected VIPT I-cache on CPU92
[  113.845292] GICv3: CPU92: found redistributor 3d0000 region 92:0x00002000aa600000
[  113.853059] CPU92: Booted secondary processor 0x00003d0000 [0x481fd010]
[  114.018654] CPU92 i=94 cpu_map=0-92,94-95 tl->mask(cpu)=92,94-95 tl->mask(i)=92-95 <- !!!
[  114.026240] ------------[ cut here ]------------
[  114.030841] WARNING: CPU: 92 PID: 590 at kernel/sched/topology.c:2220 build_sched_domains+0x934/0x12f8
...

>>
>> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
>>
>> Might need some refine to explain how to reproduce in commit log.

+1.

> and also a fix tag.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
