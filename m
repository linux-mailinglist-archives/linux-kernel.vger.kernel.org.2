Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEE45F2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhKZRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:16:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:62624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhKZROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:14:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="299096020"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="299096020"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="607941634"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2021 09:11:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqekd-0008MR-RJ; Fri, 26 Nov 2021 17:11:07 +0000
Date:   Sat, 27 Nov 2021 01:10:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Justin TerAvest <teravest@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 28/30]
 drivers/i2c/i2c-core-of.c:82:24: warning: assignment to 'struct i2c_client
 *' from 'int' makes pointer from integer without a cast
Message-ID: <202111270150.0WP6EN8x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v2-bpf
head:   241207b4769fca049dfcc4dbde0bda92e4f67027
commit: f668c459b7bfe36f2317924a5511622cd737e346 [28/30] CHROMIUM: i2c: Add device property for probing
config: arc-buildonly-randconfig-r001-20211125 (https://download.01.org/0day-ci/archive/20211127/202111270150.0WP6EN8x-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/f668c459b7bfe36f2317924a5511622cd737e346
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout f668c459b7bfe36f2317924a5511622cd737e346
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/i2c/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/i2c/i2c-core-of.c: In function 'of_i2c_register_device':
   drivers/i2c/i2c-core-of.c:82:26: error: implicit declaration of function 'i2c_new_probed_device'; did you mean 'i2c_new_scanned_device'? [-Werror=implicit-function-declaration]
      82 |                 client = i2c_new_probed_device(adap, &info, addrs, NULL);
         |                          ^~~~~~~~~~~~~~~~~~~~~
         |                          i2c_new_scanned_device
>> drivers/i2c/i2c-core-of.c:82:24: warning: assignment to 'struct i2c_client *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      82 |                 client = i2c_new_probed_device(adap, &info, addrs, NULL);
         |                        ^
   cc1: some warnings being treated as errors


vim +82 drivers/i2c/i2c-core-of.c

    64	
    65	static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
    66							 struct device_node *node)
    67	{
    68		struct i2c_client *client;
    69		struct i2c_board_info info;
    70		int ret;
    71	
    72		dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);
    73	
    74		ret = of_i2c_get_board_info(&adap->dev, node, &info);
    75		if (ret)
    76			return ERR_PTR(ret);
    77	
    78		/* Allow device property to enable probing before init */
    79		if (of_get_property(node, "linux,probed", NULL)) {
    80			unsigned short addrs[] = { info.addr, I2C_CLIENT_END };
    81	
  > 82			client = i2c_new_probed_device(adap, &info, addrs, NULL);
    83		} else {
    84			client = i2c_new_client_device(adap, &info);
    85		}
    86	
    87		if (IS_ERR(client))
    88			dev_err(&adap->dev, "of_i2c: Failure registering %pOF\n", node);
    89	
    90		return client;
    91	}
    92	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
