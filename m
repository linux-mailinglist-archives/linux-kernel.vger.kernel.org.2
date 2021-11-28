Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A3460AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 23:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhK1W17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 17:27:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:22833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346536AbhK1WZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 17:25:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="215881820"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="215881820"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 14:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="511408926"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2021 14:22:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrSZE-000BCT-5Q; Sun, 28 Nov 2021 22:22:40 +0000
Date:   Mon, 29 Nov 2021 06:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap_fast2 3/9] drivers/iio/adc/mxs-lradc-adc.c:563:2:
 error: unterminated function-like macro invocation
Message-ID: <202111290655.xr3sMLhM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap_fast2
head:   2ba93e639da00fa6374a9942dc507f64d5cb6659
commit: 46f86267bdcb14f620d5905e64cbe68dc712e028 [3/9] all: replace bitmap_weigth() with bitmap_{empty,full,eq,gt,le}
config: hexagon-randconfig-r033-20211128 (https://download.01.org/0day-ci/archive/20211129/202111290655.xr3sMLhM-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5c64d8ef8cc0c0ed3e0f2ae693d99e7f70f20a84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/46f86267bdcb14f620d5905e64cbe68dc712e028
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap_fast2
        git checkout 46f86267bdcb14f620d5905e64cbe68dc712e028
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/mxs-lradc-adc.c:563:2: error: unterminated function-like macro invocation
           if (bitmap_weight_gt(mask, LRADC_MAX_TOTAL_CHANS, LRADC_MAX_MAPPED_CHAN - rsvd_chans)
           ^
   include/linux/compiler.h:56:9: note: macro 'if' defined here
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
           ^
>> drivers/iio/adc/mxs-lradc-adc.c:834:40: error: expected '}'
   MODULE_ALIAS("platform:mxs-lradc-adc");
                                          ^
   drivers/iio/adc/mxs-lradc-adc.c:540:1: note: to match this '{'
   {
   ^
   2 errors generated.


vim +563 drivers/iio/adc/mxs-lradc-adc.c

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
   564			return false;
   565	
   566		return true;
   567	}
   568	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
