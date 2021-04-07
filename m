Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6869357896
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDGXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:35:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:59347 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDGXfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:35:08 -0400
IronPort-SDR: Ey3WlOlvLmdUrfbzDqfRhYUoCewg0HCJ6yCUZ2ljA0jNBRV+g+VbAqymSnY0A450VExQSU3Cjx
 bmGkfdw6xNTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278685579"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="gz'50?scan'50,208,50";a="278685579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:34:58 -0700
IronPort-SDR: AyU/wVdvTCLBZ4g70HqMlwCof2dlwMw9LxBkuh8Jt7HjG6sL1g9urmGzva/dptX2MBnEgnibg2
 EuV5C+1YUZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="gz'50?scan'50,208,50";a="441508888"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 16:34:56 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUHhH-000DwI-VA; Wed, 07 Apr 2021 23:34:55 +0000
Date:   Thu, 8 Apr 2021 07:34:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maciej Patelczyk <maciej.patelczyk@intel.com>
Subject: undefined reference to `cmpxchg8b_emu'
Message-ID: <202104080722.L7ErkTLc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   454859c552da78b0f587205d308401922b56863e
commit: 1c530d431c698f156538b8954b07df95337beb34 dma-buf: Use atomic_fetch_add() for the context id
date:   11 months ago
config: um-randconfig-r034-20210407 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1c530d431c698f156538b8954b07df95337beb34
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1c530d431c698f156538b8954b07df95337beb34
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_xchg_386+0x0): undefined reference to `atomic64_xchg_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_set_386+0x0): undefined reference to `atomic64_set_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_read_386+0x0): undefined reference to `atomic64_read_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_dec_386+0x0): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_inc_386+0x0): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_sub_386+0x0): undefined reference to `atomic64_sub_386'
   /usr/bin/ld: arch/x86/um/../lib/atomic64_32.o:(___ksymtab+atomic64_add_386+0x0): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/cputime.o: in function `account_user_time':
   (.text+0x47): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/cputime.o: in function `account_guest_time':
   (.text+0x1a4): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/cputime.o: in function `account_system_index_time':
   (.text+0x24d): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/rt.o: in function `update_curr_rt':
   rt.c:(.text+0x807): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/deadline.o:deadline.c:(.text+0x1174): more undefined references to `atomic64_add_386' follow
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `cpu_clock_sample_group':
   posix-cpu-timers.c:(.text+0x7f7): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x805): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x827): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x838): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x847): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x901): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x939): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x991): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x9c9): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0xa21): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0xa59): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `thread_group_sample_cputime':
   posix-cpu-timers.c:(.text+0x233e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x234f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x235e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `run_posix_cpu_timers':
   posix-cpu-timers.c:(.text+0x25f5): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o:posix-cpu-timers.c:(.text+0x2606): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: kernel/trace/trace_clock.o: in function `trace_clock_counter':
   (.text+0x145): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/bpf/core.o: in function `___bpf_prog_run':
   core.c:(.text+0x236f): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc':
   (.text+0x173): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_with_uref':
   (.text+0x194): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: (.text+0x19f): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_add':
   (.text+0x1c3): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_sub':
   (.text+0x1e3): undefined reference to `atomic64_sub_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc':
   (.text+0x200): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_not_zero':
   (.text+0x2d4): undefined reference to `atomic64_read_386'
   /usr/bin/ld: (.text+0x328): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc_not_zero':
   (.text+0x3b7): undefined reference to `atomic64_read_386'
   /usr/bin/ld: (.text+0x404): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_mmap':
   syscall.c:(.text+0x7ff): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x80a): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_mmap_open':
   syscall.c:(.text+0x8ce): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x8d9): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_get.constprop.0':
   syscall.c:(.text+0x133f): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_put.constprop.0':
   syscall.c:(.text+0x4ae4): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_put_with_uref':
   (.text+0x4bc5): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `map_create':
   syscall.c:(.text+0x511f): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x512a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get':
   (.text+0x570c): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_with_uref':
   (.text+0x57fc): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: (.text+0x5807): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_put.constprop.0':
   syscall.c:(.text+0x71a1): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
   syscall.c:(.text+0x76d9): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_init':
   (.text+0x7ee5): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_inc':
   (.text+0x7f3d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_put':
   (.text+0x7f62): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_raw_tracepoint_open':
   syscall.c:(.text+0x8333): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_get_from_fd':
   (.text+0x8574): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_by_id':
   (.text+0x862a): undefined reference to `atomic64_read_386'
   /usr/bin/ld: (.text+0x867b): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__do_sys_bpf':
   syscall.c:(.text+0x9846): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x98b7): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x993c): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/proc/task_mmu.o: in function `task_mem':
   task_mmu.c:(.text+0x3224): undefined reference to `atomic64_read_386'
   /usr/bin/ld: drivers/dma-buf/dma-fence.o: in function `dma_fence_context_alloc':
>> (.text+0x63): undefined reference to `cmpxchg8b_emu'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OPZm6trgf5XusoP/iAAA

--k1lZvvs/B4yU6o8G--
