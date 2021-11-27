Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09EA45FC46
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 04:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351460AbhK0DJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 22:09:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:35416 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351627AbhK0DHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:07:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="215760198"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="215760198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 19:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="458428702"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2021 19:04:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqo0s-0008yu-Sn; Sat, 27 Nov 2021 03:04:30 +0000
Date:   Sat, 27 Nov 2021 11:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V3 3/3] regulator: da9121: Add DA914x support
Message-ID: <202111271151.bdZw3D77-lkp@intel.com>
References: <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on robh/for-next linux/master linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Adam-Ward/regulator-da9121-add-DA914x-support/20211124-072849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: nds32-randconfig-r003-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271151.bdZw3D77-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/623a92b6a8e3ca66e0792b1cb7dfa5b4bd769b81
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Adam-Ward/regulator-da9121-add-DA914x-support/20211124-072849
        git checkout 623a92b6a8e3ca66e0792b1cb7dfa5b4bd769b81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/regulator/da9121-regulator.c:571:15: error: 'DA9141_IDX_BUCK1' undeclared here (not in a function); did you mean 'DA9121_IDX_BUCK1'?
     571 |         .id = DA9141_IDX_BUCK1,
         |               ^~~~~~~~~~~~~~~~
         |               DA9121_IDX_BUCK1
   drivers/regulator/da9121-regulator.c:595:15: error: 'DA914X_IDX_BUCK1' undeclared here (not in a function); did you mean 'DA9121_IDX_BUCK1'?
     595 |         .id = DA914X_IDX_BUCK1,
         |               ^~~~~~~~~~~~~~~~
         |               DA9121_IDX_BUCK1
   drivers/regulator/da9121-regulator.c: In function 'da9121_check_device_type':
>> drivers/regulator/da9121-regulator.c:1210:26: error: unterminated argument list invoking macro "if"
    1210 | MODULE_LICENSE("GPL v2");
         |                          ^
>> drivers/regulator/da9121-regulator.c:1211: error: expected '(' at end of input
   drivers/regulator/da9121-regulator.c:915:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
     915 |         if ((device_id != DA9121_DEVICE_ID) && (device_id != DA914X_DEVICE_ID) {
         |         ^~
   drivers/regulator/da9121-regulator.c:915:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> drivers/regulator/da9121-regulator.c:915:9: error: expected declaration or statement at end of input
   drivers/regulator/da9121-regulator.c:912:17: error: label 'error' used but not defined
     912 |                 goto error;
         |                 ^~~~
   drivers/regulator/da9121-regulator.c:900:14: warning: unused variable 'config_match' [-Wunused-variable]
     900 |         bool config_match = false;
         |              ^~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:899:15: warning: unused variable 'type' [-Wunused-variable]
     899 |         char *type;
         |               ^~~~
   drivers/regulator/da9121-regulator.c:898:25: warning: unused variable 'variant_vrc' [-Wunused-variable]
     898 |         u8 variant_mrc, variant_vrc;
         |                         ^~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:898:12: warning: unused variable 'variant_mrc' [-Wunused-variable]
     898 |         u8 variant_mrc, variant_vrc;
         |            ^~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:915:9: error: no return statement in function returning non-void [-Werror=return-type]
     915 |         if ((device_id != DA9121_DEVICE_ID) && (device_id != DA914X_DEVICE_ID) {
         |         ^~
   At top level:
   drivers/regulator/da9121-regulator.c:894:12: warning: 'da9121_check_device_type' defined but not used [-Wunused-function]
     894 | static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:884:29: warning: 'da9121_2ch_regmap_config' defined but not used [-Wunused-variable]
     884 | static struct regmap_config da9121_2ch_regmap_config = {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:873:29: warning: 'da9121_1ch_regmap_config' defined but not used [-Wunused-variable]
     873 | static struct regmap_config da9121_1ch_regmap_config = {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:775:12: warning: 'da9121_set_regulator_config' defined but not used [-Wunused-function]
     775 | static int da9121_set_regulator_config(struct da9121 *chip)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:682:20: warning: 'da9121_irq_handler' defined but not used [-Wunused-function]
     682 | static irqreturn_t da9121_irq_handler(int irq, void *data)
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/regulator/da9121-regulator.c:624:13: warning: 'da9121_status_poll_on' defined but not used [-Wunused-function]
     624 | static void da9121_status_poll_on(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/if +1210 drivers/regulator/da9121-regulator.c

e6ff10f24c587c1 Vincent Whitchurch 2020-11-03  1209  
e6ff10f24c587c1 Vincent Whitchurch 2020-11-03 @1210  MODULE_LICENSE("GPL v2");

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
