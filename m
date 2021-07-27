Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BF3D7483
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhG0LnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:43:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:32496 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236518AbhG0LnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:43:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="273504162"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="gz'50?scan'50,208,50";a="273504162"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 04:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="gz'50?scan'50,208,50";a="498770389"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 04:43:21 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8LUX-0006ky-2g; Tue, 27 Jul 2021 11:43:21 +0000
Date:   Tue, 27 Jul 2021 19:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hch-misc:dax-support-cleanups 2/10] drivers/dax/super.c:168:6:
 error: redefinition of 'bdev_dax_supported'
Message-ID: <202107271901.Ghnnw1tF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.infradead.org/users/hch/misc.git dax-support-cleanups
head:   37a8092dc083090f4fbd6a7699561dd959f1e2b8
commit: c9ee3712f2faa1229ec35bc62c0e34c9a81a3589 [2/10] dax: rename __bdev_dax_supported to bdev_dax_supported
config: powerpc64-randconfig-s032-20210727 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        git remote add hch-misc git://git.infradead.org/users/hch/misc.git
        git fetch --no-tags hch-misc dax-support-cleanups
        git checkout c9ee3712f2faa1229ec35bc62c0e34c9a81a3589
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dax/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dax/super.c:70:6: warning: no previous prototype for '__generic_fsdax_supported' [-Wmissing-prototypes]
      70 | bool __generic_fsdax_supported(struct dax_device *dax_dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dax/super.c:168:6: error: redefinition of 'bdev_dax_supported'
     168 | bool bdev_dax_supported(struct block_device *bdev, int blocksize)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from drivers/dax/super.c:16:
   include/linux/dax.h:151:20: note: previous definition of 'bdev_dax_supported' was here
     151 | static inline bool bdev_dax_supported(struct block_device *bdev,
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/dax/super.c:449:6: warning: no previous prototype for 'run_dax' [-Wmissing-prototypes]
     449 | void run_dax(struct dax_device *dax_dev)
         |      ^~~~~~~


vim +/bdev_dax_supported +168 drivers/dax/super.c

    69	
  > 70	bool __generic_fsdax_supported(struct dax_device *dax_dev,
    71			struct block_device *bdev, int blocksize, sector_t start,
    72			sector_t sectors)
    73	{
    74		bool dax_enabled = false;
    75		pgoff_t pgoff, pgoff_end;
    76		char buf[BDEVNAME_SIZE];
    77		void *kaddr, *end_kaddr;
    78		pfn_t pfn, end_pfn;
    79		sector_t last_page;
    80		long len, len2;
    81		int err, id;
    82	
    83		if (blocksize != PAGE_SIZE) {
    84			pr_info("%s: error: unsupported blocksize for dax\n",
    85					bdevname(bdev, buf));
    86			return false;
    87		}
    88	
    89		if (!dax_dev) {
    90			pr_debug("%s: error: dax unsupported by block device\n",
    91					bdevname(bdev, buf));
    92			return false;
    93		}
    94	
    95		err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
    96		if (err) {
    97			pr_info("%s: error: unaligned partition for dax\n",
    98					bdevname(bdev, buf));
    99			return false;
   100		}
   101	
   102		last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
   103		err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
   104		if (err) {
   105			pr_info("%s: error: unaligned partition for dax\n",
   106					bdevname(bdev, buf));
   107			return false;
   108		}
   109	
   110		id = dax_read_lock();
   111		len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
   112		len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
   113	
   114		if (len < 1 || len2 < 1) {
   115			pr_info("%s: error: dax access failed (%ld)\n",
   116					bdevname(bdev, buf), len < 1 ? len : len2);
   117			dax_read_unlock(id);
   118			return false;
   119		}
   120	
   121		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED) && pfn_t_special(pfn)) {
   122			/*
   123			 * An arch that has enabled the pmem api should also
   124			 * have its drivers support pfn_t_devmap()
   125			 *
   126			 * This is a developer warning and should not trigger in
   127			 * production. dax_flush() will crash since it depends
   128			 * on being able to do (page_address(pfn_to_page())).
   129			 */
   130			WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
   131			dax_enabled = true;
   132		} else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
   133			struct dev_pagemap *pgmap, *end_pgmap;
   134	
   135			pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
   136			end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
   137			if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
   138					&& pfn_t_to_page(pfn)->pgmap == pgmap
   139					&& pfn_t_to_page(end_pfn)->pgmap == pgmap
   140					&& pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
   141					&& pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))
   142				dax_enabled = true;
   143			put_dev_pagemap(pgmap);
   144			put_dev_pagemap(end_pgmap);
   145	
   146		}
   147		dax_read_unlock(id);
   148	
   149		if (!dax_enabled) {
   150			pr_info("%s: error: dax support not enabled\n",
   151					bdevname(bdev, buf));
   152			return false;
   153		}
   154		return true;
   155	}
   156	EXPORT_SYMBOL_GPL(__generic_fsdax_supported);
   157	
   158	/**
   159	 * bdev_dax_supported() - Check if the device supports dax for filesystem
   160	 * @bdev: block device to check
   161	 * @blocksize: The block size of the device
   162	 *
   163	 * This is a library function for filesystems to check if the block device
   164	 * can be mounted with dax option.
   165	 *
   166	 * Return: true if supported, false if unsupported
   167	 */
 > 168	bool bdev_dax_supported(struct block_device *bdev, int blocksize)
   169	{
   170		struct dax_device *dax_dev;
   171		struct request_queue *q;
   172		bool ret;
   173		int id;
   174	
   175		q = bdev_get_queue(bdev);
   176		if (!q || !blk_queue_dax(q)) {
   177			pr_info("%pg: error: request queue doesn't support dax\n", bdev);
   178			return false;
   179		}
   180	
   181		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
   182		if (!dax_dev) {
   183			pr_info("%pg: error: device does not support dax\n", bdev);
   184			return false;
   185		}
   186	
   187		id = dax_read_lock();
   188		ret = dax_supported(dax_dev, bdev, blocksize, 0,
   189				i_size_read(bdev->bd_inode) / 512);
   190		dax_read_unlock(id);
   191	
   192		put_dax(dax_dev);
   193	
   194		return ret;
   195	}
   196	EXPORT_SYMBOL_GPL(bdev_dax_supported);
   197	#endif
   198	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/T9PLZyw9Z0BAA==

--LQksG6bCIzRHxTLp--
