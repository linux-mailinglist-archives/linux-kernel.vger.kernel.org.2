Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4288236F3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhD3CRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 22:17:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:50274 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhD3CRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 22:17:22 -0400
IronPort-SDR: 5vahKbqt4JEIfZvYuHPgoob+fDrddvdphh0mYY6xJMe9BQVSJaWc/29eXb/ynJozeQx4iVLfvM
 bSoufhR6Chpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="176656363"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="xz'?yaml'?scan'208";a="176656363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 19:16:33 -0700
IronPort-SDR: in9eAQFVDPeYBDIfkU7R+vAKxW595QKDgF2tTEDXaLJgdjZGdiA7qclzHkxieJ3S1y5a8Fz6QY
 /Ggw+sCtLF2A==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="xz'?yaml'?scan'208";a="431191718"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 19:16:29 -0700
Date:   Fri, 30 Apr 2021 10:33:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, netfilter-devel@vger.kernel.org
Subject: [netfilter]  d509b127cc:
 WARNING:at_kernel/rcu/tree_plugin.h:#__rcu_read_unlock
Message-ID: <20210430023339.GA14275@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20210422221712.399156-6-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d509b127ccf0fe5fc48dd6c337c5291d24173418 ("[PATCH nf-next 5/5] netfilter: nfnetlink: consolidate callback types")
url: https://github.com/0day-ci/linux/commits/Pablo-Neira-Ayuso/nfnetlink-housekeeping/20210423-061840
base: https://git.kernel.org/cgit/linux/kernel/git/pablo/nf-next.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-cf9ae1bd-1_20210401
with following parameters:

	group: net
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


kern :warn : [  107.239912] WARNING: CPU: 0 PID: 4897 at kernel/rcu/tree_plugin.h:404 __rcu_read_unlock (kbuild/src/consumer/kernel/rcu/tree_plugin.h:404 kbuild/src/consumer/kernel/rcu/tree_plugin.h:392) 
kern  :warn  : [  107.249253] Modules linked in: nft_compat nf_tables nfnetlink esp4_offload psample esp4 cls_u32 sch_htb nf_conntrack_broadcast nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi sg mei_wdt ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl intel_cstate i915 hp_wmi sparse_keymap rfkill wmi_bmof ahci libahci mei_me intel_uncore i2c_i801 mei i2c_smbus serio_raw libata intel_pch_thermal intel_gtt ie31200_edac wmi video intel_pmc_core acpi_pad tpm_infineon ip_tables [last unloaded: netdevsim]
kern  :warn  : [  107.315476] CPU: 0 PID: 4897 Comm: iptables Not tainted 5.12.0-rc6-02036-gd509b127ccf0 #1
kern  :warn  : [  107.324047] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
kern :warn : [  107.333270] RIP: 0010:__rcu_read_unlock (kbuild/src/consumer/kernel/rcu/tree_plugin.h:404 kbuild/src/consumer/kernel/rcu/tree_plugin.h:392) 
kern :warn : [ 107.338310] Code: 81 e2 00 00 0f 00 0f 85 d2 00 00 00 4d 85 ed 74 40 84 c0 74 3c bf 09 00 00 00 e8 87 9c f5 ff e8 a2 b9 09 00 fb e9 43 ff ff ff <0f> 0b 5b 5d 41 5c 41 5d c3 e8 8e ba 09 00 66 85 db 0f 85 6f ff ff
All code
========
   0:	81 e2 00 00 0f 00    	and    $0xf0000,%edx
   6:	0f 85 d2 00 00 00    	jne    0xde
   c:	4d 85 ed             	test   %r13,%r13
   f:	74 40                	je     0x51
  11:	84 c0                	test   %al,%al
  13:	74 3c                	je     0x51
  15:	bf 09 00 00 00       	mov    $0x9,%edi
  1a:	e8 87 9c f5 ff       	callq  0xfffffffffff59ca6
  1f:	e8 a2 b9 09 00       	callq  0x9b9c6
  24:	fb                   	sti    
  25:	e9 43 ff ff ff       	jmpq   0xffffffffffffff6d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	41 5d                	pop    %r13
  32:	c3                   	retq   
  33:	e8 8e ba 09 00       	callq  0x9bac6
  38:	66 85 db             	test   %bx,%bx
  3b:	0f                   	.byte 0xf
  3c:	85 6f ff             	test   %ebp,-0x1(%rdi)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	c3                   	retq   
   9:	e8 8e ba 09 00       	callq  0x9ba9c
   e:	66 85 db             	test   %bx,%bx
  11:	0f                   	.byte 0xf
  12:	85 6f ff             	test   %ebp,-0x1(%rdi)
  15:	ff                   	.byte 0xff
kern  :warn  : [  107.357809] RSP: 0018:ffffc90000f57a60 EFLAGS: 00010286
kern  :warn  : [  107.363542] RAX: ffff888439890000 RBX: ffffc90000f57b28 RCX: 0000000000000000
kern  :warn  : [  107.370996] RDX: 0000000000000001 RSI: ffffffff827e19cb RDI: ffffffff827ed77c
kern  :warn  : [  107.378433] RBP: ffff888439890000 R08: 0000000000000000 R09: 000000000004073a
kern  :warn  : [  107.385906] R10: ffffc90000f57ae0 R11: 0000000000000000 R12: ffff888237197618
kern  :warn  : [  107.393339] R13: ffffffffc099c137 R14: 0000000000000000 R15: 0000000000000000
kern  :warn  : [  107.400791] FS:  00007f5d95a17740(0000) GS:ffff88843f400000(0000) knlGS:0000000000000000
kern  :warn  : [  107.409204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  107.415162] CR2: 00007ffdd18f6084 CR3: 00000002371ac005 CR4: 00000000003706f0
kern  :warn  : [  107.422585] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  107.430139] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [  107.437588] Call Trace:
kern :warn : [  107.440261] nfnl_compat_get_rcu (kbuild/src/consumer/include/linux/rcupdate.h:272 kbuild/src/consumer/include/linux/rcupdate.h:710 kbuild/src/consumer/net/netfilter/nft_compat.c:660) nft_compat
kern :warn : [  107.445931] nfnetlink_rcv_msg (kbuild/src/consumer/net/netfilter/nfnetlink.c:98 kbuild/src/consumer/net/netfilter/nfnetlink.c:295) nfnetlink
kern :warn : [  107.451549] ? __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4900) 
kern :warn : [  107.455950] ? __lock_acquire (kbuild/src/consumer/kernel/locking/lockdep.c:4900) 
kern :warn : [  107.460308] ? nfnetlink_net_init (kbuild/src/consumer/net/netfilter/nfnetlink.c:212) nfnetlink
kern :warn : [  107.466040] netlink_rcv_skb (kbuild/src/consumer/net/netlink/af_netlink.c:2502) 
kern :warn : [  107.470245] nfnetlink_rcv (kbuild/src/consumer/net/netfilter/nfnetlink.c:651) nfnetlink
kern :warn : [  107.475278] netlink_unicast (kbuild/src/consumer/net/netlink/af_netlink.c:1313 kbuild/src/consumer/net/netlink/af_netlink.c:1338) 
kern :warn : [  107.479491] netlink_sendmsg (kbuild/src/consumer/net/netlink/af_netlink.c:1927) 
kern  :warn  : [  107.483734] ------------[ cut here ]------------
kern :warn : [  107.488519] WARNING: CPU: 0 PID: 4897 at kernel/rcu/tree_plugin.h:699 rcu_sched_clock_irq (kbuild/src/consumer/kernel/rcu/tree_plugin.h:699 kbuild/src/consumer/kernel/rcu/tree.c:2649) 
kern  :warn  : [  107.498080] Modules linked in: nft_compat nf_tables nfnetlink esp4_offload psample esp4 cls_u32 sch_htb nf_conntrack_broadcast nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi sg mei_wdt ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl intel_cstate i915 hp_wmi sparse_keymap rfkill wmi_bmof ahci libahci mei_me intel_uncore i2c_i801 mei i2c_smbus serio_raw libata intel_pch_thermal intel_gtt ie31200_edac wmi video intel_pmc_core acpi_pad tpm_infineon ip_tables [last unloaded: netdevsim]
kern  :warn  : [  107.564155] CPU: 0 PID: 4897 Comm: iptables Not tainted 5.12.0-rc6-02036-gd509b127ccf0 #1
kern  :warn  : [  107.572590] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
kern :warn : [  107.581764] RIP: 0010:rcu_sched_clock_irq (kbuild/src/consumer/kernel/rcu/tree_plugin.h:699 kbuild/src/consumer/kernel/rcu/tree.c:2649) 
kern :warn : [ 107.586974] Code: 30 0b bf 00 e9 cb fd ff ff 69 c0 e8 03 00 00 8d 84 40 98 3a 00 00 48 98 e9 28 fc ff ff 4c 89 e7 e8 69 bc ff ff e9 f6 f8 ff ff <0f> 0b e9 d6 f8 ff ff e8 78 29 ff ff 84 c0 0f 85 9d fc ff ff e9 a6
All code
========
   0:	30 0b                	xor    %cl,(%rbx)
   2:	bf 00 e9 cb fd       	mov    $0xfdcbe900,%edi
   7:	ff                   	(bad)  
   8:	ff 69 c0             	ljmp   *-0x40(%rcx)
   b:	e8 03 00 00 8d       	callq  0xffffffff8d000013
  10:	84 40 98             	test   %al,-0x68(%rax)
  13:	3a 00                	cmp    (%rax),%al
  15:	00 48 98             	add    %cl,-0x68(%rax)
  18:	e9 28 fc ff ff       	jmpq   0xfffffffffffffc45
  1d:	4c 89 e7             	mov    %r12,%rdi
  20:	e8 69 bc ff ff       	callq  0xffffffffffffbc8e
  25:	e9 f6 f8 ff ff       	jmpq   0xfffffffffffff920
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 d6 f8 ff ff       	jmpq   0xfffffffffffff907
  31:	e8 78 29 ff ff       	callq  0xffffffffffff29ae
  36:	84 c0                	test   %al,%al
  38:	0f 85 9d fc ff ff    	jne    0xfffffffffffffcdb
  3e:	e9                   	.byte 0xe9
  3f:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 d6 f8 ff ff       	jmpq   0xfffffffffffff8dd
   7:	e8 78 29 ff ff       	callq  0xffffffffffff2984
   c:	84 c0                	test   %al,%al
   e:	0f 85 9d fc ff ff    	jne    0xfffffffffffffcb1
  14:	e9                   	.byte 0xe9
  15:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
kern  :warn  : [  107.606374] RSP: 0018:ffffc90000003e88 EFLAGS: 00010086
kern  :warn  : [  107.611815] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
kern  :warn  : [  107.619167] RDX: 0000000000000000 RSI: ffffffff828a6c35 RDI: ffffffff82823c4e
kern  :warn  : [  107.626557] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [  107.633990] R10: ffff888439890000 R11: 0000000000000000 R12: ffff888439890000
kern  :warn  : [  107.641393] R13: 00000000ffffffff R14: 0000000000000001 R15: 0000000000000001
kern  :warn  : [  107.648839] FS:  00007f5d95a17740(0000) GS:ffff88843f400000(0000) knlGS:0000000000000000
kern  :warn  : [  107.657198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  107.663128] CR2: 00007ffdd18f6084 CR3: 00000002371ac005 CR4: 00000000003706f0
kern  :warn  : [  107.670518] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  107.677960] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [  107.685334] Call Trace:
kern  :warn  : [  107.687880]  <IRQ>
kern :warn : [  107.690014] update_process_times (kbuild/src/consumer/arch/x86/include/asm/preempt.h:27 kbuild/src/consumer/kernel/time/timer.c:1798) 
kern :warn : [  107.694356] tick_sched_handle+0x1f/0x60 
kern :warn : [  107.699067] tick_sched_timer (kbuild/src/consumer/kernel/time/tick-sched.c:1374) 
kern :warn : [  107.703040] ? tick_sched_do_timer (kbuild/src/consumer/kernel/time/tick-sched.c:1356) 
kern :warn : [  107.707483] __hrtimer_run_queues (kbuild/src/consumer/kernel/time/hrtimer.c:1537 kbuild/src/consumer/kernel/time/hrtimer.c:1601) 
kern :warn : [  107.712090] hrtimer_interrupt (kbuild/src/consumer/kernel/time/hrtimer.c:1666) 
kern :warn : [  107.716416] __sysvec_apic_timer_interrupt (kbuild/src/consumer/arch/x86/include/asm/jump_label.h:25 kbuild/src/consumer/include/linux/jump_label.h:200 kbuild/src/consumer/arch/x86/include/asm/trace/irq_vectors.h:41 kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1107) 
kern :warn : [  107.721645] sysvec_apic_timer_interrupt (kbuild/src/consumer/arch/x86/kernel/apic/apic.c:1100 (discriminator 14)) 
kern  :warn  : [  107.726628]  </IRQ>
kern :warn : [  107.728876] asm_sysvec_apic_timer_interrupt (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:632) 
kern :warn : [  107.734190] RIP: 0010:report_bug (kbuild/src/consumer/lib/bug.c:59 kbuild/src/consumer/lib/bug.c:135 kbuild/src/consumer/lib/bug.c:150) 
kern :warn : [ 107.738511] Code: 40 67 72 83 48 3d f4 7a 74 83 73 33 48 63 05 0b 52 02 02 48 c7 c3 40 67 72 83 48 05 40 67 72 83 49 39 c4 75 0d eb 23 48 63 03 <48> 01 d8 49 39 c4 74 18 48 83 c3 0c 48 81 fb f4 7a 74 83 72 e8 4c
All code
========
   0:	40                   	rex
   1:	67 72 83             	addr32 jb 0xffffffffffffff87
   4:	48 3d f4 7a 74 83    	cmp    $0xffffffff83747af4,%rax
   a:	73 33                	jae    0x3f
   c:	48 63 05 0b 52 02 02 	movslq 0x202520b(%rip),%rax        # 0x202521e
  13:	48 c7 c3 40 67 72 83 	mov    $0xffffffff83726740,%rbx
  1a:	48 05 40 67 72 83    	add    $0xffffffff83726740,%rax
  20:	49 39 c4             	cmp    %rax,%r12
  23:	75 0d                	jne    0x32
  25:	eb 23                	jmp    0x4a
  27:	48 63 03             	movslq (%rbx),%rax
  2a:*	48 01 d8             	add    %rbx,%rax		<-- trapping instruction
  2d:	49 39 c4             	cmp    %rax,%r12
  30:	74 18                	je     0x4a
  32:	48 83 c3 0c          	add    $0xc,%rbx
  36:	48 81 fb f4 7a 74 83 	cmp    $0xffffffff83747af4,%rbx
  3d:	72 e8                	jb     0x27
  3f:	4c                   	rex.WR

Code starting with the faulting instruction
===========================================
   0:	48 01 d8             	add    %rbx,%rax
   3:	49 39 c4             	cmp    %rax,%r12
   6:	74 18                	je     0x20
   8:	48 83 c3 0c          	add    $0xc,%rbx
   c:	48 81 fb f4 7a 74 83 	cmp    $0xffffffff83747af4,%rbx
  13:	72 e8                	jb     0xfffffffffffffffd
  15:	4c                   	rex.WR
kern  :warn  : [  107.757968] RSP: 0018:ffffc90000f576a8 EFLAGS: 00000283
kern  :warn  : [  107.763365] RAX: fffffffffdac8932 RBX: ffffffff8372d004 RCX: ffffffff82000fb7
kern  :warn  : [  107.770759] RDX: 00007ffffffff000 RSI: ffffc90000f57708 RDI: ffffffff812276c4
kern  :warn  : [  107.778119] RBP: ffffc90000f57708 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [  107.785470] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff812276c4
kern  :warn  : [  107.792913] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
kern :warn : [  107.800312] ? __rcu_read_unlock (kbuild/src/consumer/kernel/rcu/tree_plugin.h:404 kbuild/src/consumer/kernel/rcu/tree_plugin.h:392) 
kern :warn : [  107.804698] ? native_iret (kbuild/src/consumer/arch/x86/entry/entry_64.S:644) 
kern :warn : [  107.808241] ? __rcu_read_unlock (kbuild/src/consumer/kernel/rcu/tree_plugin.h:404 kbuild/src/consumer/kernel/rcu/tree_plugin.h:392) 
kern :warn : [  107.812599] ? report_bug (kbuild/src/consumer/lib/bug.c:147) 
kern :warn : [  107.816390] handle_bug (kbuild/src/consumer/arch/x86/kernel/traps.c:239) 
kern :warn : [  107.819905] exc_invalid_op (kbuild/src/consumer/arch/x86/kernel/traps.c:259 (discriminator 1)) 
kern :warn : [  107.823718] asm_exc_invalid_op (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:575) 
kern :warn : [  107.827905] RIP: 0010:__rcu_read_unlock (kbuild/src/consumer/kernel/rcu/tree_plugin.h:404 kbuild/src/consumer/kernel/rcu/tree_plugin.h:392) 
kern :warn : [ 107.832929] Code: 81 e2 00 00 0f 00 0f 85 d2 00 00 00 4d 85 ed 74 40 84 c0 74 3c bf 09 00 00 00 e8 87 9c f5 ff e8 a2 b9 09 00 fb e9 43 ff ff ff <0f> 0b 5b 5d 41 5c 41 5d c3 e8 8e ba 09 00 66 85 db 0f 85 6f ff ff
All code
========
   0:	81 e2 00 00 0f 00    	and    $0xf0000,%edx
   6:	0f 85 d2 00 00 00    	jne    0xde
   c:	4d 85 ed             	test   %r13,%r13
   f:	74 40                	je     0x51
  11:	84 c0                	test   %al,%al
  13:	74 3c                	je     0x51
  15:	bf 09 00 00 00       	mov    $0x9,%edi
  1a:	e8 87 9c f5 ff       	callq  0xfffffffffff59ca6
  1f:	e8 a2 b9 09 00       	callq  0x9b9c6
  24:	fb                   	sti    
  25:	e9 43 ff ff ff       	jmpq   0xffffffffffffff6d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	41 5d                	pop    %r13
  32:	c3                   	retq   
  33:	e8 8e ba 09 00       	callq  0x9bac6
  38:	66 85 db             	test   %bx,%bx
  3b:	0f                   	.byte 0xf
  3c:	85 6f ff             	test   %ebp,-0x1(%rdi)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	c3                   	retq   
   9:	e8 8e ba 09 00       	callq  0x9ba9c
   e:	66 85 db             	test   %bx,%bx
  11:	0f                   	.byte 0xf
  12:	85 6f ff             	test   %ebp,-0x1(%rdi)
  15:	ff                   	.byte 0xff


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc6-02036-gd509b127ccf0"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export job_origin='kernel-selftests-bm.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d06'
	export tbox_group='lkp-skl-d06'
	export submit_id='608a232b9fe0ac4731aa3bb3'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d509b127ccf0fe5fc48dd6c337c5291d24173418-20210429-18225-nxftmw-8.yaml'
	export id='b582c4f76d6aa281e30b07b27835ed480ce05139'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1'
	export brand='Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz'
	export commit='d509b127ccf0fe5fc48dd6c337c5291d24173418'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI
CONFIG_DRM_I915'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kselftests=true
	export need_kconfig='CONFIG_USER_NS=y
CONFIG_BPF_SYSCALL=y
CONFIG_TEST_BPF=m
CONFIG_NUMA=y ~ ">= v5.6-rc1"
CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
CONFIG_IPV6=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_VETH=y
CONFIG_NET_IPVTI=m
CONFIG_IPV6_VTI=m
CONFIG_DUMMY=y
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
CONFIG_IFB=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP_NF_NAT=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
CONFIG_NET_SCH_NETEM=y
CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
CONFIG_KALLSYMS=y
CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"'
	export enqueue_time='2021-04-29 11:08:27 +0800'
	export _id='608a232b9fe0ac4731aa3bb3'
	export _rt='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='d482eaed546913ed45730321ef8e01349c50f213'
	export base_commit='9f4ad9e425a1d3b6a34617b8ea226d56a119a717'
	export branch='linux-review/Pablo-Neira-Ayuso/nfnetlink-housekeeping/20210423-061840'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/8'
	export scheduler_version='/lkp/lkp/.src-20210425-142307'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d509b127ccf0fe5fc48dd6c337c5291d24173418-20210429-18225-nxftmw-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linux-review/Pablo-Neira-Ayuso/nfnetlink-housekeeping/20210423-061840
commit=d509b127ccf0fe5fc48dd6c337c5291d24173418
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/vmlinuz-5.12.0-rc6-02036-gd509b127ccf0
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/8
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210428.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cf9ae1bd-1_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=9
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/vmlinuz-5.12.0-rc6-02036-gd509b127ccf0'
	export dequeue_time='2021-04-29 11:16:23 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d509b127ccf0fe5fc48dd6c337c5291d24173418-20210429-18225-nxftmw-8.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='net' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='net' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--ReaqsoxgOBHFXBhH
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d509b127ccf0fe5fc48dd6c337c5291d24173418
2021-04-29 03:18:06 mount --bind /lib/modules/5.12.0-rc6-02036-gd509b127ccf0/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d509b127ccf0fe5fc48dd6c337c5291d24173418/lib
2021-04-29 03:18:06 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-04-29 03:18:06 /kselftests/run_kselftest.sh -c net
TAP version 13
1..49
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 6 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: control multiple sockets, max_num_members
# test: unique ids
# 
# test: datapath 0x0 ports 8000,8002
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
# 
# test: datapath 0x0 ports 8000,8003
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (19)
# 
# test: datapath 0x0 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,5, expect=20,5
# 
# test: datapath 0x1000 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x1 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=10,10, expect=10,10
# info: count=17,18, expect=18,17
# 
# test: datapath 0x3 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x6 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x7 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x2 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=20,0, expect=20,0
# info: count=20,0, expect=20,0
# 
# test: datapath 0x2 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=0,20, expect=0,20
# info: count=0,20, expect=0,20
# 
# test: datapath 0x2000 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=20,20, expect=20,20
# info: count=20,20, expect=20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 7 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 8 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 9 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias d956a27c-744d-4e93-9d86-0cab12a18b08 for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# Error: Unknown device type.
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
#
not ok 11 selftests: net: xfrm_policy.sh # TIMEOUT 45 seconds
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
# 
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [ OK ]
#     TEST: IPv6 fibmatch - no route                                      [ OK ]
# 
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [ OK ]
#     TEST: IPv6 - multipath down to single path                          [ OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [ OK ]
# 
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - no linkdown flag                                       [ OK ]
#     TEST: IPv6 - no linkdown flag                                       [ OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - linkdown flag set                                      [ OK ]
#     TEST: IPv6 - linkdown flag set                                      [ OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 no linkdown flag                                         [ OK ]
#     TEST: IPv6 no linkdown flag                                         [ OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# IPv4 nexthop tests
# <<< write me >>>
# 
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [ OK ]
#     TEST: Directly connected nexthop, unicast address with device       [ OK ]
#     TEST: Gateway is linklocal address                                  [ OK ]
#     TEST: Gateway is linklocal address, no device                       [ OK ]
#     TEST: Gateway can not be local unicast address                      [ OK ]
#     TEST: Gateway can not be local unicast address, with device         [ OK ]
#     TEST: Gateway can not be a local linklocal address                  [ OK ]
#     TEST: Gateway can be local address in a VRF                         [ OK ]
#     TEST: Gateway can be local address in a VRF, with device            [ OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [ OK ]
#     TEST: Redirect to VRF lookup                                        [ OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [ OK ]
#     TEST: VRF route, gateway can not be a local address                 [ OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [ OK ]
# 
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [ OK ]
# 
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv6 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with dev-only                                       [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Add new nexthop for existing prefix                           [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Append nexthop to existing route - dev only                   [ OK ]
#     TEST: Append nexthop to existing route - reject route               [ OK ]
#     TEST: Append nexthop to existing reject route - gw                  [ OK ]
#     TEST: Append nexthop to existing reject route - dev only            [ OK ]
#     TEST: add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv4 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with reject route                                 [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with reject route                                   [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv6 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Set metric with peer route on local side                      [ OK ]
#     TEST: Set metric with peer route on peer side                       [ OK ]
#     TEST: Modify metric and peer address on local side                  [ OK ]
#     TEST: Modify metric and peer address on peer side                   [ OK ]
# 
# IPv4 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Modify metric of .0/24 address                                [ OK ]
#     TEST: Set metric of address with peer route                         [ OK ]
#     TEST: Modify metric and peer address for peer route                 [ OK ]
# 
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ OK ]
#     TEST:     MTU of second leg                                         [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [ OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [ OK ]
#     TEST: Single path route delete                                      [ OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
# 
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [FAIL]
#     TEST: rp_filter passes loopback packets                             [FAIL]
# 
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [ OK ]
#     TEST: Route in default VRF not removed                              [ OK ]
#     TEST: Route removed in default VRF when source address deleted      [ OK ]
#     TEST: Route in VRF is not removed by address delete                 [ OK ]
# 
# IPv4 mangling tests
# socat command not found. Skipping test
# 
# IPv6 mangling tests
# socat command not found. Skipping test
# 
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
# 
# ########################################
# Configuring interfaces
# 
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local linklocal address                [ OK ]
#     TEST: Invalid gw - multicast address                      [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: Invalid gw - local linklocal address, VRF           [ OK ]
#     TEST: Invalid gw - multicast address, VRF                 [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# Tests passed:  38
# Tests failed:   0
ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions                        [ OK ]
#
not ok 15 selftests: net: pmtu.sh # TIMEOUT 45 seconds
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed = 1619666415
# ipv4 defrag with overlaps
# PASS
# seed = 1619666415
# ipv6 defrag
# PASS
# seed = 1619666422
# ipv6 defrag with overlaps
# PASS
# seed = 1619666422
# ipv6 nf_conntrack defrag
# PASS
# seed = 1619666426
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed = 1619666426
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:   7466 MB/s   126631 calls/s 126631 msg/s
# tcp rx:   7472 MB/s   126693 calls/s
# tcp tx:   7404 MB/s   125582 calls/s 125582 msg/s
# tcp rx:   7411 MB/s   125552 calls/s
# tcp tx:   7463 MB/s   126587 calls/s 126587 msg/s
# tcp zerocopy
# tcp tx:   5459 MB/s    92598 calls/s  92598 msg/s
# tcp rx:   5463 MB/s    92202 calls/s
# tcp tx:   5435 MB/s    92189 calls/s  92189 msg/s
# tcp rx:   5440 MB/s    91523 calls/s
# tcp tx:   5389 MB/s    91407 calls/s  91407 msg/s
# udp
# udp rx:    549 MB/s   391549 calls/s
# udp tx:    550 MB/s   391944 calls/s   9332 msg/s
# udp rx:    547 MB/s   390150 calls/s
# udp tx:    547 MB/s   389760 calls/s   9280 msg/s
# udp tx:    545 MB/s   388374 calls/s   9247 msg/s
# udp gso
# udp rx:   1735 MB/s  1236480 calls/s
# udp tx:   2474 MB/s    41970 calls/s  41970 msg/s
# udp tx:   2474 MB/s    41964 calls/s  41964 msg/s
# udp rx:   1728 MB/s  1231104 calls/s
# udp tx:   2473 MB/s    41948 calls/s  41948 msg/s
# udp gso zerocopy
# udp rx:   1672 MB/s  1191424 calls/s
# udp tx:   2166 MB/s    36749 calls/s  36749 msg/s
# udp tx:   2180 MB/s    36976 calls/s  36976 msg/s
# udp rx:   1683 MB/s  1199360 calls/s
# udp tx:   2178 MB/s    36956 calls/s  36956 msg/s
# udp gso timestamp
# udp tx:   2246 MB/s    38094 calls/s  38094 msg/s
# udp rx:   1739 MB/s  1239040 calls/s
# udp tx:   2250 MB/s    38170 calls/s  38170 msg/s
# udp rx:   1745 MB/s  1243648 calls/s
# udp tx:   2257 MB/s    38288 calls/s  38288 msg/s
# udp gso zerocopy audit
# udp tx:   2145 MB/s    36385 calls/s  36385 msg/s
# udp rx:   1652 MB/s  1177344 calls/s
# udp tx:   2163 MB/s    36693 calls/s  36693 msg/s
# udp rx:   1668 MB/s  1188608 calls/s
# udp tx:   2164 MB/s    36712 calls/s  36712 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   2209 MB/s     109790 calls (36596/s)     109790 msgs (36596/s)
# Zerocopy acks:              109790
# udp gso timestamp audit
# udp tx:   2239 MB/s    37980 calls/s  37980 msg/s
# udp rx:   1741 MB/s  1240320 calls/s
# udp tx:   2255 MB/s    38257 calls/s  38257 msg/s
# udp rx:   1753 MB/s  1249280 calls/s
# udp tx:   2251 MB/s    38192 calls/s  38192 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   2302 MB/s     114429 calls (38143/s)     114429 msgs (38143/s)
# Tx Timestamps:              114429 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:   1643 MB/s  1170708 calls/s
# udp tx:   1919 MB/s    32557 calls/s  32557 msg/s
# udp tx:   1930 MB/s    32744 calls/s  32744 msg/s
# udp rx:   1653 MB/s  1178112 calls/s
# udp tx:   1930 MB/s    32742 calls/s  32742 msg/s
# Summary over 3.000 seconds...
# sum udp tx:   1973 MB/s      98043 calls (32681/s)      98043 msgs (32681/s)
# Tx Timestamps:               98043 received                 0 errors
# Zerocopy acks:               98043
# ipv6
# tcp
# tcp tx:   7225 MB/s   122557 calls/s 122557 msg/s
# tcp rx:   7232 MB/s   122498 calls/s
# tcp tx:   7299 MB/s   123805 calls/s 123805 msg/s
# tcp rx:   7306 MB/s   123818 calls/s
# tcp tx:   7341 MB/s   124519 calls/s 124519 msg/s
# tcp zerocopy
# tcp tx:   5390 MB/s    91429 calls/s  91429 msg/s
# tcp rx:   5395 MB/s    90939 calls/s
# tcp tx:   5399 MB/s    91578 calls/s  91578 msg/s
# tcp rx:   5404 MB/s    91389 calls/s
# tcp tx:   5381 MB/s    91268 calls/s  91268 msg/s
# udp
# udp rx:    467 MB/s   340811 calls/s
# udp tx:    467 MB/s   341162 calls/s   7934 msg/s
# udp rx:    472 MB/s   344577 calls/s
# udp tx:    472 MB/s   344258 calls/s   8006 msg/s
# udp tx:    474 MB/s   346365 calls/s   8055 msg/s
# udp gso
# udp rx:   1691 MB/s  1232384 calls/s
# udp tx:   2486 MB/s    42177 calls/s  42177 msg/s
# udp tx:   2494 MB/s    42307 calls/s  42307 msg/s
# udp rx:   1696 MB/s  1236224 calls/s
# udp tx:   2491 MB/s    42252 calls/s  42252 msg/s
# udp gso zerocopy
# udp rx:   1627 MB/s  1186048 calls/s
# udp tx:   2208 MB/s    37457 calls/s  37457 msg/s
# udp tx:   2222 MB/s    37691 calls/s  37691 msg/s
# udp rx:   1642 MB/s  1197056 calls/s
# udp tx:   2217 MB/s    37618 calls/s  37618 msg/s
# udp gso timestamp
# udp rx:   1680 MB/s  1224448 calls/s
# udp tx:   2248 MB/s    38142 calls/s  38142 msg/s
# udp tx:   2258 MB/s    38311 calls/s  38311 msg/s
# udp rx:   1691 MB/s  1232640 calls/s
# udp tx:   2263 MB/s    38398 calls/s  38398 msg/s
#
not ok 18 selftests: net: udpgso_bench.sh # TIMEOUT 45 seconds
# selftests: net: fib_rule_tests.sh
# 
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
# 
#     TEST: rule4 check: oif dummy0                             [ OK ]
# 
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward = 1
# net.ipv4.conf.dummy0.rp_filter = 0
# 
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
# 
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward = 0
# 
#     TEST: rule4 check: tos 0x10                               [ OK ]
# 
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule4 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule4 check: ipproto icmp                           [ OK ]
# 
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
# 
#     TEST: rule6 check: oif dummy0                             [ OK ]
# 
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
# 
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
# 
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
# 
#     TEST: rule6 check: tos 0x10                               [ OK ]
# 
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule6 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
# 
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
# 
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=152797 (9535 MB) txc=0 zc=n
# rx=76399 (9535 MB)
# ipv4 tcp -z -t 1
# tx=121918 (7608 MB) txc=121918 zc=n
# rx=60960 (7608 MB)
# ok
# ipv6 tcp -t 1
# tx=143882 (8978 MB) txc=0 zc=n
# rx=71941 (8978 MB)
# ipv6 tcp -z -t 1
# tx=115844 (7229 MB) txc=115844 zc=n
# rx=57923 (7229 MB)
# ok
# ipv4 udp -t 1
# tx=161435 (10074 MB) txc=0 zc=n
# rx=160452 (10012 MB)
# ipv4 udp -z -t 1
# tx=109255 (6817 MB) txc=109255 zc=n
# rx=109255 (6817 MB)
# ok
# ipv6 udp -t 1
# tx=156624 (9773 MB) txc=0 zc=n
# rx=156624 (9773 MB)
# ipv6 udp -z -t 1
# tx=111254 (6942 MB) txc=111254 zc=n
# rx=111254 (6942 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw vlan
# tx: 146
# rx: 100
# OK
# 
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
# 
# raw mtu size
# tx: 1514
# rx: 1472
# OK
# 
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
# 
# dgram mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw truncate hlen (expected to fail: does not arrive)
# tx: 14
# ./psock_snd: recv: Resource temporarily unavailable
# raw truncate hlen - 1 (expected to fail: EINVAL)
# ./psock_snd: write: Invalid argument
# raw gso min size
# tx: 1525
# rx: 1473
# OK
# 
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
# 
not ok 21 selftests: net: psock_snd.sh # exit=1
# selftests: net: udpgro_bench.sh
# ipv4
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    901 MB/s    15295 calls/s  15295 msg/s
# tcp rx:    904 MB/s    30547 calls/s
# tcp tx:    846 MB/s    14358 calls/s  14358 msg/s
# tcp rx:    847 MB/s    28684 calls/s
# tcp tx:   1080 MB/s    18333 calls/s  18333 msg/s
# tcp rx:   1081 MB/s    36661 calls/s
# tcp tx:   1060 MB/s    17983 calls/s  17983 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    640 MB/s   456548 calls/s
# udp tx:    706 MB/s    11975 calls/s  11975 msg/s
# udp rx:    715 MB/s   509452 calls/s
# udp tx:    713 MB/s    12104 calls/s  12104 msg/s
# udp rx:    714 MB/s   508880 calls/s
# udp tx:    714 MB/s    12124 calls/s  12124 msg/s
# udp rx:    719 MB/s   512442 calls/s
# udp tx:    717 MB/s    12172 calls/s  12172 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    907 MB/s    15392 calls/s
# udp tx:   1033 MB/s    17534 calls/s  17534 msg/s
# udp rx:   1011 MB/s    17159 calls/s
# udp tx:   1007 MB/s    17086 calls/s  17086 msg/s
# udp rx:   1014 MB/s    17211 calls/s
# udp tx:   1016 MB/s    17238 calls/s  17238 msg/s
# udp rx:   1009 MB/s    17118 calls/s
# udp tx:   1006 MB/s    17075 calls/s  17075 msg/s
# ipv6
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    846 MB/s    14359 calls/s  14359 msg/s
# tcp rx:    847 MB/s    28562 calls/s
# tcp tx:   1066 MB/s    18089 calls/s  18089 msg/s
# tcp rx:   1067 MB/s    36168 calls/s
# tcp tx:   1120 MB/s    18997 calls/s  18997 msg/s
# tcp rx:   1121 MB/s    38008 calls/s
# tcp tx:   1105 MB/s    18746 calls/s  18746 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    700 MB/s   510963 calls/s
# udp tx:    776 MB/s    13178 calls/s  13178 msg/s
# udp rx:    778 MB/s   567995 calls/s
# udp tx:    777 MB/s    13193 calls/s  13193 msg/s
# udp rx:    771 MB/s   562561 calls/s
# udp tx:    770 MB/s    13060 calls/s  13060 msg/s
# udp rx:    770 MB/s   561588 calls/s
# udp tx:    769 MB/s    13056 calls/s  13056 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    927 MB/s    15723 calls/s
# udp tx:   1013 MB/s    17194 calls/s  17194 msg/s
# udp rx:    976 MB/s    16559 calls/s
# udp tx:    980 MB/s    16630 calls/s  16630 msg/s
# udp rx:    980 MB/s    16622 calls/s
# udp tx:    973 MB/s    16514 calls/s  16514 msg/s
# udp rx:    968 MB/s    16433 calls/s
# udp tx:    967 MB/s    16412 calls/s  16412 msg/s
ok 22 selftests: net: udpgro_bench.sh
# selftests: net: udpgro.sh
# ipv4
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
# ipv6
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
ok 23 selftests: net: udpgro.sh
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=1
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... pass
# UDP IPv6 ... pass
# UDP IPv4 mapped to IPv6 ... pass
# TCP IPv4 ... pass
# TCP IPv6 ... pass
# TCP IPv4 mapped to IPv6 ... pass
# DCCP not supported: skipping DCCP tests
# SUCCESS
ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
# selftests: net: so_txtime.sh
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:56 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:136 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10382 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10387 expected:10000 (us)
# payload:b delay:20095 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20363 expected:20000 (us)
# payload:a delay:20407 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock tai
# send: pkt a at -1619666528139ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
# 
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
# 
# SO_TXTIME ipv6 clock tai
# payload:a delay:9988 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:a delay:9986 expected:10000 (us)
# payload:b delay:19807 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock tai
# payload:b delay:9819 expected:10000 (us)
# payload:a delay:19820 expected:20000 (us)
# OK. All tests passed
ok 27 selftests: net: so_txtime.sh
# selftests: net: ipv6_flowlabel.sh
# TEST management
# [OK]   !(flowlabel_get(fd, 1, 255, 0))
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   !(flowlabel_get(fd, 0x1FFFFF, 255, 1))
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   flowlabel_get(fd, 1, 255, 0)
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   !(flowlabel_get(fd, 1, 255, 1 | 2))
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   flowlabel_get(fd, 2, 1, 1)
# [OK]   !(flowlabel_get(fd, 2, 255, 1))
# [OK]   !(flowlabel_get(fd, 2, 1, 1))
# [OK]   flowlabel_put(fd, 2)
# [OK]   flowlabel_get(fd, 3, 3, 1)
# [OK]   !(flowlabel_get(fd, 3, 255, 0))
# [OK]   !(flowlabel_get(fd, 3, 1, 0))
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   !(flowlabel_get(fd, 3, 3, 0))
# [OK]   flowlabel_get(fd, 4, 2, 1)
# [OK]   flowlabel_get(fd, 4, 2, 0)
# [OK]   !(flowlabel_get(fd, 4, 2, 0))
# TEST datapath
# send no label: recv no label (auto off)
# sent without label
# recv without label
# send label
# sent with label 1
# recv with label 1
# TEST datapath (with auto-flowlabels)
# send no label: recv auto flowlabel
# sent without label
# recv with label 519329
# send label
# sent with label 1
# recv with label 1
# OK. All tests passed
ok 28 selftests: net: ipv6_flowlabel.sh
# selftests: net: tcp_fastopen_backup_key.sh
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# all tests done
ok 29 selftests: net: tcp_fastopen_backup_key.sh
# selftests: net: fcnal-test.sh
# 'nettest' command not found; skipping tests
ok 30 selftests: net: fcnal-test.sh
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
# 
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 34325
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
# 
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
# 
# Basic functional tests
# ----------------------
# TEST: List with nothing defined                                     [ OK ]
# TEST: Nexthop get on non-existent id                                [ OK ]
# TEST: Nexthop with no device or gateway                             [ OK ]
# TEST: Nexthop with down device                                      [ OK ]
# TEST: Nexthop with device that is linkdown                          [ OK ]
# TEST: Nexthop with device only                                      [ OK ]
# TEST: Nexthop with duplicate id                                     [ OK ]
# TEST: Blackhole nexthop                                             [ OK ]
# TEST: Blackhole nexthop with other attributes                       [ OK ]
# TEST: Blackhole nexthop with loopback device down                   [ OK ]
# TEST: Create group                                                  [ OK ]
# TEST: Create group with blackhole nexthop                           [ OK ]
# TEST: Create multipath group where 1 path is a blackhole            [ OK ]
# TEST: Multipath group can not have a member replaced by blackhole   [ OK ]
# TEST: Create group with non-existent nexthop                        [ OK ]
# TEST: Create group with same nexthop multiple times                 [ OK ]
# TEST: Replace nexthop with nexthop group                            [ OK ]
# TEST: Replace nexthop group with nexthop                            [ OK ]
# TEST: Nexthop group and device                                      [ OK ]
# TEST: Test proto flush                                              [ OK ]
# TEST: Nexthop group and blackhole                                   [ OK ]
# 
# Basic resilient nexthop group functional tests
# ----------------------------------------------
# TEST: Add a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with non-default parameters               [ OK ]
# TEST: Add a nexthop group with 0 buckets                            [ OK ]
# TEST: Replace nexthop group parameters                              [ OK ]
# TEST: Get a nexthop group after replacing parameters                [ OK ]
# TEST: Replace idle timer                                            [ OK ]
# TEST: Get a nexthop group after replacing idle timer                [ OK ]
# TEST: Replace unbalanced timer                                      [ OK ]
# TEST: Get a nexthop group after replacing unbalanced timer          [ OK ]
# TEST: Replace with no parameters                                    [ OK ]
# TEST: Get a nexthop group after replacing no parameters             [ OK ]
# TEST: Replace nexthop group type - implicit                         [ OK ]
# TEST: Replace nexthop group type - explicit                         [ OK ]
# TEST: Replace number of nexthop buckets                             [ OK ]
# TEST: Get a nexthop group after replacing with invalid parameters   [ OK ]
# TEST: Dump all nexthop buckets                                      [ OK ]
# TEST: Dump all nexthop buckets in a group                           [ OK ]
# TEST: All nexthop buckets report a positive near-zero idle time     [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop device       [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop identifier   [ OK ]
# TEST: Dump all nexthop buckets in a non-existent group              [ OK ]
# TEST: Dump all nexthop buckets in a non-resilient group             [ OK ]
# TEST: Dump all nexthop buckets using a non-existent device          [ OK ]
# TEST: Dump all nexthop buckets with invalid 'groups' keyword        [ OK ]
# TEST: Dump all nexthop buckets with invalid 'fdb' keyword           [ OK ]
# TEST: Get a valid nexthop bucket                                    [ OK ]
# TEST: Get a nexthop bucket with valid group, but invalid index      [ OK ]
# TEST: Get a nexthop bucket from a non-resilient group               [ OK ]
# TEST: Get a nexthop bucket from a non-existent group                [ OK ]
# TEST: Initial bucket allocation                                     [ OK ]
# TEST: Bucket allocation after replace                               [ OK ]
# TEST: Buckets migrated after idle timer change                      [ OK ]
# 
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv4 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# 
# IPv4 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
# 
# IPv4 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Route add - scope conflict with nexthop                       [ OK ]
# TEST: Nexthop replace with invalid scope for existing route         [ OK ]
# TEST: Basic ping                                                    [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - multiple default routes, nh first                      [ OK ]
# TEST: Ping - multiple default routes, nh second                     [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv4 route with device only nexthop                           [ OK ]
# TEST: IPv4 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with mixed v4-v6 multipath route                   [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 default route with IPv6 gateway                          [ OK ]
# TEST: IPv4 route with MPLS encap                                    [ OK ]
# TEST: IPv4 route with MPLS encap - check                            [ OK ]
# TEST: IPv4 route with MPLS encap and v6 gateway                     [ OK ]
# TEST: IPv4 route with MPLS encap, v6 gw - check                     [ OK ]
# 
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv4 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
# 
# IPv4 nexthop api compat mode
# ----------------------------
# TEST: IPv4 default nexthop compat mode check                        [ OK ]
# TEST: IPv4 compat mode on - route add notification                  [ OK ]
# TEST: IPv4 compat mode on - route dump                              [ OK ]
# TEST: IPv4 compat mode on - nexthop change                          [ OK ]
# TEST: IPv4 set compat mode - 0                                      [ OK ]
# TEST: IPv4 compat mode off - route add notification                 [ OK ]
# TEST: IPv4 compat mode off - route dump                             [ OK ]
# TEST: IPv4 compat mode off - nexthop change                         [ OK ]
# TEST: IPv4 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv4 set compat mode - 1                                      [ OK ]
# 
# IPv4 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# IPv4 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
# 
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# 
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# 
# IPv6 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Ping with nexthop                                             [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv6 route with device only nexthop                           [ OK ]
# TEST: IPv6 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 route can not have a v4 gateway                          [ OK ]
# TEST: Nexthop replace - v6 route, v4 nexthop                        [ OK ]
# TEST: Nexthop replace of group entry - v6 route, v4 nexthop         [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after removing v4 gateways           [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after replacing v4 gateways          [ OK ]
# TEST: Nexthop with default route and rpfilter                       [ OK ]
# TEST: Nexthop with multipath default route and rpfilter             [ OK ]
# 
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv6 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
# 
# IPv6 nexthop api compat mode test
# --------------------------------
# TEST: IPv6 default nexthop compat mode check                        [ OK ]
# TEST: IPv6 compat mode on - route add notification                  [ OK ]
# TEST: IPv6 compat mode on - route dump                              [ OK ]
# TEST: IPv6 compat mode on - nexthop change                          [ OK ]
# TEST: IPv6 set compat mode - 0                                      [ OK ]
# TEST: IPv6 compat mode off - route add notification                 [ OK ]
# TEST: IPv6 compat mode off - route dump                             [ OK ]
# TEST: IPv6 compat mode off - nexthop change                         [ OK ]
# TEST: IPv6 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv6 set compat mode - 1                                      [ OK ]
# 
# IPv6 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# IPv6 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
# 
# Tests passed: 214
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: mausezahn not installed
not ok 35 selftests: net: altnames.sh # exit=1
# selftests: net: icmp_redirect.sh
# 
# ###########################################################################
# Legacy routing
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Legacy routing with VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects and VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_announce = 2
# net.ipv4.conf.veth1.arp_announce = 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.039 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.035 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.028 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.028 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.028 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 110ms
# rtt min/avg/max/mdev = 0.028/0.031/0.039/0.007 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_ignore = 3
# net.ipv4.conf.veth1.arp_ignore = 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.035 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.020 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.027 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.042 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.022 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 116ms
# rtt min/avg/max/mdev = 0.020/0.029/0.042/0.008 ms
# ok
ok 38 selftests: net: route_localnet.sh
# selftests: net: reuseaddr_ports_exhausted.sh
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.reuseaddr_ports_exhausted_unreusable ...
# #            OK  global.reuseaddr_ports_exhausted_unreusable
# ok 1 global.reuseaddr_ports_exhausted_unreusable
# #  RUN           global.reuseaddr_ports_exhausted_reusable_same_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_same_euid
# ok 2 global.reuseaddr_ports_exhausted_reusable_same_euid
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_different_euid
# ok 3 global.reuseaddr_ports_exhausted_reusable_different_euid
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# tests done
ok 39 selftests: net: reuseaddr_ports_exhausted.sh
# selftests: net: txtimestamp.sh
# protocol:     TCP
# payload:      10
# server port:  9000
# 
# family:       INET 
# test SND
#     USR: 1619666638 s 827884 us (seq=0, len=0)
#     SND: 1619666638 s 828904 us (seq=9, len=10)  (USR +1019 us)
#     USR: 1619666638 s 878026 us (seq=0, len=0)
#     SND: 1619666638 s 879068 us (seq=19, len=10)  (USR +1042 us)
#     USR: 1619666638 s 928171 us (seq=0, len=0)
#     SND: 1619666638 s 929201 us (seq=29, len=10)  (USR +1030 us)
#     USR: 1619666638 s 978405 us (seq=0, len=0)
#     SND: 1619666638 s 979460 us (seq=39, len=10)  (USR +1054 us)
#     USR-SND: count=4, avg=1036 us, min=1019 us, max=1054 us
# test ENQ
#     USR: 1619666639 s 135133 us (seq=0, len=0)
#     ENQ: 1619666639 s 135146 us (seq=9, len=10)  (USR +12 us)
#     USR: 1619666639 s 185529 us (seq=0, len=0)
#     ENQ: 1619666639 s 185556 us (seq=19, len=10)  (USR +26 us)
#     USR: 1619666639 s 235937 us (seq=0, len=0)
#     ENQ: 1619666639 s 235949 us (seq=29, len=10)  (USR +12 us)
#     USR: 1619666639 s 286304 us (seq=0, len=0)
#     ENQ: 1619666639 s 286331 us (seq=39, len=10)  (USR +26 us)
#     USR-ENQ: count=4, avg=19 us, min=12 us, max=26 us
# test ENQ + SND
#     USR: 1619666639 s 443461 us (seq=0, len=0)
#     ENQ: 1619666639 s 443473 us (seq=9, len=10)  (USR +12 us)
#     SND: 1619666639 s 444490 us (seq=9, len=10)  (USR +1029 us)
#     USR: 1619666639 s 493861 us (seq=0, len=0)
#     ENQ: 1619666639 s 493888 us (seq=19, len=10)  (USR +26 us)
#     SND: 1619666639 s 494927 us (seq=19, len=10)  (USR +1065 us)
#     USR: 1619666639 s 544296 us (seq=0, len=0)
#     ENQ: 1619666639 s 544308 us (seq=29, len=10)  (USR +12 us)
#     SND: 1619666639 s 545347 us (seq=29, len=10)  (USR +1051 us)
#     USR: 1619666639 s 594701 us (seq=0, len=0)
#     ENQ: 1619666639 s 594728 us (seq=39, len=10)  (USR +27 us)
#     SND: 1619666639 s 595762 us (seq=39, len=10)  (USR +1061 us)
#     USR-ENQ: count=4, avg=19 us, min=12 us, max=27 us
#     USR-SND: count=4, avg=1052 us, min=1029 us, max=1065 us
# 
# test ACK
#     USR: 1619666639 s 755384 us (seq=0, len=0)
#     ACK: 1619666639 s 761542 us (seq=9, len=10)  (USR +6158 us)
#     USR: 1619666639 s 805800 us (seq=0, len=0)
#     ACK: 1619666639 s 811973 us (seq=19, len=10)  (USR +6173 us)
#     USR: 1619666639 s 856200 us (seq=0, len=0)
#     ACK: 1619666639 s 862394 us (seq=29, len=10)  (USR +6194 us)
#     USR: 1619666639 s 906439 us (seq=0, len=0)
#     ACK: 1619666639 s 912639 us (seq=39, len=10)  (USR +6199 us)
#     USR-ACK: count=4, avg=6181 us, min=6158 us, max=6199 us
# 
# test SND + ACK
#     USR: 1619666640 s 67629 us (seq=0, len=0)
#     SND: 1619666640 s 68643 us (seq=9, len=10)  (USR +1014 us)
#     ACK: 1619666640 s 73703 us (seq=9, len=10)  (USR +6073 us)
#     USR: 1619666640 s 118059 us (seq=0, len=0)
#     SND: 1619666640 s 119107 us (seq=19, len=10)  (USR +1048 us)
#     ACK: 1619666640 s 124239 us (seq=19, len=10)  (USR +6180 us)
#     USR: 1619666640 s 168464 us (seq=0, len=0)
#     SND: 1619666640 s 169519 us (seq=29, len=10)  (USR +1054 us)
#     ACK: 1619666640 s 174586 us (seq=29, len=10)  (USR +6122 us)
#     USR: 1619666640 s 218892 us (seq=0, len=0)
#     SND: 1619666640 s 219925 us (seq=39, len=10)  (USR +1032 us)
#     ACK: 1619666640 s 225080 us (seq=39, len=10)  (USR +6187 us)
#     USR-SND: count=4, avg=1037 us, min=1014 us, max=1054 us
#     USR-ACK: count=4, avg=6140 us, min=6073 us, max=6187 us
# 
# test ENQ + SND + ACK
#     USR: 1619666640 s 379199 us (seq=0, len=0)
#     ENQ: 1619666640 s 379212 us (seq=9, len=10)  (USR +12 us)
#     SND: 1619666640 s 380225 us (seq=9, len=10)  (USR +1025 us)
#     ACK: 1619666640 s 385359 us (seq=9, len=10)  (USR +6159 us)
#     USR: 1619666640 s 429621 us (seq=0, len=0)
#     ENQ: 1619666640 s 429633 us (seq=19, len=10)  (USR +12 us)
#     SND: 1619666640 s 430638 us (seq=19, len=10)  (USR +1017 us)
#     ACK: 1619666640 s 435781 us (seq=19, len=10)  (USR +6160 us)
#     USR: 1619666640 s 480043 us (seq=0, len=0)
#     ENQ: 1619666640 s 480069 us (seq=29, len=10)  (USR +25 us)
#     SND: 1619666640 s 481075 us (seq=29, len=10)  (USR +1031 us)
# ERROR: 18627 us expected between 6000 and 6500
#     ACK: 1619666640 s 498670 us (seq=29, len=10)  (USR +18627 us)
#     USR: 1619666640 s 530463 us (seq=0, len=0)
#     ENQ: 1619666640 s 530499 us (seq=39, len=10)  (USR +36 us)
#     SND: 1619666640 s 531504 us (seq=39, len=10)  (USR +1041 us)
# ERROR: 18689 us expected between 6000 and 6500
#     ACK: 1619666640 s 549152 us (seq=39, len=10)  (USR +18689 us)
#     USR-ENQ: count=4, avg=21 us, min=12 us, max=36 us
#     USR-SND: count=4, avg=1028 us, min=1017 us, max=1041 us
#     USR-ACK: count=4, avg=12409 us, min=6159 us, max=18689 us
not ok 40 selftests: net: txtimestamp.sh # exit=1
# selftests: net: vrf-xfrm-tests.sh
# 
# No qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# netem qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=1
# selftests: net: rxtimestamp.sh
# Testing ip...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing udp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing tcp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# PASSED.
ok 42 selftests: net: rxtimestamp.sh
# selftests: net: devlink_port_split.py
# Traceback (most recent call last):
#   File "./devlink_port_split.py", line 277, in <module>
#     main()
#   File "./devlink_port_split.py", line 242, in main
#     dev = list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=1
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [ OK ]
# TEST: IPv4 packets over UDPv6                                       [ OK ]
# TEST: IPv6 packets over UDPv4                                       [ OK ]
# TEST: IPv6 packets over UDPv6                                       [ OK ]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: Unicast MPLS packets over UDPv4                               [ OK ]
# TEST: Unicast MPLS packets over UDPv6                               [ OK ]
ok 46 selftests: net: bareudp.sh
# selftests: net: unicast_extensions.sh
# ###########################################################################
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# ###########################################################################
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [ OK ]
# TEST: assign and ping inside 255.255/16 (is allowed)                [ OK ]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [ OK ]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [ OK ]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [ OK ]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping lowest address (is forbidden)                 [ OK ]
# TEST: routing using lowest address (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
ok 47 selftests: net: unicast_extensions.sh
# selftests: net: udpgro_fwd.sh
# IPv4
# ./udpgro_fwd.sh: 90: local: -r: bad variable name
# ./udpgro_fwd.sh: 22: local: -r: bad variable name
not ok 48 selftests: net: udpgro_fwd.sh # exit=2
# selftests: net: veth.sh
# default - gro flag                                           ok 
#         - peer gro flag                                      ok 
#         - tso flag                                           ok 
#         - peer tso flag                                      ok 
#         - aggregation                                        ok 
#         - aggregation with TSO off                           ok 
# ./veth.sh: 21: local: -r: bad variable name
# ./veth.sh: 21: local: -r: bad variable name
not ok 49 selftests: net: veth.sh # exit=2

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-bm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
kernel-selftests:
  group: net
job_origin: kernel-selftests-bm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d06
tbox_group: lkp-skl-d06
submit_id: 6088d0b073a9542434914356
job_file: "/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d509b127ccf0fe5fc48dd6c337c5291d24173418-20210428-9268-h53paa-0.yaml"
id: beac0bf0194a899799980e92336d2e47279a4e32
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d06
model: Skylake
nr_cpu: 4
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1"
brand: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: d509b127ccf0fe5fc48dd6c337c5291d24173418

#! include/testbox/lkp-skl-d06
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
- CONFIG_DRM_I915
ucode: '0xe2'

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kselftests: true
need_kconfig:
- CONFIG_USER_NS=y
- CONFIG_BPF_SYSCALL=y
- CONFIG_TEST_BPF=m
- CONFIG_NUMA=y ~ ">= v5.6-rc1"
- CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
- CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
- CONFIG_IPV6=y
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_VETH=y
- CONFIG_NET_IPVTI=m
- CONFIG_IPV6_VTI=m
- CONFIG_DUMMY=y
- CONFIG_BRIDGE=y
- CONFIG_VLAN_8021Q=y
- CONFIG_IFB=y
- CONFIG_NETFILTER=y
- CONFIG_NETFILTER_ADVANCED=y
- CONFIG_NF_CONNTRACK=m
- CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
- CONFIG_IP6_NF_IPTABLES=m
- CONFIG_IP_NF_IPTABLES=m
- CONFIG_IP6_NF_NAT=m
- CONFIG_IP_NF_NAT=m
- CONFIG_NF_TABLES=m
- CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
- CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
- CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
- CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
- CONFIG_NET_SCH_FQ=m
- CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
- CONFIG_NET_SCH_NETEM=y
- CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
- CONFIG_KALLSYMS=y
- CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
- CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
- CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
- CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
- CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
- CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
- CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"
enqueue_time: 2021-04-28 11:04:16.217636559 +08:00
_id: 6088d0b073a9542434914356
_rt: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: d482eaed546913ed45730321ef8e01349c50f213
base_commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
branch: linux-devel/devel-hourly-20210426-125138
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/0"
scheduler_version: "/lkp/lkp/.src-20210425-142307"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d509b127ccf0fe5fc48dd6c337c5291d24173418-20210428-9268-h53paa-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210426-125138
- commit=d509b127ccf0fe5fc48dd6c337c5291d24173418
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/vmlinuz-5.12.0-rc6-02036-gd509b127ccf0
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210406.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cf9ae1bd-1_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210425-142307/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d509b127ccf0fe5fc48dd6c337c5291d24173418/vmlinuz-5.12.0-rc6-02036-gd509b127ccf0"
dequeue_time: 2021-04-28 11:46:35.432231532 +08:00
job_state: finished
loadavg: 0.48 0.92 0.54 1/147 19723
start_time: '1619581687'
end_time: '1619582099'
version: "/lkp/lkp/.src-20210425-142340:01225f6d-dirty:9486817ee"

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

mount --bind /lib/modules/5.12.0-rc6-02036-gd509b127ccf0/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d509b127ccf0fe5fc48dd6c337c5291d24173418/lib
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
/kselftests/run_kselftest.sh -c net

--ReaqsoxgOBHFXBhH--
