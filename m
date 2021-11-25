Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070A45D67C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352317AbhKYIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:54:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:44401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349337AbhKYIwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:52:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="216183905"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="216183905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="607484839"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 00:49:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqARc-00064r-Sr; Thu, 25 Nov 2021 08:49:28 +0000
Date:   Thu, 25 Nov 2021 16:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to
 restricted __be32
Message-ID: <202111251641.T8TrqxkW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: cb53a93e33e108bfec00a13cd12696e1c0ccc8b6 KVM: PPC: Book3S PR: Declare kvmppc_handle_exit_pr()
date:   3 months ago
config: powerpc-randconfig-s031-20211028 (https://download.01.org/0day-ci/archive/20211125/202111251641.T8TrqxkW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cb53a93e33e108bfec00a13cd12696e1c0ccc8b6
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/book3s_pr.c:660:22: sparse: sparse: cast to restricted __be32
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse: sparse: invalid assignment: &=
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    left side has type unsigned int
>> arch/powerpc/kvm/book3s_pr.c:661:33: sparse:    right side has type restricted __be32
   arch/powerpc/kvm/book3s_pr.c: note: in included file:
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:970:39: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] msr @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     expected unsigned long long [usertype] msr
   arch/powerpc/include/asm/kvm_ppc.h:972:39: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:974:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:984:23: sparse: sparse: cast to restricted __be32
   arch/powerpc/include/asm/kvm_ppc.h:986:23: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64

vim +660 arch/powerpc/kvm/book3s_pr.c

f05ed4d56e9cff1 Paul Mackerras 2011-06-29  630  
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  631  /* Book3s_32 CPUs always have 32 bytes cache line size, which Linux assumes. To
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  632   * make Book3s_32 Linux work on Book3s_64, we have to make sure we trap dcbz to
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  633   * emulate 32 bytes dcbz length.
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  634   *
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  635   * The Book3s_64 inventors also realized this case and implemented a special bit
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  636   * in the HID5 register, which is a hypervisor ressource. Thus we can't use it.
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  637   *
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  638   * My approach here is to patch the dcbz instruction on executing pages.
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  639   */
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  640  static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  641  {
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  642  	struct page *hpage;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  643  	u64 hpage_offset;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  644  	u32 *page;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  645  	int i;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  646  
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  647  	hpage = gfn_to_page(vcpu->kvm, pte->raddr >> PAGE_SHIFT);
32cad84f44d1866 Xiao Guangrong 2012-08-03  648  	if (is_error_page(hpage))
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  649  		return;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  650  
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  651  	hpage_offset = pte->raddr & ~PAGE_MASK;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  652  	hpage_offset &= ~0xFFFULL;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  653  	hpage_offset /= 4;
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  654  
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  655  	get_page(hpage);
2480b2089210de3 Cong Wang      2011-11-25  656  	page = kmap_atomic(hpage);
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  657  
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  658  	/* patch dcbz into reserved instruction, so we trap */
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  659  	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
cd087eefe637d54 Alexander Graf 2014-04-24 @660  		if ((be32_to_cpu(page[i]) & 0xff0007ff) == INS_DCBZ)
cd087eefe637d54 Alexander Graf 2014-04-24 @661  			page[i] &= cpu_to_be32(0xfffffff7);
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  662  
2480b2089210de3 Cong Wang      2011-11-25  663  	kunmap_atomic(page);
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  664  	put_page(hpage);
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  665  }
f05ed4d56e9cff1 Paul Mackerras 2011-06-29  666  

:::::: The code at line 660 was first introduced by commit
:::::: cd087eefe637d545345ea5f888d4ea4fe52e312c KVM: PPC: Book3S PR: Do dcbz32 patching with big endian instructions

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
