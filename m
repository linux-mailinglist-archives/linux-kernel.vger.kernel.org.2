Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7243F42D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2A6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:58:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50787 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2A6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635468979; x=1667004979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0UmT3ck0FAKQMkpKpXlOy+Nyz7ErJp9tp/dW7q8/QE4=;
  b=bUQ8OEDuIvCStdgl8exu8od0VLJ/JPfz7Ve9UqbRVeIt/2RWckggGfTX
   F7zLXeynXK12Am64sN5SccygMveeNAPH0e/sDpBAlrkj24D8sMzpYZ5yS
   7XjZdqyGaQULK9kLSWc2d1TVeT/iChQko0CwgtViPfYos6wFXAe/j/kuz
   koRbRHrX4rpBYP/cOOt29j7NmVJNZQzWiwrGc7toLbLwYdj2Rg939Zl/p
   tuzjNwCZXmgO/FgAN5bFR6ScpSU6eJ7IECX+TY1SIbTAYDS5NC6rNZ3Yp
   9LPcCgrwFDR1ZR30S41trqkCEpedxbCEcJibw9cQdC29JkUw/M126JnYP
   w==;
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="184122988"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2021 08:56:19 +0800
IronPort-SDR: FsgT4DNuT2mHP3xPGmraww15p2hYQYkWLsiWQj+e/NQ0ydo8oh1wK8nfLvTMjxHKzqy6GbPRWS
 MKMaOhqZEOKDyYRa9dJ/mmGyyAyOQXV+oNi9DYhkBYiEjZDlIJKBO5FJsWvWFqPOZAjv1EF0KS
 e+LBrhp+DQCXFhF5tFn6YnzhlI/oqgHuxm9AoxmX8MAA3CcEEAalp3dQhdSxnZT7I9vjtPi/a4
 yBr9TKomj6GtM4Dmo1ItBOwgDcLsm+mLhmpctUWnUbwRCEuksI7dVK6TDpHxMhe+bEhwcuFJ3H
 w94AaKfwDdk9pb8AmT2hTLx3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 17:31:46 -0700
IronPort-SDR: o7BvT5Kzd9zA9AU8WuV+Oe1PnSlfR1esDSLCQ12Ipy4Tz48G9NG8iUUMA1CzavCJFefPni2qSA
 m6AyrO2fMRVm5STTWtzOZHEnvUmGWSL0alD/0VSemp4v2VgwIGsg1IBLjSbTrC1M+fkwJ1mHZl
 wAnOB9nITWRTroi8ZJUBmZ82Pmp6H4T68GtkafCvMBOARS+WmMCRyBW2Ucac5R2qne4X6GknrM
 V3D4S5SZtHC3xixD6NRqjpN0xHQZNefPTfX4ay6qDY7J2U8O/f1iWc4UMhJGSr+sb0+vQprJSj
 x9E=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2021 17:56:19 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] sched: Fix wrong cpus_share_cache() return at CPU hotplug
Date:   Fri, 29 Oct 2021 09:56:18 +0900
Message-Id: <20211029005618.773579-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper function cpus_share_cache(int this_cpu, int that_cpu) refers
per-cpu variable sd_llc_id, or scheduler domain ID. If the two CPUs
provided to the function have same sd_llc_id value, it returns true
meaning the two CPUs share cache. When same single CPU is given to the
function as check target two CPUs, it is expected that it returns true.
However, the function can return false even when same CPU is given.
While CPU hotplug event is ongoing and scheduler domains are being
destroyed and rebuilt, sd_llc_id value changes. This value change can
happen between two sd_llc_id references in cpus_share_cache(), and the
obtained two values can be different for the same CPU.

Such wrong false return value by cpus_share_cache() resulted in a kernel
warning in ttwu_queue_wakelist() [1]. The wrong return value was passed
from ttwu_queue_cond() to ttwu_queue_wakelist() and triggered the check
"WARN_ON_ONCE(cpu == smp_processor_id()". This warning was observed by
repeating blktests test case block/008 hundreds of times, which tests
block IO during CPU hotplug.

To fix the warning, return true from cpus_share_cache() when same CPU is
given to the function, regardless of sd_llc_id value.

[1]

[ 1133.598735] WARNING: CPU: 1 PID: 10231 at kernel/sched/core.c:3744 ttwu_queue_wakelist+0x283/0x2f0
[ 1133.608391] Modules linked in: null_blk xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set nfnetlink ebtable_filter ebtables target_core_user rfkill target_core_mod ip6table_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt intel_pmc_bxt at24 iTCO_vendor_support kvm irqbypass rapl intel_cstate intel_uncore ipmi_ssif joydev pcspkr ses enclosure i2c_i801 i2c_smbus intel_pch_thermal acpi_ipmi lpc_ich ie31200_edac ipmi_si ipmi_devintf ipmi_msghandler video
[ 1133.608559]  zram ip_tables ast drm_vram_helper drm_kms_helper crct10dif_pclmul crc32_pclmul cec crc32c_intel drm_ttm_helper ttm ghash_clmulni_intel drm igb mpt3sas e1000e raid_class scsi_transport_sas dca i2c_algo_bit fuse
[ 1133.715349] CPU: 1 PID: 10231 Comm: fio Not tainted 5.15.0-rc7 #37
[ 1133.722227] Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/2015
[ 1133.729960] RIP: 0010:ttwu_queue_wakelist+0x283/0x2f0
[ 1133.735713] Code: 34 24 e8 10 e4 66 00 4c 8b 44 24 10 48 8b 4c 24 08 8b 34 24 e9 a2 fe ff ff e8 49 e4 66 00 e9 67 ff ff ff e8 5f e4 66 00 eb a0 <0f> 0b e9 cc fe ff ff 48 89 04 24 e8 ed e3 66 00 48 8b 04 24 e9 e8
[ 1133.755155] RSP: 0018:ffff8881450b72d0 EFLAGS: 00010046
[ 1133.761081] RAX: 0000000000000001 RBX: ffff888103aa8000 RCX: ffff8886f0a40000
[ 1133.768909] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb8090ac8
[ 1133.776735] RBP: 0000000000000001 R08: ffffffffb8090ac8 R09: ffffffffb8be5ee7
[ 1133.784559] R10: fffffbfff717cbdc R11: 0000000000000001 R12: 0000000000000000
[ 1133.792387] R13: ffff8886f0a60c40 R14: 0000000000000001 R15: ffff8886f0a40001
[ 1133.800213] FS:  00007f30ae894b80(0000) GS:ffff8886f0a40000(0000) knlGS:0000000000000000
[ 1133.809000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1133.815439] CR2: 0000556ff4c8edc0 CR3: 0000000134230005 CR4: 00000000001706e0
[ 1133.823264] Call Trace:
[ 1133.826416]  try_to_wake_up+0x444/0x13f0
[ 1133.831040]  ? migrate_swap_stop+0x7a0/0x7a0
[ 1133.836005]  ? insert_work+0x193/0x2e0
[ 1133.840455]  __queue_work+0x4c2/0xca0
[ 1133.844824]  ? try_to_grab_pending.part.0+0x41a/0x540
[ 1133.850576]  mod_delayed_work_on+0xa4/0x110
[ 1133.855464]  ? cancel_delayed_work_sync+0x10/0x10
[ 1133.860870]  ? __blk_mq_delay_run_hw_queue+0x96/0x4b0
[ 1133.866628]  kblockd_mod_delayed_work_on+0x17/0x20
[ 1133.872120]  blk_mq_run_hw_queue+0x125/0x270
[ 1133.877096]  ? blk_mq_delay_run_hw_queues+0x410/0x410
[ 1133.882841]  ? lockdep_hardirqs_on_prepare+0x278/0x3e0
[ 1133.888675]  blk_mq_sched_insert_request+0x272/0x430
[ 1133.894343]  ? __blk_mq_sched_bio_merge+0x350/0x350
[ 1133.899928]  blk_mq_submit_bio+0xb72/0x14d0
[ 1133.904814]  ? blk_mq_try_issue_list_directly+0x940/0x940
[ 1133.910913]  ? submit_bio_checks+0xf41/0x1690
[ 1133.915974]  ? lock_release+0x1d4/0x690
[ 1133.920515]  ? blk_try_enter_queue+0x1d9/0x3b0
[ 1133.925665]  ? percpu_ref_put_many.constprop.0+0x6c/0x1b0
[ 1133.931770]  __submit_bio+0x5f3/0x720
[ 1133.936134]  ? get_user_pages+0xa0/0xa0
[ 1133.940679]  ? submit_bio_checks+0x1690/0x1690
[ 1133.945827]  ? iov_iter_get_pages_alloc+0xf50/0xf50
[ 1133.951403]  ? find_held_lock+0x2c/0x110
[ 1133.956024]  submit_bio_noacct+0x22a/0x910
[ 1133.960828]  ? __submit_bio+0x720/0x720
[ 1133.965369]  submit_bio+0xc3/0x380
[ 1133.969473]  ? bio_release_pages.part.0+0x10c/0x3d0
[ 1133.975048]  ? submit_bio_noacct+0x910/0x910
[ 1133.980015]  __blkdev_direct_IO_simple+0x43d/0x7c0
[ 1133.985511]  ? blkdev_llseek+0xc0/0xc0
[ 1133.989969]  ? blkdev_get_block+0xd0/0xd0
[ 1133.994680]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[ 1134.000517]  ? mark_lock+0xea/0x1610
[ 1134.004792]  blkdev_direct_IO+0xa61/0x1250
[ 1134.009592]  ? lock_chain_count+0x20/0x20
[ 1134.014299]  ? __lock_acquire+0x1591/0x5010
[ 1134.019179]  ? filemap_check_errors+0x56/0xe0
[ 1134.024240]  ? filemap_write_and_wait_range+0xe7/0x130
[ 1134.030072]  ? blkdev_bio_end_io+0x3f0/0x3f0
[ 1134.035052]  generic_file_read_iter+0x1f4/0x470
[ 1134.040283]  blkdev_read_iter+0x100/0x190
[ 1134.044999]  new_sync_read+0x357/0x5d0
[ 1134.049449]  ? __fsnotify_parent+0x275/0xa30
[ 1134.054418]  ? __ia32_sys_llseek+0x2f0/0x2f0
[ 1134.059391]  ? __fsnotify_update_child_dentry_flags+0x2e0/0x2e0
[ 1134.066014]  ? __cond_resched+0x15/0x30
[ 1134.070553]  ? inode_security+0x56/0xf0
[ 1134.075102]  vfs_read+0x26c/0x4c0
[ 1134.079120]  __x64_sys_pread64+0x17c/0x1d0
[ 1134.083918]  ? vfs_read+0x4c0/0x4c0
[ 1134.088105]  ? syscall_enter_from_user_mode+0x21/0x70
[ 1134.093860]  do_syscall_64+0x3b/0x90
[ 1134.098140]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1134.103885] RIP: 0033:0x7f30b8ce91ef
[ 1134.108158] Code: 08 89 3c 24 48 89 4c 24 18 e8 2d f4 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 7d f4 ff ff 48 8b
[ 1134.127598] RSP: 002b:00007ffca86a7b60 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
[ 1134.135859] RAX: ffffffffffffffda RBX: 0000000002014540 RCX: 00007f30b8ce91ef
[ 1134.143684] RDX: 0000000000001000 RSI: 000000000207a000 RDI: 0000000000000009
[ 1134.151510] RBP: 0000000002014540 R08: 0000000000000000 R09: 0000000000000001
[ 1134.159336] R10: 00000000009ad000 R11: 0000000000000293 R12: 00007f30991a87a0
[ 1134.167163] R13: 0000000000000000 R14: 0000000000001000 R15: 00007f30991a87a0
[ 1134.174994] irq event stamp: 2161568
[ 1134.179271] hardirqs last  enabled at (2161567): [<ffffffffb53ca974>] seqcount_lockdep_reader_access.constprop.0+0x84/0x90
[ 1134.191006] hardirqs last disabled at (2161568): [<ffffffffb52361e7>] mod_delayed_work_on+0xd7/0x110
[ 1134.200832] softirqs last  enabled at (2161560): [<ffffffffb51e8a5c>] __irq_exit_rcu+0x19c/0x200
[ 1134.210315] softirqs last disabled at (2161529): [<ffffffffb51e8a5c>] __irq_exit_rcu+0x19c/0x200
[ 1134.219796] ---[ end trace aa5b727cb85e092a ]---

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f21714ea3db8..6de5e8082b95 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3707,6 +3707,13 @@ void wake_up_if_idle(int cpu)
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
+	/*
+	 * When this_cpu and that_cpu are same, sd_llc_id for the same cpu may
+	 * change between two references. Return true regardless of sd_llc_id.
+	 */
+	if (this_cpu == that_cpu)
+		return true;
+
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-- 
2.31.1

