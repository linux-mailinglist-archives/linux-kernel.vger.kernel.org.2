Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315F4460114
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbhK0TWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:22:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:10321 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234146AbhK0TUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:20:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="234510466"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="234510466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 11:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="458579020"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2021 11:17:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr3C3-0009uG-Sf; Sat, 27 Nov 2021 19:17:03 +0000
Date:   Sun, 28 Nov 2021 03:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [luxis1999-iommufd:iommufd-v5.16-rc2 18/50]
 drivers/gpu/drm/tegra/drm.c:974:17: error: implicit declaration of function
 'iommu_detatch_device'; did you mean 'iommu_detach_device'?
Message-ID: <202111280324.l3kGUbgS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.16-rc2
head:   9821bacf94cee7dd38c9f919a0a38fd48a6f3ae7
commit: 7011c70a936e99eea5c03c44e03e359b1bd58de6 [18/50] drm/tegra: Use the iommu dma_owner mechanism
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211128/202111280324.l3kGUbgS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/luxis1999/iommufd/commit/7011c70a936e99eea5c03c44e03e359b1bd58de6
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.16-rc2
        git checkout 7011c70a936e99eea5c03c44e03e359b1bd58de6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tegra/drm.c: In function 'host1x_client_iommu_detach':
>> drivers/gpu/drm/tegra/drm.c:974:17: error: implicit declaration of function 'iommu_detatch_device'; did you mean 'iommu_detach_device'? [-Werror=implicit-function-declaration]
     974 |                 iommu_detatch_device(tegra->domain, client->dev);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 iommu_detach_device
   cc1: some warnings being treated as errors


vim +974 drivers/gpu/drm/tegra/drm.c

   962	
   963	void host1x_client_iommu_detach(struct host1x_client *client)
   964	{
   965		struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
   966		struct drm_device *drm = dev_get_drvdata(client->host);
   967		struct tegra_drm *tegra = drm->dev_private;
   968	
   969		if (domain && domain != tegra->domain)
   970			return iommu_device_release_dma_owner(client->dev,
   971							      DMA_OWNER_DMA_API);
   972	
   973		if (client->group) {
 > 974			iommu_detatch_device(tegra->domain, client->dev);
   975			client->group = NULL;
   976		}
   977	}
   978	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
