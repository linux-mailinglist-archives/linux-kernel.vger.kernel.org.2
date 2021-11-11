Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7611B44D6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhKKMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:49:46 -0500
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhKKMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:49:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4BB101E;
        Thu, 11 Nov 2021 04:46:55 -0800 (PST)
Received: from bogus (unknown [10.57.45.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ACD53F70D;
        Thu, 11 Nov 2021 04:46:53 -0800 (PST)
Date:   Thu, 11 Nov 2021 12:46:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH] arch_topology: Fix missing clear cluster_cpumask in
 remove_cpu_topology()
Message-ID: <20211111124650.7mksocfjjzuzxt3i@bogus>
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:58:56PM +0800, Wang ShaoBo wrote:
> When testing cpu online and offline, warning happened like this:
> 
> [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
> [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
> [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
> [  146.751213] Workqueue: events cpuset_hotplug_workfn
> [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> [  146.752461] lr : build_sched_domains+0x414/0x11b0
> [  146.752860] sp : ffff800040a83a80
> [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
> [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
> [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
> [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
> [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
> [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
> [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
> [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
> [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
> [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
> [  146.757070] Call trace:
> [  146.757421]  build_sched_domains+0x81c/0x11b0
> [  146.757771]  partition_sched_domains_locked+0x57c/0x978
> [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
> [  146.758460]  rebuild_sched_domains+0x2c/0x48
> [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
> [  146.759114]  process_one_work+0x1f4/0x480
> [  146.759429]  worker_thread+0x48/0x460
> [  146.759734]  kthread+0x158/0x168
> [  146.760030]  ret_from_fork+0x10/0x20
> [  146.760318] ---[ end trace 82c44aad6900e81a ]---
> 
> For some architectures like risc-v and arm64 which use common code
> clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
> is set, cluster_sibling in cpu_topology of each sibling adjacent
> to CPUx is missed clearing, this causes checking failed in
> topology_span_sane() and rebuilding topology failure at end when CPU online.
> 
> Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
> (CPU 92, 93, 94, 95 are in one cluster):
> 
> Before revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
> 
> After revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
