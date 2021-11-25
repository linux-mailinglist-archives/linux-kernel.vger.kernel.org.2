Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA345E341
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbhKYXWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 18:22:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:26585 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347032AbhKYXUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 18:20:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="259478083"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="259478083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 15:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="539083094"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2021 15:14:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqNx8-00073n-R8; Thu, 25 Nov 2021 23:14:54 +0000
Date:   Fri, 26 Nov 2021 07:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gang Li <ligang.bdlg@bytedance.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Gang Li <ligang.bdlg@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] shmem: change shrinklist_lock form spinlock to mutex
 and move iput into it
Message-ID: <202111260701.YxF96BC5-lkp@intel.com>
References: <20211122064126.76734-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122064126.76734-1-ligang.bdlg@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on linux/master linus/master v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gang-Li/shmem-change-shrinklist_lock-form-spinlock-to-mutex-and-move-iput-into-it/20211122-144228
base:   https://github.com/hnaz/linux-mm master
config: i386-randconfig-m021-20211124 (https://download.01.org/0day-ci/archive/20211126/202111260701.YxF96BC5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
mm/shmem.c:1139 shmem_evict_inode() warn: inconsistent indenting

vim +1139 mm/shmem.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  1127  
1f895f75dc0881 Al Viro            2010-06-05  1128  static void shmem_evict_inode(struct inode *inode)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1129  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1130  	struct shmem_inode_info *info = SHMEM_I(inode);
779750d20b93bb Kirill A. Shutemov 2016-07-26  1131  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1132  
30e6a51dbb0594 Hui Su             2020-12-14  1133  	if (shmem_mapping(inode->i_mapping)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1134  		shmem_unacct_size(info->flags, inode->i_size);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1135  		inode->i_size = 0;
3889e6e76f66b7 Nicholas Piggin    2010-05-27  1136  		shmem_truncate_range(inode, 0, (loff_t)-1);
779750d20b93bb Kirill A. Shutemov 2016-07-26  1137  		if (!list_empty(&info->shrinklist)) {
713e6a98816b68 Gang Li            2021-11-22  1138  		    mutex_lock(&sbinfo->shrinklist_mutex);
779750d20b93bb Kirill A. Shutemov 2016-07-26 @1139  			if (!list_empty(&info->shrinklist)) {
779750d20b93bb Kirill A. Shutemov 2016-07-26  1140  				list_del_init(&info->shrinklist);
779750d20b93bb Kirill A. Shutemov 2016-07-26  1141  				sbinfo->shrinklist_len--;
779750d20b93bb Kirill A. Shutemov 2016-07-26  1142  			}
713e6a98816b68 Gang Li            2021-11-22  1143  		    mutex_unlock(&sbinfo->shrinklist_mutex);
779750d20b93bb Kirill A. Shutemov 2016-07-26  1144  		}
af53d3e9e04024 Hugh Dickins       2019-04-18  1145  		while (!list_empty(&info->swaplist)) {
af53d3e9e04024 Hugh Dickins       2019-04-18  1146  			/* Wait while shmem_unuse() is scanning this inode... */
af53d3e9e04024 Hugh Dickins       2019-04-18  1147  			wait_var_event(&info->stop_eviction,
af53d3e9e04024 Hugh Dickins       2019-04-18  1148  				       !atomic_read(&info->stop_eviction));
cb5f7b9a47963d Hugh Dickins       2008-02-04  1149  			mutex_lock(&shmem_swaplist_mutex);
af53d3e9e04024 Hugh Dickins       2019-04-18  1150  			/* ...but beware of the race if we peeked too early */
af53d3e9e04024 Hugh Dickins       2019-04-18  1151  			if (!atomic_read(&info->stop_eviction))
^1da177e4c3f41 Linus Torvalds     2005-04-16  1152  				list_del_init(&info->swaplist);
cb5f7b9a47963d Hugh Dickins       2008-02-04  1153  			mutex_unlock(&shmem_swaplist_mutex);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1154  		}
3ed47db34f480d Al Viro            2016-01-22  1155  	}
b09e0fa4b4ea66 Eric Paris         2011-05-24  1156  
38f38657444d15 Aristeu Rozanski   2012-08-23  1157  	simple_xattrs_free(&info->xattrs);
0f3c42f522dc1a Hugh Dickins       2012-11-16  1158  	WARN_ON(inode->i_blocks);
5b04c6890f0dc7 Pavel Emelyanov    2008-02-04  1159  	shmem_free_inode(inode->i_sb);
dbd5768f87ff6f Jan Kara           2012-05-03  1160  	clear_inode(inode);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1161  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1162  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
