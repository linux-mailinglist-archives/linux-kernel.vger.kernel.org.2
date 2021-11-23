Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC0459CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhKWHWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:22:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:12465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231896AbhKWHWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:22:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234916757"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="234916757"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 23:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="674362260"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2021 23:19:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpQ5R-0001a6-RW; Tue, 23 Nov 2021 07:19:29 +0000
Date:   Tue, 23 Nov 2021 15:18:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 18/91] drivers/pci/msi/legacy.c:54:5: warning: no
 previous prototype for function 'pci_msi_legacy_setup_msi_irqs'
Message-ID: <202111231428.RmNJuNXe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   2d9ab27714e1576db18b1ee323eaae9886e16006
commit: 5e32e214c6eeda4237b4fb01cd77c6c247465e0c [18/91] PCI/MSI: Split out irqdomain code
config: mips-randconfig-r035-20211123 (https://download.01.org/0day-ci/archive/20211123/202111231428.RmNJuNXe-lkp@intel.com/config.gz)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c133fb321f7ca6083ce15b6aa5bf89de6600e649)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=5e32e214c6eeda4237b4fb01cd77c6c247465e0c
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 5e32e214c6eeda4237b4fb01cd77c6c247465e0c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/msi/legacy.c:7:
   include/linux/msi.h:391:65: warning: declaration of 'struct cpumask' will not be visible outside of this function [-Wvisibility]
   int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
                                                                   ^
   drivers/pci/msi/legacy.c:48:20: error: use of undeclared identifier 'entry'
                           for (i = 0; i < entry->nvec_used; i++)
                                           ^
>> drivers/pci/msi/legacy.c:54:5: warning: no previous prototype for function 'pci_msi_legacy_setup_msi_irqs' [-Wmissing-prototypes]
   int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
       ^
   drivers/pci/msi/legacy.c:54:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
   ^
   static 
>> drivers/pci/msi/legacy.c:59:6: warning: no previous prototype for function 'pci_msi_legacy_teardown_msi_irqs' [-Wmissing-prototypes]
   void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
        ^
   drivers/pci/msi/legacy.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
   ^
   static 
   3 warnings and 1 error generated.


vim +/pci_msi_legacy_setup_msi_irqs +54 drivers/pci/msi/legacy.c

    53	
  > 54	int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
    55	{
    56		return arch_setup_msi_irqs(dev, nvec, type);
    57	}
    58	
  > 59	void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
