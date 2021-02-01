Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2402830A4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBAJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:55:09 -0500
Received: from foss.arm.com ([217.140.110.172]:54598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232543AbhBAJzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:55:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D8C101E;
        Mon,  1 Feb 2021 01:54:16 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16C73F718;
        Mon,  1 Feb 2021 01:54:14 -0800 (PST)
Subject: Re: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, mgorman@suse.de,
        song.bao.hua@hisilicon.com
References: <20210122123943.1217-1-valentin.schneider@arm.com>
 <20210122123943.1217-2-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
Date:   Mon, 1 Feb 2021 10:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122123943.1217-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 13:39, Valentin Schneider wrote:

[...]

> @@ -1705,7 +1702,7 @@ void sched_init_numa(void)
>  	/* Compute default topology size */
>  	for (i = 0; sched_domain_topology[i].mask; i++);
>  
> -	tl = kzalloc((i + level + 1) *
> +	tl = kzalloc((i + nr_levels) *
>  			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>  	if (!tl)
>  		return;

This hunk creates issues during startup on my Arm64 juno board on tip/sched/core.

---8<---

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Mon, 1 Feb 2021 09:58:04 +0100
Subject: [PATCH] sched/topology: Fix sched_domain_topology_level alloc in
 sched_init_numa

Commit "sched/topology: Make sched_init_numa() use a set for the
deduplicating sort" allocates 'i + nr_levels (level)' instead of
'i + nr_levels + 1' sched_domain_topology_level.

This led to an Oops (on Arm64 juno with CONFIG_SCHED_DEBUG):

sched_init_domains
  build_sched_domains()
    __free_domain_allocs()
      __sdt_free() {
	...
        for_each_sd_topology(tl)
	  ...
          sd = *per_cpu_ptr(sdd->sd, j); <--
	  ...
      }

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

./scripts/decode_stacktrace.sh ./vmlinux < input.log

[    0.495693] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    0.501280] Modules linked in:
[    0.504342] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc2-00025-g7a976f77bb96 #95
[    0.512455] Hardware name: ARM Juno development board (r0) (DT)
[    0.518386] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    0.524409] pc : build_sched_domains (kernel/sched/topology.c:1872 kernel/sched/topology.c:1288 kernel/sched/topology.c:2120)
[    0.529132] lr : build_sched_domains (kernel/sched/topology.c:1868 kernel/sched/topology.c:1288 kernel/sched/topology.c:2120)
[    0.533847] sp : ffff800011efbd00
[    0.537165] x29: ffff800011efbd00 x28: ffff800011b69a38
[    0.542496] x27: 0000000000000000 x26: 0000000000000000
[    0.547827] x25: ffff000800191600 x24: 0000000000000000
[    0.553157] x23: ffff800011b69a40 x22: 0000000000000001
[    0.558487] x21: ffff000800056e00 x20: ffff00080016f380
[    0.563818] x19: ffff800011b6a410 x18: 0000000000000000
[    0.569149] x17: 0000000000000000 x16: 0000000000000000
[    0.574478] x15: 0000000000000030 x14: ffffffffffffffff
[    0.579809] x13: ffff800011b82d38 x12: 0000000000000189
[    0.585139] x11: 0000000000000083 x10: ffff800011bdad38
[    0.590469] x9 : 00000000fffff000 x8 : ffff800011b82d38
[    0.595800] x7 : 00000000000000e0 x6 : 000000000000003f
[    0.601130] x5 : 0000000000000000 x4 : 0000000000000000
[    0.606460] x3 : 0000000000000000 x2 : ffff80096d857000
[    0.611790] x1 : 0000000000000001 x0 : 0000000000000001
[    0.617120] Call trace:
[    0.619566] build_sched_domains (kernel/sched/topology.c:1872 kernel/sched/topology.c:1288 kernel/sched/topology.c:2120)
[    0.623934] sched_init_domains (kernel/sched/topology.c:2194)
[    0.627954] sched_init_smp (kernel/sched/core.c:7727)
[    0.631629] kernel_init_freeable (init/main.c:1528)
[    0.635914] kernel_init (init/main.c:1417)
[    0.639416] ret_from_fork (arch/arm64/kernel/entry.S:959)
[ 0.643008] Code: b4000360 93407f1b aa0003e1 f87b7ae2 (f8626821)
All code
========
   0:	60                   	(bad)
   1:	03 00                	add    (%rax),%eax
   3:	b4 1b                	mov    $0x1b,%ah
   5:	7f 40                	jg     0x47
   7:	93                   	xchg   %eax,%ebx
   8:	e1 03                	loope  0xd
   a:	00 aa e2 7a 7b f8    	add    %ch,-0x784851e(%rdx)
  10:*	21 68 62             	and    %ebp,0x62(%rax)		<-- trapping instruction
  13:	f8                   	clc

Code starting with the faulting instruction
===========================================
   0:	21 68 62             	and    %ebp,0x62(%rax)
   3:	f8                   	clc
[    0.649129] ---[ end trace 4453f742a7781011 ]---
[    0.653772] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.661449] SMP: stopping secondary CPUs
[    0.665389] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bf5c9bd10bfe..09d35044bd88 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1702,7 +1702,7 @@ void sched_init_numa(void)
 	/* Compute default topology size */
 	for (i = 0; sched_domain_topology[i].mask; i++);
 
-	tl = kzalloc((i + nr_levels) *
+	tl = kzalloc((i + nr_levels + 1) *
 			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
-- 
2.25.1
