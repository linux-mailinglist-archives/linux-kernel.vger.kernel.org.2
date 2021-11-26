Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB86745EFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbhKZOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:34:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:51908 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353949AbhKZOcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:32:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299074736"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="299074736"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 06:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="510657324"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2021 06:28:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqcCq-0008Ex-OY; Fri, 26 Nov 2021 14:28:04 +0000
Date:   Fri, 26 Nov 2021 22:27:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size
 (2448) exceeds limit (2048) in 'iqs626_probe'
Message-ID: <202111262250.Y0l0olCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: f1d2809de97adc422967b6de59f0f6199769eb93 Input: Add support for Azoteq IQS626A
date:   8 months ago
config: mips-randconfig-r013-20211124 (https://download.01.org/0day-ci/archive/20211126/202111262250.Y0l0olCY-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1d2809de97adc422967b6de59f0f6199769eb93
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f1d2809de97adc422967b6de59f0f6199769eb93
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size (2448) exceeds limit (2048) in 'iqs626_probe' [-Wframe-larger-than]
   static int iqs626_probe(struct i2c_client *client)
              ^
   1 warning generated.
   Assembler messages:
   Warning: a different -march was already specified, is now octeon


vim +/iqs626_probe +1645 drivers/input/misc/iqs626a.c

  1644	
> 1645	static int iqs626_probe(struct i2c_client *client)
  1646	{
  1647		struct iqs626_ver_info ver_info;
  1648		struct iqs626_private *iqs626;
  1649		int error;
  1650	
  1651		iqs626 = devm_kzalloc(&client->dev, sizeof(*iqs626), GFP_KERNEL);
  1652		if (!iqs626)
  1653			return -ENOMEM;
  1654	
  1655		i2c_set_clientdata(client, iqs626);
  1656		iqs626->client = client;
  1657	
  1658		iqs626->regmap = devm_regmap_init_i2c(client, &iqs626_regmap_config);
  1659		if (IS_ERR(iqs626->regmap)) {
  1660			error = PTR_ERR(iqs626->regmap);
  1661			dev_err(&client->dev, "Failed to initialize register map: %d\n",
  1662				error);
  1663			return error;
  1664		}
  1665	
  1666		init_completion(&iqs626->ati_done);
  1667	
  1668		error = regmap_raw_read(iqs626->regmap, IQS626_VER_INFO, &ver_info,
  1669					sizeof(ver_info));
  1670		if (error)
  1671			return error;
  1672	
  1673		if (ver_info.prod_num != IQS626_VER_INFO_PROD_NUM) {
  1674			dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
  1675				ver_info.prod_num);
  1676			return -EINVAL;
  1677		}
  1678	
  1679		error = iqs626_parse_prop(iqs626);
  1680		if (error)
  1681			return error;
  1682	
  1683		error = iqs626_input_init(iqs626);
  1684		if (error)
  1685			return error;
  1686	
  1687		error = devm_request_threaded_irq(&client->dev, client->irq,
  1688						  NULL, iqs626_irq, IRQF_ONESHOT,
  1689						  client->name, iqs626);
  1690		if (error) {
  1691			dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
  1692			return error;
  1693		}
  1694	
  1695		if (!wait_for_completion_timeout(&iqs626->ati_done,
  1696						 msecs_to_jiffies(2000))) {
  1697			dev_err(&client->dev, "Failed to complete ATI\n");
  1698			return -ETIMEDOUT;
  1699		}
  1700	
  1701		/*
  1702		 * The keypad may include one or more switches and is not registered
  1703		 * until ATI is complete and the initial switch states are read.
  1704		 */
  1705		error = input_register_device(iqs626->keypad);
  1706		if (error)
  1707			dev_err(&client->dev, "Failed to register keypad: %d\n", error);
  1708	
  1709		return error;
  1710	}
  1711	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
