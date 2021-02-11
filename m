Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5599318D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBKOVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:21:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:9992 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhBKOGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:06:06 -0500
IronPort-SDR: l0E2D9DR7A7y7PwCSE8Gk2d+MRvINFuEJyQ2ndelzWZgOAMTCWWz994dniKuDyDbmvGVu9t4I8
 fvJg6dbTbOYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="181467674"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="gz'50?scan'50,208,50";a="181467674"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 06:04:50 -0800
IronPort-SDR: sfuDotcc5HCWk2T4FE/wG32ydP8mrofa5MOXf/ecWHen4nQnbjGc98oyV7s5e3l7QPGhNRDDel
 tlB1xVCDvWYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="gz'50?scan'50,208,50";a="437124224"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2021 06:04:48 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lACaM-0003pQ-Vh; Thu, 11 Feb 2021 14:04:46 +0000
Date:   Thu, 11 Feb 2021 22:03:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/media/common/videobuf2/videobuf2-dma-contig.c:509:5: error:
 implicit declaration of function '__pfn_to_phys'
Message-ID: <202102112238.87CWG6bY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
commit: 4bfc848e0981fcd35db00fe1c6581560689f6dc7 m68k/mm: enable use of generic memory_model.h for !DISCONTIGMEM
date:   8 weeks ago
config: m68k-randconfig-r021-20210211 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bfc848e0981fcd35db00fe1c6581560689f6dc7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4bfc848e0981fcd35db00fe1c6581560689f6dc7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/common/videobuf2/videobuf2-dma-contig.c: In function 'vb2_dc_get_userptr':
>> drivers/media/common/videobuf2/videobuf2-dma-contig.c:509:5: error: implicit declaration of function '__pfn_to_phys' [-Werror=implicit-function-declaration]
     509 |     __pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
         |     ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__pfn_to_phys +509 drivers/media/common/videobuf2/videobuf2-dma-contig.c

e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  455  
36c0f8b32c4bd4 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2016-04-15  456  static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
cd474037c4a9a9 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  457  	unsigned long size, enum dma_data_direction dma_dir)
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  458  {
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  459  	struct vb2_dc_buf *buf;
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  460  	struct frame_vector *vec;
c4860ad6056483 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tvrtko Ursulin      2017-07-31  461  	unsigned int offset;
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  462  	int n_pages, i;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  463  	int ret = 0;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  464  	struct sg_table *sgt;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  465  	unsigned long contig_size;
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  466  	unsigned long dma_align = dma_get_cache_alignment();
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  467  
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  468  	/* Only cache aligned DMA transfers are reliable */
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  469  	if (!IS_ALIGNED(vaddr | size, dma_align)) {
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  470  		pr_debug("user data must be aligned to %lu bytes\n", dma_align);
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  471  		return ERR_PTR(-EINVAL);
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  472  	}
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  473  
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  474  	if (!size) {
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  475  		pr_debug("size is zero\n");
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  476  		return ERR_PTR(-EINVAL);
d81e870d5afa1b drivers/media/v4l2-core/videobuf2-dma-contig.c        Marek Szyprowski    2012-06-12  477  	}
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  478  
10791829eb52d5 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2016-07-21  479  	if (WARN_ON(!dev))
10791829eb52d5 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2016-07-21  480  		return ERR_PTR(-EINVAL);
10791829eb52d5 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2016-07-21  481  
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  482  	buf = kzalloc(sizeof *buf, GFP_KERNEL);
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  483  	if (!buf)
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  484  		return ERR_PTR(-ENOMEM);
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  485  
36c0f8b32c4bd4 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2016-04-15  486  	buf->dev = dev;
cd474037c4a9a9 drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  487  	buf->dma_dir = dma_dir;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  488  
c4860ad6056483 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tvrtko Ursulin      2017-07-31  489  	offset = lower_32_bits(offset_in_page(vaddr));
707947247e9517 drivers/media/common/videobuf2/videobuf2-dma-contig.c Hans Verkuil        2019-04-04  490  	vec = vb2_create_framevec(vaddr, size);
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  491  	if (IS_ERR(vec)) {
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  492  		ret = PTR_ERR(vec);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  493  		goto fail_buf;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  494  	}
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  495  	buf->vec = vec;
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  496  	n_pages = frame_vector_count(vec);
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  497  	ret = frame_vector_to_pages(vec);
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  498  	if (ret < 0) {
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  499  		unsigned long *nums = frame_vector_pfns(vec);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  500  
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  501  		/*
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  502  		 * Failed to convert to pages... Check the memory is physically
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  503  		 * contiguous and use direct mapping
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  504  		 */
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  505  		for (i = 1; i < n_pages; i++)
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  506  			if (nums[i-1] + 1 != nums[i])
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  507  				goto fail_pfnvec;
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04  508  		buf->dma_addr = dma_map_resource(buf->dev,
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04 @509  				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04  510  		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04  511  			ret = -ENOMEM;
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04  512  			goto fail_pfnvec;
55ea54441fb3b6 drivers/media/common/videobuf2/videobuf2-dma-contig.c Christoph Hellwig   2019-01-04  513  		}
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  514  		goto out;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  515  	}
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  516  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  517  	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  518  	if (!sgt) {
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  519  		pr_err("failed to allocate sg table\n");
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  520  		ret = -ENOMEM;
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  521  		goto fail_pfnvec;
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  522  	}
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  523  
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  524  	ret = sg_alloc_table_from_pages(sgt, frame_vector_pages(vec), n_pages,
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  525  		offset, size, GFP_KERNEL);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  526  	if (ret) {
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  527  		pr_err("failed to initialize sg table\n");
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  528  		goto fail_sgt;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  529  	}
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  530  
251a79f8f5adfd drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  531  	/*
251a79f8f5adfd drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  532  	 * No need to sync to the device, this will happen later when the
251a79f8f5adfd drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  533  	 * prepare() memop is called.
251a79f8f5adfd drivers/media/v4l2-core/videobuf2-dma-contig.c        Hans Verkuil        2014-11-18  534  	 */
8b7c0280ab03dd drivers/media/common/videobuf2/videobuf2-dma-contig.c Marek Szyprowski    2020-09-04  535  	if (dma_map_sgtable(buf->dev, sgt, buf->dma_dir,
8b7c0280ab03dd drivers/media/common/videobuf2/videobuf2-dma-contig.c Marek Szyprowski    2020-09-04  536  			    DMA_ATTR_SKIP_CPU_SYNC)) {
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  537  		pr_err("failed to map scatterlist\n");
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  538  		ret = -EIO;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  539  		goto fail_sgt_init;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  540  	}
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  541  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  542  	contig_size = vb2_dc_get_contiguous_size(sgt);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  543  	if (contig_size < size) {
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  544  		pr_err("contiguous mapping is too small %lu/%lu\n",
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  545  			contig_size, size);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  546  		ret = -EFAULT;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  547  		goto fail_map_sg;
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  548  	}
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  549  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  550  	buf->dma_addr = sg_dma_address(sgt->sgl);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  551  	buf->dma_sgt = sgt;
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  552  out:
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  553  	buf->size = size;
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  554  
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  555  	return buf;
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  556  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  557  fail_map_sg:
8b7c0280ab03dd drivers/media/common/videobuf2/videobuf2-dma-contig.c Marek Szyprowski    2020-09-04  558  	dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  559  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  560  fail_sgt_init:
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  561  	sg_free_table(sgt);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  562  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  563  fail_sgt:
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  564  	kfree(sgt);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  565  
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  566  fail_pfnvec:
fb639eb3915431 drivers/media/v4l2-core/videobuf2-dma-contig.c        Jan Kara            2015-07-13  567  	vb2_destroy_framevec(vec);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  568  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  569  fail_buf:
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  570  	kfree(buf);
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  571  
e15dab752d4c58 drivers/media/v4l2-core/videobuf2-dma-contig.c        Tomasz Stanislawski 2012-06-14  572  	return ERR_PTR(ret);
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  573  }
1a758d4e847f77 drivers/media/video/videobuf2-dma-contig.c            Pawel Osciak        2010-10-11  574  

:::::: The code at line 509 was first introduced by commit
:::::: 55ea54441fb3b6532d5d32417911ff5a10750903 videobuf2: replace a layering violation with dma_map_resource

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vtzGhvizbBRQ85DL--
