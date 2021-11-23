Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20645AF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhKWWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:44:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:52910 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238420AbhKWWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:44:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="259028222"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="259028222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 14:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="606988043"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2021 14:40:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpeT8-0002Ny-Ae; Tue, 23 Nov 2021 22:40:54 +0000
Date:   Wed, 24 Nov 2021 06:40:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     kbuild-all@lists.01.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com
Subject: Re: [PATCH 9/9] iommu: Move flush queue data into iommu_dma_cookie
Message-ID: <202111240645.30neUyaq-lkp@intel.com>
References: <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on v5.16-rc2 next-20211123]
[cannot apply to tegra-drm/drm/tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Robin-Murphy/iommu-Refactor-flush-queues-into-iommu-dma/20211123-221220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211124/202111240645.30neUyaq-lkp@intel.com/config.gz)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d4623bb02366503fa7c3805228fa9534c9490d20
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Robin-Murphy/iommu-Refactor-flush-queues-into-iommu-dma/20211123-221220
        git checkout d4623bb02366503fa7c3805228fa9534c9490d20
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tegra/vic.c: In function 'vic_exit':
   drivers/gpu/drm/tegra/vic.c:196:17: error: implicit declaration of function 'dma_unmap_single'; did you mean 'mount_single'? [-Werror=implicit-function-declaration]
     196 |                 dma_unmap_single(vic->dev, vic->falcon.firmware.phys,
         |                 ^~~~~~~~~~~~~~~~
         |                 mount_single
   drivers/gpu/drm/tegra/vic.c:197:61: error: 'DMA_TO_DEVICE' undeclared (first use in this function); did you mean 'MT_DEVICE'?
     197 |                                  vic->falcon.firmware.size, DMA_TO_DEVICE);
         |                                                             ^~~~~~~~~~~~~
         |                                                             MT_DEVICE
   drivers/gpu/drm/tegra/vic.c:197:61: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/tegra/vic.c:202:17: error: implicit declaration of function 'dma_free_coherent' [-Werror=implicit-function-declaration]
     202 |                 dma_free_coherent(vic->dev, vic->falcon.firmware.size,
         |                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/vic.c: In function 'vic_load_firmware':
   drivers/gpu/drm/tegra/vic.c:234:24: error: implicit declaration of function 'dma_alloc_coherent' [-Werror=implicit-function-declaration]
     234 |                 virt = dma_alloc_coherent(vic->dev, size, &iova, GFP_KERNEL);
         |                        ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tegra/vic.c:234:22: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     234 |                 virt = dma_alloc_coherent(vic->dev, size, &iova, GFP_KERNEL);
         |                      ^
   drivers/gpu/drm/tegra/vic.c:236:23: error: implicit declaration of function 'dma_mapping_error' [-Werror=implicit-function-declaration]
     236 |                 err = dma_mapping_error(vic->dev, iova);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/vic.c:258:24: error: implicit declaration of function 'dma_map_single' [-Werror=implicit-function-declaration]
     258 |                 phys = dma_map_single(vic->dev, virt, size, DMA_TO_DEVICE);
         |                        ^~~~~~~~~~~~~~
   drivers/gpu/drm/tegra/vic.c:258:61: error: 'DMA_TO_DEVICE' undeclared (first use in this function); did you mean 'MT_DEVICE'?
     258 |                 phys = dma_map_single(vic->dev, virt, size, DMA_TO_DEVICE);
         |                                                             ^~~~~~~~~~~~~
         |                                                             MT_DEVICE
   drivers/gpu/drm/tegra/vic.c: In function 'vic_probe':
   drivers/gpu/drm/tegra/vic.c:412:15: error: implicit declaration of function 'dma_coerce_mask_and_coherent' [-Werror=implicit-function-declaration]
     412 |         err = dma_coerce_mask_and_coherent(dev, *dev->parent->dma_mask);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +234 drivers/gpu/drm/tegra/vic.c

0ae797a8ba05a2 Arto Merilainen 2016-12-14  214  
77a0b09dd993c8 Thierry Reding  2019-02-01  215  static int vic_load_firmware(struct vic *vic)
77a0b09dd993c8 Thierry Reding  2019-02-01  216  {
20e7dce255e96a Thierry Reding  2019-10-28  217  	struct host1x_client *client = &vic->client.base;
20e7dce255e96a Thierry Reding  2019-10-28  218  	struct tegra_drm *tegra = vic->client.drm;
d972d624762805 Thierry Reding  2019-10-28  219  	dma_addr_t iova;
20e7dce255e96a Thierry Reding  2019-10-28  220  	size_t size;
20e7dce255e96a Thierry Reding  2019-10-28  221  	void *virt;
77a0b09dd993c8 Thierry Reding  2019-02-01  222  	int err;
77a0b09dd993c8 Thierry Reding  2019-02-01  223  
d972d624762805 Thierry Reding  2019-10-28  224  	if (vic->falcon.firmware.virt)
77a0b09dd993c8 Thierry Reding  2019-02-01  225  		return 0;
77a0b09dd993c8 Thierry Reding  2019-02-01  226  
77a0b09dd993c8 Thierry Reding  2019-02-01  227  	err = falcon_read_firmware(&vic->falcon, vic->config->firmware);
77a0b09dd993c8 Thierry Reding  2019-02-01  228  	if (err < 0)
20e7dce255e96a Thierry Reding  2019-10-28  229  		return err;
20e7dce255e96a Thierry Reding  2019-10-28  230  
20e7dce255e96a Thierry Reding  2019-10-28  231  	size = vic->falcon.firmware.size;
20e7dce255e96a Thierry Reding  2019-10-28  232  
20e7dce255e96a Thierry Reding  2019-10-28  233  	if (!client->group) {
d972d624762805 Thierry Reding  2019-10-28 @234  		virt = dma_alloc_coherent(vic->dev, size, &iova, GFP_KERNEL);
20e7dce255e96a Thierry Reding  2019-10-28  235  
d972d624762805 Thierry Reding  2019-10-28  236  		err = dma_mapping_error(vic->dev, iova);
20e7dce255e96a Thierry Reding  2019-10-28  237  		if (err < 0)
20e7dce255e96a Thierry Reding  2019-10-28  238  			return err;
20e7dce255e96a Thierry Reding  2019-10-28  239  	} else {
d972d624762805 Thierry Reding  2019-10-28  240  		virt = tegra_drm_alloc(tegra, size, &iova);
20e7dce255e96a Thierry Reding  2019-10-28  241  	}
20e7dce255e96a Thierry Reding  2019-10-28  242  
d972d624762805 Thierry Reding  2019-10-28  243  	vic->falcon.firmware.virt = virt;
d972d624762805 Thierry Reding  2019-10-28  244  	vic->falcon.firmware.iova = iova;
77a0b09dd993c8 Thierry Reding  2019-02-01  245  
77a0b09dd993c8 Thierry Reding  2019-02-01  246  	err = falcon_load_firmware(&vic->falcon);
77a0b09dd993c8 Thierry Reding  2019-02-01  247  	if (err < 0)
77a0b09dd993c8 Thierry Reding  2019-02-01  248  		goto cleanup;
77a0b09dd993c8 Thierry Reding  2019-02-01  249  
20e7dce255e96a Thierry Reding  2019-10-28  250  	/*
20e7dce255e96a Thierry Reding  2019-10-28  251  	 * In this case we have received an IOVA from the shared domain, so we
20e7dce255e96a Thierry Reding  2019-10-28  252  	 * need to make sure to get the physical address so that the DMA API
20e7dce255e96a Thierry Reding  2019-10-28  253  	 * knows what memory pages to flush the cache for.
20e7dce255e96a Thierry Reding  2019-10-28  254  	 */
20e7dce255e96a Thierry Reding  2019-10-28  255  	if (client->group) {
d972d624762805 Thierry Reding  2019-10-28  256  		dma_addr_t phys;
d972d624762805 Thierry Reding  2019-10-28  257  
20e7dce255e96a Thierry Reding  2019-10-28  258  		phys = dma_map_single(vic->dev, virt, size, DMA_TO_DEVICE);
20e7dce255e96a Thierry Reding  2019-10-28  259  
20e7dce255e96a Thierry Reding  2019-10-28  260  		err = dma_mapping_error(vic->dev, phys);
20e7dce255e96a Thierry Reding  2019-10-28  261  		if (err < 0)
20e7dce255e96a Thierry Reding  2019-10-28  262  			goto cleanup;
20e7dce255e96a Thierry Reding  2019-10-28  263  
d972d624762805 Thierry Reding  2019-10-28  264  		vic->falcon.firmware.phys = phys;
20e7dce255e96a Thierry Reding  2019-10-28  265  	}
20e7dce255e96a Thierry Reding  2019-10-28  266  
77a0b09dd993c8 Thierry Reding  2019-02-01  267  	return 0;
77a0b09dd993c8 Thierry Reding  2019-02-01  268  
77a0b09dd993c8 Thierry Reding  2019-02-01  269  cleanup:
20e7dce255e96a Thierry Reding  2019-10-28  270  	if (!client->group)
d972d624762805 Thierry Reding  2019-10-28  271  		dma_free_coherent(vic->dev, size, virt, iova);
20e7dce255e96a Thierry Reding  2019-10-28  272  	else
d972d624762805 Thierry Reding  2019-10-28  273  		tegra_drm_free(tegra, size, virt, iova);
20e7dce255e96a Thierry Reding  2019-10-28  274  
77a0b09dd993c8 Thierry Reding  2019-02-01  275  	return err;
77a0b09dd993c8 Thierry Reding  2019-02-01  276  }
77a0b09dd993c8 Thierry Reding  2019-02-01  277  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
