Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95FD3F91DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhH0BLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:11:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:22675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhH0BLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:11:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303450298"
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="gz'50?scan'50,208,50";a="303450298"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 18:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="gz'50?scan'50,208,50";a="457185511"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2021 18:10:56 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJQOW-0001qg-68; Fri, 27 Aug 2021 01:10:56 +0000
Date:   Fri, 27 Aug 2021 09:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/batch 19/27] include/linux/bpf.h:707:20: error:
 field 'ops' has incomplete type
Message-ID: <202108270908.rUzcrwrG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/batch
head:   b81b17307e02f8e6d4abf87e7ec2d7e5aea1e0b5
commit: 847fb4eb93cf46ad827ba84404d2c9d6998ea67f [19/27] bpf: Attach multi trampoline with ftrace_ops
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=847fb4eb93cf46ad827ba84404d2c9d6998ea67f
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/batch
        git checkout 847fb4eb93cf46ad827ba84404d2c9d6998ea67f
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:49,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:87,
                    from init/main.c:21:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/perf_event.h:57,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:87,
                    from init/main.c:21:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   init/main.c:757:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     757 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:769:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     769 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:771:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     771 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from include/linux/bpf.h:26,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from init/do_mounts.c:7:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from init/do_mounts.c:7:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
--
   In file included from include/linux/bpf.h:26,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from arch/um/kernel/mem.c:11:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from arch/um/kernel/mem.c:11:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   arch/um/kernel/mem.c:184:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
     184 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/um/kernel/mem.c:197:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
     197 | void *uml_kmalloc(int size, int flags)
         |       ^~~~~~~~~~~
--
   In file included from include/linux/bpf.h:26,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/tracehook.h:50,
                    from arch/um/kernel/process.c:26:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/tracehook.h:50,
                    from arch/um/kernel/process.c:26:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   arch/um/kernel/process.c:49:5: warning: no previous prototype for 'pid_to_processor_id' [-Wmissing-prototypes]
      49 | int pid_to_processor_id(int pid)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:85:7: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
      85 | void *__switch_to(struct task_struct *from, struct task_struct *to)
         |       ^~~~~~~~~~~
   arch/um/kernel/process.c: In function 'new_thread_handler':
   arch/um/kernel/process.c:120:21: warning: variable 'n' set but not used [-Wunused-but-set-variable]
     120 |  int (*fn)(void *), n;
         |                     ^
   arch/um/kernel/process.c: At top level:
   arch/um/kernel/process.c:138:6: warning: no previous prototype for 'fork_handler' [-Wmissing-prototypes]
     138 | void fork_handler(void)
         |      ^~~~~~~~~~~~
   arch/um/kernel/process.c:214:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
     214 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/um/kernel/process.c:251:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
     251 | int copy_to_user_proc(void __user *to, void *from, int size)
         |     ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:261:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
     261 | int clear_user_proc(void __user *buf, int size)
         |     ^~~~~~~~~~~~~~~
   arch/um/kernel/process.c:274:6: warning: no previous prototype for 'set_using_sysemu' [-Wmissing-prototypes]
     274 | void set_using_sysemu(int value)
         |      ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:281:5: warning: no previous prototype for 'get_using_sysemu' [-Wmissing-prototypes]
     281 | int get_using_sysemu(void)
         |     ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:319:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
     319 | int __init make_proc_sysemu(void)
         |            ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:359:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     359 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:49,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:87,
                    from arch/um/kernel/syscall.c:11:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/perf_event.h:57,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:87,
                    from arch/um/kernel/syscall.c:11:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   arch/um/kernel/syscall.c:17:6: warning: no previous prototype for 'old_mmap' [-Wmissing-prototypes]
      17 | long old_mmap(unsigned long addr, unsigned long len,
         |      ^~~~~~~~
--
   In file included from include/linux/bpf.h:26,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/um/kernel/um_arch.c:18:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/um/kernel/um_arch.c:18:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   arch/um/kernel/um_arch.c:400:19: warning: no previous prototype for 'read_initrd' [-Wmissing-prototypes]
     400 | int __init __weak read_initrd(void)
         |                   ^~~~~~~~~~~
   arch/um/kernel/um_arch.c:418:13: warning: no previous prototype for 'check_bugs' [-Wmissing-prototypes]
     418 | void __init check_bugs(void)
         |             ^~~~~~~~~~
   arch/um/kernel/um_arch.c:428:7: warning: no previous prototype for 'text_poke' [-Wmissing-prototypes]
     428 | void *text_poke(void *addr, const void *opcode, size_t len)
         |       ^~~~~~~~~
   arch/um/kernel/um_arch.c:440:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
     440 | void text_poke_sync(void)
         |      ^~~~~~~~~~~~~~
--
   In file included from include/linux/bpf.h:26,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/net/netprio_cgroup.h:11,
                    from include/linux/netdevice.h:41,
                    from include/uapi/linux/if_arp.h:27,
                    from include/linux/if_arp.h:23,
                    from arch/um/drivers/slirp_kern.c:6:
   include/linux/ftrace.h:353:41: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                         ^~~~~~~~~~
   include/linux/ftrace.h:353:5: warning: no previous prototype for 'register_ftrace_direct_multi' [-Wmissing-prototypes]
     353 | int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:357:43: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |                                           ^~~~~~~~~~
   include/linux/ftrace.h:357:5: warning: no previous prototype for 'unregister_ftrace_direct_multi' [-Wmissing-prototypes]
     357 | int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/ftrace.h:361:39: warning: 'struct ftrace_ops' declared inside parameter list will not be visible outside of this definition or declaration
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |                                       ^~~~~~~~~~
   include/linux/ftrace.h:361:5: warning: no previous prototype for 'modify_ftrace_direct_multi' [-Wmissing-prototypes]
     361 | int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/net/netprio_cgroup.h:11,
                    from include/linux/netdevice.h:41,
                    from include/uapi/linux/if_arp.h:27,
                    from include/linux/if_arp.h:23,
                    from arch/um/drivers/slirp_kern.c:6:
>> include/linux/bpf.h:707:20: error: field 'ops' has incomplete type
     707 |  struct ftrace_ops ops;
         |                    ^~~
   arch/um/drivers/slirp_kern.c:18:6: warning: no previous prototype for 'slirp_init' [-Wmissing-prototypes]
      18 | void slirp_init(struct net_device *dev, void *data)
         |      ^~~~~~~~~~
..


vim +/ops +707 include/linux/bpf.h

   701	
   702	struct bpf_trampoline_multi {
   703		struct bpf_trampoline main;
   704		struct list_head list;
   705		u32 *ids;
   706		u32 ids_cnt;
 > 707		struct ftrace_ops ops;
   708		int tr_cnt;
   709		struct bpf_trampoline *tr[];
   710	};
   711	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--W/nzBZO5zC0uMSeA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--W/nzBZO5zC0uMSeA--
