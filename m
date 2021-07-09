Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD503C27D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGIQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:59:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:7714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIQ7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:59:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295374807"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="gz'50?scan'50,208,50";a="295374807"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 09:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="gz'50?scan'50,208,50";a="628908098"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2021 09:56:47 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1tny-000Ez9-Vh; Fri, 09 Jul 2021 16:56:46 +0000
Date:   Sat, 10 Jul 2021 00:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hch-misc:um-set_fs 1/1] arch/um/include/asm/uaccess.h:53:19: error:
 implicit declaration of function 'get_unaligned'; did you mean
 'get_cmdline'?
Message-ID: <202107100031.j6juKfkU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.infradead.org/users/hch/misc.git um-set_fs
head:   969a5fb627a0faf0402f8b7e211e1a6398b73736
commit: 969a5fb627a0faf0402f8b7e211e1a6398b73736 [1/1] um: remove set_fs
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add hch-misc git://git.infradead.org/users/hch/misc.git
        git fetch --no-tags hch-misc um-set_fs
        git checkout 969a5fb627a0faf0402f8b7e211e1a6398b73736
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:725,
                    from mm/maccess.c:6:
   mm/maccess.c: In function 'copy_from_kernel_nofault':
>> arch/um/include/asm/uaccess.h:53:19: error: implicit declaration of function 'get_unaligned'; did you mean 'get_cmdline'? [-Werror=implicit-function-declaration]
      53 |  *((type *)dst) = get_unaligned((type *)(src));   \
         |                   ^~~~~~~~~~~~~
   mm/maccess.c:19:3: note: in expansion of macro '__get_kernel_nofault'
      19 |   __get_kernel_nofault(dst, src, type, err_label);  \
         |   ^~~~~~~~~~~~~~~~~~~~
   mm/maccess.c:31:2: note: in expansion of macro 'copy_from_kernel_nofault_loop'
      31 |  copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/maccess.c: In function 'copy_to_kernel_nofault':
>> arch/um/include/asm/uaccess.h:60:2: error: implicit declaration of function 'put_unaligned' [-Werror=implicit-function-declaration]
      60 |  put_unaligned(*((type *)src), (type *)(dst));   \
         |  ^~~~~~~~~~~~~
   mm/maccess.c:45:3: note: in expansion of macro '__put_kernel_nofault'
      45 |   __put_kernel_nofault(dst, src, type, err_label);  \
         |   ^~~~~~~~~~~~~~~~~~~~
   mm/maccess.c:54:2: note: in expansion of macro 'copy_to_kernel_nofault_loop'
      54 |  copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +53 arch/um/include/asm/uaccess.h

    50	
    51	#define __get_kernel_nofault(dst, src, type, err_label)			\
    52	do {									\
  > 53		*((type *)dst) = get_unaligned((type *)(src));			\
    54		if (0) /* make sure the label looks used to the compiler */	\
    55			goto err_label;						\
    56	} while (0)
    57	
    58	#define __put_kernel_nofault(dst, src, type, err_label)			\
    59	do {									\
  > 60		put_unaligned(*((type *)src), (type *)(dst));			\
    61		if (0) /* make sure the label looks used to the compiler */	\
    62			goto err_label;						\
    63	} while (0)
    64	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--envbJBWh7q8WU6mo--
