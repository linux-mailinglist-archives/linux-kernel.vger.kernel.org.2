Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9F382077
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhEPSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 14:41:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:15965 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhEPSlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 14:41:37 -0400
IronPort-SDR: XK8RzJipPxF4agIo6viZFC825FB+d8hY4mEQK40fa5+IaH6+kblfguMkNKRhs0RMBMe5+BQJGi
 0XGsr/RFo9zg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200401770"
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="gz'50?scan'50,208,50";a="200401770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 11:40:20 -0700
IronPort-SDR: ur+tKGoozGUkxKda96uSlSKxJS8UyV2fOKAxobxJ2+UG8s+lWKsdni3M0HpsCF8RBVBnWK0jEY
 gqsXhOCYlfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="gz'50?scan'50,208,50";a="540135273"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2021 11:40:18 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liLgX-0001Vb-VE; Sun, 16 May 2021 18:40:17 +0000
Date:   Mon, 17 May 2021 02:39:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:596:48: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202105170249.QeQcAXak-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63d1cb53e26a9a4168b84a8981b225c0a9cfa235
commit: ea29b20a828511de3348334e529a3d046a180416 init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM
date:   9 weeks ago
config: s390-randconfig-s032-20210517 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea29b20a828511de3348334e529a3d046a180416
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ea29b20a828511de3348334e529a3d046a180416
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:596:48: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:646:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *hwbase @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:646:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:646:35: sparse:     got void *hwbase
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1155:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1155:21: sparse:     expected unsigned long long [usertype] *ptr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1155:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1180:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1180:21: sparse:     expected unsigned long long [usertype] *ptr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1180:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: note: in included file (through arch/s390/include/asm/io.h, include/linux/io.h, include/linux/pci.h):
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
--
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:26:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:29:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:39:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:42:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:720:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: note: in included file (through arch/s390/include/asm/io.h, include/linux/io.h, include/linux/pci.h):
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: too many warnings
--
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:554:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] iplen @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:554:31: sparse:     expected unsigned short [usertype] iplen
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:554:31: sparse:     got restricted __be16 [usertype]
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:556:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] tot_len @@     got unsigned short [usertype] iplen @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:556:54: sparse:     expected restricted __be16 [usertype] tot_len
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:556:54: sparse:     got unsigned short [usertype] iplen
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:559:60: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] payload_len @@     got unsigned short [usertype] iplen @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:559:60: sparse:     expected restricted __be16 [usertype] payload_len
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:559:60: sparse:     got unsigned short [usertype] iplen
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c: note: in included file (through arch/s390/include/asm/io.h, include/linux/scatterlist.h, include/linux/dma-mapping.h, ...):
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]

vim +/__iomem +596 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

d424b6c024157f Sunil Goutham     2020-03-21  567  
d424b6c024157f Sunil Goutham     2020-03-21  568  static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
d424b6c024157f Sunil Goutham     2020-03-21  569  {
d424b6c024157f Sunil Goutham     2020-03-21  570  	void __iomem *hwbase;
d424b6c024157f Sunil Goutham     2020-03-21  571  	struct mbox *mbox;
d424b6c024157f Sunil Goutham     2020-03-21  572  	int err, vf;
d424b6c024157f Sunil Goutham     2020-03-21  573  	u64 base;
d424b6c024157f Sunil Goutham     2020-03-21  574  
d424b6c024157f Sunil Goutham     2020-03-21  575  	if (!numvfs)
d424b6c024157f Sunil Goutham     2020-03-21  576  		return -EINVAL;
d424b6c024157f Sunil Goutham     2020-03-21  577  
d424b6c024157f Sunil Goutham     2020-03-21  578  	pf->mbox_pfvf = devm_kcalloc(&pf->pdev->dev, numvfs,
d424b6c024157f Sunil Goutham     2020-03-21  579  				     sizeof(struct mbox), GFP_KERNEL);
d424b6c024157f Sunil Goutham     2020-03-21  580  	if (!pf->mbox_pfvf)
d424b6c024157f Sunil Goutham     2020-03-21  581  		return -ENOMEM;
d424b6c024157f Sunil Goutham     2020-03-21  582  
d424b6c024157f Sunil Goutham     2020-03-21  583  	pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
d424b6c024157f Sunil Goutham     2020-03-21  584  					   WQ_UNBOUND | WQ_HIGHPRI |
d424b6c024157f Sunil Goutham     2020-03-21  585  					   WQ_MEM_RECLAIM, 1);
d424b6c024157f Sunil Goutham     2020-03-21  586  	if (!pf->mbox_pfvf_wq)
d424b6c024157f Sunil Goutham     2020-03-21  587  		return -ENOMEM;
d424b6c024157f Sunil Goutham     2020-03-21  588  
facede8209ef0d Subbaraya Sundeep 2021-02-11  589  	/* On CN10K platform, PF <-> VF mailbox region follows after
facede8209ef0d Subbaraya Sundeep 2021-02-11  590  	 * PF <-> AF mailbox region.
facede8209ef0d Subbaraya Sundeep 2021-02-11  591  	 */
facede8209ef0d Subbaraya Sundeep 2021-02-11  592  	if (test_bit(CN10K_MBOX, &pf->hw.cap_flag))
facede8209ef0d Subbaraya Sundeep 2021-02-11  593  		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
facede8209ef0d Subbaraya Sundeep 2021-02-11  594  		       MBOX_SIZE;
facede8209ef0d Subbaraya Sundeep 2021-02-11  595  	else
facede8209ef0d Subbaraya Sundeep 2021-02-11 @596  		base = readq((void __iomem *)((u64)pf->reg_base +
facede8209ef0d Subbaraya Sundeep 2021-02-11  597  					      RVU_PF_VF_BAR4_ADDR));
d424b6c024157f Sunil Goutham     2020-03-21  598  
facede8209ef0d Subbaraya Sundeep 2021-02-11  599  	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
d424b6c024157f Sunil Goutham     2020-03-21  600  	if (!hwbase) {
d424b6c024157f Sunil Goutham     2020-03-21  601  		err = -ENOMEM;
d424b6c024157f Sunil Goutham     2020-03-21  602  		goto free_wq;
d424b6c024157f Sunil Goutham     2020-03-21  603  	}
d424b6c024157f Sunil Goutham     2020-03-21  604  
d424b6c024157f Sunil Goutham     2020-03-21  605  	mbox = &pf->mbox_pfvf[0];
d424b6c024157f Sunil Goutham     2020-03-21  606  	err = otx2_mbox_init(&mbox->mbox, hwbase, pf->pdev, pf->reg_base,
d424b6c024157f Sunil Goutham     2020-03-21  607  			     MBOX_DIR_PFVF, numvfs);
d424b6c024157f Sunil Goutham     2020-03-21  608  	if (err)
d424b6c024157f Sunil Goutham     2020-03-21  609  		goto free_iomem;
d424b6c024157f Sunil Goutham     2020-03-21  610  
d424b6c024157f Sunil Goutham     2020-03-21  611  	err = otx2_mbox_init(&mbox->mbox_up, hwbase, pf->pdev, pf->reg_base,
d424b6c024157f Sunil Goutham     2020-03-21  612  			     MBOX_DIR_PFVF_UP, numvfs);
d424b6c024157f Sunil Goutham     2020-03-21  613  	if (err)
d424b6c024157f Sunil Goutham     2020-03-21  614  		goto free_iomem;
d424b6c024157f Sunil Goutham     2020-03-21  615  
d424b6c024157f Sunil Goutham     2020-03-21  616  	for (vf = 0; vf < numvfs; vf++) {
d424b6c024157f Sunil Goutham     2020-03-21  617  		mbox->pfvf = pf;
d424b6c024157f Sunil Goutham     2020-03-21  618  		INIT_WORK(&mbox->mbox_wrk, otx2_pfvf_mbox_handler);
d424b6c024157f Sunil Goutham     2020-03-21  619  		INIT_WORK(&mbox->mbox_up_wrk, otx2_pfvf_mbox_up_handler);
d424b6c024157f Sunil Goutham     2020-03-21  620  		mbox++;
d424b6c024157f Sunil Goutham     2020-03-21  621  	}
d424b6c024157f Sunil Goutham     2020-03-21  622  
d424b6c024157f Sunil Goutham     2020-03-21  623  	return 0;
d424b6c024157f Sunil Goutham     2020-03-21  624  
d424b6c024157f Sunil Goutham     2020-03-21  625  free_iomem:
d424b6c024157f Sunil Goutham     2020-03-21  626  	if (hwbase)
d424b6c024157f Sunil Goutham     2020-03-21  627  		iounmap(hwbase);
d424b6c024157f Sunil Goutham     2020-03-21  628  free_wq:
d424b6c024157f Sunil Goutham     2020-03-21  629  	destroy_workqueue(pf->mbox_pfvf_wq);
d424b6c024157f Sunil Goutham     2020-03-21  630  	return err;
d424b6c024157f Sunil Goutham     2020-03-21  631  }
d424b6c024157f Sunil Goutham     2020-03-21  632  
d424b6c024157f Sunil Goutham     2020-03-21  633  static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
d424b6c024157f Sunil Goutham     2020-03-21  634  {
d424b6c024157f Sunil Goutham     2020-03-21  635  	struct mbox *mbox = &pf->mbox_pfvf[0];
d424b6c024157f Sunil Goutham     2020-03-21  636  
d424b6c024157f Sunil Goutham     2020-03-21  637  	if (!mbox)
d424b6c024157f Sunil Goutham     2020-03-21  638  		return;
d424b6c024157f Sunil Goutham     2020-03-21  639  
d424b6c024157f Sunil Goutham     2020-03-21  640  	if (pf->mbox_pfvf_wq) {
d424b6c024157f Sunil Goutham     2020-03-21  641  		destroy_workqueue(pf->mbox_pfvf_wq);
d424b6c024157f Sunil Goutham     2020-03-21  642  		pf->mbox_pfvf_wq = NULL;
d424b6c024157f Sunil Goutham     2020-03-21  643  	}
d424b6c024157f Sunil Goutham     2020-03-21  644  
d424b6c024157f Sunil Goutham     2020-03-21  645  	if (mbox->mbox.hwbase)
d424b6c024157f Sunil Goutham     2020-03-21 @646  		iounmap(mbox->mbox.hwbase);
d424b6c024157f Sunil Goutham     2020-03-21  647  
d424b6c024157f Sunil Goutham     2020-03-21  648  	otx2_mbox_destroy(&mbox->mbox);
d424b6c024157f Sunil Goutham     2020-03-21  649  }
d424b6c024157f Sunil Goutham     2020-03-21  650  

:::::: The code at line 596 was first introduced by commit
:::::: facede8209ef0dee84557c036e8502a99bb20a91 octeontx2-pf: cn10k: Add mbox support for CN10K

:::::: TO: Subbaraya Sundeep <sbhatta@marvell.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FHBNjac9OUDKbImvBCw3Fh1MgenUGTnMl8RmlO/02HVypR/EsZp8+cxEEcVms7ZZRVjjtGm+
JroEgHNC9hbOdTXMSN+tfAJ7282MkgbzkFNeZTfVBRGFSbMkJs1iaY16xAPs5TSgwaEDXiOY
hBZOQ3ngieyltWtjf8W217Cwej6KQ1IrL1aO4EVzWLhsHzOEXs1s17OySuabhSNpCuzTe1JX
bqwejmawDqIjTx7pEhh2KtsreziNN7b8qw6ak+Jg60ilkdZ9pawSUGd2fn3/NmGwZXp6uH/5
9eb8erp/mVTjXPg1lAtJVB28nIGUzadTR/jyconhmrz6E/Ezb98FIWxibN2f7KJqsZg2JHRJ
QvU4UgoMY+LqepyGU+o4TIpbvVnOnTmqoK11fegSHK4SYs6bDvDdKr8yY3iq6DYi+rx+urZF
AebXxtHwUj/Op0OWaFmFuSL/6/9VbxViDARLl8hV/0pajYaTnFbg5Pzy/E9nuf1aJIlZqnGg
Oq5M0CRQ3+SiJVFy+6c2rnHYu+z1O9rJ1/OrMkAcE2hx3Rx/t4QlC/Zzx9iRUJ+sALKwB0HC
rN7BZ2JXtsxKoP21AlqTGbe5C4exndjsEirQxIC1F1VWBWBJLly1slot/7bL5w1svJc+cZeb
jzmxHKO2Jh/vInKfl7VYWJOUiTCv5rEJ3MeJcsxSJv75+/fziwzI9Pr1/uE0+RJny+l8PvtF
99J0vBl7FT91rPnCuBjw7SBUJKXz+flt8o53Zf97ej7/mLyc/uO1res0PbZbwm/ZdSOQhe9e
7398e3og8rXztGl5UR8WlrdYpGekgh/yogNMI8NTGeFRATqpkTkdopiO4yLJZMKGlHKyQPRN
KnAsCmOJ7ODbgERtpe/0EDuMQuaHuFSuabB0mfwkOYta2AxG7ZaX6R0jXz507TNu9xBWVVbn
HEqWkkwCJQnfxWkrAxZ52uzD4Xdijx49FFaE+3gwADDqSnd9OAH9RN+D4VdAiM8tpvqlcg8X
PJnpsWp7eNYU8vzqetNcQC6dlI8+hpT1UKbaseR4b6iBzUEsWRSTUVIRydJoV9S2uCpoS3pY
afiQ35jt6uD4aLqoSk+pO1ZWStK3wllzWVhMvih/kfBc9H4iv8CPl69Pjz9f79FtWj9B7gpu
8UPqVPVzBXbL5NuP5/t/JvHL49PLyanSqtD0+huh7T6yWXFpzJ7VHMQvcKAzkOX1IWaaw14H
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
xXMnfQaWnCVIUAEuKtp10Do1/Bdq8xMJj+QBAA==

--DocE+STaALJfprDB--
