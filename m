Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D4368ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhDWI2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Apr 2021 04:28:02 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:57316 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhDWI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:28:01 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id DDD1E18E033
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:27:21 +0100 (IST)
Received: (qmail 12155 invoked from network); 23 Apr 2021 08:27:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Apr 2021 08:27:21 -0000
Date:   Fri, 23 Apr 2021 09:25:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH 00/10] sched/fair: wake_affine improvements
Message-ID: <20210423082532.GA4239@techsingularity.net>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:53:16PM +0530, Srikar Dronamraju wrote:
> Recently we found that some of the benchmark numbers on Power10 were lesser
> than expected. Some analysis showed that the problem lies in the fact that
> L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.
> 

I didn't get the chance to review this properly although I am suspicious
of tracking idle_core and updating that more frequently. It becomes a very
hot cache line that bounces. I did experiement with tracking an idle core
but the data either went stale too quickly or the updates incurred more
overhead than a reduced search saved.

The series also oopses a *lot* and didn't get through a run of basic
workloads on x86 on any of three machines. An example oops is

[  137.770968] BUG: unable to handle page fault for address: 000000000001a5c8
[  137.777836] #PF: supervisor read access in kernel mode
[  137.782965] #PF: error_code(0x0000) - not-present page
[  137.788097] PGD 8000004098a42067 P4D 8000004098a42067 PUD 4092e36067 PMD 40883ac067 PTE 0
[  137.796261] Oops: 0000 [#1] SMP PTI
[  137.799747] CPU: 0 PID: 14913 Comm: GC Slave Tainted: G            E     5.12.0-rc8-llcfallback-v1r1 #1
[  137.809123] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
[  137.816765] RIP: 0010:cpus_share_cache+0x22/0x30
[  137.821396] Code: fc ff 0f 0b eb 80 66 90 0f 1f 44 00 00 48 63 ff 48 63 f6 48 c7 c0 c8 a5 01 00 48 8b 0c fd 00 59 9d 9a 48 8b 14 f5 00 59 9d 9a <8b> 14 02 39 14 01 0f 94 c0 c3 0f 1f 40 00 0f 1f 44 00 00 41 57 41
[  137.840133] RSP: 0018:ffff9e0aa26a7c60 EFLAGS: 00010086
[  137.845360] RAX: 000000000001a5c8 RBX: ffff8bfbc65cf280 RCX: ffff8c3abf440000
[  137.852483] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000015
[  137.859605] RBP: ffff8bbc478b9fe0 R08: 0000000000000000 R09: 000000000001a5b8
[  137.866730] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8bbc47c88a00
[  137.873855] R13: 0000000000000015 R14: 0000000000000001 R15: ffff8bfde0199fc0
[  137.880978] FS:  00007fa33c173700(0000) GS:ffff8bfabf400000(0000) knlGS:0000000000000000
[  137.889055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.894794] CR2: 000000000001a5c8 CR3: 0000004096b22006 CR4: 00000000003706f0
[  137.901918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  137.909041] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  137.916164] Call Trace:
[  137.918614]  select_task_rq_fair+0xb88/0x1410
[  137.922974]  try_to_wake_up+0x114/0x4b0
[  137.926813]  ? should_numa_migrate_memory+0x54/0x170
[  137.931775]  wake_up_q+0x64/0xa0
[  137.934999]  futex_wake+0x13e/0x160
[  137.938493]  do_futex+0xce/0xa80
[  137.941724]  ? asm_sysvec_call_function+0x12/0x20
[  137.946422]  ? __cgroup_account_cputime+0x24/0x30
[  137.951126]  ? update_curr+0xfa/0x1a0
[  137.954784]  ? pick_next_entity+0x70/0x110
[  137.958876]  ? pick_next_task_fair+0xd2/0x3b0
[  137.963233]  __x64_sys_futex+0x13b/0x1f0
[  137.967155]  do_syscall_64+0x33/0x80
[  137.970737]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  137.975786] RIP: 0033:0x7fc9de7e1cda
[  137.979365] Code: 00 00 b8 ca 00 00 00 0f 05 5a 5e c3 0f 1f 40 00 56 52 c7 07 00 00 00 00 81 f6 81 00 00 00 ba 01 00 00 00 b8 ca 00 00 00 0f 05 <5a> 5e c3 0f 1f 00 41 54 41 55 49 89 fc 49 89 f5 48 83 ec 18 48 89
[  137.998101] RSP: 002b:00007fa33c170af0 EFLAGS: 00000206 ORIG_RAX: 00000000000000ca
[  138.005657] RAX: ffffffffffffffda RBX: 00007fc9d80050a8 RCX: 00007fc9de7e1cda
[  138.012783] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 00007fc9d8005128
[  138.019907] RBP: 00007fc9d85b9298 R08: 0000000000000000 R09: 0000000000000001
[  138.027031] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fc9d8005128
[  138.034155] R13: 00007fc9d85b9268 R14: 00007fc9d8005150 R15: 00007fc9d85b8df8
[  138.041279] Modules linked in: binfmt_misc(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) dmi_sysfs(E) msr(E) intel_rapl_msr(E) intel_rapl_common(E) sb_edac(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) iTCO_wdt(E) kvm_intel(E) iTCO_vendor_support(E) ipmi_ssif(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ixgbe(E) ghash_clmulni_intel(E) xfrm_algo(E) aesni_intel(E) mdio_devres(E) crypto_simd(E) cryptd(E) joydev(E) igb(E) libphy(E) ioatdma(E) mei_me(E) i2c_i801(E) mdio(E) pcspkr(E) acpi_ipmi(E) i2c_smbus(E) lpc_ich(E) mei(E) dca(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) button(E) btrfs(E) blake2b_generic(E) libcrc32c(E) xor(E) raid6_pq(E) hid_generic(E) usbhid(E) ast(E) i2c_algo_bit(E) drm_vram_helper(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) cec(E) xhci_pci(E) drm_ttm_helper(E) ehci_pci(E) ttm(E) xhci_hcd(E) ehci_hcd(E) crc32c_intel(E) drm(E) usbcore(E) mpt3sas(E)
[  138.041333]  raid_class(E) scsi_transport_sas(E) wmi(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E)
[  138.140016] CR2: 000000000001a5c8

-- 
Mel Gorman
SUSE Labs
