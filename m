Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B677231933C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhBKTjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:39:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:22155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhBKTjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:39:01 -0500
IronPort-SDR: 7sBezLN4sP5SOPJnbUS4MQAIqaJr+j1iwhnJiRFNqcjPBb4xiFzTPyrxfItwLZFnfntK6buSMd
 Feyo+9UalZAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="178796164"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="gz'50?scan'50,208,50";a="178796164"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 11:38:14 -0800
IronPort-SDR: b9kL3zspJrGCaF7OW4bj+cvhi+EnTOxK/rzv1wm8QQsGE+SEbnd6A5b1Ny59gcsfe+mM7vVNj8
 VsOr3ezKuYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="gz'50?scan'50,208,50";a="399629870"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2021 11:38:11 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAHn0-00041Z-OH; Thu, 11 Feb 2021 19:38:10 +0000
Date:   Fri, 12 Feb 2021 03:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gene Chen <gene_chen@richtek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: include/linux/unaligned/be_byteshift.h:51:19: error: redefinition of
 'get_unaligned_be64'
Message-ID: <202102120317.K5xpdsVK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gene,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
commit: 1f4877218f7e2c2b914aeb69a8a0f47d59c74717 iio: adc: mt6360: Add ADC driver for MT6360
date:   3 months ago
config: arc-randconfig-r024-20210209 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f4877218f7e2c2b914aeb69a8a0f47d59c74717
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1f4877218f7e2c2b914aeb69a8a0f47d59c74717
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/mt6360-adc.c:12:
   include/linux/unaligned/be_byteshift.h:41:19: error: redefinition of 'get_unaligned_be16'
      41 | static inline u16 get_unaligned_be16(const void *p)
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:23:28: note: previous definition of 'get_unaligned_be16' was here
      23 | static __always_inline u16 get_unaligned_be16(const void *p)
         |                            ^~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/mt6360-adc.c:12:
   include/linux/unaligned/be_byteshift.h:46:19: error: redefinition of 'get_unaligned_be32'
      46 | static inline u32 get_unaligned_be32(const void *p)
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:28:28: note: previous definition of 'get_unaligned_be32' was here
      28 | static __always_inline u32 get_unaligned_be32(const void *p)
         |                            ^~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/mt6360-adc.c:12:
>> include/linux/unaligned/be_byteshift.h:51:19: error: redefinition of 'get_unaligned_be64'
      51 | static inline u64 get_unaligned_be64(const void *p)
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:33:28: note: previous definition of 'get_unaligned_be64' was here
      33 | static __always_inline u64 get_unaligned_be64(const void *p)
         |                            ^~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/mt6360-adc.c:12:
   include/linux/unaligned/be_byteshift.h:56:20: error: redefinition of 'put_unaligned_be16'
      56 | static inline void put_unaligned_be16(u16 val, void *p)
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:53:29: note: previous definition of 'put_unaligned_be16' was here
      53 | static __always_inline void put_unaligned_be16(u16 val, void *p)
         |                             ^~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/mt6360-adc.c:12:
   include/linux/unaligned/be_byteshift.h:61:20: error: redefinition of 'put_unaligned_be32'
      61 | static inline void put_unaligned_be32(u32 val, void *p)
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:58:29: note: previous definition of 'put_unaligned_be32' was here
      58 | static __always_inline void put_unaligned_be32(u32 val, void *p)
         |                             ^~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/adc/mt6360-adc.c:12:
   include/linux/unaligned/be_byteshift.h:66:20: error: redefinition of 'put_unaligned_be64'
      66 | static inline void put_unaligned_be64(u64 val, void *p)
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/unaligned.h:13,
                    from arch/arc/include/asm/unaligned.h:11,
                    from arch/arc/include/asm/io.h:12,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from drivers/iio/adc/mt6360-adc.c:5:
   include/linux/unaligned/access_ok.h:63:29: note: previous definition of 'put_unaligned_be64' was here
      63 | static __always_inline void put_unaligned_be64(u64 val, void *p)
         |                             ^~~~~~~~~~~~~~~~~~


vim +/get_unaligned_be64 +51 include/linux/unaligned/be_byteshift.h

064106a91be5e7 Harvey Harrison 2008-04-29  50  
064106a91be5e7 Harvey Harrison 2008-04-29 @51  static inline u64 get_unaligned_be64(const void *p)
064106a91be5e7 Harvey Harrison 2008-04-29  52  {
19f747f7370fcf Bart Van Assche 2020-03-13  53  	return __get_unaligned_be64(p);
064106a91be5e7 Harvey Harrison 2008-04-29  54  }
064106a91be5e7 Harvey Harrison 2008-04-29  55  

:::::: The code at line 51 was first introduced by commit
:::::: 064106a91be5e76cb42c1ddf5d3871e3a1bd2a23 kernel: add common infrastructure for unaligned access

:::::: TO: Harvey Harrison <harvey.harrison@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XbB/Ae9xRDUqHAEA

--6c2NcOVqGQ03X4Wi--
