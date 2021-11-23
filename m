Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82245AD96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhKWUwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:52:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:44182 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhKWUwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:52:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222351224"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="222351224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 12:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="674623681"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2021 12:48:51 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpcig-0002HU-Km; Tue, 23 Nov 2021 20:48:50 +0000
Date:   Wed, 24 Nov 2021 04:48:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [tip:perf/core 12/17] arch/arm64/kvm/arm.c:499:15: warning: no
 previous prototype for 'kvm_arch_vcpu_get_ip'
Message-ID: <202111240411.iKbDg3oU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   a9f4a6e92b3b319296fb078da2615f618f6cd80c
commit: e1bfc24577cc65c95dc519d7621a9c985b97e567 [12/17] KVM: Move x86's perf guest info callbacks to generic KVM
config: arm64-randconfig-r035-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240411.iKbDg3oU-lkp@intel.com/config.gz)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e1bfc24577cc65c95dc519d7621a9c985b97e567
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip perf/core
        git checkout e1bfc24577cc65c95dc519d7621a9c985b97e567
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/arm.c:499:15: warning: no previous prototype for 'kvm_arch_vcpu_get_ip' [-Wmissing-prototypes]
     499 | unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
         |               ^~~~~~~~~~~~~~~~~~~~


vim +/kvm_arch_vcpu_get_ip +499 arch/arm64/kvm/arm.c

   498	
 > 499	unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
   500	{
   501		return *vcpu_pc(vcpu);
   502	}
   503	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
