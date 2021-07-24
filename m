Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6273C3D4578
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhGXGUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 02:20:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:4593 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhGXGUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 02:20:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="275811777"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="gz'50?scan'50,208,50";a="275811777"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 00:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="gz'50?scan'50,208,50";a="502984832"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2021 00:00:38 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7BeH-00033u-JY; Sat, 24 Jul 2021 07:00:37 +0000
Date:   Sat, 24 Jul 2021 15:00:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
Message-ID: <202107241438.ZGxGgokJ-lkp@intel.com>
References: <20210723135239.388325-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723135239.388325-3-clement.leger@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Clément,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on regmap/for-next]
[also build test WARNING on robh/for-next v5.14-rc2 next-20210723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cl-ment-L-ger/add-SMC-based-regmap-driver-for-secure-syscon-access/20210723-215708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5b8123662c54263f6fc86b6ef9e296739fe78353
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cl-ment-L-ger/add-SMC-based-regmap-driver-for-secure-syscon-access/20210723-215708
        git checkout 5b8123662c54263f6fc86b6ef9e296739fe78353
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mfd/syscon.c: In function 'syscon_probe':
>> drivers/mfd/syscon.c:407:23: warning: variable 'syscon_config' set but not used [-Wunused-but-set-variable]
     407 |  struct regmap_config syscon_config = syscon_regmap_config;
         |                       ^~~~~~~~~~~~~


vim +/syscon_config +407 drivers/mfd/syscon.c

   401	
   402	static int syscon_probe(struct platform_device *pdev)
   403	{
   404		int ret;
   405		struct device *dev = &pdev->dev;
   406		struct syscon_platform_data *pdata = dev_get_platdata(dev);
 > 407		struct regmap_config syscon_config = syscon_regmap_config;
   408		struct syscon *syscon;
   409		const struct syscon_driver_data *driver_data;
   410	
   411		if (pdata)
   412			syscon_config.name = pdata->label;
   413	
   414		syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
   415		if (!syscon)
   416			return -ENOMEM;
   417	
   418		driver_data = (const struct syscon_driver_data *)
   419					platform_get_device_id(pdev)->driver_data;
   420	
   421		ret = driver_data->probe_func(pdev, dev, syscon);
   422		if (ret)
   423			return ret;
   424	
   425		platform_set_drvdata(pdev, syscon);
   426	
   427		return 0;
   428	}
   429	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ReaqsoxgOBHFXBhH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ReaqsoxgOBHFXBhH--
