Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660245AFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhKWX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:26:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:56239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhKWX0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:26:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="259038306"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="259038306"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 15:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509230185"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2021 15:22:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpf7n-0002RT-C3; Tue, 23 Nov 2021 23:22:55 +0000
Date:   Wed, 24 Nov 2021 07:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: fs/xfs/xfs_trans.c:559:8: warning: variable 'error' set but not used
Message-ID: <202111240723.ALWlwQXv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: dc3ffbb14060c943469d5e12900db3a60bc3fa64 xfs: gut error handling in xfs_trans_unreserve_and_mod_sb()
date:   1 year, 6 months ago
config: x86_64-randconfig-a015-20211118 (https://download.01.org/0day-ci/archive/20211124/202111240723.ALWlwQXv-lkp@intel.com/config.gz)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dc3ffbb14060c943469d5e12900db3a60bc3fa64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dc3ffbb14060c943469d5e12900db3a60bc3fa64
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/xfs_trans.c: In function 'xfs_trans_unreserve_and_mod_sb':
>> fs/xfs/xfs_trans.c:559:8: warning: variable 'error' set but not used [-Wunused-but-set-variable]
     559 |  int   error;
         |        ^~~~~


vim +/error +559 fs/xfs/xfs_trans.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  536  
^1da177e4c3f41 Linus Torvalds    2005-04-16  537  /*
dc3ffbb14060c9 Dave Chinner      2020-05-20  538   * xfs_trans_unreserve_and_mod_sb() is called to release unused reservations and
dc3ffbb14060c9 Dave Chinner      2020-05-20  539   * apply superblock counter changes to the in-core superblock.  The
45c34141126a89 David Chinner     2007-06-18  540   * t_res_fdblocks_delta and t_res_frextents_delta fields are explicitly NOT
45c34141126a89 David Chinner     2007-06-18  541   * applied to the in-core superblock.  The idea is that that has already been
45c34141126a89 David Chinner     2007-06-18  542   * done.
^1da177e4c3f41 Linus Torvalds    2005-04-16  543   *
45c34141126a89 David Chinner     2007-06-18  544   * If we are not logging superblock counters, then the inode allocated/free and
45c34141126a89 David Chinner     2007-06-18  545   * used block counts are not updated in the on disk superblock. In this case,
45c34141126a89 David Chinner     2007-06-18  546   * XFS_TRANS_SB_DIRTY will not be set when the transaction is updated but we
45c34141126a89 David Chinner     2007-06-18  547   * still need to update the incore superblock with the changes.
^1da177e4c3f41 Linus Torvalds    2005-04-16  548   */
71e330b593905e Dave Chinner      2010-05-21  549  void
^1da177e4c3f41 Linus Torvalds    2005-04-16  550  xfs_trans_unreserve_and_mod_sb(
0bd5ddedccca44 Dave Chinner      2015-02-23  551  	struct xfs_trans	*tp)
^1da177e4c3f41 Linus Torvalds    2005-04-16  552  {
0bd5ddedccca44 Dave Chinner      2015-02-23  553  	struct xfs_mount	*mp = tp->t_mountp;
0d485ada404b36 Dave Chinner      2015-02-23  554  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
45c34141126a89 David Chinner     2007-06-18  555  	int64_t			blkdelta = 0;
45c34141126a89 David Chinner     2007-06-18  556  	int64_t			rtxdelta = 0;
1b0407125f9a5b Christoph Hellwig 2010-09-30  557  	int64_t			idelta = 0;
1b0407125f9a5b Christoph Hellwig 2010-09-30  558  	int64_t			ifreedelta = 0;
0bd5ddedccca44 Dave Chinner      2015-02-23 @559  	int			error;
^1da177e4c3f41 Linus Torvalds    2005-04-16  560  
1b0407125f9a5b Christoph Hellwig 2010-09-30  561  	/* calculate deltas */
45c34141126a89 David Chinner     2007-06-18  562  	if (tp->t_blk_res > 0)
45c34141126a89 David Chinner     2007-06-18  563  		blkdelta = tp->t_blk_res;
45c34141126a89 David Chinner     2007-06-18  564  	if ((tp->t_fdblocks_delta != 0) &&
45c34141126a89 David Chinner     2007-06-18  565  	    (xfs_sb_version_haslazysbcount(&mp->m_sb) ||
45c34141126a89 David Chinner     2007-06-18  566  	     (tp->t_flags & XFS_TRANS_SB_DIRTY)))
45c34141126a89 David Chinner     2007-06-18  567  	        blkdelta += tp->t_fdblocks_delta;
45c34141126a89 David Chinner     2007-06-18  568  
45c34141126a89 David Chinner     2007-06-18  569  	if (tp->t_rtx_res > 0)
45c34141126a89 David Chinner     2007-06-18  570  		rtxdelta = tp->t_rtx_res;
45c34141126a89 David Chinner     2007-06-18  571  	if ((tp->t_frextents_delta != 0) &&
45c34141126a89 David Chinner     2007-06-18  572  	    (tp->t_flags & XFS_TRANS_SB_DIRTY))
45c34141126a89 David Chinner     2007-06-18  573  		rtxdelta += tp->t_frextents_delta;
45c34141126a89 David Chinner     2007-06-18  574  
1b0407125f9a5b Christoph Hellwig 2010-09-30  575  	if (xfs_sb_version_haslazysbcount(&mp->m_sb) ||
1b0407125f9a5b Christoph Hellwig 2010-09-30  576  	     (tp->t_flags & XFS_TRANS_SB_DIRTY)) {
1b0407125f9a5b Christoph Hellwig 2010-09-30  577  		idelta = tp->t_icount_delta;
1b0407125f9a5b Christoph Hellwig 2010-09-30  578  		ifreedelta = tp->t_ifree_delta;
^1da177e4c3f41 Linus Torvalds    2005-04-16  579  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  580  
1b0407125f9a5b Christoph Hellwig 2010-09-30  581  	/* apply the per-cpu counters */
1b0407125f9a5b Christoph Hellwig 2010-09-30  582  	if (blkdelta) {
0d485ada404b36 Dave Chinner      2015-02-23  583  		error = xfs_mod_fdblocks(mp, blkdelta, rsvd);
dc3ffbb14060c9 Dave Chinner      2020-05-20  584  		ASSERT(!error);
1b0407125f9a5b Christoph Hellwig 2010-09-30  585  	}
45c34141126a89 David Chinner     2007-06-18  586  
1b0407125f9a5b Christoph Hellwig 2010-09-30  587  	if (idelta) {
501ab323875339 Dave Chinner      2015-02-23  588  		error = xfs_mod_icount(mp, idelta);
dc3ffbb14060c9 Dave Chinner      2020-05-20  589  		ASSERT(!error);
^1da177e4c3f41 Linus Torvalds    2005-04-16  590  	}
1b0407125f9a5b Christoph Hellwig 2010-09-30  591  
1b0407125f9a5b Christoph Hellwig 2010-09-30  592  	if (ifreedelta) {
e88b64ea1f3da6 Dave Chinner      2015-02-23  593  		error = xfs_mod_ifree(mp, ifreedelta);
dc3ffbb14060c9 Dave Chinner      2020-05-20  594  		ASSERT(!error);
^1da177e4c3f41 Linus Torvalds    2005-04-16  595  	}
1b0407125f9a5b Christoph Hellwig 2010-09-30  596  
0bd5ddedccca44 Dave Chinner      2015-02-23  597  	if (rtxdelta == 0 && !(tp->t_flags & XFS_TRANS_SB_DIRTY))
0bd5ddedccca44 Dave Chinner      2015-02-23  598  		return;
0bd5ddedccca44 Dave Chinner      2015-02-23  599  
1b0407125f9a5b Christoph Hellwig 2010-09-30  600  	/* apply remaining deltas */
0bd5ddedccca44 Dave Chinner      2015-02-23  601  	spin_lock(&mp->m_sb_lock);
dc3ffbb14060c9 Dave Chinner      2020-05-20  602  	mp->m_sb.sb_frextents += rtxdelta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  603  	mp->m_sb.sb_dblocks += tp->t_dblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  604  	mp->m_sb.sb_agcount += tp->t_agcount_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  605  	mp->m_sb.sb_imax_pct += tp->t_imaxpct_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  606  	mp->m_sb.sb_rextsize += tp->t_rextsize_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  607  	mp->m_sb.sb_rbmblocks += tp->t_rbmblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  608  	mp->m_sb.sb_rblocks += tp->t_rblocks_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  609  	mp->m_sb.sb_rextents += tp->t_rextents_delta;
dc3ffbb14060c9 Dave Chinner      2020-05-20  610  	mp->m_sb.sb_rextslog += tp->t_rextslog_delta;
0bd5ddedccca44 Dave Chinner      2015-02-23  611  	spin_unlock(&mp->m_sb_lock);
1b0407125f9a5b Christoph Hellwig 2010-09-30  612  
dc3ffbb14060c9 Dave Chinner      2020-05-20  613  	/*
dc3ffbb14060c9 Dave Chinner      2020-05-20  614  	 * Debug checks outside of the spinlock so they don't lock up the
dc3ffbb14060c9 Dave Chinner      2020-05-20  615  	 * machine if they fail.
dc3ffbb14060c9 Dave Chinner      2020-05-20  616  	 */
dc3ffbb14060c9 Dave Chinner      2020-05-20  617  	ASSERT(mp->m_sb.sb_imax_pct >= 0);
dc3ffbb14060c9 Dave Chinner      2020-05-20  618  	ASSERT(mp->m_sb.sb_rextslog >= 0);
1b0407125f9a5b Christoph Hellwig 2010-09-30  619  	return;
^1da177e4c3f41 Linus Torvalds    2005-04-16  620  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  621  

:::::: The code at line 559 was first introduced by commit
:::::: 0bd5ddedccca4451ac2390d1155b4ab74b990eff xfs: replace xfs_mod_incore_sb_batched

:::::: TO: Dave Chinner <dchinner@redhat.com>
:::::: CC: Dave Chinner <david@fromorbit.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
