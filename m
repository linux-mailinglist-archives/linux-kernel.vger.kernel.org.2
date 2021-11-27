Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2524345FD09
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 07:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbhK0GM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 01:12:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:63887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238608AbhK0GK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 01:10:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="299146130"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="299146130"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 22:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="498661746"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 22:07:42 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqqs9-00099N-CB; Sat, 27 Nov 2021 06:07:41 +0000
Date:   Sat, 27 Nov 2021 14:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [dhowells-fs:fscache-rewrite-indexing-3 60/63]
 fs/nfs/fscache.c:58:51: sparse: sparse: incorrect type in argument 3
 (different base types)
Message-ID: <202111271427.AQQrX7DH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite-indexing-3
head:   7cb6fc11f97e7d40213fb323f0474fdf5ce4ff24
commit: d3292e579b1e9fd57f6f7716e9d01a13144db386 [60/63] nfs: Convert to new fscache volume/cookie API
config: s390-randconfig-s032-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271427.AQQrX7DH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=d3292e579b1e9fd57f6f7716e9d01a13144db386
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs fscache-rewrite-indexing-3
        git checkout d3292e579b1e9fd57f6f7716e9d01a13144db386
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/nfs/fscache.c:58:51: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be16 const [usertype] sin_port @@
   fs/nfs/fscache.c:58:51: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:58:51: sparse:     got restricted __be16 const [usertype] sin_port
>> fs/nfs/fscache.c:59:61: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const [usertype] s_addr @@
   fs/nfs/fscache.c:59:61: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:59:61: sparse:     got restricted __be32 const [usertype] s_addr
>> fs/nfs/fscache.c:64:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be16 const [usertype] sin6_port @@
   fs/nfs/fscache.c:64:52: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:64:52: sparse:     got restricted __be16 const [usertype] sin6_port
>> fs/nfs/fscache.c:65:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:65:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:65:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:66:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:66:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:66:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:67:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:67:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:67:73: sparse:     got restricted __be32 const
   fs/nfs/fscache.c:68:73: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long x @@     got restricted __be32 const @@
   fs/nfs/fscache.c:68:73: sparse:     expected unsigned long long x
   fs/nfs/fscache.c:68:73: sparse:     got restricted __be32 const

vim +58 fs/nfs/fscache.c

    37	
    38	/*
    39	 * Get the per-client index cookie for an NFS client if the appropriate mount
    40	 * flag was set
    41	 * - We always try and get an index cookie for the client, but get filehandle
    42	 *   cookies on a per-superblock basis, depending on the mount flags
    43	 */
    44	static bool nfs_fscache_get_client_key(struct nfs_client *clp,
    45					       char *key, int *_len)
    46	{
    47		const struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *) &clp->cl_addr;
    48		const struct sockaddr_in *sin = (struct sockaddr_in *) &clp->cl_addr;
    49	
    50		*_len += snprintf(key + *_len, NFS_MAX_KEY_LEN - *_len,
    51				  ",%u.%u,%x",
    52				  clp->rpc_ops->version,
    53				  clp->cl_minorversion,
    54				  clp->cl_addr.ss_family);
    55	
    56		switch (clp->cl_addr.ss_family) {
    57		case AF_INET:
  > 58			if (!nfs_append_int(key, _len, sin->sin_port) ||
  > 59			    !nfs_append_int(key, _len, sin->sin_addr.s_addr))
    60				return false;
    61			return true;
    62	
    63		case AF_INET6:
  > 64			if (!nfs_append_int(key, _len, sin6->sin6_port) ||
  > 65			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[0]) ||
    66			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[1]) ||
    67			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[2]) ||
    68			    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[3]))
    69				return false;
    70			return true;
    71	
    72		default:
    73			printk(KERN_WARNING "NFS: Unknown network family '%d'\n",
    74			       clp->cl_addr.ss_family);
    75			return false;
    76		}
    77	}
    78	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
