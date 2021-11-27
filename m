Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C114600CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355925AbhK0SAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 13:00:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:6527 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233245AbhK0R6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:58:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223003070"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="223003070"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 09:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="457980073"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2021 09:55:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr1ug-0009pp-JU; Sat, 27 Nov 2021 17:55:02 +0000
Date:   Sun, 28 Nov 2021 01:54:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/mdio/mdio-xgene.c:337:13: warning: cast to smaller
 integer type 'enum xgene_mdio_id' from 'const void *'
Message-ID: <202111280114.D7JHY3PG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
date:   1 year, 3 months ago
config: arm64-randconfig-r032-20211118 (https://download.01.org/0day-ci/archive/20211128/202111280114.D7JHY3PG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/zynqmp/ drivers/gpio/ drivers/gpu/drm/ drivers/net/mdio/ drivers/net/wireless/intel/ipw2x00/ drivers/net/wireless/intel/iwlwifi/mvm/ drivers/staging/rtl8188eu/ drivers/usb/gadget/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/mdio/mdio-xgene.c:337:13: warning: cast to smaller integer type 'enum xgene_mdio_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   mdio_id = (enum xgene_mdio_id)of_id->data;
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +337 drivers/net/mdio/mdio-xgene.c

1f3d62090d3ba4 drivers/net/phy/mdio-xgene.c Arnd Bergmann       2017-02-01  324  
1f3d62090d3ba4 drivers/net/phy/mdio-xgene.c Arnd Bergmann       2017-02-01  325  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  326  static int xgene_mdio_probe(struct platform_device *pdev)
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  327  {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  328  	struct device *dev = &pdev->dev;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  329  	struct mii_bus *mdio_bus;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  330  	const struct of_device_id *of_id;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  331  	struct xgene_mdio_pdata *pdata;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  332  	void __iomem *csr_base;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  333  	int mdio_id = 0, ret = 0;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  334  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  335  	of_id = of_match_device(xgene_mdio_of_match, &pdev->dev);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  336  	if (of_id) {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25 @337  		mdio_id = (enum xgene_mdio_id)of_id->data;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  338  	} else {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  339  #ifdef CONFIG_ACPI
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  340  		const struct acpi_device_id *acpi_id;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  341  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  342  		acpi_id = acpi_match_device(xgene_mdio_acpi_match, &pdev->dev);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  343  		if (acpi_id)
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  344  			mdio_id = (enum xgene_mdio_id)acpi_id->driver_data;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  345  #endif
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  346  	}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  347  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  348  	if (!mdio_id)
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  349  		return -ENODEV;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  350  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  351  	pdata = devm_kzalloc(dev, sizeof(struct xgene_mdio_pdata), GFP_KERNEL);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  352  	if (!pdata)
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  353  		return -ENOMEM;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  354  	pdata->mdio_id = mdio_id;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  355  	pdata->dev = dev;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  356  
0ae9fce32c5e5d drivers/net/phy/mdio-xgene.c YueHaibing          2019-08-01  357  	csr_base = devm_platform_ioremap_resource(pdev, 0);
b2df430b52cf9e drivers/net/phy/mdio-xgene.c Wei Yongjun         2016-07-28  358  	if (IS_ERR(csr_base))
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  359  		return PTR_ERR(csr_base);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  360  	pdata->mac_csr_addr = csr_base;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  361  	pdata->mdio_csr_addr = csr_base + BLOCK_XG_MDIO_CSR_OFFSET;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  362  	pdata->diag_csr_addr = csr_base + BLOCK_DIAG_CSR_OFFSET;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  363  
8ec7074a6bf74e drivers/net/phy/mdio-xgene.c Quan Nguyen         2017-05-10  364  	if (mdio_id == XGENE_MDIO_RGMII)
8ec7074a6bf74e drivers/net/phy/mdio-xgene.c Quan Nguyen         2017-05-10  365  		spin_lock_init(&pdata->mac_lock);
8ec7074a6bf74e drivers/net/phy/mdio-xgene.c Quan Nguyen         2017-05-10  366  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  367  	if (dev->of_node) {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  368  		pdata->clk = devm_clk_get(dev, NULL);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  369  		if (IS_ERR(pdata->clk)) {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  370  			dev_err(dev, "Unable to retrieve clk\n");
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  371  			return PTR_ERR(pdata->clk);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  372  		}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  373  	}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  374  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  375  	ret = xgene_mdio_reset(pdata);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  376  	if (ret)
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  377  		return ret;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  378  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  379  	mdio_bus = mdiobus_alloc();
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  380  	if (!mdio_bus) {
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  381  		ret = -ENOMEM;
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  382  		goto out_clk;
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  383  	}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  384  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  385  	mdio_bus->name = "APM X-Gene MDIO bus";
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  386  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  387  	if (mdio_id == XGENE_MDIO_RGMII) {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  388  		mdio_bus->read = xgene_mdio_rgmii_read;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  389  		mdio_bus->write = xgene_mdio_rgmii_write;
8ec7074a6bf74e drivers/net/phy/mdio-xgene.c Quan Nguyen         2017-05-10  390  		mdio_bus->priv = (void __force *)pdata;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  391  		snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s",
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  392  			 "xgene-mii-rgmii");
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  393  	} else {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  394  		mdio_bus->read = xgene_xfi_mdio_read;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  395  		mdio_bus->write = xgene_xfi_mdio_write;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  396  		mdio_bus->priv = (void __force *)pdata->mdio_csr_addr;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  397  		snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s",
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  398  			 "xgene-mii-xfi");
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  399  	}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  400  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  401  	mdio_bus->parent = dev;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  402  	platform_set_drvdata(pdev, pdata);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  403  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  404  	if (dev->of_node) {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  405  		ret = of_mdiobus_register(mdio_bus, dev->of_node);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  406  	} else {
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  407  #ifdef CONFIG_ACPI
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  408  		/* Mask out all PHYs from auto probing. */
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  409  		mdio_bus->phy_mask = ~0;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  410  		ret = mdiobus_register(mdio_bus);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  411  		if (ret)
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  412  			goto out_mdiobus;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  413  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  414  		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(dev), 1,
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  415  				    acpi_register_phy, NULL, mdio_bus, NULL);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  416  #endif
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  417  	}
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  418  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  419  	if (ret)
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  420  		goto out_mdiobus;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  421  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  422  	pdata->mdio_bus = mdio_bus;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  423  	xgene_mdio_status = true;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  424  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  425  	return 0;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  426  
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  427  out_mdiobus:
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  428  	mdiobus_free(mdio_bus);
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  429  
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  430  out_clk:
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  431  	if (dev->of_node)
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  432  		clk_disable_unprepare(pdata->clk);
ab14436065c806 drivers/net/phy/mdio-xgene.c Alexey Khoroshilov  2017-12-16  433  
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  434  	return ret;
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  435  }
43b3cf6634a4ae drivers/net/phy/mdio-xgene.c Iyappan Subramanian 2016-07-25  436  

:::::: The code at line 337 was first introduced by commit
:::::: 43b3cf6634a4ae2eac3b6f08019db8f19a114811 drivers: net: phy: xgene: Add MDIO driver

:::::: TO: Iyappan Subramanian <isubramanian@apm.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
