Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ADB4604F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 07:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhK1GZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 01:25:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:7016 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232356AbhK1GXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 01:23:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="296608733"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="296608733"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 22:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="675966555"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2021 22:20:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrDXr-000APc-KK; Sun, 28 Nov 2021 06:20:15 +0000
Date:   Sun, 28 Nov 2021 14:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-fast7 3/9] drivers/iio/adc/mxs-lradc-adc.c:834:40:
 error: unterminated argument list invoking macro "if"
Message-ID: <202111281416.oSk25KrN-lkp@intel.com>
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
config: xtensa-randconfig-r004-20211128 (https://download.01.org/0day-ci/archive/20211128/202111281416.oSk25KrN-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/7a4a8dc6adcf9ce8680e675df2cccb20f964d4e3
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-fast7
        git checkout 7a4a8dc6adcf9ce8680e675df2cccb20f964d4e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/adc/mxs-lradc-adc.c: In function 'mxs_lradc_adc_validate_scan_mask':
>> drivers/iio/adc/mxs-lradc-adc.c:834:40: error: unterminated argument list invoking macro "if"
     834 | MODULE_ALIAS("platform:mxs-lradc-adc");
         |                                        ^
>> drivers/iio/adc/mxs-lradc-adc.c:835: error: expected '(' at end of input
   drivers/iio/adc/mxs-lradc-adc.c:563:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
     563 |         if (bitmap_weight_gt(mask, LRADC_MAX_TOTAL_CHANS, LRADC_MAX_MAPPED_CHAN - rsvd_chans)
         |         ^~
   drivers/iio/adc/mxs-lradc-adc.c:563:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> drivers/iio/adc/mxs-lradc-adc.c:563:9: error: expected declaration or statement at end of input
   At top level:
   drivers/iio/adc/mxs-lradc-adc.c:538:13: warning: 'mxs_lradc_adc_validate_scan_mask' defined but not used [-Wunused-function]
     538 | static bool mxs_lradc_adc_validate_scan_mask(struct iio_dev *iio,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:521:12: warning: 'mxs_lradc_adc_buffer_postdisable' defined but not used [-Wunused-function]
     521 | static int mxs_lradc_adc_buffer_postdisable(struct iio_dev *iio)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:483:12: warning: 'mxs_lradc_adc_buffer_preenable' defined but not used [-Wunused-function]
     483 | static int mxs_lradc_adc_buffer_preenable(struct iio_dev *iio)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:476:13: warning: 'mxs_lradc_adc_trigger_remove' defined but not used [-Wunused-function]
     476 | static void mxs_lradc_adc_trigger_remove(struct iio_dev *iio)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:452:12: warning: 'mxs_lradc_adc_trigger_init' defined but not used [-Wunused-function]
     452 | static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:413:20: warning: 'mxs_lradc_adc_trigger_handler' defined but not used [-Wunused-function]
     413 | static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:384:20: warning: 'mxs_lradc_adc_handle_irq' defined but not used [-Wunused-function]
     384 | static irqreturn_t mxs_lradc_adc_handle_irq(int irq, void *data)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:376:30: warning: 'mxs_lradc_adc_iio_info' defined but not used [-Wunused-const-variable=]
     376 | static const struct iio_info mxs_lradc_adc_iio_info = {
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:64:18: warning: 'mxs_lradc_adc_vref_mv' defined but not used [-Wunused-const-variable=]
      64 | static const u32 mxs_lradc_adc_vref_mv[][LRADC_MAX_TOTAL_CHANS] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:51:20: warning: 'mx28_lradc_adc_irq_names' defined but not used [-Wunused-variable]
      51 | static const char *mx28_lradc_adc_irq_names[] = {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/mxs-lradc-adc.c:42:20: warning: 'mx23_lradc_adc_irq_names' defined but not used [-Wunused-variable]
      42 | static const char *mx23_lradc_adc_irq_names[] = {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/if +834 drivers/iio/adc/mxs-lradc-adc.c

6dd112b9f85e5f Ksenija Stanojevic 2017-03-16  830  
6dd112b9f85e5f Ksenija Stanojevic 2017-03-16  831  MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
6dd112b9f85e5f Ksenija Stanojevic 2017-03-16  832  MODULE_DESCRIPTION("Freescale MXS LRADC driver general purpose ADC driver");
6dd112b9f85e5f Ksenija Stanojevic 2017-03-16  833  MODULE_LICENSE("GPL");
6dd112b9f85e5f Ksenija Stanojevic 2017-03-16 @834  MODULE_ALIAS("platform:mxs-lradc-adc");

:::::: The code at line 834 was first introduced by commit
:::::: 6dd112b9f85e5f24ac8c15d892690cb44a4b7936 iio: adc: mxs-lradc: Add support for ADC driver

:::::: TO: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
:::::: CC: Lee Jones <lee.jones@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
