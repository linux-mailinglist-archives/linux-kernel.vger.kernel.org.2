Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4879544EDA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhKLUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:01:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:54946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbhKLUBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:01:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="220088755"
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="gz'50?scan'50,208,50";a="220088755"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 11:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="gz'50?scan'50,208,50";a="453257365"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2021 11:58:07 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlcgZ-000Iui-1g; Fri, 12 Nov 2021 19:58:07 +0000
Date:   Sat, 13 Nov 2021 03:57:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202111130306.zjs6KjX1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5833291ab6de9c3e2374336b51c814e515e8f3a5
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   7 months ago
config: powerpc-randconfig-s031-20211028 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:959:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:959:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] int_pending @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     expected unsigned int [usertype] int_pending
   arch/powerpc/include/asm/kvm_ppc.h:977:1: sparse:     got restricted __le32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:968:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     expected unsigned long long [usertype] srr0
   arch/powerpc/include/asm/kvm_ppc.h:964:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] srr1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     expected unsigned long long [usertype] srr1
   arch/powerpc/include/asm/kvm_ppc.h:965:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg0 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     expected unsigned long long [usertype] sprg0
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg0 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     expected unsigned long long [usertype] sprg0
   arch/powerpc/include/asm/kvm_ppc.h:960:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg1 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     expected unsigned long long [usertype] sprg1
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg1 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     expected unsigned long long [usertype] sprg1
   arch/powerpc/include/asm/kvm_ppc.h:961:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg2 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] sprg2
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg2 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     expected unsigned long long [usertype] sprg2
   arch/powerpc/include/asm/kvm_ppc.h:962:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg3 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] sprg3
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg3 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     expected unsigned long long [usertype] sprg3
   arch/powerpc/include/asm/kvm_ppc.h:963:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg4 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     expected unsigned long long [usertype] sprg4
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg4 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     expected unsigned long long [usertype] sprg4
   arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg5 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     expected unsigned long long [usertype] sprg5
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg5 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     expected unsigned long long [usertype] sprg5
   arch/powerpc/include/asm/kvm_ppc.h:979:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg6 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     expected unsigned long long [usertype] sprg6
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg6 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     expected unsigned long long [usertype] sprg6
   arch/powerpc/include/asm/kvm_ppc.h:980:1: sparse:     got restricted __le64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg7 @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     expected unsigned long long [usertype] sprg7
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sprg7 @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     expected unsigned long long [usertype] sprg7
   arch/powerpc/include/asm/kvm_ppc.h:981:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __be64
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: cast to restricted __le64
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __be32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __be32
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __be64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __be64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] dar @@     got restricted __le64 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     expected unsigned long long [usertype] dar
   arch/powerpc/include/asm/kvm_ppc.h:966:1: sparse:     got restricted __le64 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __be32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __be32 [usertype]
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dsisr @@     got restricted __le32 [usertype] @@
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     expected unsigned int [usertype] dsisr
   arch/powerpc/include/asm/kvm_ppc.h:976:1: sparse:     got restricted __le32 [usertype]

vim +978 arch/powerpc/include/asm/kvm_ppc.h

1dc0c5b88cae1c Bharat Bhushan 2014-07-17  958  
5deb8e7ad8ac7e Alexander Graf 2014-04-24  959  SHARED_WRAPPER(critical, 64)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  960  SHARED_SPRNG_WRAPPER(sprg0, 64, SPRN_GSPRG0)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  961  SHARED_SPRNG_WRAPPER(sprg1, 64, SPRN_GSPRG1)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  962  SHARED_SPRNG_WRAPPER(sprg2, 64, SPRN_GSPRG2)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  963  SHARED_SPRNG_WRAPPER(sprg3, 64, SPRN_GSPRG3)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  964  SHARED_SPRNG_WRAPPER(srr0, 64, SPRN_GSRR0)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  965  SHARED_SPRNG_WRAPPER(srr1, 64, SPRN_GSRR1)
1dc0c5b88cae1c Bharat Bhushan 2014-07-17  966  SHARED_SPRNG_WRAPPER(dar, 64, SPRN_GDEAR)
dc168549d9a0fb Bharat Bhushan 2014-07-17  967  SHARED_SPRNG_WRAPPER(esr, 64, SPRN_GESR)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  968  SHARED_WRAPPER_GET(msr, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  969  static inline void kvmppc_set_msr_fast(struct kvm_vcpu *vcpu, u64 val)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  970  {
5deb8e7ad8ac7e Alexander Graf 2014-04-24  971  	if (kvmppc_shared_big_endian(vcpu))
5deb8e7ad8ac7e Alexander Graf 2014-04-24  972  	       vcpu->arch.shared->msr = cpu_to_be64(val);
5deb8e7ad8ac7e Alexander Graf 2014-04-24  973  	else
5deb8e7ad8ac7e Alexander Graf 2014-04-24  974  	       vcpu->arch.shared->msr = cpu_to_le64(val);
5deb8e7ad8ac7e Alexander Graf 2014-04-24  975  }
5deb8e7ad8ac7e Alexander Graf 2014-04-24  976  SHARED_WRAPPER(dsisr, 32)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  977  SHARED_WRAPPER(int_pending, 32)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @978  SHARED_WRAPPER(sprg4, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @979  SHARED_WRAPPER(sprg5, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @980  SHARED_WRAPPER(sprg6, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24 @981  SHARED_WRAPPER(sprg7, 64)
5deb8e7ad8ac7e Alexander Graf 2014-04-24  982  

:::::: The code at line 978 was first introduced by commit
:::::: 5deb8e7ad8ac7e3fcdfa042acff617f461b361c2 KVM: PPC: Make shared struct aka magic page guest endian

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lBeCwCYTJyotchvviv8fcdIXsts9AgA=

--k+w/mQv8wyuph6w0--
