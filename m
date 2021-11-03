Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38E443F05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhKCJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:14:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:55530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhKCJN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:13:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="231712139"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="gz'50?scan'50,208,50";a="231712139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 02:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="gz'50?scan'50,208,50";a="531855932"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2021 02:11:17 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miCIe-0005QH-ML; Wed, 03 Nov 2021 09:11:16 +0000
Date:   Wed, 3 Nov 2021 17:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Kim <brian.kim@hardkernel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        memeka <mihailescu2m@gmail.com>, Yang Deokgyu <secugyu@gmail.com>
Subject: [tobetter:odroid-5.15.y 21/74] drivers/char/exynos-gpiomem.c:121:22:
 error: incompatible types when assigning to type 'pgprot_t' {aka 'struct
 <anonymous>'} from type 'int'
Message-ID: <202111031707.MeWNNLUq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/tobetter/linux odroid-5.15.y
head:   bcf324ec70af843cc1e6a88e67a8b7f44c4739bb
commit: 61f45d975621becb00c0aef303769f10428b9cd8 [21/74] ODROID-XU4: char: exynos: add /dev/gpiomem device for rootless user GPIO access
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/tobetter/linux/commit/61f45d975621becb00c0aef303769f10428b9cd8
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.15.y
        git checkout 61f45d975621becb00c0aef303769f10428b9cd8
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

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--NzB8fVQJ5HfG6fxh--
