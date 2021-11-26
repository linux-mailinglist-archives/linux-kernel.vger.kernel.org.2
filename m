Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B145F5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhKZUKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:10:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:49344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhKZUI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:08:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235532589"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="235532589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 12:05:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="498536055"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 12:05:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqhT8-0008X3-6M; Fri, 26 Nov 2021 20:05:14 +0000
Date:   Sat, 27 Nov 2021 04:04:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 3/9]
 drivers/iommu/iommufd/io_pagetable.c:1155:13: sparse: sparse: incompatible
 types in comparison expression (different type sizes):
Message-ID: <202111270410.Hg2WjX0B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   20622aca716f08225b705a8c84a2beeb8c71decb
commit: 3e99bfe1e6898207226254c9c3663804f72e4c75 [3/9] iommufd: Data structure to provide IOVA to PFN mapping
config: arm-randconfig-s031-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270410.Hg2WjX0B-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jgunthorpe/linux/commit/3e99bfe1e6898207226254c9c3663804f72e4c75
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 3e99bfe1e6898207226254c9c3663804f72e4c75
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommufd/io_pagetable.c:1155:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> drivers/iommu/iommufd/io_pagetable.c:1155:13: sparse:    unsigned int *
>> drivers/iommu/iommufd/io_pagetable.c:1155:13: sparse:    unsigned long *
   drivers/iommu/iommufd/io_pagetable.c:1156:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
   drivers/iommu/iommufd/io_pagetable.c:1156:13: sparse:    unsigned long *
   drivers/iommu/iommufd/io_pagetable.c:1156:13: sparse:    unsigned int *
   drivers/iommu/iommufd/io_pagetable.c:1211:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
   drivers/iommu/iommufd/io_pagetable.c:1211:13: sparse:    unsigned int *
   drivers/iommu/iommufd/io_pagetable.c:1211:13: sparse:    unsigned long *
   drivers/iommu/iommufd/io_pagetable.c:1212:13: sparse: sparse: incompatible types in comparison expression (different type sizes):
   drivers/iommu/iommufd/io_pagetable.c:1212:13: sparse:    unsigned long *
   drivers/iommu/iommufd/io_pagetable.c:1212:13: sparse:    unsigned int *

vim +1155 drivers/iommu/iommufd/io_pagetable.c

  1131	
  1132	/**
  1133	* iopt_access_pages - Return a list of pages under the iova
  1134	*
  1135	* Reads @npages starting at iova and returns the struct page * pointers. These
  1136	* can be kmap'd by the caller for CPU access.
  1137	*
  1138	* The caller must perform iopt_unaccess_pages() when done to balance this.
  1139	*
  1140	* CHECKME: callers that need a DMA mapping via a sgl should create another
  1141	* interface to build the SGL efficiently)
  1142	*/
  1143	int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
  1144			      size_t npages, struct page **out_pages, bool write)
  1145	{
  1146		unsigned long cur_iova;
  1147		unsigned long iova_end;
  1148		struct iopt_area *area;
  1149		size_t length;
  1150		int rc;
  1151	
  1152		down_read(&iopt->rwsem);
  1153		if (!npages || iova % PAGE_SIZE)
  1154			return -EINVAL;
> 1155		if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
  1156		    check_add_overflow(iova, length - 1, &iova_end))
  1157			return -EOVERFLOW;
  1158	
  1159		cur_iova = iova;
  1160		for (area = iopt_area_iter_first(iopt, iova, iova_end); area;
  1161		     area = iopt_area_iter_next(area, iova, iova_end)) {
  1162			unsigned long intr_start = max(iova, iopt_area_iova(area));
  1163			unsigned long intr_end =
  1164				min(iova_end, iopt_area_last_iova(area));
  1165			size_t npages = (intr_end - intr_start + 1) / PAGE_SIZE;
  1166	
  1167			/* Need contiguous areas un the access */
  1168			if (cur_iova != intr_start) {
  1169				rc = -EINVAL;
  1170				goto out_remove;
  1171			}
  1172	
  1173			npages = (intr_end - intr_start + 1) / PAGE_SIZE;
  1174			rc = iopt_pages_add_user(
  1175				area->pages,
  1176				(intr_start - iopt_area_iova(area)) / PAGE_SIZE, npages,
  1177				out_pages + (intr_end - iopt_area_iova(area) + 1) /
  1178						    PAGE_SIZE,
  1179				write);
  1180			if (rc)
  1181				goto out_remove;
  1182			cur_iova += npages * PAGE_SIZE;
  1183			atomic_inc(&area->num_users);
  1184		}
  1185	
  1186		up_read(&iopt->rwsem);
  1187		return 0;
  1188	
  1189	out_remove:
  1190		iopt_unaccess_pages(iopt, iova, (cur_iova - iova) / PAGE_SIZE);
  1191		return rc;
  1192	}
  1193	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
