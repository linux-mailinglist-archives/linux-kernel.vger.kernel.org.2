Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862D83536B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhDDEgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 00:36:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:20137 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDDEgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 00:36:46 -0400
IronPort-SDR: IzS+/umPuNbwyJoK9ieleV6upSbPS5sk+NzGCHGu0x7ch9Q3mJHClZXN129Oduz8kn9UuWCgm/
 KO+jqdw4WGpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="192168985"
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="192168985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 21:36:41 -0700
IronPort-SDR: VB0S3e3h0dx0iog8REe4k78tlZ+ccxunheHtM3weWgjLqMLVhVUm7FQXzqTfnLm/ZMfO/5+ESk
 9KZzZjd0Re2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="597192965"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2021 21:36:39 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSuV4-00089Q-D6; Sun, 04 Apr 2021 04:36:38 +0000
Date:   Sun, 4 Apr 2021 12:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: caps.c:undefined reference to `atomic64_dec_386'
Message-ID: <202104041223.NyMmG2a3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2023a53bdf41b7646b1d384b6816af06309f73a5
commit: 4f1d756def68588b88068af1d5a4a3b6dc7e6e2a ceph: add global total_caps to count the mdsc's total caps number
date:   8 months ago
config: um-randconfig-r016-20210404 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4f1d756def68588b88068af1d5a4a3b6dc7e6e2a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4f1d756def68588b88068af1d5a4a3b6dc7e6e2a
        # save the attached .config to linux build tree
        make W=1 ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_inc':
   syscall.c:(.text+0x4b0b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_put':
   syscall.c:(.text+0x4b1d): undefined reference to `atomic64_dec_return_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_raw_tracepoint_open':
   syscall.c:(.text+0x4ddf): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_link_get_from_fd':
   syscall.c:(.text+0x4f53): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_curr_or_next':
   syscall.c:(.text+0x4fad): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x4fe6): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_by_id':
   syscall.c:(.text+0x5085): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x50b8): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/bpf/syscall.o: in function `__do_sys_bpf':
   syscall.c:(.text+0x56a7): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x56ec): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x5d99): undefined reference to `atomic64_read_386'
   /usr/bin/ld: syscall.c:(.text+0x5de2): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: syscall.c:(.text+0x5e27): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: kernel/bpf/bpf_iter.o: in function `prepare_seq_file.isra.0':
   bpf_iter.c:(.text+0x155): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_set_ino_cb':
   inode.c:(.text+0x9c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_alloc_inode':
   inode.c:(.text+0x143c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x1444): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x144e): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x1456): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_fill_inode':
   inode.c:(.text+0x28f1): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x2914): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: inode.c:(.text+0x352a): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x353d): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x3571): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x357e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x3587): undefined reference to `atomic64_set_386'
   /usr/bin/ld: inode.c:(.text+0x359c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_fill_trace':
   inode.c:(.text+0x397b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3bc0): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3dde): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3dec): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: inode.c:(.text+0x3e3e): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/inode.o:inode.c:(.text+0x3f1e): more undefined references to `atomic64_inc_386' follow
   /usr/bin/ld: fs/ceph/inode.o: in function `ceph_readdir_prepopulate':
   inode.c:(.text+0x48c8): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x48e4): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x4b31): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x4b72): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_prune':
   dir.c:(.text+0xb3): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: dir.c:(.text+0xde): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_release':
   dir.c:(.text+0x1b5): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_init':
   dir.c:(.text+0x294): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `__dcache_find_get_entry':
   dir.c:(.text+0x503): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x512): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x556): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x565): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_async_unlink_cb':
   dir.c:(.text+0x9b6): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_lookup':
   dir.c:(.text+0x1b6f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x1b7f): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_d_revalidate':
   dir.c:(.text+0x295b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_readdir':
   dir.c:(.text+0x3459): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x3468): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x347e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x348d): undefined reference to `atomic64_read_386'
   /usr/bin/ld: dir.c:(.text+0x3f12): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/dir.o:dir.c:(.text+0x3f92): more undefined references to `atomic64_read_386' follow
   /usr/bin/ld: fs/ceph/dir.o: in function `ceph_readdir':
   dir.c:(.text+0x3fc8): undefined reference to `atomic64_set_386'
   /usr/bin/ld: dir.c:(.text+0x3fdb): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_finish_async_create':
   file.c:(.text+0x68d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: file.c:(.text+0x6ce): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_async_create_cb':
   file.c:(.text+0x1ffe): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_write_iter':
   file.c:(.text+0x33fb): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `__ceph_copy_file_range':
   file.c:(.text+0x4b9b): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/file.o: in function `ceph_atomic_open':
   file.c:(.text+0x5d72): undefined reference to `atomic64_read_386'
   /usr/bin/ld: file.c:(.text+0x5d83): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/addr.o: in function `ceph_page_mkwrite':
   addr.c:(.text+0x662d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `__prep_cap':
   caps.c:(.text+0x1334): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `__check_cap_issue.isra.0':
   caps.c:(.text+0x33b2): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `ceph_add_cap':
   caps.c:(.text+0x3cc0): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `__ceph_remove_cap':
>> caps.c:(.text+0x49f0): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `ceph_check_caps':
   caps.c:(.text+0x6351): undefined reference to `atomic64_read_386'
   /usr/bin/ld: caps.c:(.text+0x6365): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/caps.o: in function `handle_cap_grant':
   caps.c:(.text+0x7796): undefined reference to `atomic64_read_386'
   /usr/bin/ld: caps.c:(.text+0x77b9): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/ceph/snap.o: in function `__ceph_finish_cap_snap':
   snap.c:(.text+0xcde): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_adjust_quota_realms_count':
   quota.c:(.text+0x66f): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: quota.c:(.text+0x677): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_handle_quota':
   quota.c:(.text+0x7bf): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: quota.c:(.text+0x80f): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_files_exceeded':
   quota.c:(.text+0x8aa): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_bytes_exceeded':
   quota.c:(.text+0x938): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/quota.o: in function `ceph_quota_is_max_bytes_approaching':
   quota.c:(.text+0x9cd): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/mds_client.o: in function `ceph_iterate_session_caps':
>> mds_client.c:(.text+0x39e8): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/ceph/mds_client.o: in function `ceph_invalidate_dir_request':
   mds_client.c:(.text+0x565a): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: mds_client.c:(.text+0x5669): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: fs/ceph/mds_client.o: in function `ceph_mdsc_init':
   mds_client.c:(.text+0x822a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/ceph/debugfs.o: in function `metric_show':
   debugfs.c:(.text+0x10c5): undefined reference to `atomic64_read_386'
>> /usr/bin/ld: debugfs.c:(.text+0x10ec): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/ceph/metric.o: in function `ceph_metric_init':
   metric.c:(.text+0x18): undefined reference to `atomic64_set_386'
>> /usr/bin/ld: metric.c:(.text+0x3c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/dma-buf/dma-fence.o: in function `dma_fence_context_alloc':
   dma-fence.c:(.text+0x222): undefined reference to `cmpxchg8b_emu'
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
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `nf_ct_acct_add':
   nf_conntrack_core.c:(.text+0x1c23): undefined reference to `atomic64_add_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text+0x1c30): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `__nf_ct_refresh_acct':
   nf_conntrack_core.c:(.text+0x2c77): undefined reference to `atomic64_add_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text+0x2c83): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `nf_ct_kill_acct':
   nf_conntrack_core.c:(.text+0x31f4): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o:nf_conntrack_core.c:(.text+0x3200): more undefined references to `atomic64_add_386' follow
   /usr/bin/ld: net/netfilter/nf_conntrack_core.o: in function `__nf_ct_resolve_clash':
   nf_conntrack_core.c:(.text.unlikely+0xcf): undefined reference to `atomic64_read_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text.unlikely+0x106): undefined reference to `atomic64_add_386'
   /usr/bin/ld: nf_conntrack_core.c:(.text.unlikely+0x113): undefined reference to `atomic64_add_386'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
   inet_timewait_sock.c:(.text+0x36e): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_timewait_sock.c:(.text+0x37a): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
   inet_connection_sock.c:(.text+0x1730): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_connection_sock.c:(.text+0x173c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
   tcp_input.c:(.text+0x9f7b): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `tcp_conn_request':
   tcp_input.c:(.text+0xa210): undefined reference to `atomic64_set_386'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKE+aWAAAy5jb25maWcAlDxbc9u20u/9FRr3pZ05aX1J0vR84weIBEUckQQNgLLsF46i
KImmtuWx5J7m33+7AC8ACUg+L4m1u1gAi8XeAPDnn36ekNfD7nF12K5XDw8/Jt82T5uX1WHz
ZfJ1+7D5v0nMJwVXExoz9RsQZ9un139+f32cfPjt02/nk/nm5WnzMIl2T1+3316h3Xb39NPP
P0W8SNisjqJ6QYVkvKgVXarrs2/r9bs/J7/Em8/b1dPkz9+ufjt/d3n5q/nrzGrGZD2Lousf
LWjWs7r+8/zq/LxFZHEHv7z6cH55ft7joowUsw59brGPSFFnrJj3HVjAWiqiWOTgUiJrIvN6
xhX3IlgBTWmPYuKmvuUCewB5/DyZabE+TPabw+tzL6Gp4HNa1CAgmZdW64KpmhaLmgiYIsuZ
ur64/NTNmUcka6d1dgbcPYiaVIpPtvvJ0+6AvXY9VgxkJkmmsGkDjGlCqkzpfj3glEtVkJxe
n/3ytHva/NoRyDu5YCWKqhtDySVb1vlNRStqd98R3BIVpXUYHwkuZZ3TnIu7mihFotQzjUrS
jE3tjkkFKuqhTMmCghyhT00BQwYhZe26wDpN9q+f9z/2h81jvy4zWlDBIr2MMuW3liZaGFb8
h0YKV8FZ95jnhBX+JjGdVrNE6oFvnr5Mdl8HQxg2imBR53RBCyXbMavt4+Zl7xt2el+X0IrH
zFmTgiOGxRn1yEcjbeqUzdJaUFkrloMuuYvUjHk0hJZbKSjNSwVc9W7Q443K6ne12v81OUCr
yQo47A+rw36yWq93r0+H7dO3fgaw8eY1NKhJFPGqUKyYOdolmXc8b+hCD0VE1USO5Qbd3NWA
69cMftR0CcJUPUw6FLpNA+rGp4icg+AEiahmISiJ63zqHbM7lp4Hm5s/PGvF5ikwhEXph5Fx
3NMJaClLwEr80S8EKxTYMpLQIc2VkYVcf998eX3YvEy+blaH15fNXoOb0XmwndmbCV6V1hhK
MqO1Xi4qeihs4Wg2+FnP4T/LgGpOtYxSGttiTAgTtYXzGgqhTpI0/EsWy2N4EefkGD4Bpb6n
4hhJTBcsChg0QwEqCjrts1ANwbRMbBl0jMFgeBpJjhuloSGKWEJNaTQvOSw/7mLFBbXZamFp
56Db+jjfyURCv7CVI6L0wgQw9eLSZi1oRu58Liebo3y0dxGx6+UEyYGl5JWIqOV5RFzP7pnl
EQEwBYDbX1xn94GVA9zy3jMW3YaPuLz3DZtzVZu/HZfPSzCM7J7WCRdobuG/nBSRI+UhmYQ/
Qr6pYvHFx74HowbNj84EdZxzcMgMvJ/wrdyMqhwsUN07OWflenC/01JSDPzCwJWPvYBjYayB
V46pplkC0hN+1lMiQTBVlnn4JhUEiz1b/RO2cA/RUjPgKC+XUWqtDy25O0HJZgXJEr990HNz
cS0f9LiJrfupY7kIs+JAxutKDDwViRcM5tiI3Cc/4DclQjDbZs6R9i6XY0jtrGcH1YLEjafY
gjpKNFYC1Bod0NnzgkHQOHbNbxldnDs7QjuGJtYvNy9fdy+Pq6f1ZkL/3jyBlyXgMiL0sxAT
2D7kjS36jhe5EXzrTPxWW2bVdGwXXbTxNkbteeG3yzwviYIQfB5gQ6a+PQbcHf3K+DTYHoYh
wDU2cbSXGxChe8mYBHMNe5HnLncbnxIRQ1jo12WZVkmSUeOMYd0hFwDb7923PGGZUdd2H2DA
ol2GE5m6SYte2SrP3u2fN+vt1+16snvGfG/fx1GAtRx+bkVLEGUy7uwgEyRB8JtkZAa2qSpL
bkdbGPeCqxkjID2L5qb1CNdFzQSyAwE+CmQPTsmyHffXF32GWAh0y/L6wkwu3e0Pk+eX3Xqz
3+9eJocfzyaWdOKjdnbvP32US+9KIMqP+HAEoWQUxOV5oKePIYYl7CJW5YydQB/H50ex7/3Y
eWBI8z8C8E9+eCQqyX1eM6dJAsGWTrt68ltWRCkko4HeG/SVf/PkoCV+K5HPKI/pbHlxBFtn
geWJ7gRbBoW8YCS6qi/DyIDA0KsGWsGWzz0SW3762G6NfisgkKGVLXAKEeTZtMkQPtok2UUY
h80z7VciXt65rAFal2BrTDwqq9xFg7q7gCjnCxeSQ4CYV7lOBxOSs+yu752Rq8s6oWC/I2XZ
HOgvolJixEUzyM2twA2YgLkwQ3ZCtQah16q+uvSIryUheexrmd7NQi6m5Q0bhlQ+Y9xSgD0r
ZE4VgRGMB13lkRd+nxK+ZIVts0/aMMtWo5TtCX18P/WWUHAxrpzQ+6rOwFFndTlTZJpRX3ij
Sy5YHpNRE4RZUY1GCoo6gsWletEEK4CgZGzO01vKZqkTB5sinS7YeTrHElckWKnq+M6qxGBf
iR1cgfLDLLRHqTk4VwGuoHNfpCzt2AxcGOSJlq6ZuRtJyOtLa2w0wuDCV7YCoWPQieuN8usd
WLeAXg/b+t5J9H31slpD2DSJN39v165PkgpmIDBnkTwQ00uZeeEFxOKwU10j2OUBkGojzokR
1d2Ivo+rPchWl8Dg5C23TrKtXjtg+K+GtJsb8NnXL/8+/xf8c3FmExjcPyCRx74sKbMG/nz4
cWbLHhLNwg7qPT9rLD9GJmu21AaLh3ywTp7V6Baq2Bz+u3v5y7dMOJCCKldyFtdh03YYCyYU
php5V71sA7TVy/r79rBZ4w5/92XzDMwgzB7HZ3rbXV3CLq95ktSWeTRVUpnXOY+bCvJwu94S
CMzBwUKEKWDftgXoAQukbPS/hjDTqQg19XK93cBSKzDQYKmbUmG77XhcgUHR7gNTSEGzQRfo
amqV6tKaso1KlAEnyIii+S0EyhaCozlgM1lJiFziqxGCtEXcYW5gRIUbNmTgwCg0JU+7Ocau
dibj2EezchFfvPu82m++TP4yWRLY7K/bB1MM7RghWWOlvOpyjI0jNDxAKbNqxgpvhH9Cgbrq
iapzzLupJVydgcocM80LKxIxy+iL3poFViA2EBSfV6UtuinKzidtWVxYqWxhDlxqWbICfmGj
dlPQfzbr18Pq88NGH2FNdO55sHbBlBVJrlC7rDQ4S9w93xAZL+IM0CBy5sbrneIIGld5aQs5
NCA92nzzuHv5MclXT6tvm0fvroUESTmpEwJqHbUBGII+q07WnJswcADEPZmQZQa6XCqtmzrr
eT9oNMWs0bMP9O7w+QXMNAVF9+BkkzmbiUHn8J/CRcS01OY/l75wtT13QheMUWBN4lhcvz//
swv/CkpjrL3pSGhuV5QzSgodr1ow7bX7OeXkSPWgwyY+5UUshijyuiu035ecWybqflpZHuX+
KgEbY/3WG8WVQQvrAgoMPECg3uF1xBj/+E4I4rYEgBnyfHh8AoE6ho7Q1l9amWEdmkKmlJNh
WaRR5rC+9mtj+RX4ASH3TEBQ7gLpACbn05pCcFC0rkfvjsYVgjmztkU/HZgh9UkBzMPSMRZL
2Mj5ABIz4ghHeat0y0TYmQv8Ai2e8QEIUyCblwbKagqxU8YiX1FcU5idQof80wEAnC63j4dR
fnN6NwJ4+MWlPimgTWFnDNZi8CmSWcb+VKo0peeISK/elVjxxDJ4XAteKVccDGOBKagko0eU
r+2iBBUOphVApPk3pESlg44MFqKTKZc+t92RRBmRktnnEWVdFuXwdx2n0RiIhwNjqCBisEys
ZCMIaD6YmLxaDhG1qorCzU67Ft6DGgh/wYEyKoecFooNuSS88kf+Btd375U6UhFX1HoXS1+W
w8wgXKXVQK3O3SxtzHjqGjzUzn63RiV6lVmndp5xdDRRNbUrH61/afHXZ+vXz9v1md0ujz9I
NnN1axEqtkGDkGzxEggGxEODakm/VGWjjIm7p3XbMr3TESjsm7x0/CxQDCPsDtSJpbWk0e5l
g+YUIhDMVwI3dvr2PqPdoOAv9/JMjzJlmnq4DdyGeLavjuH15ZBjBBn3iaFDc2lFdgUeQxWF
docOFE/FQUVzO05pwMAopgs/jxpX0tlcNvIeUhDfBnKIuuscfh642mCh/Bo1JNRqcarDjExp
NupQYblM8TqOQuprEclIhbppSaoYQ0waEBvJSRGT4KQTFR5DR5ReXV6dpmLCF5k7JFPBSYyu
LDgeUIEp47IuTq6mLPIyyKYsg2LrGZAiJDTJwqzVMZGpdjOEKApv+NjvJXAusKrLu0H3Qb/c
t1wamtbwLHXms5+sd4+ft0+QqD7u8F7J3md0lqrdXT4UTn20+WwC6QaDTveH1cu3zSHUqyJi
RpWnVO2l8tnqMVU/2mNUKjibhiKWkVeDPKRpdryz9Kj0GiLMIPS5eMijjVqAxXwz7TivOEJc
JP8L6yIJXyr00nO9j94oW4yrqfS6rZ4ISE4QjPeUjwoPN984Lgg9cr+bdmh4qSSE3+VwVz6u
DuvvbnlysB3xtibm3+quPDkmQ+3cYPHgza2l4yRZJQc5hI8KvDd40reNCvfj9E7RkKx6Ku0t
T3YNdHgx97S69Q3epvw9/Zv0syEvq6PzQh9/YkoQ8YyuhB2lf4NhMpQ0Kk707c8jPIQpkam5
EH1stinNSn9Y3JOEbKVBe1LuMYkgxSy04VuahTwx9ewy5MY9tLSYKd91aB/tSSnlJDqBP+It
GhKdhHPxxj1YJKHQvyMxsfuxPvlt4b395iE11ZcT/Mq5erttu6m4IicYNq7ibQwFJVko3mgp
8Pj4RJ/D8PwoLQ+UzXy0yqknBSiYVIMb5z46MShqhmmPOrWGBEKUEz1WV4NbEu1l8WOpsFXR
kXYh0/wGzsvryw8fB9ApU1iqZuWIvsOYzWYXqix0YAc1RGjzfLwbuBtkujj3dtQYF+aK2MIj
gK7TyI8KIoDZUZ7jeqONGp2Xhns4IUigYmCG6GgU+ordcM1d860BwSvZBgvZDy6rvL64bJ6Y
gA+YHF5WT/vn3Yu+m3HYrXcPk4fd6svk8+ph9bTG+vb+9RnxfYJi2JnUWg1KkB0Ccm4/gmin
Oh68wQbqdk77UNuhqeknuW/fDNjhpGkqfBbboG7FsFYMwMyXwjf0WTSccsLHHPgiCWkM8p8e
6QGRnjHF6RGG8hgy9/nsph2Nh7MpbtooXUsVONuCHfTa69snq01+pE1u2rAipktXSVfPzw/b
tbaDk++bh2ffQhaJ9w1DoyC0qVg0PP/9hopjguVYQXR99b1TBjF+agw3SdQYHuP1LgO0SxZY
0CMiUIVB5IiRoPiuawCHGQKKlV11w4E3eVLqh5sA2IMQ5bCCa2OVfbXNIDpye1l0XcZkqXrk
/vXpqXy1HUPgrwq1YypmGQ123aRsLGBYekKPMNo8dTxfQW6HIFhL/xqQkDQBYY++fXd3RD0D
JbepYPEs8KKh6TtkBYZFVsv3RPZJEv7qDijM6Q7WbSI8kLBlH6STKfHfVQ22wAs4vuMlpB+P
IITFfnu0uX/T9Q0/69AhCeLC5/EQovgMNVHOPXn4CQro1T1EZU6FFSF5ycmQwVRcfvzkv9Qc
TNLGGtEgFtBn/en88uLG7qaH1rOF8LO0aPIQTQybKBARZVnkvxxMFMl81YTlpbWsGSmn/a8y
5W68RinFkX1wbGwPrYus+UM/XGJYnSG+Nz5WE2PlbX6gTQYXOC9rnwtqJ3PzunndQPz0e/Ng
0XlN2lDX0dRZhRacKt8Ljw6bSDc/1lCjeANgKeznQC1UJ8fejoX3uLLFymTqaySTm+ABLuIV
vfGJukNPk/EQo6kcAyGT8vWvCE7zSA8z4T4jauGxPFb40iTwP/XdBOpYiGEt0Ej4ZjiksdTm
0xPDjlI+p2Mp3CTepYt4PLyLN6BIbsZEQybE16PucKiEqXctShaoV2hsf3Y7bph5U5d+6T36
0PgMm13rRlyVHCDBIya8TohdNW9xDe/rs+ev26+7+utqfzhrDqofVvs9Xn4eH02DiR8MDwB4
AXFUfNAIFekYNzBdpNAXQd772ia3R5pV7mX4BqTfgvrujDXo0WGQGYJclH7oR++4Mn5sZF1p
fdQQ4pMj7ZDtoGCq4ToOdR4RIoZqsA9m7vZeX126A2iQkf+kuifQBfrh6Km3mjMmwNcTgbb4
9ZHgnqVtqVaGimI9iRqLiIyO8BBkSo+hTYoEM2JXQmfEHKNP3Q4QmjMh7CSxhUuSlxkdw0ej
RCAE9mNgiV918TBm+UiFNHw+pf5vbLQU0fDs1EygHG5bhGKY4+tloKgjfHTiIMUQKVYkYcfQ
zCbnITes5Zh4hGuuKY1v35kVHZRKkYXuZ7TzG8Q4bmgQjekaykdF7T3JIzYcra5jqyNflBMX
Ej8PwPF7MTb1FAIcgjduF55GvKTFQt4yZ/cv+guGA0h7xXIIzjgvp851nOZpg4eVi+gv7Nhy
0Zd+AvcYx8qHkHomB4IvpFPwSmXw/Ls2AojpIkiRXYHlxGy4DlHdCBU4w6iLSFqP3fFXzSmk
N3lcmxN0x9k1n4DAhoE4x6IYXXlEoFjW00re1c3L+VYPbuwf+JxcCUpy8/hDXLv3cyeHzf4w
irxjwSHv5gVTXNiJ96jRAGHf9m35pSQXxLzA0R2Xq/Vfm8NErL5sd11J1TnGJpDXeEUfBR4t
TX2biiQgH+F+4qiFNd//AXWW3gdwLZlObq3UeDkn8YDfPPJFv0ORN+BbJmjm3M2LkhlmTFb+
bRKxC/B8UoGZcz9O0VCjctKM4zX6WyIKiBq9V95b6ojCVkxYpK/217yopJepoDcVDFC/+cPL
wHQW+x/IWy3gB82yKiOiTlkRuB7s0OMnD5b6VXngsyz9HJtg9ARTz53/MVEkYtK+2TtOeRuK
OJrk9sJnqhoUBlHtYcpSfzrk+rxncMsA6mktkjmzN7D5Xc9Kxodu5E9/USEizBu/0hJPk63I
pIXg0yel7lr97hm1eHzEZTsabw3Wjd0T2C9sxvxlA8QWkW0dDaCuiFBDNmnkvLtu7NXqZZJs
Nw/4+YnHx9enttz9C7T4dfKle6xn8UnsI5YGULPLyAWWxYerKw+ooXRGlotFpoccmKJU41ka
2LjfYll6RGKAvr7lVXIrig+I8h6OvlFCXYXIF4U6kVN2O77a3cICWUkMkx284ZnhM1CwEcP0
FB8z5dKyrglhGV/Y5pKqVHGetYFC60HM68pJ/LL923y2pH9RuV034AkffeHCvOobXjBxwLV+
lWB/Rm+h8tJ+d9xCwDtWhftpiyImmfMgEvaY5p0wkYOZpuYLfu0sku3L439XLxt9mmif9SS3
4JfwW2GWaFqQfiAU4yfBLCktlSBdJ9bo+1b4yGU0cy8aViHLmgivW/SeEq/WYIHCq4DDGVl+
MoMsVX9Jqn1lF6iNgjmC4IMtAtX4hoAuhPcmq0Gj42yYgPnK+cJxoWVe33BZzyv8UKPyX/Yw
yIZFSTWZpdDtl0rKqvl4mKUf4OGcV33mt7v5W5iwqkZxTrAOL8ziJm5kj8iEFhEd3y9034OO
1V+r2vR1PzaQecowerTDO5uu8xiQtOnXvo4QBY+au/DedZoV3rgqV532l6uXw1Zbp+fVy95s
456qJuIPDJ7sfALBEEnrt6MeFEhOf/brCCqG4AZncmeeql6/s1+9DlnUVdF8isdb8R3T46tm
XmR3tkDHszSvzOHPSW4uU+sPKim8Y/BgrHW2+jESB2RdTsiGMOyVYUAHKmNSlpHPFCT/XfD8
9+Rhtf8+WX/fPk++dEbTFmvCXIn9h8Y0wpoGdeGg+rUH/P+dPdty4ziu7+crXPNwareqp9fX
xH7oB1qSbZ3oFlG2k35RuR1P4urETtlOTfd+/SF4kXgB3b27VTtpA+BVIAmAIMDKg9rJA6fl
mdNTQGc5XRN81SuSKdsgHysmflqEFlmikWEtzaM8jaoSe7kHJLDypoRpnes4rBZ1zxyJhe1f
xQ7dWYh7CKxvdzNHXxY09BDnBILuunOcsvM1dOHs8CEudFnFid0y4wgfM+epWQWZUuW8psJe
+tlJL5ixk9AKw9CAo4DJMWvQCVPrgauHpKYpdokoxrLmJfzNTLmxQyyFzd//Ymtw8/q6e+0A
TecvMYrj4XI6MmgrSKT789ZcH7xO+A+NU1VhUoRh2flf8bffKZga+CYe2KJLjJOZPb0HQ1ez
nJpZ/nXF5qQtp3iQonzmytCrNOrQxluplRx1eDMH2pHRHuThqD96qMMix85NdrCnj+a5Fgd0
MujTYbenf2x2ljHVewm6ZlTyExS/9yxCOmGKFUk8z05p0p90uwOkKwLV72oSWpTRvKR1xTCj
EYKYLnq3t129mwrD+zHpYrrbIg1uBiNtnwhp72ZsXjL0baVTBDuI2KdPXecxAa9J1df2FwlM
ojkxvWIlgimWN+PbEdJBSTAZBA83Tn1sG6vHk0UR0QcHF0W9bneoc6bVYxHRePdjc+7Eh/Pl
9PHGAwSeX5gI+KS5zb3uD7vOE2Oo/Tv8U2enCvYuVJz5L+ptrDfgzEFgUyzaYNGHC1v3aRyw
hXXavfIo6WdtIciiq7wAmQjt0bUqtO8RLHK0uLGiRBTfgMYS4nIBICHghj7/WAHDPCClUYfV
2mA3jhRYVQY7wfP6yRhCBOErTjCgg1fYMKYBj1AL6oKm79Vzajh98JhFrGmkDhmBWT1EN6BU
KIHa+ixjknC9wvlq7fhkuFPcY0MYqQM37pLaR4p0KqV8EXLNdEBdrJHQjw1QVo9UC4GEmoJq
UtjcSZtPq2yK6CGaArSCOMwoh7lfuS0n+1OVS6YbgdAq9DmHU8C24Lqz6soL+8EqIGUIp5cJ
FqF3LBiPfLkygeIBvThoPl4vbP3ufrBuQ+MBSBVYD6CQYxJT8KQKhoPuDfb9JEURkMlo2MMK
C9SPK4XT5CEoEmMtXu232YZUrD1R/YGCpkIRaz4BeX0+nvaXlzfj8AVSiGAx9bxdUvgiwEwz
LZboA7GaM7qVED0ybQOSJ4SJEbq3Kfa1cBl4w2i1mS1FPTBMXrRIccFmYUaSVyqpEda8oLVj
28yqAhAOzwNs+7oXh4zNeVBTkMRgxrnjbysNNbhF8q0P75YikczbtCnzdRxPerMCy/SD7etx
+91GRAcei6hYPCbxlAcHzDyxBjqXI+vGrnN52XU2T09cCd28ilrPn3Xhz21MG2CcBVWJ2XNh
MIZlWQK40whY0eQrplGvb1Mw+RDieerbHLCIvbbhtwgDjO5SgO7sfryzSTCEbV6MhMVoNB47
1Uk4dAG3WwARk6VuB92uZ9AC3X9w6pZwu26dhO80A7eohF8vOhuPbh/M+a6rIg76417XXlrW
5Iiddha6k9buZy7WnNH5vGRnv2UHEgPPgzvP28MCfFNqssLPZoEtI+rxhxR4uLRJUElhEZUp
MVRcCWpfNmFSiiKKeIjnDMQZaAjC6vGQw3VK9VsbRb4uYxHkCR7jeoQNSapurub5inUlKup1
THHfY6wET6HAbYFXOq8X4OZbWhAzkL2i/O0qjd5qopeGnkJaHvgPjsY7wvOgKDqPWXc1K6P7
qzTtV1uK+GgoFU9RE3qenjMGhrI5bltOozAmdRAF2DWhuGE4bd5f9tuzoTko86uNawR5IzIl
3AkECYn1iFZ0WueLIGYbZlUx9ooy1g/Nz56Je8DJhuCrYK73tRaZjl72bFNvrRFu6WXGk4yw
Fbg04yQ6tfDYtEFjK9HuXjT9Y83UA0+6DhJAcN94GrNBPjothSmZLmdYnDD6mAXwcgLj26Uo
ZhnKIVsK2PwhSEA8e8T5TZDRKJmBaR/vsiRaRMRe7fKTW73WBrt8YNJAYaXUaHUsj98rKAvy
0gHbtoQu0fKFVF3SKFs6wFVYEAfYBglUcJOKh/ONmWowtYA2jdUkh1lvAFcyNjAeEVJiRfNW
GZFESiwCqW66nLnfno7n41+XzuLn++7056rz/LFjDIqsy1+RtreU0aMQwhXnVWRuxGxi2g3b
IezftotIAxXbM2czSCVyN/3S7w7HV8iY/KBTaieQJIa4lRh/2HQxJVfYSBKN+6OR02sA1pQ4
8DvxV8h7wnbxvtt8/3gH8+n5yCTS8/tut30xshDhFNb0il1X1UoOT6fj/skwOPLsHej6U9TN
J6T1rJgT0G4tkwaTItmphG/78sPzFGP4ulQUUHGJBmlXFCK4lVNQOc1drb0kmHewwq54ToRc
s4g0veLPWEJQAFykaU5QUEOfV0DphyEOus0ZXLR0+6865kyMqmQWR0kItRiqvoj5m+i5+pI7
MNY0sWMtQjgdC6JrkMJpUFaiM7qEwqqZDMeY4VMjovFoMOxhtXLUyIsaDj3NBmEQ3aIGB52I
QlLD2gzfsVhD4Fs7VK70nwctjB4/TtudcW4rAw+G1451EifTHDNSx6xPSy1iueEvwZGdYvO8
E4FukfuBX5FqJgjeEuKRJS5hmERx2UGIe2x4CFaUen87P6MFDITYl/Kg8w/K87J18gO3yvyz
08RktzxGyNvr8ZmB6THAqsfQohzsZU/eYi5WXMKfjpun7fHNVw7Fi2ubh+Jfs9Nud95u2KTf
H0/xva+SX5Fy2v3n9MFXgYOTT7U2r6xr3r6j+FYCDmoe1FKEL4IQ1z98FWHY5kT5rW/bGF5S
pVaoluXPzvzICA9H3WigFBCuAsXgFlXnWRilxu2iTmQmD8MIQKWkhv1MR4Om5ChKRnlw9125
QrkaRGhfMrbjFY4Z2n3OQxVwsU+YkH5c2JHs+lC1NxicnB8d6IEl8WzjHQxG6I2TICiqbNTT
79kkvKzGk9uBIflJDE1Hoy72VETiQVMyTzQR/tow6np6XaxTZy7B3LI17c1Gas8tbtPlBgse
F7vMkwQxorOj2EhV2Z710nMICDCJxizYfFlgpcB0diiJu7u20pOSnbKwzGPTYVmAIBQ6uHNZ
L3Rd0arlTdRzNVsZ0c35T2GzU+y2WMONHR4mg+oPMtkPGaVCvQpzEKziujIR/MbZBImMhOpK
x7Aot1im1ZXVNCL45SPS6UbSYRJm2568aixgJpXtu/WaY6TX3p1zfDjDrKsiGp24YI0ibKPU
wdoWkBf6g/Q4fzB/1a5QSJM4nZoO4fyeKxB+X6iEo9KFtqqwuZtI/0aQ+jkrG/vLiiRxCPm9
ZlT6xyNtAI7nMCRBou8gIMDo7pgKIjy6astNCgwHPKMDHr5oBnpmUD4Wdg4JhmDaU4zeT86o
MCwYG7dra2imkmOcKOMzcsU8wSNVIZXBDdKMDmt9AgSsnpnjBu9tNAo++NeCiVOvooWBRxv3
kQNXOb1CjIQka/IIAVwS/GGjVka9iHIx8PJPJqASPLKRMQ2b2VbexNrHEUmtkMADSk4WlYi9
+Lz7eDry7A0IL3I/RnSiOCZYxElYRprJBBJ66HOn9jq1bqWzcGu15L7CDStjS51TPJCqMhPw
zsI6KCPjXZr4035tdWq4Q9SUAjAawDpgPa2i1BP/lV8haVRam/AgYOYC7EQNAoot2iA2iscz
KgLJ9y2g8BGOMxoF4BjkurpwqnVEmJq45o8ssL0JaJaFnSuVg/kc+8rYZpwGZndTuiAv0wKe
EtojC/XmdYQ7YwAtLVtFkIek9jxlIbwW7PsZrvUJbV59/7E/H8fj0eTPnpZpHgjgkTvPNDEc
3OIVtiS3g1uz9hZzO/JgxrrYZ2H6Xoy/tlvjGtfA3WD3dBZJz1fxjbczNwMvZujFeAdwc+PF
TDyYyeDGO+jJ6JeDngx8Q5sMfU2Ob62hxTQH9qnH3p70+mZXvFTYoymgITSIY7zVHg7u4+AB
DvaMaISDb3DwLQ6eePrt6UrP05ee1Zm7PB7XJQJbmjCI3FPmqZGNTYKDKKl0EbqFM8FtWeYI
psxJFaN1PZZxkmC1zUmEw8sounPBcQCZOkOblzgqW+KP0/Vhor2rluVdTBcmYlnNDJYNE8xo
u8ziQDyvNAF1Bop9En8VryXVJVFLF+f1+l4/gA1JV5ihdtuP0/7y080IZZ4Z8Is/u4y0d1Ot
dAJ52th5nPEUMaXnlee0rVX3rwWxNgo5BikEKWfCBbwKF/mejNL8BGbSbx2mEeX6bsW0VvyO
XtGiJxO366rUx02y0TbFsWEXtcnw5kTuSKCBt7HCtQrzRJYXK+1Q9OCWCU2//AHG1Kfj34dP
Pzdvm0/wZOl9f/h03vy1Y/Xsnz7tD5fdM3zET9/e//rDSKT9sjk97Q5maiPtyrSzP+wv+83r
/t9WIJQYnhWJlJVm6jyOYMwmEkSpzptKiaKBnNIaCe5sivfDyu6NDKOxtdkM3IgtwFeNG1Nw
+vl+OXa2EJb1eGojDxrETLDUfbMkkCRzoqeGN8B9Fx7pDqUa0CWld0FcLIzshSbCLQLSJAp0
SUvjTrCBoYRa/B2r496eEF/n74rCpb7T1X1VA7hhuqRsB2VnsVuvhLsFbJXVpGcaIhXeMN4L
dKuAeKbokJvE81mvP06XidMb8BhGgX2kj/wP9mpLTdGyWrAtUnFx8fHtdb/98/vuZ2fLGfoZ
nDl+OnxcGlejAha6fBMFAdKnKAhRhUVhy5ASbCjLchX1R6PexLX3fVxedocLvPLdPXWiA+87
vCD7e3956ZDz+bjdc1S4uWycwQR6VjU1+0GKdWHBDibS7xZ58tgbdNG7NrUe5zFlHxCphEb3
MRaXpBn/grANbqU+yZRfdb0dn3RjgOrPNHB6HsymLqxyuT2o3J0oCtyySblGBpHPsHgsEllg
/XowkwWpZRs9rkv0kZti7IWabHd5g2NEtXQ/HvjXNPO3gLdNnukz4jyrvQ4DPmAjWglKcRmx
f96dL24LZTDoI98IwG4jD+jmO03IXdR3P4yAY5PKqq963RAPhCD5WzZlF/01Z6fh0OmKEVRT
wWLGyFECf5F2yjRkq+PaZgkUN7hK1VL0R3g2s5Zi0Mc0RLUUjXCfLZBVi4FHPeSIXZCBC0wR
GOSKnZpuERJVzcveBM3ZLvDrQrQsBI39+4tx3dXsOIhkASlqY6RFki2n8dWzipQBFrqy4b18
PYtRZhUIJMaRYk6SRkyLwqy6DQWoAP7ytLrCnoB2P16ITM6M/8X2pAX5SsJrk0NJQsk1xlIH
Bbr9o6+oG2xZWIkSGp7Co7oqHorIVfQ6h8/ib1gSOMnkLPRofNMw4vHt/bQ7nw25vplvSO8b
OdUkX3NkaOMhHuy1KXSFExlygW0wX6kp9sinr4en41sn+3j7tjvJvNEXrP8ko3EdFJiEG5bT
ueX3p2MWdmgrHeex1Gok2EkNCAf4f3FVRWUEN6/Fo4Pl7seYUqEQuJzfYL2KQ0OBTU2DlCqK
w8J21lRXy6jlWypdp3rdfzttmA53On5c9gfkHIenFNj2x+FsH0MR8vhUN9HXaFCcWOJXiwsS
HNUIs9draMhQNLat8ZBG8hRncjoEXupdI7nWvFf0akfXCsMokecwXaxdLo9WEJeYSQxWwB8H
z7SKK6uoIYOmu0NMkwAa73tEQh9TiJoQB9w0BFl12r5qyGI5TSQNXU4lWdPSw6g70YKNRcj9
bmvcugvoGJ5mroAQKnSJxXrYnS4iqOzuDAnYO+f982ED6e4725fd9rsRvE7cX4l3jsL6VRpO
vC6eQsAczd+c44Wuqo3EZ/vKs5CUj3Z7yATLitnaCu54uhJf11oKvjPAv0QP1eXmb0xHaxrM
oHf8/etM7S+Ju7G0H4X47sqncQXRjEr9ZYhyZ4FwThBsgrqoWZyFEJqI8oQ5GvvnZWiKyAXE
HGcafTrF/ZaFnZIYRoCAabHsRDBAvRuT94P6ilYQ1HG1rM0KrAjBAGiMwJ4Dm5NA0Njpo0+6
10h8Eg0nIeXaYjcDLyZRL3SDiwnm/h9oVxhsg2oUNL2iMVJPo5xpjkfwkNgzJZLmK3/ll1nC
0Fexd1tQJhs1QaVMaBhhcCb3oPRDk77dkr4CArUQK/J6/tV8jdggpgzRRzFCpLOYXbdrq2Wj
h1uFWMY0YmczCqvv9Kx1hNI8iBnPryJ2mpfECFrLdhoICQXhaKwsXwAGWcS6zjbAtR50jc4T
0W+NWI8fOk9yI6Q9/L727bPE9GQIkq+Qs6YFxOW9Fa80LWLjJSn4p5VgSapKw7WL7U1hVJgX
5iI1mWd9qoAq9oZnmvLVCcKh76f94fKdv6x9etudn90LHBFMwEliJsFw849eSATCHQ2eCCQQ
u7MxDd96Ke6XcVR9GTbTxPgOblOdGhoKEYxKdIS/ZNS+6WNG0tgJaGqArcfb7NCfQiTsOipL
RmV5qgI9+z87Eaa5/bZRzrt3LhtFav+6+/Oyf5Mn15mTbgX8hL0GE83a8aElMsq4PTqFCAc8
G3A7lFnJ+s8jpX7pdfvD/9GYp2ArDVwWdZ8XiOTF6yI01Vc/XztRwK8F05haodRtDG+vlhHB
jI4UeZwZ0S1E1bMcPBOFgwuE2uN5QbXUd785X4Zzv+TycPft4/kZbnq0iCq6+zNv39g4l1Nq
R9u1XgNcrdusGtymosQeMPgmKalE3lg1lWkLDpie7ZIR005N24ioBfB8B8O8uKAszzpprFWA
so9A8wwXdtqKGS/M3CbzKUQPxqQUmiynQuNrB8tvQeU8pFGasA/sVqkw+FNEwXr84nAJmwDW
MqRWkTQRBOAyl4CoYuXw8yrlFl3TN6lBlVMEWMzZGT6n7hiENza/qMR2wAAk2vqOML5C9C+B
BUc02NCznFHFFbyHgwzGxmEvahDpCnrOnWfLQdbCXYi4VMJwDUSd/Ph+/tRJjtvvH+9iMS02
h2d9r2d9CODOVcbfw8Dgz7rUtE2BhOMhX1Zfuo2Ewh/Js75UKpii+m75rPIiYUdnahFJdTLe
wu/QNF3TvhO0UC+WbIorQnFuW99ff0bN42smyKP/xhn42uQK/wiV4c5Y8O3tM4I2vybM710U
FUKDEnoN3Bi1m9E/zu/7A4928anz9nHZ/dixf+wu28+fP/+z/cLca5hXyV8jtk+kmmMdnhJL
F2LzvAcEhKDjVWRsTqy9pCHlBLAneHeasmLHFpMEdcOG5Fr5VszZOnHy9Vpg2D6Ur3ksW4ug
XFPDvVNAeQ8tKRBgTNxyV7lEeAcjJ0tY1NQLa70aEQ6ATTO4eXrEyHYgrftNK9D9B1+6kbN5
ACm2Bai9SxcrOVLvIj+62YTAC3kmbUMwdK73XNmd78Sh4POCsSUmcyf6Lo7Sp81l04EzdAv6
vHNAc1uA9ekKCbTPCpwVBZK7nse4ms2Pt6wOSUVAHiyXrXO8sbw9PTY7F5Rs7rIqJknzHqQM
lughL5ZTsLSXHgPV9hABBg+wHOYxKHwcZhK58XQ1bHSP5rdTzw+NodiTzHZRIdCVXJTDVKW8
EO3bcc5KHj1eMaXBwIG5GXDlp4kXrARhHnQa6K336xkomzIHhtOyVpV0xZYBVpvPEUUpYwam
vvGiXIilZv+M9pRWjA0R3Wtn1ojhYIN9Xqu6dYYq7ykEbBGVe8Whpu3WzWzNFFR/MTn/NCMF
XeSV82EUQkno1iRN2TbBk8rl/OmJdPLSDw0OJxlbghBYWBbwhL9syNlGhBFaSpyIx6wrcFm1
cKCCjwSPiCwYFo5/2HoasebM7Dc6hyBoVTFJuGECeq6PfSZD+FWELcviyqrUWvERuwPkkYlN
N00R3p7aAC06h4OSe7gDV+KQ2sQ+3iy5Ra08UiZ4uEG5ZRgFdTNEJRKqcDkpgPepm+ed5jQK
8cj1yZQByt1n1gbenA8Bix7EkJoz1cACp/k8tNSpAfaAvJS8E+u3piICJU5osAJ3XWwqwK4j
wB7GtYUg1wIKSCWBif8MLBmu0GQWSd0OCsikXYAHJyxB58MXG6eNM1qVS8h9CVOBTSynYnsg
KSMiE3z8GHbZ/zQOXmZi2xIyIb82Rapi2pIt2FxlBsd5Uxiu/h9u7HwZCLIAAA==

--45Z9DzgjV8m4Oswq--
