Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5133616FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 02:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhDPA4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 20:56:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:15388 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhDPA4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:56:36 -0400
IronPort-SDR: eA6CfI2W2RbvFnwKOSwP1LI99h7RMuvJKTHL91SDXQVkGY2NrfCv5oh+kiDK0wLO+uqPEo26dQ
 ypQ3aW7miHuw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191781998"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="gz'50?scan'50,208,50";a="191781998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 17:56:12 -0700
IronPort-SDR: pEoQkCCiVJ0fok2olGfOULhXk5k16WjLXvZyVsP/6WdoLziFxDjWXoogytFG1Sslax2Pej3yex
 ADyEsaAXtryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="gz'50?scan'50,208,50";a="418946157"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2021 17:56:08 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXCmE-0001BB-LC; Fri, 16 Apr 2021 00:56:06 +0000
Date:   Fri, 16 Apr 2021 08:55:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds 1/13]
 arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset
 [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject
 'feature' with type 'unsigned char' at offset 1
Message-ID: <202104160817.a5FOA0xa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
head:   8bd0f043b3e94069930bec5cb3fbb5c857748c80
commit: 5f8bd90197ff7ab1cf9f06dd9c594f3636c71297 [1/13] Makefile: Enable -Warray-bounds
config: alpha-randconfig-r013-20210415 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=5f8bd90197ff7ab1cf9f06dd9c594f3636c71297
        git remote add gustavoars-linux https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars-linux testing/warray-bounds
        git checkout 5f8bd90197ff7ab1cf9f06dd9c594f3636c71297
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:21,
                    from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from drivers/ide/ide-ioctls.c:6:
   In function 'ide_task_ioctl',
       inlined from 'generic_ide_ioctl' at drivers/ide/ide-ioctls.c:287:10:
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   drivers/ide/ide-ioctls.c:213:2: note: in expansion of macro 'memcpy'
     213 |  memcpy(&cmd.tf.feature, &args[1], 6);
         |  ^~~~~~
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   drivers/ide/ide-ioctls.c:221:2: note: in expansion of macro 'memcpy'
     221 |  memcpy(&args[1], &cmd.tf.feature, 6);
         |  ^~~~~~
--
   In file included from include/linux/string.h:21,
                    from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bio.h:8,
                    from drivers/md/bcache/bcache.h:182,
                    from drivers/md/bcache/alloc.c:64:
   In function 'pick_data_bucket',
       inlined from 'bch_alloc_sectors' at drivers/md/bcache/alloc.c:627:15:
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   include/uapi/linux/bcache.h:109:32: note: in expansion of macro 'memcpy'
     109 | #define bkey_copy(_dest, _src) memcpy(_dest, _src, bkey_bytes(_src))
         |                                ^~~~~~
   drivers/md/bcache/alloc.c:586:3: note: in expansion of macro 'bkey_copy'
     586 |   bkey_copy(&ret->key, alloc);
         |   ^~~~~~~~~
--
   In file included from include/linux/string.h:21,
                    from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:16,
                    from drivers/media/pci/ngene/ngene-core.c:13:
   drivers/media/pci/ngene/ngene-core.c: In function 'ngene_command_config_free_buf':
>> arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
      22 | #define memcpy __builtin_memcpy
   drivers/media/pci/ngene/ngene-core.c:388:2: note: in expansion of macro 'memcpy'
     388 |  memcpy(&com.cmd.ConfigureBuffers.config, config, 6);
         |  ^~~~~~


vim +22 arch/alpha/include/asm/string.h

^1da177e4c3f415 include/asm-alpha/string.h Linus Torvalds 2005-04-16  21  
^1da177e4c3f415 include/asm-alpha/string.h Linus Torvalds 2005-04-16 @22  #define memcpy __builtin_memcpy
^1da177e4c3f415 include/asm-alpha/string.h Linus Torvalds 2005-04-16  23  

:::::: The code at line 22 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bp/iNruPH9dso1Pn--
