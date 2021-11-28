Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1421460764
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358192AbhK1QSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:18:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:55672 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238574AbhK1QQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:16:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="259752462"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="259752462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 08:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="557223103"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2021 08:13:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrMny-000Ar4-Dq; Sun, 28 Nov 2021 16:13:30 +0000
Date:   Mon, 29 Nov 2021 00:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: drivers/vfio/pci/vfio_pci_igd.c:146:21: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202111290026.O3vehj03-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3498e7f2bb415e447354a3debef6738d9655768c
commit: 179209fa12709a3df8888c323b37315da2683c24 vfio: IOMMU_API should be selected
date:   9 months ago
config: i386-randconfig-s002-20211117 (https://download.01.org/0day-ci/archive/20211129/202111290026.O3vehj03-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=179209fa12709a3df8888c323b37315da2683c24
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 179209fa12709a3df8888c323b37315da2683c24
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vfio/pci/vfio_pci_igd.c:146:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/vfio/pci/vfio_pci_igd.c:146:21: sparse:     expected unsigned short [addressable] [usertype] val
   drivers/vfio/pci/vfio_pci_igd.c:146:21: sparse:     got restricted __le16 [usertype]
>> drivers/vfio/pci/vfio_pci_igd.c:161:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/vfio/pci/vfio_pci_igd.c:161:21: sparse:     expected unsigned int [addressable] [usertype] val
   drivers/vfio/pci/vfio_pci_igd.c:161:21: sparse:     got restricted __le32 [usertype]
   drivers/vfio/pci/vfio_pci_igd.c:176:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/vfio/pci/vfio_pci_igd.c:176:21: sparse:     expected unsigned short [addressable] [usertype] val
   drivers/vfio/pci/vfio_pci_igd.c:176:21: sparse:     got restricted __le16 [usertype]

vim +146 drivers/vfio/pci/vfio_pci_igd.c

f572a960a15e8b Alex Williamson 2016-02-22  109  
f572a960a15e8b Alex Williamson 2016-02-22  110  static size_t vfio_pci_igd_cfg_rw(struct vfio_pci_device *vdev,
f572a960a15e8b Alex Williamson 2016-02-22  111  				  char __user *buf, size_t count, loff_t *ppos,
f572a960a15e8b Alex Williamson 2016-02-22  112  				  bool iswrite)
f572a960a15e8b Alex Williamson 2016-02-22  113  {
f572a960a15e8b Alex Williamson 2016-02-22  114  	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
f572a960a15e8b Alex Williamson 2016-02-22  115  	struct pci_dev *pdev = vdev->region[i].data;
f572a960a15e8b Alex Williamson 2016-02-22  116  	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
f572a960a15e8b Alex Williamson 2016-02-22  117  	size_t size;
f572a960a15e8b Alex Williamson 2016-02-22  118  	int ret;
f572a960a15e8b Alex Williamson 2016-02-22  119  
f572a960a15e8b Alex Williamson 2016-02-22  120  	if (pos >= vdev->region[i].size || iswrite)
f572a960a15e8b Alex Williamson 2016-02-22  121  		return -EINVAL;
f572a960a15e8b Alex Williamson 2016-02-22  122  
f572a960a15e8b Alex Williamson 2016-02-22  123  	size = count = min(count, (size_t)(vdev->region[i].size - pos));
f572a960a15e8b Alex Williamson 2016-02-22  124  
f572a960a15e8b Alex Williamson 2016-02-22  125  	if ((pos & 1) && size) {
f572a960a15e8b Alex Williamson 2016-02-22  126  		u8 val;
f572a960a15e8b Alex Williamson 2016-02-22  127  
f572a960a15e8b Alex Williamson 2016-02-22  128  		ret = pci_user_read_config_byte(pdev, pos, &val);
f572a960a15e8b Alex Williamson 2016-02-22  129  		if (ret)
37a682ffbe2ab3 Heiner Kallweit 2021-01-24  130  			return ret;
f572a960a15e8b Alex Williamson 2016-02-22  131  
f572a960a15e8b Alex Williamson 2016-02-22  132  		if (copy_to_user(buf + count - size, &val, 1))
f572a960a15e8b Alex Williamson 2016-02-22  133  			return -EFAULT;
f572a960a15e8b Alex Williamson 2016-02-22  134  
f572a960a15e8b Alex Williamson 2016-02-22  135  		pos++;
f572a960a15e8b Alex Williamson 2016-02-22  136  		size--;
f572a960a15e8b Alex Williamson 2016-02-22  137  	}
f572a960a15e8b Alex Williamson 2016-02-22  138  
f572a960a15e8b Alex Williamson 2016-02-22  139  	if ((pos & 3) && size > 2) {
f572a960a15e8b Alex Williamson 2016-02-22  140  		u16 val;
f572a960a15e8b Alex Williamson 2016-02-22  141  
f572a960a15e8b Alex Williamson 2016-02-22  142  		ret = pci_user_read_config_word(pdev, pos, &val);
f572a960a15e8b Alex Williamson 2016-02-22  143  		if (ret)
37a682ffbe2ab3 Heiner Kallweit 2021-01-24  144  			return ret;
f572a960a15e8b Alex Williamson 2016-02-22  145  
f572a960a15e8b Alex Williamson 2016-02-22 @146  		val = cpu_to_le16(val);
f572a960a15e8b Alex Williamson 2016-02-22  147  		if (copy_to_user(buf + count - size, &val, 2))
f572a960a15e8b Alex Williamson 2016-02-22  148  			return -EFAULT;
f572a960a15e8b Alex Williamson 2016-02-22  149  
f572a960a15e8b Alex Williamson 2016-02-22  150  		pos += 2;
f572a960a15e8b Alex Williamson 2016-02-22  151  		size -= 2;
f572a960a15e8b Alex Williamson 2016-02-22  152  	}
f572a960a15e8b Alex Williamson 2016-02-22  153  
f572a960a15e8b Alex Williamson 2016-02-22  154  	while (size > 3) {
f572a960a15e8b Alex Williamson 2016-02-22  155  		u32 val;
f572a960a15e8b Alex Williamson 2016-02-22  156  
f572a960a15e8b Alex Williamson 2016-02-22  157  		ret = pci_user_read_config_dword(pdev, pos, &val);
f572a960a15e8b Alex Williamson 2016-02-22  158  		if (ret)
37a682ffbe2ab3 Heiner Kallweit 2021-01-24  159  			return ret;
f572a960a15e8b Alex Williamson 2016-02-22  160  
f572a960a15e8b Alex Williamson 2016-02-22 @161  		val = cpu_to_le32(val);
f572a960a15e8b Alex Williamson 2016-02-22  162  		if (copy_to_user(buf + count - size, &val, 4))
f572a960a15e8b Alex Williamson 2016-02-22  163  			return -EFAULT;
f572a960a15e8b Alex Williamson 2016-02-22  164  
f572a960a15e8b Alex Williamson 2016-02-22  165  		pos += 4;
f572a960a15e8b Alex Williamson 2016-02-22  166  		size -= 4;
f572a960a15e8b Alex Williamson 2016-02-22  167  	}
f572a960a15e8b Alex Williamson 2016-02-22  168  
f572a960a15e8b Alex Williamson 2016-02-22  169  	while (size >= 2) {
f572a960a15e8b Alex Williamson 2016-02-22  170  		u16 val;
f572a960a15e8b Alex Williamson 2016-02-22  171  
f572a960a15e8b Alex Williamson 2016-02-22  172  		ret = pci_user_read_config_word(pdev, pos, &val);
f572a960a15e8b Alex Williamson 2016-02-22  173  		if (ret)
37a682ffbe2ab3 Heiner Kallweit 2021-01-24  174  			return ret;
f572a960a15e8b Alex Williamson 2016-02-22  175  
f572a960a15e8b Alex Williamson 2016-02-22  176  		val = cpu_to_le16(val);
f572a960a15e8b Alex Williamson 2016-02-22  177  		if (copy_to_user(buf + count - size, &val, 2))
f572a960a15e8b Alex Williamson 2016-02-22  178  			return -EFAULT;
f572a960a15e8b Alex Williamson 2016-02-22  179  
f572a960a15e8b Alex Williamson 2016-02-22  180  		pos += 2;
f572a960a15e8b Alex Williamson 2016-02-22  181  		size -= 2;
f572a960a15e8b Alex Williamson 2016-02-22  182  	}
f572a960a15e8b Alex Williamson 2016-02-22  183  
f572a960a15e8b Alex Williamson 2016-02-22  184  	while (size) {
f572a960a15e8b Alex Williamson 2016-02-22  185  		u8 val;
f572a960a15e8b Alex Williamson 2016-02-22  186  
f572a960a15e8b Alex Williamson 2016-02-22  187  		ret = pci_user_read_config_byte(pdev, pos, &val);
f572a960a15e8b Alex Williamson 2016-02-22  188  		if (ret)
37a682ffbe2ab3 Heiner Kallweit 2021-01-24  189  			return ret;
f572a960a15e8b Alex Williamson 2016-02-22  190  
f572a960a15e8b Alex Williamson 2016-02-22  191  		if (copy_to_user(buf + count - size, &val, 1))
f572a960a15e8b Alex Williamson 2016-02-22  192  			return -EFAULT;
f572a960a15e8b Alex Williamson 2016-02-22  193  
f572a960a15e8b Alex Williamson 2016-02-22  194  		pos++;
f572a960a15e8b Alex Williamson 2016-02-22  195  		size--;
f572a960a15e8b Alex Williamson 2016-02-22  196  	}
f572a960a15e8b Alex Williamson 2016-02-22  197  
f572a960a15e8b Alex Williamson 2016-02-22  198  	*ppos += count;
f572a960a15e8b Alex Williamson 2016-02-22  199  
f572a960a15e8b Alex Williamson 2016-02-22  200  	return count;
f572a960a15e8b Alex Williamson 2016-02-22  201  }
f572a960a15e8b Alex Williamson 2016-02-22  202  

:::::: The code at line 146 was first introduced by commit
:::::: f572a960a15e8bb56599f6d2358a9c18f0808e91 vfio/pci: Intel IGD host and LCP bridge config space access

:::::: TO: Alex Williamson <alex.williamson@redhat.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
