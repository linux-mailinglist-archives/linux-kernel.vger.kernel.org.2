Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0E441E06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhKAQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:23:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:11475 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232609AbhKAQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:23:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291888198"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="gz'50?scan'50,208,50";a="291888198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 09:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="gz'50?scan'50,208,50";a="449000988"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2021 09:20:56 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mha3M-0003WJ-43; Mon, 01 Nov 2021 16:20:56 +0000
Date:   Tue, 2 Nov 2021 00:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/ceph/decode.c:164:38: warning: taking address of packed member
 'in_addr' of class or structure 'ceph_entity_addr' may result in an
 unaligned pointer value
Message-ID: <202111020037.mtHK1nhW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8bb7eca972ad531c9b149c0a51ab43a417385813
commit: cd1a677cad994021b19665ed476aea63f5d54f31 libceph, ceph: implement msgr2.1 protocol (crc and secure modes)
date:   11 months ago
config: mips-randconfig-r011-20211101 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd1a677cad994021b19665ed476aea63f5d54f31
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cd1a677cad994021b19665ed476aea63f5d54f31
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/ceph/decode.c:4:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:28:
   In file included from include/net/checksum.h:22:
   arch/mips/include/asm/checksum.h:161:9: error: unsupported inline asm: input with type 'unsigned long' matching output with type '__wsum' (aka 'unsigned int')
           : "0" ((__force unsigned long)daddr),
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/ceph/decode.c:6:
   include/linux/ceph/decode.h:236:33: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           __be16 ss_family = *(__be16 *)&a->in_addr.ss_family;
                                          ^~~~~~~~~~~~~~~~~~~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:13:52: note: expanded from macro '__get_unaligned_le'
   #define __get_unaligned_le(ptr) ((__force typeof(*(ptr)))({                     \
                                                      ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:14:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),                      \
                                          ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:14:47: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),                      \
                                                        ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:15:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_le16((ptr)),   \
                                          ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:16:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),   \
                                          ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:16:65: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),   \
                                                                          ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:17:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),   \
                                          ^~~
>> net/ceph/decode.c:164:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:17:65: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),   \
                                                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:13:52: note: expanded from macro '__get_unaligned_le'
   #define __get_unaligned_le(ptr) ((__force typeof(*(ptr)))({                     \
                                                      ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:14:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),                      \
                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:14:47: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),                      \
                                                        ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:15:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_le16((ptr)),   \
                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:16:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),   \
                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:16:65: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),   \
                                                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:17:33: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),   \
                                          ^~~
   net/ceph/decode.c:172:38: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/unaligned.h:22:24: note: expanded from macro 'get_unaligned'
   # define get_unaligned  __get_unaligned_le
                           ^
   include/linux/unaligned/generic.h:17:65: note: expanded from macro '__get_unaligned_le'
           __builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),   \
                                                                          ^~~
   17 warnings and 1 error generated.
--
   In file included from net/ceph/messenger_v2.c:20:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:28:
   In file included from include/net/checksum.h:22:
   arch/mips/include/asm/checksum.h:161:9: error: unsupported inline asm: input with type 'unsigned long' matching output with type '__wsum' (aka 'unsigned int')
           : "0" ((__force unsigned long)daddr),
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/ceph/messenger_v2.c:20:
   In file included from include/net/sock.h:61:
   include/linux/poll.h:142:27: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                           ^~~~~~~~~
   include/linux/poll.h:140:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:126:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   include/linux/poll.h:142:39: warning: division by zero is undefined [-Wdivision-by-zero]
                   M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
                                                       ^~~~~~~~~
   include/linux/poll.h:140:32: note: expanded from macro 'M'
   #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:126:51: note: expanded from macro '__MAP'
           (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
                                                            ^ ~~~~~~~~~
   In file included from net/ceph/messenger_v2.c:24:
   include/linux/ceph/decode.h:236:33: warning: taking address of packed member 'in_addr' of class or structure 'ceph_entity_addr' may result in an unaligned pointer value [-Waddress-of-packed-member]
           __be16 ss_family = *(__be16 *)&a->in_addr.ss_family;
                                          ^~~~~~~~~~~~~~~~~~~~
>> net/ceph/messenger_v2.c:557:16: warning: taking address of packed member 'front_crc' of class or structure 'ceph_connection_v2_info::(anonymous struct)::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
           cpu_to_le32s(&con->v2.out_epil.front_crc);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:112:22: note: expanded from macro 'cpu_to_le32s'
   #define cpu_to_le32s __cpu_to_le32s
                        ^
   include/uapi/linux/byteorder/little_endian.h:94:39: note: expanded from macro '__cpu_to_le32s'
   #define __cpu_to_le32s(x) do { (void)(x); } while (0)
                                         ^
>> net/ceph/messenger_v2.c:558:16: warning: taking address of packed member 'middle_crc' of class or structure 'ceph_connection_v2_info::(anonymous struct)::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
           cpu_to_le32s(&con->v2.out_epil.middle_crc);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:112:22: note: expanded from macro 'cpu_to_le32s'
   #define cpu_to_le32s __cpu_to_le32s
                        ^
   include/uapi/linux/byteorder/little_endian.h:94:39: note: expanded from macro '__cpu_to_le32s'
   #define __cpu_to_le32s(x) do { (void)(x); } while (0)
                                         ^
>> net/ceph/messenger_v2.c:559:16: warning: taking address of packed member 'data_crc' of class or structure 'ceph_connection_v2_info::(anonymous struct)::(anonymous union)::(anonymous)' may result in an unaligned pointer value [-Waddress-of-packed-member]
           cpu_to_le32s(&con->v2.out_epil.data_crc);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:112:22: note: expanded from macro 'cpu_to_le32s'
   #define cpu_to_le32s __cpu_to_le32s
                        ^
   include/uapi/linux/byteorder/little_endian.h:94:39: note: expanded from macro '__cpu_to_le32s'
   #define __cpu_to_le32s(x) do { (void)(x); } while (0)
                                         ^
   6 warnings and 1 error generated.


vim +164 net/ceph/decode.c

     5	
   > 6	#include <linux/ceph/decode.h>
     7	
     8	static int
     9	ceph_decode_entity_addr_versioned(void **p, void *end,
    10					  struct ceph_entity_addr *addr)
    11	{
    12		int ret;
    13		u8 struct_v;
    14		u32 struct_len, addr_len;
    15		void *struct_end;
    16	
    17		ret = ceph_start_decoding(p, end, 1, "entity_addr_t", &struct_v,
    18					  &struct_len);
    19		if (ret)
    20			goto bad;
    21	
    22		ret = -EINVAL;
    23		struct_end = *p + struct_len;
    24	
    25		ceph_decode_copy_safe(p, end, &addr->type, sizeof(addr->type), bad);
    26	
    27		ceph_decode_copy_safe(p, end, &addr->nonce, sizeof(addr->nonce), bad);
    28	
    29		ceph_decode_32_safe(p, end, addr_len, bad);
    30		if (addr_len > sizeof(addr->in_addr))
    31			goto bad;
    32	
    33		memset(&addr->in_addr, 0, sizeof(addr->in_addr));
    34		if (addr_len) {
    35			ceph_decode_copy_safe(p, end, &addr->in_addr, addr_len, bad);
    36	
    37			addr->in_addr.ss_family =
    38				le16_to_cpu((__force __le16)addr->in_addr.ss_family);
    39		}
    40	
    41		/* Advance past anything the client doesn't yet understand */
    42		*p = struct_end;
    43		ret = 0;
    44	bad:
    45		return ret;
    46	}
    47	
    48	static int
    49	ceph_decode_entity_addr_legacy(void **p, void *end,
    50				       struct ceph_entity_addr *addr)
    51	{
    52		int ret = -EINVAL;
    53	
    54		/* Skip rest of type field */
    55		ceph_decode_skip_n(p, end, 3, bad);
    56	
    57		/*
    58		 * Clients that don't support ADDR2 always send TYPE_NONE, change it
    59		 * to TYPE_LEGACY for forward compatibility.
    60		 */
    61		addr->type = CEPH_ENTITY_ADDR_TYPE_LEGACY;
    62		ceph_decode_copy_safe(p, end, &addr->nonce, sizeof(addr->nonce), bad);
    63		memset(&addr->in_addr, 0, sizeof(addr->in_addr));
    64		ceph_decode_copy_safe(p, end, &addr->in_addr,
    65				      sizeof(addr->in_addr), bad);
    66		addr->in_addr.ss_family =
    67				be16_to_cpu((__force __be16)addr->in_addr.ss_family);
    68		ret = 0;
    69	bad:
    70		return ret;
    71	}
    72	
    73	int
    74	ceph_decode_entity_addr(void **p, void *end, struct ceph_entity_addr *addr)
    75	{
    76		u8 marker;
    77	
    78		ceph_decode_8_safe(p, end, marker, bad);
    79		if (marker == 1)
    80			return ceph_decode_entity_addr_versioned(p, end, addr);
    81		else if (marker == 0)
    82			return ceph_decode_entity_addr_legacy(p, end, addr);
    83	bad:
    84		return -EINVAL;
    85	}
    86	EXPORT_SYMBOL(ceph_decode_entity_addr);
    87	
    88	/*
    89	 * Return addr of desired type (MSGR2 or LEGACY) or error.
    90	 * Make sure there is only one match.
    91	 *
    92	 * Assume encoding with MSG_ADDR2.
    93	 */
    94	int ceph_decode_entity_addrvec(void **p, void *end, bool msgr2,
    95				       struct ceph_entity_addr *addr)
    96	{
    97		__le32 my_type = msgr2 ? CEPH_ENTITY_ADDR_TYPE_MSGR2 :
    98					 CEPH_ENTITY_ADDR_TYPE_LEGACY;
    99		struct ceph_entity_addr tmp_addr;
   100		int addr_cnt;
   101		bool found;
   102		u8 marker;
   103		int ret;
   104		int i;
   105	
   106		ceph_decode_8_safe(p, end, marker, e_inval);
   107		if (marker != 2) {
   108			pr_err("bad addrvec marker %d\n", marker);
   109			return -EINVAL;
   110		}
   111	
   112		ceph_decode_32_safe(p, end, addr_cnt, e_inval);
   113	
   114		found = false;
   115		for (i = 0; i < addr_cnt; i++) {
   116			ret = ceph_decode_entity_addr(p, end, &tmp_addr);
   117			if (ret)
   118				return ret;
   119	
   120			if (tmp_addr.type == my_type) {
   121				if (found) {
   122					pr_err("another match of type %d in addrvec\n",
   123					       le32_to_cpu(my_type));
   124					return -EINVAL;
   125				}
   126	
   127				memcpy(addr, &tmp_addr, sizeof(*addr));
   128				found = true;
   129			}
   130		}
   131		if (!found && addr_cnt != 0) {
   132			pr_err("no match of type %d in addrvec\n",
   133			       le32_to_cpu(my_type));
   134			return -ENOENT;
   135		}
   136	
   137		return 0;
   138	
   139	e_inval:
   140		return -EINVAL;
   141	}
   142	EXPORT_SYMBOL(ceph_decode_entity_addrvec);
   143	
   144	static int get_sockaddr_encoding_len(sa_family_t family)
   145	{
   146		union {
   147			struct sockaddr sa;
   148			struct sockaddr_in sin;
   149			struct sockaddr_in6 sin6;
   150		} u;
   151	
   152		switch (family) {
   153		case AF_INET:
   154			return sizeof(u.sin);
   155		case AF_INET6:
   156			return sizeof(u.sin6);
   157		default:
   158			return sizeof(u);
   159		}
   160	}
   161	
   162	int ceph_entity_addr_encoding_len(const struct ceph_entity_addr *addr)
   163	{
 > 164		sa_family_t family = get_unaligned(&addr->in_addr.ss_family);
   165		int addr_len = get_sockaddr_encoding_len(family);
   166	
   167		return 1 + CEPH_ENCODING_START_BLK_LEN + 4 + 4 + 4 + addr_len;
   168	}
   169	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
T3pH6fj/eVTU27YNAgA=

--n8g4imXOkfNTN/H1--
