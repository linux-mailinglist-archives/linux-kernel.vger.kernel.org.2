Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20533E9B26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHKXRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:17:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:46530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhHKXRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:17:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="214972511"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="gz'50?scan'50,208,50";a="214972511"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 16:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="gz'50?scan'50,208,50";a="507283300"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 16:16:50 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDxSs-000MBW-3X; Wed, 11 Aug 2021 23:16:50 +0000
Date:   Thu, 12 Aug 2021 07:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:kspp/memcpy/next-20210803/v2-devel 77/86]
 include/linux/string.h:297:2: error: implicit declaration of function
 '__underlying_memcpy'; did you mean '__builtin_memcpy'?
Message-ID: <202108120729.qhKMUvtr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git kspp/memcpy/next-20210803/v2-devel
head:   4752984fc24104f399e70f99d48afa047d86a381
commit: 0faff4e74f49485683ea9757f2e49fdab41c7f20 [77/86] netlink: Use flex_cpy() to avoid false-positive memcpy() warning
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=0faff4e74f49485683ea9757f2e49fdab41c7f20
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees kspp/memcpy/next-20210803/v2-devel
        git checkout 0faff4e74f49485683ea9757f2e49fdab41c7f20
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/netlink/af_netlink.c:21:
   net/netlink/af_netlink.c: In function 'netlink_ack':
>> include/linux/string.h:297:2: error: implicit declaration of function '__underlying_memcpy'; did you mean '__builtin_memcpy'? [-Werror=implicit-function-declaration]
     297 |  __underlying_memcpy(dst, src, __src_bytes);  \
         |  ^~~~~~~~~~~~~~~~~~~
   net/netlink/af_netlink.c:2452:2: note: in expansion of macro 'flex_cpy'
    2452 |  flex_cpy(&errmsg->msg, errlen, nlh, errlen, nlmsg_content);
         |  ^~~~~~~~
   cc1: some warnings being treated as errors


vim +297 include/linux/string.h

01f33c336e2d29 Martin Wilck 2017-08-14  274  
1e9264c10e1d25 Kees Cook    2021-08-10  275  /** flex_cpy - Copy between two flexible array members.
1e9264c10e1d25 Kees Cook    2021-08-10  276   *
1e9264c10e1d25 Kees Cook    2021-08-10  277   * @dst: Destination pointer
1e9264c10e1d25 Kees Cook    2021-08-10  278   * @dst_count: Number of @member elements to copy at end of @dst struct
1e9264c10e1d25 Kees Cook    2021-08-10  279   * @src: Source pointer
1e9264c10e1d25 Kees Cook    2021-08-10  280   * @src_count: Number of @member elements to copy from end of @src struct
1e9264c10e1d25 Kees Cook    2021-08-10  281   * @member: The flexible array member of both @src and @dst
1e9264c10e1d25 Kees Cook    2021-08-10  282   *
1e9264c10e1d25 Kees Cook    2021-08-10  283   * The full structure of @src will be copied to @dst, as well as
1e9264c10e1d25 Kees Cook    2021-08-10  284   * @src_count @member elements. @src and @dst must reference the same type.
1e9264c10e1d25 Kees Cook    2021-08-10  285   * @dst_count must be >= @src_count.
1e9264c10e1d25 Kees Cook    2021-08-10  286   */
1e9264c10e1d25 Kees Cook    2021-08-10  287  #define flex_cpy(dst, dst_count, src, src_count, member) ({		\
1e9264c10e1d25 Kees Cook    2021-08-10  288  	size_t __dst_bytes = struct_size(dst, member, dst_count);	\
1e9264c10e1d25 Kees Cook    2021-08-10  289  	size_t __src_bytes = struct_size(src, member, src_count);	\
1e9264c10e1d25 Kees Cook    2021-08-10  290  	BUILD_BUG_ON(!__same_type(*(dst), *(src)));			\
1e9264c10e1d25 Kees Cook    2021-08-10  291  	WARN_ONCE(IS_ENABLED(CONFIG_FORTIFY_SOURCE) &&			\
1e9264c10e1d25 Kees Cook    2021-08-10  292  		  __dst_bytes < __src_bytes,				\
1e9264c10e1d25 Kees Cook    2021-08-10  293  		  "flex_cpy: detected write overflow (size %zu) of %s (size %zu)\n", \
1e9264c10e1d25 Kees Cook    2021-08-10  294  		  __src_bytes,						\
1e9264c10e1d25 Kees Cook    2021-08-10  295  		  "field \"" #dst "\" at " __FILE__ ":" __stringify(__LINE__), \
1e9264c10e1d25 Kees Cook    2021-08-10  296  		  __dst_bytes);						\
1e9264c10e1d25 Kees Cook    2021-08-10 @297  	__underlying_memcpy(dst, src, __src_bytes);		\
1e9264c10e1d25 Kees Cook    2021-08-10  298  })
1e9264c10e1d25 Kees Cook    2021-08-10  299  

:::::: The code at line 297 was first introduced by commit
:::::: 1e9264c10e1d259549421c6f5adfedb80144a6b3 string: Introduce flexible array memcpy() helpers

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
