Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8C34ABD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCZPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:50:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:50959 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCZPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:50:07 -0400
IronPort-SDR: 1Hs3gFD1Eci7kzUvb2zJ+9V6LjcSdlaVkgIImGnayeil9DcV0hsF3eMb0QCt+xkWywnGScZsWg
 CmasLtRRy2iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211333133"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="gz'50?scan'50,208,50";a="211333133"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 08:49:59 -0700
IronPort-SDR: Y0aqlr5vo1VxQWLYN3jfyjFvoBAo3yYILuN7jFJERgI4pw0cNod1XNwBg/4gmKUmG+EcLTvL6O
 VrBL6wFGjcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="gz'50?scan'50,208,50";a="436925288"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2021 08:49:58 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPoij-0002qV-FK; Fri, 26 Mar 2021 15:49:57 +0000
Date:   Fri, 26 Mar 2021 23:48:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: core.c:undefined reference to `cmpxchg8b_emu'
Message-ID: <202103262350.Y3DbF1yY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   db24726bfefa68c606947a86132591568a06bfb4
commit: 5ca419f2864a2c60940dcf4bbaeb69546200e36f bpf: Add BPF_FETCH field / create atomic_fetch_add instruction
date:   2 months ago
config: um-randconfig-r006-20210326 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ca419f2864a2c60940dcf4bbaeb69546200e36f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5ca419f2864a2c60940dcf4bbaeb69546200e36f
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/fork.o: in function `mm_init.isra.0':
   fork.c:(.text+0x401): undefined reference to `atomic64_set_386'
   /usr/bin/ld: mm/debug.o: in function `dump_mm':
   debug.c:(.text+0x2d4): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/inode.o: in function `inode_init_always':
   inode.c:(.text+0x447): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/inode.o: in function `generic_update_time':
   inode.c:(.text+0x2478): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x24b6): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/inode.o: in function `file_update_time':
   inode.c:(.text+0x2fd7): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/namespace.o: in function `alloc_mnt_ns':
   namespace.c:(.text+0x2b1): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: fs/fuse/inode.o: in function `fuse_change_attributes_common':
   inode.c:(.text+0x11b4): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/inode.o: in function `fuse_reverse_inval_inode':
   inode.c:(.text+0x16e7): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/inode.o: in function `fuse_conn_init':
   inode.c:(.text+0x1996): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x19d1): undefined reference to `atomic64_set_386'
   /usr/bin/ld: drivers/phy/ingenic/phy-ingenic-usb.o: in function `ingenic_usb_phy_probe':
   phy-ingenic-usb.c:(.text+0x2eb): undefined reference to `devm_platform_ioremap_resource'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_current_read':
   pids.c:(.text+0xd): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_events_show':
   pids.c:(.text+0x36): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_max_write':
   pids.c:(.text+0x9a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_css_alloc':
   pids.c:(.text+0x11f): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x12f): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x13c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_max_show':
   pids.c:(.text+0x176): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_fork':
   pids.c:(.text+0x237): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: pids.c:(.text+0x247): undefined reference to `atomic64_read_386'
   /usr/bin/ld: pids.c:(.text+0x271): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: pids.c:(.text+0x291): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: pids.c:(.text+0x2a4): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_uncharge.constprop.0':
   pids.c:(.text+0x3ab): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_attach':
   pids.c:(.text+0x573): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_cancel_attach':
   pids.c:(.text+0x693): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/trace/trace_clock.o: in function `trace_clock_counter':
   trace_clock.c:(.text+0x10d): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/bpf/core.o: in function `___bpf_prog_run':
>> core.c:(.text+0x1933): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: core.c:(.text+0x341c): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_by_id.part.0':
   syscall.c:(.text+0x74f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x784): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_by_id.part.0':
   syscall.c:(.text+0x813): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x840): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_get.constprop.0':
   syscall.c:(.text+0x8ed): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_put.constprop.0':
   syscall.c:(.text+0x92b): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_put.constprop.0':
   syscall.c:(.text+0x315e): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_put_with_uref':
   syscall.c:(.text+0x320f): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `map_create':
   syscall.c:(.text+0x34d8): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x34e6): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc':
   syscall.c:(.text+0x38ce): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_with_uref':
   syscall.c:(.text+0x38ef): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x38fa): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get':
   syscall.c:(.text+0x3965): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_with_uref':
   syscall.c:(.text+0x39e5): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o:syscall.c:(.text+0x39f0): more undefined references to `atomic64_inc_386' follow
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_not_zero':
   syscall.c:(.text+0x3a3f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x3a79): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
   syscall.c:(.text+0x4de9): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_add':
   syscall.c:(.text+0x541e): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_sub':
   syscall.c:(.text+0x5440): undefined reference to `atomic64_sub_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc':
   syscall.c:(.text+0x547b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc_not_zero':
   syscall.c:(.text+0x54a2): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x54d7): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_init':
   syscall.c:(.text+0x5590): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_inc':
   syscall.c:(.text+0x5608): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_put':
   syscall.c:(.text+0x561c): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_tracing_prog_attach':
   syscall.c:(.text+0x590a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_get_from_fd':
   syscall.c:(.text+0x5d47): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__do_sys_bpf':
   syscall.c:(.text+0x6920): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x6967): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x69ac): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_curr_or_next':
   syscall.c:(.text+0x79e2): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x7a1b): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_get_curr_or_next':
   syscall.c:(.text+0x7abf): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x7af8): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/bpf_iter.o: in function `prepare_seq_file':
   bpf_iter.c:(.text+0x196): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_rmdir':
   dir.c:(.text+0x330): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x36b): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_rename_common':
   dir.c:(.text+0x8d3): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x917): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: dir.c:(.text+0x96b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x9b1): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_unlink':
   dir.c:(.text+0xb79): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: dir.c:(.text+0xbe8): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0xc23): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_dentry_revalidate':
   dir.c:(.text+0x1177): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_do_getattr':
   dir.c:(.text+0x147f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_create_open':
   dir.c:(.text+0x1e0e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x1e6d): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/dir.o: in function `create_new_entry.constprop.0':
   dir.c:(.text+0x2180): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x21e1): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_link':
   dir.c:(.text+0x2373): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_lookup_name':
   dir.c:(.text+0x265c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/fuse/dir.o: in function `fuse_reverse_inval_entry':
   dir.c:(.text+0x2ac0): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x2afb): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/fuse/file.o: in function `fuse_aio_complete':
   file.c:(.text+0xf84): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/file.o: in function `fuse_short_read.isra.0':
   file.c:(.text+0x16e1): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/fuse/file.o: in function `fuse_do_readpage':
   file.c:(.text+0x1953): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/fuse/file.o: in function `fuse_readahead':

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
u3CcuUrm1oXW84BUVt7/AnRoW3x/iwAA

--SUOF0GtieIMvvwua--
