Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB745F77A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 01:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbhK0Aji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 19:39:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:24536 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343788AbhK0Ahh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 19:37:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321961942"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="321961942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 16:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="572454825"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2021 16:34:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqlfZ-0008pL-Nj; Sat, 27 Nov 2021 00:34:21 +0000
Date:   Sat, 27 Nov 2021 08:33:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 3/9]
 drivers/iommu/iommufd/io_pagetable.c:1155:6: warning: comparison of distinct
 pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL
 << 16)) *' (aka 'unsigned long *'))
Message-ID: <202111270838.oY7LmFOc-lkp@intel.com>
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
config: hexagon-randconfig-r004-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270838.oY7LmFOc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/3e99bfe1e6898207226254c9c3663804f72e4c75
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 3e99bfe1e6898207226254c9c3663804f72e4c75
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/io_pagetable.c:1155:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:1156:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:1155:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:1156:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:1155:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
>> drivers/iommu/iommufd/io_pagetable.c:1156:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1211:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1212:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1211:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1212:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1211:6: warning: comparison of distinct pointer types ('typeof (npages) *' (aka 'unsigned int *') and 'typeof ((1UL << 16)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           if (check_mul_overflow(npages, PAGE_SIZE, &length) ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:84:15: note: expanded from macro 'check_mul_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/iommu/iommufd/io_pagetable.c:1212:6: warning: comparison of distinct pointer types ('typeof (iova) *' (aka 'unsigned long *') and 'typeof (length - 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
               check_add_overflow(iova, length - 1, &iova_end))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:66:15: note: expanded from macro 'check_add_overflow'
           (void) (&__a == &__b);                  \
                   ~~~~ ^  ~~~~
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   12 warnings generated.


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
> 1156		    check_add_overflow(iova, length - 1, &iova_end))
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
