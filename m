Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603C460520
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 08:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbhK1H3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 02:29:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:29108 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhK1H1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 02:27:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223042400"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="223042400"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 23:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="458722887"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2021 23:24:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrEXo-000AT6-Tz; Sun, 28 Nov 2021 07:24:16 +0000
Date:   Sun, 28 Nov 2021 15:23:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 46/100]
 arch/powerpc/platforms/cell/axon_msi.c:212:44: error: passing argument 1 of
 'msi_device_has_property' from incompatible pointer type
Message-ID: <202111281517.uhxzSCMA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   76af424949030bcbbe874fc272e3cd7e388a6c7f
commit: fce5ea72265d4fc76cfc10c819c3482d20b12fef [46/100] powerpc/cell/axon_msi: Use MSI device properties
config: powerpc64-randconfig-r021-20211128 (https://download.01.org/0day-ci/archive/20211128/202111281517.uhxzSCMA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=fce5ea72265d4fc76cfc10c819c3482d20b12fef
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout fce5ea72265d4fc76cfc10c819c3482d20b12fef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/cell/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/cell/axon_msi.c: In function 'setup_msi_msg_address':
>> arch/powerpc/platforms/cell/axon_msi.c:212:44: error: passing argument 1 of 'msi_device_has_property' from incompatible pointer type [-Werror=incompatible-pointer-types]
     212 |         is_64bit = msi_device_has_property(dev, MSI_PROP_64BIT);
         |                                            ^~~
         |                                            |
         |                                            struct pci_dev *
   In file included from arch/powerpc/platforms/cell/axon_msi.c:11:
   include/linux/msi.h:164:45: note: expected 'struct device *' but argument is of type 'struct pci_dev *'
     164 | bool msi_device_has_property(struct device *dev, unsigned long prop);
         |                              ~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/msi_device_has_property +212 arch/powerpc/platforms/cell/axon_msi.c

   198	
   199	static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
   200	{
   201		struct device_node *dn;
   202		bool is_64bit;
   203		int len;
   204		const u32 *prop;
   205	
   206		dn = of_node_get(pci_device_to_OF_node(dev));
   207		if (!dn) {
   208			dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
   209			return -ENODEV;
   210		}
   211	
 > 212		is_64bit = msi_device_has_property(dev, MSI_PROP_64BIT);
   213	
   214		for (; dn; dn = of_get_next_parent(dn)) {
   215			if (is_64bit) {
   216				prop = of_get_property(dn, "msi-address-64", &len);
   217				if (prop)
   218					break;
   219			}
   220	
   221			prop = of_get_property(dn, "msi-address-32", &len);
   222			if (prop)
   223				break;
   224		}
   225	
   226		if (!prop) {
   227			dev_dbg(&dev->dev,
   228				"axon_msi: no msi-address-(32|64) properties found\n");
   229			return -ENOENT;
   230		}
   231	
   232		switch (len) {
   233		case 8:
   234			msg->address_hi = prop[0];
   235			msg->address_lo = prop[1];
   236			break;
   237		case 4:
   238			msg->address_hi = 0;
   239			msg->address_lo = prop[0];
   240			break;
   241		default:
   242			dev_dbg(&dev->dev,
   243				"axon_msi: malformed msi-address-(32|64) property\n");
   244			of_node_put(dn);
   245			return -EINVAL;
   246		}
   247	
   248		of_node_put(dn);
   249	
   250		return 0;
   251	}
   252	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
