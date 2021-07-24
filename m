Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC13D4911
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhGXRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 13:30:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:40919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhGXRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:30:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="233884833"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="233884833"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 10:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="663759821"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2021 10:42:49 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7Lfk-0003ep-CY; Sat, 24 Jul 2021 17:42:48 +0000
Date:   Sun, 25 Jul 2021 01:41:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hch-block:blkdev.h-includes 16/16] drivers/nvdimm/btt.c:1159:26:
 error: invalid use of undefined type 'struct bio_integrity_payload'
Message-ID: <202107250145.wpphnpbK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.infradead.org/users/hch/block.git blkdev.h-includes
head:   48f7fda047613ceec07881f14a5eaf1ee19d4433
commit: 48f7fda047613ceec07881f14a5eaf1ee19d4433 [16/16] block: move the integrity definitions from bio.h to blk-integrity.h
config: powerpc-randconfig-s032-20210724 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        git remote add hch-block git://git.infradead.org/users/hch/block.git
        git fetch --no-tags hch-block blkdev.h-includes
        git checkout 48f7fda047613ceec07881f14a5eaf1ee19d4433
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/nvdimm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:7,
                    from drivers/nvdimm/btt.c:8:
   drivers/nvdimm/btt.c: In function 'btt_rw_integrity':
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/bvec.h:58:41: note: in definition of macro '__bvec_iter_bvec'
      58 | #define __bvec_iter_bvec(bvec, iter) (&(bvec)[(iter).bi_idx])
         |                                         ^~~~
   include/linux/bvec.h:90:3: note: in expansion of macro 'mp_bvec_iter_page'
      90 |  (mp_bvec_iter_page((bvec), (iter)) +   \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bvec.h:95:13: note: in expansion of macro 'bvec_iter_page'
      95 |  .bv_page = bvec_iter_page((bvec), (iter)), \
         |             ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/bvec.h:58:48: note: in definition of macro '__bvec_iter_bvec'
      58 | #define __bvec_iter_bvec(bvec, iter) (&(bvec)[(iter).bi_idx])
         |                                                ^~~~
   include/linux/bvec.h:90:3: note: in expansion of macro 'mp_bvec_iter_page'
      90 |  (mp_bvec_iter_page((bvec), (iter)) +   \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bvec.h:95:13: note: in expansion of macro 'bvec_iter_page'
      95 |  .bv_page = bvec_iter_page((bvec), (iter)), \
         |             ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/bvec.h:58:41: note: in definition of macro '__bvec_iter_bvec'
      58 | #define __bvec_iter_bvec(bvec, iter) (&(bvec)[(iter).bi_idx])
         |                                         ^~~~
   include/linux/bvec.h:72:3: note: in expansion of macro 'mp_bvec_iter_offset'
      72 |  (mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:91:3: note: in expansion of macro 'mp_bvec_iter_page_idx'
      91 |   mp_bvec_iter_page_idx((bvec), (iter)))
         |   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:95:13: note: in expansion of macro 'bvec_iter_page'
      95 |  .bv_page = bvec_iter_page((bvec), (iter)), \
         |             ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/bvec.h:58:48: note: in definition of macro '__bvec_iter_bvec'
      58 | #define __bvec_iter_bvec(bvec, iter) (&(bvec)[(iter).bi_idx])
         |                                                ^~~~
   include/linux/bvec.h:72:3: note: in expansion of macro 'mp_bvec_iter_offset'
      72 |  (mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:91:3: note: in expansion of macro 'mp_bvec_iter_page_idx'
      91 |   mp_bvec_iter_page_idx((bvec), (iter)))
         |   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:95:13: note: in expansion of macro 'bvec_iter_page'
      95 |  .bv_page = bvec_iter_page((bvec), (iter)), \
         |             ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/bvec.h:69:50: note: in definition of macro 'mp_bvec_iter_offset'
      69 |  (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
         |                                                  ^~~~
   include/linux/bvec.h:91:3: note: in expansion of macro 'mp_bvec_iter_page_idx'
      91 |   mp_bvec_iter_page_idx((bvec), (iter)))
         |   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:95:13: note: in expansion of macro 'bvec_iter_page'
      95 |  .bv_page = bvec_iter_page((bvec), (iter)), \
         |             ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from drivers/nvdimm/btt.c:6:
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:4: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |    ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:21: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                     ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:69:3: note: in expansion of macro '__bvec_iter_bvec'
      69 |  (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
         |   ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:69:3: note: in expansion of macro '__bvec_iter_bvec'
      69 |  (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
         |   ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   In file included from include/linux/list.h:8,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from drivers/nvdimm/btt.c:6:
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:4: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |    ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:38:3: note: in expansion of macro '__cmp_once'
      38 |   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
         |   ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:69:3: note: in expansion of macro '__bvec_iter_bvec'
      69 |  (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
         |   ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:69:3: note: in expansion of macro '__bvec_iter_bvec'
      69 |  (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
         |   ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/bvec.h:83:3: note: in expansion of macro 'mp_bvec_iter_offset'
      83 |  (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/bvec.h:87:20: note: in expansion of macro 'bvec_iter_offset'
      87 |        PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
         |                    ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from drivers/nvdimm/btt.c:6:
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:4: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |    ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:23:25: note: in expansion of macro '__is_constexpr'
      23 |   (__is_constexpr(x) && __is_constexpr(y))
         |                         ^~~~~~~~~~~~~~
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
>> drivers/nvdimm/btt.c:1159:26: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                          ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:66:6: note: in expansion of macro '__bvec_iter_bvec'
      66 |      __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
         |      ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:104:27: note: in expansion of macro '__careful_cmp'
     104 | #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
         |                           ^~~~~~~~~~~~~
   include/linux/bvec.h:86:2: note: in expansion of macro 'min_t'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |  ^~~~~
   include/linux/minmax.h:37:3: note: in expansion of macro '__cmp'
      37 |   __cmp(x, y, op), \
         |   ^~~~~
   include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   include/linux/bvec.h:65:2: note: in expansion of macro 'min'
      65 |  min((iter).bi_size,     \
         |  ^~~
   include/linux/bvec.h:86:18: note: in expansion of macro 'mp_bvec_iter_len'
      86 |  min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),  \
         |                  ^~~~~~~~~~~~~~~~
   include/linux/bvec.h:96:13: note: in expansion of macro 'bvec_iter_len'
      96 |  .bv_len  = bvec_iter_len((bvec), (iter)), \
         |             ^~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:8: note: in expansion of macro 'bvec_iter_bvec'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |        ^~~~~~~~~~~~~~
   drivers/nvdimm/btt.c:1159:40: error: invalid use of undefined type 'struct bio_integrity_payload'
    1159 |   bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
         |                                        ^~
   include/linux/minmax.h:28:27: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
..


vim +1159 drivers/nvdimm/btt.c

5212e11fde4d40 Vishal Verma    2015-06-25  1140  
41cd8b70c37ace Vishal Verma    2015-06-25  1141  #ifdef CONFIG_BLK_DEV_INTEGRITY
41cd8b70c37ace Vishal Verma    2015-06-25  1142  static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
41cd8b70c37ace Vishal Verma    2015-06-25  1143  			struct arena_info *arena, u32 postmap, int rw)
41cd8b70c37ace Vishal Verma    2015-06-25  1144  {
41cd8b70c37ace Vishal Verma    2015-06-25  1145  	unsigned int len = btt_meta_size(btt);
41cd8b70c37ace Vishal Verma    2015-06-25  1146  	u64 meta_nsoff;
41cd8b70c37ace Vishal Verma    2015-06-25  1147  	int ret = 0;
41cd8b70c37ace Vishal Verma    2015-06-25  1148  
41cd8b70c37ace Vishal Verma    2015-06-25  1149  	if (bip == NULL)
41cd8b70c37ace Vishal Verma    2015-06-25  1150  		return 0;
41cd8b70c37ace Vishal Verma    2015-06-25  1151  
41cd8b70c37ace Vishal Verma    2015-06-25  1152  	meta_nsoff = to_namespace_offset(arena, postmap) + btt->sector_size;
41cd8b70c37ace Vishal Verma    2015-06-25  1153  
41cd8b70c37ace Vishal Verma    2015-06-25  1154  	while (len) {
41cd8b70c37ace Vishal Verma    2015-06-25  1155  		unsigned int cur_len;
41cd8b70c37ace Vishal Verma    2015-06-25  1156  		struct bio_vec bv;
41cd8b70c37ace Vishal Verma    2015-06-25  1157  		void *mem;
41cd8b70c37ace Vishal Verma    2015-06-25  1158  
41cd8b70c37ace Vishal Verma    2015-06-25 @1159  		bv = bvec_iter_bvec(bip->bip_vec, bip->bip_iter);
41cd8b70c37ace Vishal Verma    2015-06-25  1160  		/*
41cd8b70c37ace Vishal Verma    2015-06-25  1161  		 * The 'bv' obtained from bvec_iter_bvec has its .bv_len and
41cd8b70c37ace Vishal Verma    2015-06-25  1162  		 * .bv_offset already adjusted for iter->bi_bvec_done, and we
41cd8b70c37ace Vishal Verma    2015-06-25  1163  		 * can use those directly
41cd8b70c37ace Vishal Verma    2015-06-25  1164  		 */
41cd8b70c37ace Vishal Verma    2015-06-25  1165  
41cd8b70c37ace Vishal Verma    2015-06-25  1166  		cur_len = min(len, bv.bv_len);
41cd8b70c37ace Vishal Verma    2015-06-25  1167  		mem = kmap_atomic(bv.bv_page);
41cd8b70c37ace Vishal Verma    2015-06-25  1168  		if (rw)
41cd8b70c37ace Vishal Verma    2015-06-25  1169  			ret = arena_write_bytes(arena, meta_nsoff,
3ae3d67ba705c7 Vishal Verma    2017-05-10  1170  					mem + bv.bv_offset, cur_len,
3ae3d67ba705c7 Vishal Verma    2017-05-10  1171  					NVDIMM_IO_ATOMIC);
41cd8b70c37ace Vishal Verma    2015-06-25  1172  		else
41cd8b70c37ace Vishal Verma    2015-06-25  1173  			ret = arena_read_bytes(arena, meta_nsoff,
3ae3d67ba705c7 Vishal Verma    2017-05-10  1174  					mem + bv.bv_offset, cur_len,
3ae3d67ba705c7 Vishal Verma    2017-05-10  1175  					NVDIMM_IO_ATOMIC);
41cd8b70c37ace Vishal Verma    2015-06-25  1176  
41cd8b70c37ace Vishal Verma    2015-06-25  1177  		kunmap_atomic(mem);
41cd8b70c37ace Vishal Verma    2015-06-25  1178  		if (ret)
41cd8b70c37ace Vishal Verma    2015-06-25  1179  			return ret;
41cd8b70c37ace Vishal Verma    2015-06-25  1180  
41cd8b70c37ace Vishal Verma    2015-06-25  1181  		len -= cur_len;
41cd8b70c37ace Vishal Verma    2015-06-25  1182  		meta_nsoff += cur_len;
b1fb2c52b2d85f Dmitry Monakhov 2017-06-29  1183  		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
b1fb2c52b2d85f Dmitry Monakhov 2017-06-29  1184  			return -EIO;
41cd8b70c37ace Vishal Verma    2015-06-25  1185  	}
41cd8b70c37ace Vishal Verma    2015-06-25  1186  
41cd8b70c37ace Vishal Verma    2015-06-25  1187  	return ret;
41cd8b70c37ace Vishal Verma    2015-06-25  1188  }
41cd8b70c37ace Vishal Verma    2015-06-25  1189  

:::::: The code at line 1159 was first introduced by commit
:::::: 41cd8b70c37ace40077c8d6ec0b74b983178c192 libnvdimm, btt: add support for blk integrity

:::::: TO: Vishal Verma <vishal.l.verma@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6TrnltStXW4iwmi0--
