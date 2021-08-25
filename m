Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39023F7375
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhHYKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:39:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:17016 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237638AbhHYKjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:39:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197739350"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="197739350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 03:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="598008430"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2021 03:38:51 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIqJ0-00004r-JN; Wed, 25 Aug 2021 10:38:50 +0000
Date:   Wed, 25 Aug 2021 18:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Kim <brian.kim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        memeka <mihailescu2m@gmail.com>, Yang Deokgyu <secugyu@gmail.com>
Subject: [tobetter-linux:odroid-5.14.y 21/68]
 drivers/char/exynos-gpiomem.c:121:22: error: incompatible types when
 assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
Message-ID: <202108251854.nxLmZNMS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/tobetter/linux odroid-5.14.y
head:   62bd983c27712ddb2dccb2efe9cdc3a086daf8e0
commit: 7b9acbf68d2938b1533c176b4bdd7becdb40bfc1 [21/68] ODROID-XU4: char: exynos: add /dev/gpiomem device for rootless user GPIO access
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/tobetter/linux/commit/7b9acbf68d2938b1533c176b4bdd7becdb40bfc1
        git remote add tobetter-linux https://github.com/tobetter/linux
        git fetch --no-tags tobetter-linux odroid-5.14.y
        git checkout 7b9acbf68d2938b1533c176b4bdd7becdb40bfc1
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/char/exynos-gpiomem.c: In function 'exynos_gpiomem_mmap':
   drivers/char/exynos-gpiomem.c:121:22: error: implicit declaration of function 'phys_mem_access_prot'; did you mean 'phys_mem_access_prot_allowed'? [-Werror=implicit-function-declaration]
     121 |  vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
         |                      ^~~~~~~~~~~~~~~~~~~~
         |                      phys_mem_access_prot_allowed
>> drivers/char/exynos-gpiomem.c:121:22: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
   cc1: some warnings being treated as errors


vim +121 drivers/char/exynos-gpiomem.c

   106	
   107	static int exynos_gpiomem_mmap(struct file *file, struct vm_area_struct *vma)
   108	{
   109		int gpio_area = 0;
   110	
   111		while (gpio_area < inst->gpio_area_count) {
   112			if ((inst->gpio_regs_phys[gpio_area] >> PAGE_SHIFT) == vma->vm_pgoff)
   113				goto found;
   114	
   115			gpio_area++;
   116		}
   117	
   118		return -EACCES;
   119	
   120	found:
 > 121		vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
   122				PAGE_SIZE,
   123				vma->vm_page_prot);
   124	
   125		vma->vm_ops = &exynos_gpiomem_vm_ops;
   126	
   127		if (remap_pfn_range(vma, vma->vm_start,
   128					vma->vm_pgoff,
   129					PAGE_SIZE,
   130					vma->vm_page_prot)) {
   131			return -EAGAIN;
   132		}
   133	
   134		return 0;
   135	}
   136	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--FCuugMFkClbJLl1L--
