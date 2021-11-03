Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB44449E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhKCVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:00:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:61530 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhKCVAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:00:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218787803"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="gz'50?scan'50,208,50";a="218787803"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 13:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="gz'50?scan'50,208,50";a="489711116"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2021 13:57:28 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miNK3-0005qT-U6; Wed, 03 Nov 2021 20:57:27 +0000
Date:   Thu, 4 Nov 2021 04:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: arch/s390/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202111040455.l6k7r56a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a602285ac11b019e9ce7c3907328e9f95f4967f0
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   10 months ago
config: s390-randconfig-s032-20211103 (attached as .config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
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

--0F1p//8PRICkK4MW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
UPdo2T2wAAA=

--0F1p//8PRICkK4MW--
