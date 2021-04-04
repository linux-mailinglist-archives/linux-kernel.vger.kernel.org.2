Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789A8353647
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 05:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhDDDIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 23:08:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:58843 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236644AbhDDDIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 23:08:43 -0400
IronPort-SDR: Bl9DV6FtVpuP21ARbaA0A+iudrSJUiFADd8SZulwVmvwwpVZ7RZyCJ0NbImlUxcqA/wHlUw/hg
 zINvPBDVksZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="253995827"
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="253995827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 20:08:38 -0700
IronPort-SDR: wRPoo9O1dByL86IVBCvsodqeIodaCmGL0g9EMUKKX27so61e/2Xq0zQ9oNjTqka6tzCTKx8/yV
 pwnMbYrJ/Bpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="456949750"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2021 20:08:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSt7s-00086Z-7Z; Sun, 04 Apr 2021 03:08:36 +0000
Date:   Sun, 4 Apr 2021 11:08:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>
Subject: /usr/bin/ld: file.c:undefined reference to `atomic64_inc_386'
Message-ID: <202104041100.6cx208rc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2023a53bdf41b7646b1d384b6816af06309f73a5
commit: 9a8d03ca2e2c334d08ee91a3e07dcce31a02fdc6 ceph: attempt to do async create when possible
date:   1 year ago
config: um-randconfig-r016-20210404 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a8d03ca2e2c334d08ee91a3e07dcce31a02fdc6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9a8d03ca2e2c334d08ee91a3e07dcce31a02fdc6
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   syscall.c:(.text+0x18d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x198): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_mmap_open':
   syscall.c:(.text+0x200): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x20b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_get':
   syscall.c:(.text+0x2ca): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_put.constprop.0':
   syscall.c:(.text+0x252a): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_put_with_uref':
   syscall.c:(.text+0x25bb): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `map_create':
   syscall.c:(.text+0x2878): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x2886): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc':
   syscall.c:(.text+0x2bd0): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_with_uref':
   syscall.c:(.text+0x2be6): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x2bf1): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_with_uref':
   syscall.c:(.text+0x2c4d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x2c58): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_not_zero':
   syscall.c:(.text+0x2c9a): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x2cd4): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_put.constprop.0':
   syscall.c:(.text+0x3b2c): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
   syscall.c:(.text+0x3f37): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_add':
   syscall.c:(.text+0x43d4): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_sub':
   syscall.c:(.text+0x43ea): undefined reference to `atomic64_sub_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc':
   syscall.c:(.text+0x4421): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_inc_not_zero':
   syscall.c:(.text+0x443a): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x446f): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_by_id':
   syscall.c:(.text+0x4554): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x4587): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__do_sys_bpf':
   syscall.c:(.text+0x4c7c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x4cc3): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x4d08): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_set_ino_cb':
   inode.c:(.text+0x9c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_alloc_inode':
   inode.c:(.text+0x116f): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x1177): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x1181): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x1189): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_fill_inode':
   inode.c:(.text+0x25ff): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x2622): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: inode.c:(.text+0x3201): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x3214): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x3243): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x3251): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x325a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x326f): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_fill_trace':
   inode.c:(.text+0x3644): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3889): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3aa7): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3ab5): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3b07): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/inode.o:inode.c:(.text+0x3be7): more undefined references to `atomic64_inc_386' follow
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_readdir_prepopulate':
   inode.c:(.text+0x4591): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x45ad): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x47fa): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x483b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_prune':
   dir.c:(.text+0xb3): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: dir.c:(.text+0xde): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `__dcache_find_get_entry':
   dir.c:(.text+0x4c9): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x4d8): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x51c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x52b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_async_unlink_cb':
   dir.c:(.text+0x959): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_lookup':
   dir.c:(.text+0x1b1b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x1b2b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_revalidate':
   dir.c:(.text+0x293c): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_readdir':
   dir.c:(.text+0x3388): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x3397): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x33ad): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x33bc): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x3e41): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o:dir.c:(.text+0x3ec1): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_readdir':
   dir.c:(.text+0x3ef7): undefined reference to `atomic64_set_386'
   /usr/bin/ld: dir.c:(.text+0x3f0a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_finish_async_create':
   file.c:(.text+0x6d1): undefined reference to `atomic64_inc_386'
>> /usr/bin/ld: file.c:(.text+0x712): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_async_create_cb':
   file.c:(.text+0x1faf): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_write_iter':
   file.c:(.text+0x32f6): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `__ceph_copy_file_range':
   file.c:(.text+0x4aad): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_atomic_open':
   file.c:(.text+0x5cb2): undefined reference to `atomic64_read_386'
   /usr/bin/ld: file.c:(.text+0x5cc3): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/addr.o: in function `ceph_page_mkwrite':
   addr.c:(.text+0x6485): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `__send_cap':
   caps.c:(.text+0x17ac): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `__check_cap_issue.isra.0':
   caps.c:(.text+0x349a): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `ceph_check_caps':
   caps.c:(.text+0x5eea): undefined reference to `atomic64_read_386'
   /usr/bin/ld: caps.c:(.text+0x5ef8): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `handle_cap_grant':
   caps.c:(.text+0x6e4c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: caps.c:(.text+0x6e6f): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/ceph/snap.o: in function `__ceph_finish_cap_snap':
   snap.c:(.text+0xcdc): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_adjust_quota_realms_count':
   quota.c:(.text+0x628): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: quota.c:(.text+0x630): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_handle_quota':
   quota.c:(.text+0x778): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: quota.c:(.text+0x7c8): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_files_exceeded':
   quota.c:(.text+0x8fc): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_bytes_exceeded':
   quota.c:(.text+0x98a): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_bytes_approaching':
   quota.c:(.text+0xa1f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/mds_client.o: in function `ceph_invalidate_dir_request':
   mds_client.c:(.text+0x586f): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: mds_client.c:(.text+0x587e): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/mds_client.o: in function `ceph_mdsc_init':
   mds_client.c:(.text+0x80b5): undefined reference to `atomic64_set_386'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/dma-buf/dma-fence.o: in function `dma_fence_context_alloc':
   dma-fence.c:(.text+0x1fc): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: drivers/mtd/nand/raw/nand_legacy.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/mtd/nand/raw/nand_legacy.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x63): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `__nf_ct_refresh_acct':
   nf_conntrack_core.c:(.text+0x29df): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text+0x29eb): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `nf_ct_kill_acct':
   nf_conntrack_core.c:(.text+0x2f51): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text+0x2f5d): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `__nf_ct_resolve_clash':
   nf_conntrack_core.c:(.text.unlikely+0xce): undefined reference to `atomic64_read_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text.unlikely+0xf2): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text.unlikely+0xff): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
   inet_timewait_sock.c:(.text+0x368): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_timewait_sock.c:(.text+0x374): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
   inet_connection_sock.c:(.text+0x16bc): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_connection_sock.c:(.text+0x16c8): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
   tcp_input.c:(.text+0x9f33): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `tcp_conn_request':
   tcp_input.c:(.text+0xa1c8): undefined reference to `atomic64_set_386'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
io2Z/wcaU5ovva0AAA==

--Dxnq1zWXvFF0Q93v--
