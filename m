Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCE45E1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbhKYU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:56:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:39598 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350944AbhKYUyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:54:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296370919"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296370919"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 12:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457484987"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2021 12:50:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqLhj-0006ut-6y; Thu, 25 Nov 2021 20:50:51 +0000
Date:   Fri, 26 Nov 2021 04:50:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: drivers/pci/controller/pci-xgene.c:626:34: warning: unused variable
 'xgene_pcie_match_table'
Message-ID: <202111260409.W9j5FDps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b501b85957deb17f1fe0a861fee820255519d526
commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
date:   9 months ago
config: x86_64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260409.W9j5FDps-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pci-xgene.c:626:34: warning: unused variable 'xgene_pcie_match_table' [-Wunused-const-variable]
   static const struct of_device_id xgene_pcie_match_table[] = {
                                    ^
   1 warning generated.


vim +/xgene_pcie_match_table +626 drivers/pci/controller/pci-xgene.c

5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  625  
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01 @626  static const struct of_device_id xgene_pcie_match_table[] = {
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  627  	{.compatible = "apm,xgene-pcie",},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  628  	{},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  629  };
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  630  

:::::: The code at line 626 was first introduced by commit
:::::: 5f6b6ccdbe1cdfa5aa4347ec5412509b8995db27 PCI: xgene: Add APM X-Gene PCIe driver

:::::: TO: Tanmay Inamdar <tinamdar@apm.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
