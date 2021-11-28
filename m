Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B1460505
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 07:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbhK1Gk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 01:40:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:2256 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245474AbhK1Gi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 01:38:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="259721110"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="259721110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 22:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="539639334"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2021 22:33:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrDkR-000APu-Me; Sun, 28 Nov 2021 06:33:15 +0000
Date:   Sun, 28 Nov 2021 14:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-fast7 3/9] drivers/iio/adc/mxs-lradc-adc.c:563:52:
 error: use of undeclared identifier 'LRADC_MAX_MAPPED_CHAN'
Message-ID: <202111281438.kbhQCbqW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-fast7
head:   21de62a46d4806527ba13c148c7d96a26f1a69e7
commit: 7a4a8dc6adcf9ce8680e675df2cccb20f964d4e3 [3/9] all: replace bitmap_weigth() with bitmap_{empty,full,eq,gt,le}
config: hexagon-buildonly-randconfig-r003-20211128 (https://download.01.org/0day-ci/archive/20211128/202111281438.kbhQCbqW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5c64d8ef8cc0c0ed3e0f2ae693d99e7f70f20a84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/7a4a8dc6adcf9ce8680e675df2cccb20f964d4e3
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-fast7
        git checkout 7a4a8dc6adcf9ce8680e675df2cccb20f964d4e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/mxs-lradc-adc.c:563:52: error: use of undeclared identifier 'LRADC_MAX_MAPPED_CHAN'
           if (bitmap_weight_gt(mask, LRADC_MAX_TOTAL_CHANS, LRADC_MAX_MAPPED_CHAN - rsvd_chans)
                                                             ^
>> drivers/iio/adc/mxs-lradc-adc.c:564:3: error: expected ')'
                   return false;
                   ^
   drivers/iio/adc/mxs-lradc-adc.c:563:5: note: to match this '('
           if (bitmap_weight_gt(mask, LRADC_MAX_TOTAL_CHANS, LRADC_MAX_MAPPED_CHAN - rsvd_chans)
              ^
   2 errors generated.


vim +/LRADC_MAX_MAPPED_CHAN +563 drivers/iio/adc/mxs-lradc-adc.c

   537	
   538	static bool mxs_lradc_adc_validate_scan_mask(struct iio_dev *iio,
   539						     const unsigned long *mask)
   540	{
   541		struct mxs_lradc_adc *adc = iio_priv(iio);
   542		struct mxs_lradc *lradc = adc->lradc;
   543		int rsvd_chans = 0;
   544		unsigned long rsvd_mask = 0;
   545	
   546		if (lradc->use_touchbutton)
   547			rsvd_mask |= CHAN_MASK_TOUCHBUTTON;
   548		if (lradc->touchscreen_wire == MXS_LRADC_TOUCHSCREEN_4WIRE)
   549			rsvd_mask |= CHAN_MASK_TOUCHSCREEN_4WIRE;
   550		if (lradc->touchscreen_wire == MXS_LRADC_TOUCHSCREEN_5WIRE)
   551			rsvd_mask |= CHAN_MASK_TOUCHSCREEN_5WIRE;
   552	
   553		if (lradc->use_touchbutton)
   554			rsvd_chans++;
   555		if (lradc->touchscreen_wire)
   556			rsvd_chans += 2;
   557	
   558		/* Test for attempts to map channels with special mode of operation. */
   559		if (bitmap_intersects(mask, &rsvd_mask, LRADC_MAX_TOTAL_CHANS))
   560			return false;
   561	
   562		/* Test for attempts to map more channels then available slots. */
 > 563		if (bitmap_weight_gt(mask, LRADC_MAX_TOTAL_CHANS, LRADC_MAX_MAPPED_CHAN - rsvd_chans)
 > 564			return false;
   565	
   566		return true;
   567	}
   568	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
