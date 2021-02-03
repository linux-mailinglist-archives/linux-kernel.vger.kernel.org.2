Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314530D411
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhBCHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:33:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:40932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhBCHdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:33:00 -0500
IronPort-SDR: i2S0QIFXU8DIqnKqAFx9f79dtpMA1OOKVHlYQqMMw2ShF0dYgwXdqX71il4l06E/LoVGuWq8I7
 3pelLPlX7tpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242511168"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="242511168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 23:32:07 -0800
IronPort-SDR: j/0VlVa4SLTVYsgsrOI2BkDf2scTQpnbwY8tOblf55jqabwDgvGsfU92d+pNLK0KW2GoMyC0hq
 mCpUWH+BmLhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="372280971"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2021 23:32:01 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7Cds-00008z-Ig; Wed, 03 Feb 2021 07:32:00 +0000
Date:   Wed, 03 Feb 2021 15:31:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:willy-maple] BUILD REGRESSION
 7e346d2845b4bd77663394f39fa70456e0084c86
Message-ID: <601a5159.wxfxTnVx6t+jU5Nh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git willy-maple
branch HEAD: 7e346d2845b4bd77663394f39fa70456e0084c86  vma_iterator and /proc/$pid/maps

Error/Warning reports:

https://lore.kernel.org/lkml/202102030620.iqKSz7vJ-lkp@intel.com
https://lore.kernel.org/lkml/202102030650.iZBgPiVQ-lkp@intel.com
https://lore.kernel.org/lkml/202102030655.arrcFfTg-lkp@intel.com
https://lore.kernel.org/lkml/202102030719.jw9ahlsz-lkp@intel.com
https://lore.kernel.org/lkml/202102030727.M5PKkEGW-lkp@intel.com
https://lore.kernel.org/lkml/202102030728.8eFDkf8E-lkp@intel.com
https://lore.kernel.org/lkml/202102030733.ToNwP3su-lkp@intel.com
https://lore.kernel.org/lkml/202102030750.3Ozx5bhz-lkp@intel.com
https://lore.kernel.org/lkml/202102030953.0zx5H2qj-lkp@intel.com
https://lore.kernel.org/lkml/202102031140.3Ms6psce-lkp@intel.com

Error/Warning in current branch:

fs/proc/task_nommu.c:29:23: error: 'struct mm_struct' has no member named 'mm_rb'
include/linux/compiler_types.h:140:35: error: 'struct vm_area_struct' has no member named 'vm_rb'
include/linux/compiler_types.h:140:35: error: 'struct vm_region' has no member named 'vm_rb'
include/linux/kernel.h:694:51: error: 'struct vm_area_struct' has no member named 'vm_rb'
include/linux/kernel.h:694:51: error: 'struct vm_region' has no member named 'vm_rb'
include/linux/maple_tree.h:79:22: error: 'MAPLE_RANGE64_SLOTS' undeclared here (not in a function)
include/linux/maple_tree.h:79:22: error: use of undeclared identifier 'MAPLE_RANGE64_SLOTS'
include/linux/maple_tree.h:85:22: error: 'MAPLE_ARANGE64_SLOTS' undeclared here (not in a function)
include/linux/maple_tree.h:85:22: error: use of undeclared identifier 'MAPLE_ARANGE64_SLOTS'
include/linux/maple_tree.h:91:28: error: 'MAPLE_NODE_SLOTS' undeclared here (not in a function); did you mean
include/linux/maple_tree.h:91:28: error: 'MAPLE_NODE_SLOTS' undeclared here (not in a function); did you mean 'MAPLE_ALLOC_SLOTS'?
include/linux/maple_tree.h:96:27: error: use of undeclared identifier 'MAPLE_NODE_SLOTS'
include/linux/mm.h:2595:6: warning: no previous prototype for 'mm_populate_vma' [-Wmissing-prototypes]
include/linux/mm.h:2605:6: warning: no previous prototype for 'mm_populate_vma' [-Wmissing-prototypes]
lib/maple_tree.c:3273:6: warning: no previous prototype for 'mas_is_span_wr' [-Wmissing-prototypes]
lib/maple_tree.c:3373:6: warning: no previous prototype for 'mas_wr_walk' [-Wmissing-prototypes]
lib/maple_tree.c:5618:5: warning: no previous prototype for 'mtree_store' [-Wmissing-prototypes]
lib/maple_tree.c:5633:5: warning: no previous prototype for 'mtree_store' [-Wmissing-prototypes]
lib/maple_tree.c:5677:5: warning: no previous prototype for 'mtree_alloc_range' [-Wmissing-prototypes]
lib/maple_tree.c:5692:5: warning: no previous prototype for 'mtree_alloc_range' [-Wmissing-prototypes]
lib/maple_tree.c:5712:5: warning: no previous prototype for 'mtree_alloc_rrange' [-Wmissing-prototypes]
lib/maple_tree.c:5727:5: warning: no previous prototype for 'mtree_alloc_rrange' [-Wmissing-prototypes]
mm/mempolicy.c:807:25: warning: variable 'next' set but not used [-Wunused-but-set-variable]
mm/mmap.c:2361:5: warning: no previous prototype for 'do_mas_align_munmap' [-Wmissing-prototypes]
mm/mmap.c:2479:5: warning: no previous prototype for 'do_mas_align_munmap' [-Wmissing-prototypes]
mm/mmap.c:2825:18: warning: variable 'ma_lock' set but not used [-Wunused-but-set-variable]
mm/mmap.c:2830:18: warning: variable 'ma_lock' set but not used [-Wunused-but-set-variable]
mm/nommu.c:22:10: fatal error: linux/vmacache.h: No such file or directory

possible Error/Warning in current branch:

include/asm-generic/rwonce.h:55:30: error: assignment of read-only location '*(const volatile unsigned char *)&<erroneous-expression>[(int)slot]'
include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'int' [-Wformat=]
include/linux/kern_levels.h:5:18: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'int' [-Wformat=]
include/linux/rcupdate.h:388:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
include/linux/rcupdate.h:388:36: error: invalid type argument of unary '*' (have 'int')
include/uapi/linux/const.h:34:54: error: invalid operands to binary / (have 'const unsigned char *' and 'const unsigned char *')
lib/maple_tree.c:1014:14: warning: assignment to 'struct maple_alloc *' from 'unsigned char' makes pointer from integer without a cast [-Wint-conversion]
lib/maple_tree.c:1022:33: error: assignment of read-only location '<erroneous-expression>[(int)node->node_count--]'
lib/maple_tree.c:1053:33: warning: comparison between pointer and integer
lib/maple_tree.c:1056:32: error: assignment of read-only location '<erroneous-expression>[(int)head->node_count]'
lib/maple_tree.c:1064:18: error: assignment of read-only location '<erroneous-expression>[0]'
lib/maple_tree.c:1109:26: warning: initialization of 'unsigned int' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:1128:9: error: assignment to 'struct maple_alloc **' from incompatible pointer type 'const unsigned char *' [-Werror=incompatible-pointer-types]
lib/maple_tree.c:1215:16: warning: assignment to 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:1286:15: sparse: sparse: incorrect type in assignment (different address spaces)
lib/maple_tree.c:1395:16: error: 'MAPLE_ARANGE64_META_MAX' undeclared (first use in this function)
lib/maple_tree.c:1779:32: sparse: sparse: incorrect type in initializer (different address spaces)
lib/maple_tree.c:3373:6: sparse: sparse: symbol 'mas_wr_walk' was not declared. Should it be static?
lib/maple_tree.c:3392:58: sparse: sparse: incorrect type in argument 2 (different address spaces)
lib/maple_tree.c:3565:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
lib/maple_tree.c:376:33: error: invalid operands to binary & (have 'long unsigned int' and 'const unsigned char *')
lib/maple_tree.c:376:35: error: wrong type argument to bit-complement
lib/maple_tree.c:376:36: error: 'MAPLE_NODE_MASK' undeclared (first use in this function); did you mean 'MAPLE_HEIGHT_MASK'?
lib/maple_tree.c:40:19: error: initializer element is not constant
lib/maple_tree.c:40:19: warning: initialization of 'unsigned char' from 'const long unsigned int *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:463:10: error: returning 'const unsigned char *' from a function with incompatible return type 'long unsigned int *' [-Werror=incompatible-pointer-types]
lib/maple_tree.c:49:21: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:5179:23: sparse: sparse: incorrect type in assignment (different address spaces)
lib/maple_tree.c:5274:20: warning: initialization of 'int' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:5288:15: warning: assignment to 'int' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:5289:20: warning: initialization of 'int' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:5303:15: warning: assignment to 'int' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
lib/maple_tree.c:56:36: error: invalid operands to binary / (have 'const unsigned char *' and 'int')
lib/maple_tree.c:5790:26: sparse: sparse: incorrect type in argument 1 (different address spaces)
lib/maple_tree.c:5791:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
lib/maple_tree.c:5922:6: warning: no previous prototype for 'mt_dump_range' [-Wmissing-prototypes]
lib/maple_tree.c:5932:6: warning: no previous prototype for 'mt_dump_entry' [-Wmissing-prototypes]
lib/maple_tree.c:5937:6: warning: no previous prototype for 'mt_dump_range' [-Wmissing-prototypes]
lib/maple_tree.c:5947:6: warning: no previous prototype for 'mt_dump_entry' [-Wmissing-prototypes]
lib/maple_tree.c:5948:6: warning: no previous prototype for 'mt_dump_range64' [-Wmissing-prototypes]
lib/maple_tree.c:5963:6: warning: no previous prototype for 'mt_dump_range64' [-Wmissing-prototypes]
lib/maple_tree.c:5985:28: warning: passing argument 1 of 'mt_dump_entry' makes pointer from integer without a cast [-Wint-conversion]
lib/maple_tree.c:5985:6: warning: no previous prototype for 'mt_dump_arange64' [-Wmissing-prototypes]
lib/maple_tree.c:5987:27: warning: passing argument 1 of 'mt_dump_node' makes pointer from integer without a cast [-Wint-conversion]
lib/maple_tree.c:6000:6: warning: no previous prototype for 'mt_dump_arange64' [-Wmissing-prototypes]
lib/maple_tree.c:6074:6: warning: no previous prototype for 'mas_validate_gaps' [-Wmissing-prototypes]
lib/maple_tree.c:6089:6: warning: no previous prototype for 'mas_validate_gaps' [-Wmissing-prototypes]
lib/maple_tree.c:610:27: error: assignment of read-only location '<erroneous-expression>[(int)piv]'
lib/maple_tree.c:6163:6: warning: no previous prototype for 'mas_validate_parent_slot' [-Wmissing-prototypes]
lib/maple_tree.c:6178:6: warning: no previous prototype for 'mas_validate_parent_slot' [-Wmissing-prototypes]
lib/maple_tree.c:6196:6: warning: no previous prototype for 'mas_validate_child_slot' [-Wmissing-prototypes]
lib/maple_tree.c:6211:6: warning: no previous prototype for 'mas_validate_child_slot' [-Wmissing-prototypes]
lib/maple_tree.c:6230:6: warning: no previous prototype for 'mas_validate_limits' [-Wmissing-prototypes]
lib/maple_tree.c:6245:6: warning: no previous prototype for 'mas_validate_limits' [-Wmissing-prototypes]
lib/maple_tree.c:6281:6: warning: no previous prototype for 'mt_validate_nulls' [-Wmissing-prototypes]
lib/maple_tree.c:6296:6: warning: no previous prototype for 'mt_validate_nulls' [-Wmissing-prototypes]
lib/maple_tree.c:6323:6: warning: no previous prototype for 'mt_validate' [-Wmissing-prototypes]
lib/maple_tree.c:6338:6: warning: no previous prototype for 'mt_validate' [-Wmissing-prototypes]
lib/maple_tree.c:643:10: error: returning 'const unsigned char *' from a function with incompatible return type 'void **' [-Werror=incompatible-pointer-types]
lib/maple_tree.c:67:22: error: size of array 'slot' has non-integer type
lib/maple_tree.c:67:9: warning: ISO C90 forbids array 'slot' whose size can't be evaluated [-Wvla]
lib/maple_tree.c:67:9: warning: variably modified 'slot' at file scope
lib/maple_tree.c:681:24: sparse:    void *
lib/maple_tree.c:681:24: sparse:    void [noderef] __rcu *
lib/maple_tree.c:681:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
lib/maple_tree.c:681:24: sparse: sparse: too many errors
lib/maple_tree.c:68:16: error: size of array 'pivot' has non-integer type
lib/maple_tree.c:68:2: warning: ISO C90 forbids array 'pivot' whose size can't be evaluated [-Wvla]
lib/maple_tree.c:68:2: warning: variably modified 'pivot' at file scope
lib/maple_tree.c:69:16: error: size of array 'gap' has non-integer type
lib/maple_tree.c:69:2: warning: ISO C90 forbids array 'gap' whose size can't be evaluated [-Wvla]
lib/maple_tree.c:69:2: warning: variably modified 'gap' at file scope
lib/maple_tree.c:922:34: error: assignment of read-only location '<erroneous-expression>[(int)gap]'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_child_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_gaps
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_limits
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_parent_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_arange64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_entry
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate
|   `-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate_nulls
|-- alpha-defconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|   `-- mm-mmap.c:warning:variable-ma_lock-set-but-not-used
|-- arc-allyesconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-allmodconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-allyesconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-neponset_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-pcm027_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm-pxa_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- arm64-allyesconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|-- arm64-defconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|-- c6x-allyesconfig
|   |-- fs-proc-task_nommu.c:error:struct-mm_struct-has-no-member-named-mm_rb
|   |-- include-asm-generic-rwonce.h:error:assignment-of-read-only-location-(const-volatile-unsigned-char-)-erroneous-expression-(int)slot
|   |-- include-linux-compiler_types.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-kern_levels.h:warning:format-lu-expects-argument-of-type-long-unsigned-int-but-argument-has-type-int
|   |-- include-linux-kern_levels.h:warning:format-p-expects-argument-of-type-void-but-argument-has-type-int
|   |-- include-linux-kernel.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-kernel.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-mm.h:warning:no-previous-prototype-for-mm_populate_vma
|   |-- include-linux-rcupdate.h:error:invalid-type-argument-of-unary-(have-int-)
|   |-- include-linux-rcupdate.h:warning:cast-to-pointer-from-integer-of-different-size
|   |-- include-uapi-linux-const.h:error:invalid-operands-to-binary-(have-const-unsigned-char-and-const-unsigned-char-)
|   |-- lib-maple_tree.c:error:MAPLE_ARANGE64_META_MAX-undeclared-(first-use-in-this-function)
|   |-- lib-maple_tree.c:error:MAPLE_NODE_MASK-undeclared-(first-use-in-this-function)
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)gap
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)head-node_count
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)node-node_count
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)piv
|   |-- lib-maple_tree.c:error:assignment-to-struct-maple_alloc-from-incompatible-pointer-type-const-unsigned-char
|   |-- lib-maple_tree.c:error:initializer-element-is-not-constant
|   |-- lib-maple_tree.c:error:invalid-operands-to-binary-(have-const-unsigned-char-and-int-)
|   |-- lib-maple_tree.c:error:invalid-operands-to-binary-(have-long-unsigned-int-and-const-unsigned-char-)
|   |-- lib-maple_tree.c:error:returning-const-unsigned-char-from-a-function-with-incompatible-return-type-long-unsigned-int
|   |-- lib-maple_tree.c:error:returning-const-unsigned-char-from-a-function-with-incompatible-return-type-void
|   |-- lib-maple_tree.c:error:size-of-array-gap-has-non-integer-type
|   |-- lib-maple_tree.c:error:size-of-array-pivot-has-non-integer-type
|   |-- lib-maple_tree.c:error:size-of-array-slot-has-non-integer-type
|   |-- lib-maple_tree.c:error:wrong-type-argument-to-bit-complement
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-gap-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-pivot-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-slot-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:assignment-to-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:assignment-to-struct-maple_alloc-from-unsigned-char-makes-pointer-from-integer-without-a-cast
|   |-- lib-maple_tree.c:warning:assignment-to-unsigned-char-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:comparison-between-pointer-and-integer
|   |-- lib-maple_tree.c:warning:initialization-of-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-char-from-const-long-unsigned-int-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-char-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_child_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_gaps
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_limits
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_parent_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_arange64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_entry
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate_nulls
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- lib-maple_tree.c:warning:passing-argument-of-mt_dump_entry-makes-pointer-from-integer-without-a-cast
|   |-- lib-maple_tree.c:warning:passing-argument-of-mt_dump_node-makes-pointer-from-integer-without-a-cast
|   |-- lib-maple_tree.c:warning:variably-modified-gap-at-file-scope
|   |-- lib-maple_tree.c:warning:variably-modified-pivot-at-file-scope
|   |-- lib-maple_tree.c:warning:variably-modified-slot-at-file-scope
|   `-- mm-nommu.c:fatal-error:linux-vmacache.h:No-such-file-or-directory
|-- c6x-evmc6474_defconfig
|   |-- fs-proc-task_nommu.c:error:struct-mm_struct-has-no-member-named-mm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-kernel.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-kernel.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-mm.h:warning:no-previous-prototype-for-mm_populate_vma
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-nommu.c:fatal-error:linux-vmacache.h:No-such-file-or-directory
|-- h8300-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a001-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a002-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a003-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a004-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a005-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a006-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-randconfig-m021-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- i386-tinyconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- m68k-allmodconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- m68k-amiga_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- m68k-hp300_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- m68k-m5272c3_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- m68k-randconfig-r006-20210202
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- mips-allmodconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- mips-allyesconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- mips-maltaup_xpa_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- mips-randconfig-s031-20210202
|   |-- lib-maple_tree.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-maple_enode-enode-got-void-noderef-__rcu-ma_root
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-entry-got-void-noderef-__rcu-ma_root
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-slots-got-void-noderef-__rcu
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-assigned-slots-got-void-noderef-__rcu
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-slots-got-void-noderef-__rcu
|   |-- lib-maple_tree.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-slots-got-void-noderef-__rcu
|   |-- lib-maple_tree.c:sparse:sparse:symbol-mas_wr_walk-was-not-declared.-Should-it-be-static
|   |-- lib-maple_tree.c:sparse:sparse:too-many-errors
|   |-- lib-maple_tree.c:sparse:void
|   `-- lib-maple_tree.c:sparse:void-noderef-__rcu
|-- nds32-allnoconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- nios2-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- openrisc-or1klitex_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- parisc-allyesconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- parisc-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-acadia_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-allmodconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   `-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|-- powerpc-allnoconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-allyesconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   `-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|-- powerpc-klondike_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-mpc5200_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-pasemi_defconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   `-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|-- powerpc-storcenter_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc-tqm8560_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- powerpc64-alldefconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- riscv-nommu_k210_defconfig
|   |-- fs-proc-task_nommu.c:error:struct-mm_struct-has-no-member-named-mm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-kernel.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   `-- include-linux-kernel.h:error:struct-vm_region-has-no-member-named-vm_rb
|-- riscv-nommu_virt_defconfig
|   |-- fs-proc-task_nommu.c:error:struct-mm_struct-has-no-member-named-mm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   |-- include-linux-compiler_types.h:error:struct-vm_region-has-no-member-named-vm_rb
|   |-- include-linux-kernel.h:error:struct-vm_area_struct-has-no-member-named-vm_rb
|   `-- include-linux-kernel.h:error:struct-vm_region-has-no-member-named-vm_rb
|-- riscv-rv32_defconfig
|   |-- include-asm-generic-rwonce.h:error:assignment-of-read-only-location-(const-volatile-unsigned-char-)-erroneous-expression-(int)slot
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-rcupdate.h:error:invalid-type-argument-of-unary-(have-int-)
|   |-- include-linux-rcupdate.h:warning:cast-to-pointer-from-integer-of-different-size
|   |-- include-uapi-linux-const.h:error:invalid-operands-to-binary-(have-const-unsigned-char-and-const-unsigned-char-)
|   |-- lib-maple_tree.c:error:MAPLE_ARANGE64_META_MAX-undeclared-(first-use-in-this-function)
|   |-- lib-maple_tree.c:error:MAPLE_NODE_MASK-undeclared-(first-use-in-this-function)
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)gap
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)head-node_count
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)node-node_count
|   |-- lib-maple_tree.c:error:assignment-of-read-only-location-erroneous-expression-(int)piv
|   |-- lib-maple_tree.c:error:assignment-to-struct-maple_alloc-from-incompatible-pointer-type-const-unsigned-char
|   |-- lib-maple_tree.c:error:initializer-element-is-not-constant
|   |-- lib-maple_tree.c:error:invalid-operands-to-binary-(have-const-unsigned-char-and-int-)
|   |-- lib-maple_tree.c:error:invalid-operands-to-binary-(have-long-unsigned-int-and-const-unsigned-char-)
|   |-- lib-maple_tree.c:error:returning-const-unsigned-char-from-a-function-with-incompatible-return-type-long-unsigned-int
|   |-- lib-maple_tree.c:error:returning-const-unsigned-char-from-a-function-with-incompatible-return-type-void
|   |-- lib-maple_tree.c:error:size-of-array-gap-has-non-integer-type
|   |-- lib-maple_tree.c:error:size-of-array-pivot-has-non-integer-type
|   |-- lib-maple_tree.c:error:size-of-array-slot-has-non-integer-type
|   |-- lib-maple_tree.c:error:wrong-type-argument-to-bit-complement
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-gap-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-pivot-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:ISO-C90-forbids-array-slot-whose-size-can-t-be-evaluated
|   |-- lib-maple_tree.c:warning:assignment-to-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:assignment-to-struct-maple_alloc-from-unsigned-char-makes-pointer-from-integer-without-a-cast
|   |-- lib-maple_tree.c:warning:assignment-to-unsigned-char-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:comparison-between-pointer-and-integer
|   |-- lib-maple_tree.c:warning:initialization-of-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-char-from-const-long-unsigned-int-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-char-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:initialization-of-unsigned-int-from-const-unsigned-char-makes-integer-from-pointer-without-a-cast
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- lib-maple_tree.c:warning:variably-modified-gap-at-file-scope
|   |-- lib-maple_tree.c:warning:variably-modified-pivot-at-file-scope
|   |-- lib-maple_tree.c:warning:variably-modified-slot-at-file-scope
|   |-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|   `-- mm-mmap.c:warning:variable-ma_lock-set-but-not-used
|-- s390-allnoconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- s390-defconfig
|   `-- lib-maple_tree.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- sh-allmodconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)-did-you-mean
|   `-- include-linux-mm.h:warning:no-previous-prototype-for-mm_populate_vma
|-- sparc-defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- sparc64-allyesconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_child_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_gaps
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_limits
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_parent_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_arange64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_entry
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate_nulls
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|-- sparc64-randconfig-m031-20210202
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   `-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|-- um-i386_defconfig
|   |-- include-linux-maple_tree.h:error:MAPLE_ARANGE64_SLOTS-undeclared-here-(not-in-a-function)
|   |-- include-linux-maple_tree.h:error:MAPLE_NODE_SLOTS-undeclared-here-(not-in-a-function)
|   `-- include-linux-maple_tree.h:error:MAPLE_RANGE64_SLOTS-undeclared-here-(not-in-a-function)
|-- x86_64-allyesconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_child_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_gaps
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_limits
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_validate_parent_slot
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_arange64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_entry
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_dump_range64
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mt_validate_nulls
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-defconfig
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-kexec
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-randconfig-m001-20210202
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-randconfig-s021-20210202
|   `-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|-- x86_64-rhel
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-rhel-7.6-kselftests
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
|-- x86_64-rhel-8.3
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
|   |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
|   |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
|   `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap
`-- x86_64-rhel-8.3-kbuiltin
    |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_is_span_wr
    |-- lib-maple_tree.c:warning:no-previous-prototype-for-mas_wr_walk
    |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_range
    |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_alloc_rrange
    |-- lib-maple_tree.c:warning:no-previous-prototype-for-mtree_store
    |-- mm-mempolicy.c:warning:variable-next-set-but-not-used
    `-- mm-mmap.c:warning:no-previous-prototype-for-do_mas_align_munmap

clang_recent_errors
`-- powerpc64-randconfig-r002-20210202
    |-- include-linux-maple_tree.h:error:use-of-undeclared-identifier-MAPLE_ARANGE64_SLOTS
    |-- include-linux-maple_tree.h:error:use-of-undeclared-identifier-MAPLE_NODE_SLOTS
    `-- include-linux-maple_tree.h:error:use-of-undeclared-identifier-MAPLE_RANGE64_SLOTS

elapsed time: 726m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
openrisc                  or1klitex_defconfig
powerpc                    klondike_defconfig
arm                          pcm027_defconfig
powerpc64                        alldefconfig
c6x                        evmc6474_defconfig
m68k                          hp300_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
sh                   secureedge5410_defconfig
um                             i386_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
h8300                               defconfig
powerpc                     tqm8560_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
