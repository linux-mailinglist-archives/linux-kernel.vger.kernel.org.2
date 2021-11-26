Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3F45F6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbhKZWmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:42:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:35331 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244440AbhKZWkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:40:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321955926"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="321955926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 14:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="458392168"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2021 14:37:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqjqH-0008gx-W6; Fri, 26 Nov 2021 22:37:17 +0000
Date:   Sat, 27 Nov 2021 06:37:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Zhi Wang <zhi.wang.linux@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] i915/gvt: Introduce the mmio_info_table.c to
 support VFIO new mdev API
Message-ID: <202111270654.IbLd57DI-lkp@intel.com>
References: <20211126114623.88739-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126114623.88739-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on drm-tip/drm-tip drm/drm-next tegra-drm/drm/tegra/for-next v5.16-rc2 next-20211126]
[cannot apply to airlied/drm-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhi-Wang/i915-gvt-Introduce-the-mmio_info_table-c-to-support-VFIO-new-mdev-API/20211126-194800
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20211127/202111270654.IbLd57DI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/82dadc38be63d9271031336db366cd71104df3a0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhi-Wang/i915-gvt-Introduce-the-mmio_info_table-c-to-support-VFIO-new-mdev-API/20211126-194800
        git checkout 82dadc38be63d9271031336db366cd71104df3a0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gvt/mmio_info_table.c:1414: warning: expecting prototype for intel_gvt_setup_mmio_table(). Prototype was for intel_gvt_setup_mmio_info() instead


vim +1414 drivers/gpu/drm/i915/gvt/mmio_info_table.c

  1402	
  1403	/**
  1404	 * intel_gvt_setup_mmio_table - setup MMIO information table for GVT device
  1405	 * @gvt: GVT device
  1406	 *
  1407	 * This function is called at the initialization stage, to setup the MMIO
  1408	 * information table for GVT device
  1409	 *
  1410	 * Returns:
  1411	 * zero on success, negative if failed.
  1412	 */
  1413	int intel_gvt_setup_mmio_info(struct intel_gvt *gvt)
> 1414	{

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
