Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D13FC076
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbhHaBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:23:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:9877 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239214AbhHaBXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:23:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205599132"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="gz'50?scan'50,208,50";a="205599132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 18:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="gz'50?scan'50,208,50";a="687477980"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2021 18:22:53 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKsUG-0005fo-Jk; Tue, 31 Aug 2021 01:22:52 +0000
Date:   Tue, 31 Aug 2021 09:22:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202108310929.aMMU1E3T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8596e589b787732c8346f0482919e83cc9362db1
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   8 months ago
config: s390-randconfig-s031-20210830 (attached as .config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/s390/boot/compressed/decompressor.c: note: in included file (through arch/s390/boot/compressed/../../../../lib/decompress_unxz.c):
>> arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *

vim +393 arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin 2011-01-12  385  
24fa0402a9b6a5 Lasse Collin 2011-01-12  386  /* Decode the Stream Header field (the first 12 bytes of the .xz Stream). */
24fa0402a9b6a5 Lasse Collin 2011-01-12  387  static enum xz_ret dec_stream_header(struct xz_dec *s)
24fa0402a9b6a5 Lasse Collin 2011-01-12  388  {
24fa0402a9b6a5 Lasse Collin 2011-01-12  389  	if (!memeq(s->temp.buf, HEADER_MAGIC, HEADER_MAGIC_SIZE))
24fa0402a9b6a5 Lasse Collin 2011-01-12  390  		return XZ_FORMAT_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  391  
24fa0402a9b6a5 Lasse Collin 2011-01-12  392  	if (xz_crc32(s->temp.buf + HEADER_MAGIC_SIZE, 2, 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12 @393  			!= get_le32(s->temp.buf + HEADER_MAGIC_SIZE + 2))
24fa0402a9b6a5 Lasse Collin 2011-01-12  394  		return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  395  
24fa0402a9b6a5 Lasse Collin 2011-01-12  396  	if (s->temp.buf[HEADER_MAGIC_SIZE] != 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12  397  		return XZ_OPTIONS_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  398  
24fa0402a9b6a5 Lasse Collin 2011-01-12  399  	/*
24fa0402a9b6a5 Lasse Collin 2011-01-12  400  	 * Of integrity checks, we support only none (Check ID = 0) and
24fa0402a9b6a5 Lasse Collin 2011-01-12  401  	 * CRC32 (Check ID = 1). However, if XZ_DEC_ANY_CHECK is defined,
24fa0402a9b6a5 Lasse Collin 2011-01-12  402  	 * we will accept other check types too, but then the check won't
24fa0402a9b6a5 Lasse Collin 2011-01-12  403  	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
24fa0402a9b6a5 Lasse Collin 2011-01-12  404  	 */
24fa0402a9b6a5 Lasse Collin 2011-01-12  405  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a5 Lasse Collin 2011-01-12  406  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KCC92BtxCfA/wECtM231AAA=

--X1bOJ3K7DJ5YkBrT--
