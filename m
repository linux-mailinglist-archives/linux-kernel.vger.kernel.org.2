Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02D035D98F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbhDMIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:04:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:46023 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238700AbhDMID2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:03:28 -0400
IronPort-SDR: +X4y23YztOPoi5roYG2cQ6aFx7YFlJZztTupFi0vNjnTVLEG/clpijOdnT5QdlWU4pLNhbqpTA
 1jJRh/jl0RiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194477906"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="gz'50?scan'50,208,50";a="194477906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 01:02:29 -0700
IronPort-SDR: by/CyAbIfx40Hn0tqQ6RB30c8ZQ7Ss3M1HjSaONcHqzf8TgjFKDwkrHu9amh73uZ4AYda9uMoU
 hccsWrqY4BdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="gz'50?scan'50,208,50";a="443355295"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2021 01:02:27 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWE0A-0000w0-PO; Tue, 13 Apr 2021 08:02:26 +0000
Date:   Tue, 13 Apr 2021 16:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: lib/bitfield_kunit.c:93:1: warning: the frame size of 4184 bytes is
 larger than 2048 bytes
Message-ID: <202104131619.JDD81Hcm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vitor,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89698becf06d341a700913c3d89ce2a914af69a2
commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253 lib: kunit: add bitfield test conversion to KUnit
date:   6 months ago
config: arm-randconfig-r013-20210413 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2585f5164c298aaaed14c2c8d313cbe7bd5b253
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d2585f5164c298aaaed14c2c8d313cbe7bd5b253
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/bitfield_kunit.c: In function 'test_bitfields_compile':
   lib/bitfield_kunit.c:136:21: warning: unsigned conversion from 'int' to 'u16' {aka 'short unsigned int'} changes value from '393216' to '0' [-Woverflow]
     136 |  u16_encode_bits(0, 0x60000);
         |                     ^~~~~~~
   At top level:
   lib/bitfield_kunit.c:129:20: warning: 'test_bitfields_compile' defined but not used [-Wunused-function]
     129 | static void __init test_bitfields_compile(struct kunit *context)
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   lib/bitfield_kunit.c: In function 'test_bitfields_constants':
>> lib/bitfield_kunit.c:93:1: warning: the frame size of 4184 bytes is larger than 2048 bytes [-Wframe-larger-than=]
      93 | }
         | ^


vim +93 lib/bitfield_kunit.c

0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  10  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  11  #define CHECK_ENC_GET_U(tp, v, field, res) do {				\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  12  		{							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  13  			u##tp _res;					\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  14  									\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  15  			_res = u##tp##_encode_bits(v, field);		\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  16  			KUNIT_ASSERT_FALSE_MSG(context, _res != res,	\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  17  				       "u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",	\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  18  				       (u64)_res);			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  19  			KUNIT_ASSERT_FALSE(context,			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  20  				   u##tp##_get_bits(_res, field) != v);	\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  21  		}							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  22  	} while (0)
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  23  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  24  #define CHECK_ENC_GET_LE(tp, v, field, res) do {			\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  25  		{							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  26  			__le##tp _res;					\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  27  									\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  28  			_res = le##tp##_encode_bits(v, field);		\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  29  			KUNIT_ASSERT_FALSE_MSG(context,			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  30  				       _res != cpu_to_le##tp(res),	\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  31  				       "le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  32  				       (u64)le##tp##_to_cpu(_res),	\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  33  				       (u64)(res));			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  34  			KUNIT_ASSERT_FALSE(context,			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  35  				   le##tp##_get_bits(_res, field) != v);\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  36  		}							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  37  	} while (0)
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  38  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  39  #define CHECK_ENC_GET_BE(tp, v, field, res) do {			\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  40  		{							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  41  			__be##tp _res;					\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  42  									\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  43  			_res = be##tp##_encode_bits(v, field);		\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  44  			KUNIT_ASSERT_FALSE_MSG(context,			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  45  				       _res != cpu_to_be##tp(res),	\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  46  				       "be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",	\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  47  				       (u64)be##tp##_to_cpu(_res),	\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  48  				       (u64)(res));			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  49  			KUNIT_ASSERT_FALSE(context,			\
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  50  				   be##tp##_get_bits(_res, field) != v);\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  51  		}							\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  52  	} while (0)
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  53  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  54  #define CHECK_ENC_GET(tp, v, field, res) do {				\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  55  		CHECK_ENC_GET_U(tp, v, field, res);			\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  56  		CHECK_ENC_GET_LE(tp, v, field, res);			\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  57  		CHECK_ENC_GET_BE(tp, v, field, res);			\
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  58  	} while (0)
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  59  
d2585f5164c298 lib/bitfield_kunit.c Vitor Massaru Iha 2020-07-29  60  static void __init test_bitfields_constants(struct kunit *context)
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  61  {
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  62  	/*
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  63  	 * NOTE
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  64  	 * This whole function compiles (or at least should, if everything
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  65  	 * is going according to plan) to nothing after optimisation.
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  66  	 */
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  67  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  68  	CHECK_ENC_GET(16,  1, 0x000f, 0x0001);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  69  	CHECK_ENC_GET(16,  3, 0x00f0, 0x0030);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  70  	CHECK_ENC_GET(16,  5, 0x0f00, 0x0500);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  71  	CHECK_ENC_GET(16,  7, 0xf000, 0x7000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  72  	CHECK_ENC_GET(16, 14, 0x000f, 0x000e);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  73  	CHECK_ENC_GET(16, 15, 0x00f0, 0x00f0);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  74  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  75  	CHECK_ENC_GET_U(8,  1, 0x0f, 0x01);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  76  	CHECK_ENC_GET_U(8,  3, 0xf0, 0x30);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  77  	CHECK_ENC_GET_U(8, 14, 0x0f, 0x0e);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  78  	CHECK_ENC_GET_U(8, 15, 0xf0, 0xf0);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  79  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  80  	CHECK_ENC_GET(32,  1, 0x00000f00, 0x00000100);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  81  	CHECK_ENC_GET(32,  3, 0x0000f000, 0x00003000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  82  	CHECK_ENC_GET(32,  5, 0x000f0000, 0x00050000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  83  	CHECK_ENC_GET(32,  7, 0x00f00000, 0x00700000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  84  	CHECK_ENC_GET(32, 14, 0x0f000000, 0x0e000000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  85  	CHECK_ENC_GET(32, 15, 0xf0000000, 0xf0000000);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  86  
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  87  	CHECK_ENC_GET(64,  1, 0x00000f0000000000ull, 0x0000010000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  88  	CHECK_ENC_GET(64,  3, 0x0000f00000000000ull, 0x0000300000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  89  	CHECK_ENC_GET(64,  5, 0x000f000000000000ull, 0x0005000000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  90  	CHECK_ENC_GET(64,  7, 0x00f0000000000000ull, 0x0070000000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  91  	CHECK_ENC_GET(64, 14, 0x0f00000000000000ull, 0x0e00000000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  92  	CHECK_ENC_GET(64, 15, 0xf000000000000000ull, 0xf000000000000000ull);
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20 @93  }
0e2dc70e3d0d50 lib/test_bitfield.c  Johannes Berg     2018-06-20  94  

:::::: The code at line 93 was first introduced by commit
:::::: 0e2dc70e3d0d503b0cc9c5f74db3eb6db52c9e22 bitfield: add tests

:::::: TO: Johannes Berg <johannes@sipsolutions.net>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zYM0uCDKw75PZbzx--
