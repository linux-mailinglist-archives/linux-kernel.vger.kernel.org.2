Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050B035AF29
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhDJRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:02:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:58632 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJRC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:02:56 -0400
IronPort-SDR: WR4tp+6yrNFXWz1oijVee+HXGQWArh7h0HVhbmF6uaHM2vEjJUHOpfe0vMpvvZJ4JOH6g6M/Kr
 6G1yBXczZGHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="174035755"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="gz'50?scan'50,208,50";a="174035755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 10:02:41 -0700
IronPort-SDR: ju2lJpASQr8buHtyEqS3SJ3ggmNXfwI/KHxSRP/ywn4nWiTMwC5mMK3hQaR1JB87qnnhU2MS5j
 ggFcn0+VMmjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="gz'50?scan'50,208,50";a="459599720"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2021 10:02:39 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVH0I-000IVj-LI; Sat, 10 Apr 2021 17:02:38 +0000
Date:   Sun, 11 Apr 2021 01:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: export.c:undefined reference to `atomic64_read_386'
Message-ID: <202104110127.LPcoAOf3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4961772226de3b48a395a26c076d450d7044c76
commit: 3cc55f4434b421d37300aa9a167ace7d60b45ccf nfs: use change attribute for NFS re-exports
date:   2 months ago
config: um-randconfig-r023-20210410 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3cc55f4434b421d37300aa9a167ace7d60b45ccf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3cc55f4434b421d37300aa9a167ace7d60b45ccf
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/sched/rt.o: in function `update_curr_rt':
   rt.c:(.text+0x1fa0): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/deadline.o:deadline.c:(.text+0x3455): more undefined references to `atomic64_add_386' follow
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `cpu_clock_sample_group':
   posix-cpu-timers.c:(.text+0x14b4): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x14c2): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x14e6): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x14f7): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x1506): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o:posix-cpu-timers.c:(.text+0x15c8): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `cpu_clock_sample_group':
   posix-cpu-timers.c:(.text+0x169f): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x16ef): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x173f): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `thread_group_sample_cputime':
   posix-cpu-timers.c:(.text+0x2d0b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x2d1c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x2d2b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `run_posix_cpu_timers':
   posix-cpu-timers.c:(.text+0x2f42): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x2f53): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o:posix-cpu-timers.c:(.text+0x2f64): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_max_write':
   pids.c:(.text+0x171): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_cancel.constprop.0':
   pids.c:(.text+0x27c): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_fork':
   pids.c:(.text+0x3b3): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: pids.c:(.text+0x3c3): undefined reference to `atomic64_read_386'
   /usr/bin/ld: pids.c:(.text+0x41b): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_attach':
   pids.c:(.text+0x553): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_cancel_attach':
   pids.c:(.text+0x633): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_css_alloc':
   pids.c:(.text+0x7ea): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x7fa): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x807): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/trace/trace_clock.o: in function `trace_clock_counter':
   trace_clock.c:(.text+0x175): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/bpf/core.o: in function `___bpf_prog_run':
   core.c:(.text+0x3802): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc':
   syscall.c:(.text+0x33): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_with_uref':
   syscall.c:(.text+0x54): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x5f): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_add':
   syscall.c:(.text+0x83): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc':
   syscall.c:(.text+0xa0): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_put_uref':
   syscall.c:(.text+0xf3): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_inc_not_zero':
   syscall.c:(.text+0x34c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x3b0): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x44e): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc_not_zero':
   syscall.c:(.text+0x547): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x5aa): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_sub':
   syscall.c:(.text+0xce5): undefined reference to `atomic64_sub_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_put.constprop.0':
   syscall.c:(.text+0x6bd3): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `map_create':
   syscall.c:(.text+0x77b9): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x77c7): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get':
   syscall.c:(.text+0x9504): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_with_uref':
   syscall.c:(.text+0x95e4): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x95ef): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_put.constprop.0':
   syscall.c:(.text+0xc220): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_get':
   syscall.c:(.text+0xc6fa): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
   syscall.c:(.text+0xd314): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_init':
   syscall.c:(.text+0xe095): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_inc':
   syscall.c:(.text+0xe10d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_put':
   syscall.c:(.text+0xe130): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_tracing_prog_attach':
   syscall.c:(.text+0xe683): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_get_from_fd':
   syscall.c:(.text+0xef65): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_by_id':
   syscall.c:(.text+0xf322): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0xf383): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/bpf_iter.o: in function `prepare_seq_file':
   bpf_iter.c:(.text+0x3d0): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/nfs/nfstrace.o: in function `trace_event_raw_event_nfs_inode_event':
   nfstrace.c:(.text+0x31ec): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/nfstrace.o: in function `trace_event_raw_event_nfs_inode_event_done':
   nfstrace.c:(.text+0x5a01): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/nfstrace.o: in function `trace_event_raw_event_nfs_access_exit':
   nfstrace.c:(.text+0x5ea1): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/export.o: in function `nfs_fetch_iversion':
>> export.c:(.text+0x4d): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/fscache.o: in function `nfs_fscache_update_auxdata':
   fscache.c:(.text+0x183): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/fscache-index.o:fscache-index.c:(.text+0x193): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: fs/nfs/nfs4proc.o: in function `nfs4_update_changeattr_locked':
   nfs4proc.c:(.text+0xd3d): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/nfs/nfs4proc.o: in function `_nfs4_open_and_get_state':
   nfs4proc.c:(.text+0x1187f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfs/delegation.o: in function `nfs_inode_set_delegation':
   delegation.c:(.text+0x20a1): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/nfsd/nfs3xdr.o: in function `fill_pre_wcc':
   nfs3xdr.c:(.text+0x1cee): undefined reference to `atomic64_read_386'
   /usr/bin/ld: nfs3xdr.c:(.text+0x1dca): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/nfsd/nfs3xdr.o: in function `fill_post_wcc':
   nfs3xdr.c:(.text+0x2099): undefined reference to `atomic64_read_386'
   /usr/bin/ld: nfs3xdr.c:(.text+0x20df): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
   inet_timewait_sock.c:(.text+0xeb): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_timewait_sock.c:(.text+0xf7): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
   inet_connection_sock.c:(.text+0xc18): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_connection_sock.c:(.text+0xc24): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
   tcp_input.c:(.text+0x37cd): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/sunrpc/auth_gss/svcauth_gss.o: in function `gss_proxy_save_rsc':
   svcauth_gss.c:(.text+0x1dd4): undefined reference to `atomic64_inc_return_386'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4tDkcnq+sGzo+x+qY5rSLdgAAA==

--OXfL5xGRrasGEqWY--
