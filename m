Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06945D553
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhKYHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:21:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:34790 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348047AbhKYHTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:19:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222333230"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="222333230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="675138989"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 23:16:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq8zZ-0005xI-5L; Thu, 25 Nov 2021 07:16:25 +0000
Date:   Thu, 25 Nov 2021 15:16:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/include/asm/kvm_ppc.h:978:1: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202111251523.PG4QWwjV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   7 months ago
config: powerpc-randconfig-s031-20211028 (https://download.01.org/0day-ci/archive/20211125/202111251523.PG4QWwjV-lkp@intel.com/config)
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
        # save the config file to linux build tree
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

1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  958  
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  959  SHARED_WRAPPER(critical, 64)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  960  SHARED_SPRNG_WRAPPER(sprg0, 64, SPRN_GSPRG0)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  961  SHARED_SPRNG_WRAPPER(sprg1, 64, SPRN_GSPRG1)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  962  SHARED_SPRNG_WRAPPER(sprg2, 64, SPRN_GSPRG2)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  963  SHARED_SPRNG_WRAPPER(sprg3, 64, SPRN_GSPRG3)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  964  SHARED_SPRNG_WRAPPER(srr0, 64, SPRN_GSRR0)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  965  SHARED_SPRNG_WRAPPER(srr1, 64, SPRN_GSRR1)
1dc0c5b88cae1c2 Bharat Bhushan 2014-07-17  966  SHARED_SPRNG_WRAPPER(dar, 64, SPRN_GDEAR)
dc168549d9a0fb5 Bharat Bhushan 2014-07-17  967  SHARED_SPRNG_WRAPPER(esr, 64, SPRN_GESR)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  968  SHARED_WRAPPER_GET(msr, 64)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  969  static inline void kvmppc_set_msr_fast(struct kvm_vcpu *vcpu, u64 val)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  970  {
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  971  	if (kvmppc_shared_big_endian(vcpu))
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  972  	       vcpu->arch.shared->msr = cpu_to_be64(val);
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  973  	else
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  974  	       vcpu->arch.shared->msr = cpu_to_le64(val);
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  975  }
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  976  SHARED_WRAPPER(dsisr, 32)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  977  SHARED_WRAPPER(int_pending, 32)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24 @978  SHARED_WRAPPER(sprg4, 64)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24 @979  SHARED_WRAPPER(sprg5, 64)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24 @980  SHARED_WRAPPER(sprg6, 64)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24 @981  SHARED_WRAPPER(sprg7, 64)
5deb8e7ad8ac7e3 Alexander Graf 2014-04-24  982  

:::::: The code at line 978 was first introduced by commit
:::::: 5deb8e7ad8ac7e3fcdfa042acff617f461b361c2 KVM: PPC: Make shared struct aka magic page guest endian

:::::: TO: Alexander Graf <agraf@suse.de>
:::::: CC: Alexander Graf <agraf@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
