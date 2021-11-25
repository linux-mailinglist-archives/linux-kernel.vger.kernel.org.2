Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4A45D9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348247AbhKYMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:13:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:35732 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240059AbhKYMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:11:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222375672"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222375672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 04:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457845823"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 04:08:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqDYI-0006Jf-IR; Thu, 25 Nov 2021 12:08:34 +0000
Date:   Thu, 25 Nov 2021 20:07:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] virtio-mmio: harden interrupt
Message-ID: <202111252001.Z5tli1Np-lkp@intel.com>
References: <20211125063034.12347-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125063034.12347-1-jasowang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5f53fa508db098c9d372423a6dac31c8a5679cdf
config: mips-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111252001.Z5tli1Np-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/e19a8a1a95bd891090863b2d6828b8dc55d3633f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
        git checkout e19a8a1a95bd891090863b2d6828b8dc55d3633f
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_mmio.c:105:6: warning: no previous prototype for function 'vm_disable_cbs' [-Wmissing-prototypes]
   void vm_disable_cbs(struct virtio_device *vdev)
        ^
   drivers/virtio/virtio_mmio.c:105:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vm_disable_cbs(struct virtio_device *vdev)
   ^
   static 
>> drivers/virtio/virtio_mmio.c:121:6: warning: no previous prototype for function 'vm_enable_cbs' [-Wmissing-prototypes]
   void vm_enable_cbs(struct virtio_device *vdev)
        ^
   drivers/virtio/virtio_mmio.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vm_enable_cbs(struct virtio_device *vdev)
   ^
   static 
   2 warnings generated.


vim +/vm_disable_cbs +105 drivers/virtio/virtio_mmio.c

   103	
   104	/* disable irq handlers */
 > 105	void vm_disable_cbs(struct virtio_device *vdev)
   106	{
   107		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
   108		int irq = platform_get_irq(vm_dev->pdev, 0);
   109	
   110		/*
   111		 * The below synchronize() guarantees that any
   112		 * interrupt for this line arriving after
   113		 * synchronize_irq() has completed is guaranteed to see
   114		 * intx_soft_enabled == false.
   115		 */
   116		WRITE_ONCE(vm_dev->intr_soft_enabled, false);
   117		synchronize_irq(irq);
   118	}
   119	
   120	/* enable irq handlers */
 > 121	void vm_enable_cbs(struct virtio_device *vdev)
   122	{
   123		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
   124		int irq = platform_get_irq(vm_dev->pdev, 0);
   125	
   126		disable_irq(irq);
   127		/*
   128		 * The above disable_irq() provides TSO ordering and
   129		 * as such promotes the below store to store-release.
   130		 */
   131		WRITE_ONCE(vm_dev->intr_soft_enabled, true);
   132		enable_irq(irq);
   133		return;
   134	}
   135	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
