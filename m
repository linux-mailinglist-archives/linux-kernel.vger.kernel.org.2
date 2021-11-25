Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8545DE35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356227AbhKYQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:05:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:50815 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbhKYQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:02:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296338374"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296338374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 07:56:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="592050758"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 07:56:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqH73-0006ap-5v; Thu, 25 Nov 2021 15:56:41 +0000
Date:   Thu, 25 Nov 2021 23:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, airlied@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch, jenmin_yuan@aspeedtech.com,
        kuohsiang_chou@aspeedtech.com, arc_sung@aspeedtech.com,
        tommy_huang@aspeedtech.com
Subject: Re: [PATCH] drm/ast: Create the driver for ASPEED proprietory
  Display-Port
Message-ID: <202111252305.4CNMgIAc-lkp@intel.com>
References: <20211122103617.3496-1-kuohsiang_chou@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122103617.3496-1-kuohsiang_chou@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KuoHsiang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-intel/for-linux-next drm-tip/drm-tip drm-exynos/exynos-drm-next tegra-drm/drm/tegra/for-next v5.16-rc2 next-20211125]
[cannot apply to airlied/drm-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/KuoHsiang-Chou/drm-ast-Create-the-driver-for-ASPEED-proprietory-Display-Port/20211122-183830
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: i386-randconfig-c021-20211123 (https://download.01.org/0day-ci/archive/20211125/202111252305.4CNMgIAc-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/ast/ast_dp.c:166:3-4: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
