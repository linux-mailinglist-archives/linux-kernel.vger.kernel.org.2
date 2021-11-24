Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680CA45B219
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhKXCkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:40:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:3481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235796AbhKXCkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:40:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222410015"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="222410015"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 18:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="674706225"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2021 18:37:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpiA2-0004CV-M3; Wed, 24 Nov 2021 02:37:26 +0000
Date:   Wed, 24 Nov 2021 10:37:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:xfs-5.16-fixes 49/52] fs/xfs/xfs_ioctl32.c:500:17:
 error: 'error' undeclared; did you mean 'PG_error'?
Message-ID: <202111241041.WxTEwPLE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git xfs-5.16-fixes
head:   572afb64675281e83a9152f762854fd9998b5deb
commit: 7997e4cb7c5ba7f8f389a17146a3c1c31c3da918 [49/52] xfs: fix build warning in xfs_file_compat_ioctl
config: s390-randconfig-m031-20211123 (https://download.01.org/0day-ci/archive/20211124/202111241041.WxTEwPLE-lkp@intel.com/config.gz)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=7997e4cb7c5ba7f8f389a17146a3c1c31c3da918
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs xfs-5.16-fixes
        git checkout 7997e4cb7c5ba7f8f389a17146a3c1c31c3da918
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/xfs/xfs_ioctl32.c: In function 'xfs_file_compat_ioctl':
>> fs/xfs/xfs_ioctl32.c:500:17: error: 'error' undeclared (first use in this function); did you mean 'PG_error'?
     500 |                 error = mnt_want_write_file(filp);
         |                 ^~~~~
         |                 PG_error
   fs/xfs/xfs_ioctl32.c:500:17: note: each undeclared identifier is reported only once for each function it appears in
>> fs/xfs/xfs_ioctl32.c:491:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     491 |         case XFS_IOC_SWAPEXT_32: {
         |                                  ^
   fs/xfs/xfs_ioctl32.c:507:9: note: here
     507 |         case XFS_IOC_FSBULKSTAT_32:
         |         ^~~~


vim +500 fs/xfs/xfs_ioctl32.c

28750975ace79c fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  432  
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  433  long
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  434  xfs_file_compat_ioctl(
d5547f9feea459 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  435  	struct file		*filp,
e0edd5962bd83d fs/xfs/linux-2.6/xfs_ioctl32.c Nathan Scott        2006-03-29  436  	unsigned		cmd,
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  437  	unsigned long		p)
^1da177e4c3f41 fs/xfs/linux-2.6/xfs_ioctl32.c Linus Torvalds      2005-04-16  438  {
496ad9aa8ef448 fs/xfs/xfs_ioctl32.c           Al Viro             2013-01-23  439  	struct inode		*inode = file_inode(filp);
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  440  	struct xfs_inode	*ip = XFS_I(inode);
4529e6d7a6ab72 fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2019-08-15  441  	void			__user *arg = compat_ptr(p);
^1da177e4c3f41 fs/xfs/linux-2.6/xfs_ioctl32.c Linus Torvalds      2005-04-16  442  
cca28fb83d9e60 fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2010-06-24  443  	trace_xfs_file_compat_ioctl(ip);
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  444  
^1da177e4c3f41 fs/xfs/linux-2.6/xfs_ioctl32.c Linus Torvalds      2005-04-16  445  	switch (cmd) {
a9d25bde1e9b24 fs/xfs/xfs_ioctl32.c           Nick Bowler         2018-12-17  446  #if defined(BROKEN_X86_ALIGNMENT)
526c420c44b45b fs/xfs/linux-2.6/xfs_ioctl32.c Eric Sandeen        2005-09-05  447  	case XFS_IOC_ALLOCSP_32:
526c420c44b45b fs/xfs/linux-2.6/xfs_ioctl32.c Eric Sandeen        2005-09-05  448  	case XFS_IOC_FREESP_32:
526c420c44b45b fs/xfs/linux-2.6/xfs_ioctl32.c Eric Sandeen        2005-09-05  449  	case XFS_IOC_ALLOCSP64_32:
837a6e7f5cdb5e fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2019-10-24  450  	case XFS_IOC_FREESP64_32: {
d5547f9feea459 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  451  		struct xfs_flock64	bf;
d5547f9feea459 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  452  
d5547f9feea459 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  453  		if (xfs_compat_flock64_copyin(&bf, arg))
b474c7ae4395ba fs/xfs/xfs_ioctl32.c           Eric Sandeen        2014-06-22  454  			return -EFAULT;
526c420c44b45b fs/xfs/linux-2.6/xfs_ioctl32.c Eric Sandeen        2005-09-05  455  		cmd = _NATIVE_IOC(cmd, struct xfs_flock64);
837a6e7f5cdb5e fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2019-10-24  456  		return xfs_ioc_space(filp, &bf);
d5547f9feea459 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  457  	}
547e00c3c68126 fs/xfs/linux-2.6/xfs_ioctl32.c Michal Marek        2007-07-11  458  	case XFS_IOC_FSGEOMETRY_V1_32:
f69e8091c4a2ae fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2021-02-03  459  		return xfs_compat_ioc_fsgeometry_v1(ip->i_mount, arg);
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  460  	case XFS_IOC_FSGROWFSDATA_32: {
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  461  		struct xfs_growfs_data	in;
7997e4cb7c5ba7 fs/xfs/xfs_ioctl32.c           Darrick J. Wong     2021-11-18  462  		int		error;
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  463  
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  464  		if (xfs_compat_growfs_data_copyin(&in, arg))
b474c7ae4395ba fs/xfs/xfs_ioctl32.c           Eric Sandeen        2014-06-22  465  			return -EFAULT;
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  466  		error = mnt_want_write_file(filp);
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  467  		if (error)
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  468  			return error;
f69e8091c4a2ae fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2021-02-03  469  		error = xfs_growfs_data(ip->i_mount, &in);
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  470  		mnt_drop_write_file(filp);
2451337dd04390 fs/xfs/xfs_ioctl32.c           Dave Chinner        2014-06-25  471  		return error;
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  472  	}
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  473  	case XFS_IOC_FSGROWFSRT_32: {
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  474  		struct xfs_growfs_rt	in;
7997e4cb7c5ba7 fs/xfs/xfs_ioctl32.c           Darrick J. Wong     2021-11-18  475  		int		error;
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  476  
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  477  		if (xfs_compat_growfs_rt_copyin(&in, arg))
b474c7ae4395ba fs/xfs/xfs_ioctl32.c           Eric Sandeen        2014-06-22  478  			return -EFAULT;
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  479  		error = mnt_want_write_file(filp);
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  480  		if (error)
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  481  			return error;
f69e8091c4a2ae fs/xfs/xfs_ioctl32.c           Christoph Hellwig   2021-02-03  482  		error = xfs_growfs_rt(ip->i_mount, &in);
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12  483  		mnt_drop_write_file(filp);
2451337dd04390 fs/xfs/xfs_ioctl32.c           Dave Chinner        2014-06-25  484  		return error;
471d59103167c8 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  485  	}
^1da177e4c3f41 fs/xfs/linux-2.6/xfs_ioctl32.c Linus Torvalds      2005-04-16  486  #endif
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  487  	/* long changes size, but xfs only copiese out 32 bits */
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  488  	case XFS_IOC_GETVERSION_32:
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  489  		cmd = _NATIVE_IOC(cmd, long);
4d4be482a4d78c fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2008-12-09  490  		return xfs_file_ioctl(filp, cmd, p);
3725867dccfb83 fs/xfs/linux-2.6/xfs_ioctl32.c Christoph Hellwig   2009-09-01 @491  	case XFS_IOC_SWAPEXT_32: {
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  492  		struct xfs_swapext	  sxp;
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  493  		struct compat_xfs_swapext __user *sxu = arg;
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  494  
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  495  		/* Bulk copy in up to the sx_stat field, then copy bstat */
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  496  		if (copy_from_user(&sxp, sxu,
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  497  				   offsetof(struct xfs_swapext, sx_stat)) ||
e5d412f17846b0 fs/xfs/linux-2.6/xfs_ioctl32.c sandeen@sandeen.net 2008-11-25  498  		    xfs_ioctl32_bstat_copyin(&sxp.sx_stat, &sxu->sx_stat))
b474c7ae4395ba fs/xfs/xfs_ioctl32.c           Eric Sandeen        2014-06-22  499  			return -EFAULT;
d9457dc0562499 fs/xfs/xfs_ioctl32.c           Jan Kara            2012-06-12 @500  		error = mnt_want_write_file(filp);

:::::: The code at line 500 was first introduced by commit
:::::: d9457dc056249913a7abe8b71dc09e427e590e35 xfs: Convert to new freezing code

:::::: TO: Jan Kara <jack@suse.cz>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
