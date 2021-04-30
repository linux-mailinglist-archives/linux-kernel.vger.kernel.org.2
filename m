Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8186C36F54F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhD3FYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:24:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:54056 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhD3FYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:24:09 -0400
IronPort-SDR: N+CUCtVdKnwvptb8gMxXnaq4Kub7vFcdUFgt0L3rptn49me2WJAA0ugiq/daSRa1IDG+eCqbPo
 KPfHLmPeGvsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="282543275"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="282543275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:23:22 -0700
IronPort-SDR: Asc7xu+QtQhY/uSENFDc8DeybYZN49Pg7ikbm8QclWADtQWvCj2+n4jJFUa0LfVjIvLO7Fuusx
 F0ZFsEMsEppQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="527506061"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2021 22:23:18 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, seanjc@google.com,
        x86@kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v2 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation out of sleeping region
Date:   Fri, 30 Apr 2021 13:22:47 +0800
Message-Id: <20210430052247.3079672-2-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430052247.3079672-1-like.xu@linux.intel.com>
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is compiled with the CONFIG_LOCKDEP option, the conditional
might_sleep_if() deep in kmem_cache_alloc() will generate the following
trace, and potentially cause a deadlock when another LBR event is added:

[  243.115549] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:196
[  243.117576] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 839, name: perf
[  243.119326] INFO: lockdep is turned off.
[  243.120249] irq event stamp: 0
[  243.120967] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  243.122415] hardirqs last disabled at (0): [<ffffffff810d9bf5>] copy_process+0xa45/0x1dc0
[  243.124302] softirqs last  enabled at (0): [<ffffffff810d9bf5>] copy_process+0xa45/0x1dc0
[  243.126255] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  243.128119] CPU: 0 PID: 839 Comm: perf Not tainted 5.11.0-rc4-guest+ #8
[  243.129654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[  243.131520] Call Trace:
[  243.132112]  dump_stack+0x8d/0xb5
[  243.132896]  ___might_sleep.cold.106+0xb3/0xc3
[  243.133984]  slab_pre_alloc_hook.constprop.85+0x96/0xd0
[  243.135208]  ? intel_pmu_lbr_add+0x152/0x170
[  243.136207]  kmem_cache_alloc+0x36/0x250
[  243.137126]  intel_pmu_lbr_add+0x152/0x170
[  243.138088]  x86_pmu_add+0x83/0xd0
[  243.138889]  ? lock_acquire+0x158/0x350
[  243.139791]  ? lock_acquire+0x158/0x350
[  243.140694]  ? lock_acquire+0x158/0x350
[  243.141625]  ? lock_acquired+0x1e3/0x360
[  243.142544]  ? lock_release+0x1bf/0x340
[  243.143726]  ? trace_hardirqs_on+0x1a/0xd0
[  243.144823]  ? lock_acquired+0x1e3/0x360
[  243.145742]  ? lock_release+0x1bf/0x340
[  243.147107]  ? __slab_free+0x49/0x540
[  243.147966]  ? trace_hardirqs_on+0x1a/0xd0
[  243.148924]  event_sched_in.isra.129+0xf8/0x2a0
[  243.149989]  merge_sched_in+0x261/0x3e0
[  243.150889]  ? trace_hardirqs_on+0x1a/0xd0
[  243.151869]  visit_groups_merge.constprop.135+0x130/0x4a0
[  243.153122]  ? sched_clock_cpu+0xc/0xb0
[  243.154023]  ctx_sched_in+0x101/0x210
[  243.154884]  ctx_resched+0x6f/0xc0
[  243.155686]  perf_event_exec+0x21e/0x2e0
[  243.156641]  begin_new_exec+0x5e5/0xbd0
[  243.157540]  load_elf_binary+0x6af/0x1770
[  243.158478]  ? __kernel_read+0x19d/0x2b0
[  243.159977]  ? lock_acquire+0x158/0x350
[  243.160876]  ? __kernel_read+0x19d/0x2b0
[  243.161796]  bprm_execve+0x3c8/0x840
[  243.162638]  do_execveat_common.isra.38+0x1a5/0x1c0
[  243.163776]  __x64_sys_execve+0x32/0x40
[  243.164676]  do_syscall_64+0x33/0x40
[  243.165514]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  243.166746] RIP: 0033:0x7f6180a26feb
[  243.167590] Code: Unable to access opcode bytes at RIP 0x7f6180a26fc1.
[  243.169097] RSP: 002b:00007ffc6558ce18 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[  243.170844] RAX: ffffffffffffffda RBX: 00007ffc65592d30 RCX: 00007f6180a26feb
[  243.172514] RDX: 000055657f408dc0 RSI: 00007ffc65592410 RDI: 00007ffc65592d30
[  243.174162] RBP: 00007ffc6558ce80 R08: 00007ffc6558cde0 R09: 0000000000000000
[  243.176042] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffc65592410
[  243.177696] R13: 000055657f408dc0 R14: 0000000000000001 R15: 00007ffc65592410

One of the solution is to use GFP_ATOMIC, but it will make the code less
reliable under memory pressue. Let's move the memory allocation out of
the sleeping region and put it into the intel_pmu_hw_config(). The LBR
xsave buffer is a per-CPU buffer, not a per-event buffer. This buffer is
allocated once when initializing the LBR event.

The disadvantage of this fix is that the cpuc->lbr_xsave memory
will be allocated for each cpu like the legacy ds_buffer.

Fixes: c085fb8774 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
v1->v2 Changelog:
- Frob reserve_lbr_buffers() in intel_pmu_hw_config().

 arch/x86/events/intel/core.c |  2 ++
 arch/x86/events/intel/lbr.c  | 25 +++++++++++++++++++------
 arch/x86/events/perf_event.h |  6 ++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 456aa6ffd9a1..19027aa01f82 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3745,6 +3745,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 			event->destroy = hw_perf_lbr_event_destroy;
 		}
+
+		reserve_lbr_buffers(event);
 	}
 
 	if (event->attr.aux_output) {
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bb4486c4155a..1c39155c9f67 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -658,7 +658,6 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
-	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -696,11 +695,6 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
-
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
-	    kmem_cache && !cpuc->lbr_xsave &&
-	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
-		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
 }
 
 void release_lbr_buffers(void)
@@ -722,6 +716,25 @@ void release_lbr_buffers(void)
 	}
 }
 
+void reserve_lbr_buffers(struct perf_event *event)
+{
+	struct kmem_cache *kmem_cache;
+	struct cpu_hw_events *cpuc;
+	int cpu;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
+		if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
+			cpuc->lbr_xsave =
+				kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+						      cpu_to_node(cpu));
+	}
+}
+
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e7d4fd..727e5490e78c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1244,6 +1244,8 @@ void reserve_ds_buffers(void);
 
 void release_lbr_buffers(void);
 
+void reserve_lbr_buffers(struct perf_event *event);
+
 extern struct event_constraint bts_constraint;
 extern struct event_constraint vlbr_constraint;
 
@@ -1393,6 +1395,10 @@ static inline void release_lbr_buffers(void)
 {
 }
 
+static inline void reserve_lbr_buffers(struct perf_event *event)
+{
+}
+
 static inline int intel_pmu_init(void)
 {
 	return 0;
-- 
2.30.2

