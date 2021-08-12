Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761023EA85C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHLQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:16:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:21719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhHLQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:13:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215376199"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="gz'50?scan'50,208,50";a="215376199"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 09:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="gz'50?scan'50,208,50";a="446594965"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2021 09:08:57 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEDGK-000MmI-In; Thu, 12 Aug 2021 16:08:56 +0000
Date:   Fri, 13 Aug 2021 00:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:netfs-folio 3/3] fs/ceph/addr.c:813:4: error: 'page'
 undeclared
Message-ID: <202108130010.tof4ZOg6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-folio
head:   bd62d82fbd1b69357ba3c0d8dffc62fd861f6d3e
commit: bd62d82fbd1b69357ba3c0d8dffc62fd861f6d3e [3/3] ceph: Use folios
config: arm-randconfig-s031-20210812 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=bd62d82fbd1b69357ba3c0d8dffc62fd861f6d3e
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs netfs-folio
        git checkout bd62d82fbd1b69357ba3c0d8dffc62fd861f6d3e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/ceph/addr.c: In function 'writepage_nounlock':
   fs/ceph/addr.c:553:2: warning: #warning ^^^ which page? [-Wcpp]
     553 | #warning ^^^ which page?
         |  ^~~~~~~
   fs/ceph/addr.c: In function 'writepages_finish':
   fs/ceph/addr.c:674:2: warning: #warning ^^^ page or folio? [-Wcpp]
     674 | #warning ^^^ page or folio?
         |  ^~~~~~~
   fs/ceph/addr.c: In function 'ceph_writepages_start':
>> fs/ceph/addr.c:813:4: error: 'page' undeclared (first use in this function)
     813 |    page = pvec.pages[i];
         |    ^~~~
   fs/ceph/addr.c:813:4: note: each undeclared identifier is reported only once for each function it appears in
   In file included from fs/ceph/addr.c:2:
>> fs/ceph/addr.c:814:46: error: passing argument 1 of 'folio_index' from incompatible pointer type [-Werror=incompatible-pointer-types]
     814 |    dout("? %p idx %lu\n", folio, folio_index(folio));
         |                                              ^~~~~
         |                                              |
         |                                              struct page *
   include/linux/ceph/ceph_debug.h:26:29: note: in definition of macro 'dout'
      26 |    printk(KERN_DEBUG fmt, ##__VA_ARGS__); \
         |                             ^~~~~~~~~~~
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:457:49: note: expected 'struct folio *' but argument is of type 'struct page *'
     457 | static inline pgoff_t folio_index(struct folio *folio)
         |                                   ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:816:16: error: passing argument 1 of 'folio_lock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     816 |     folio_lock(folio);  /* first page */
         |                ^~~~~
         |                |
         |                struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:700:45: note: expected 'struct folio *' but argument is of type 'struct page *'
     700 | static inline void folio_lock(struct folio *folio)
         |                               ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:817:28: error: passing argument 1 of 'folio_trylock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     817 |    else if (!folio_trylock(folio))
         |                            ^~~~~
         |                            |
         |                            struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:687:48: note: expected 'struct folio *' but argument is of type 'struct page *'
     687 | static inline bool folio_trylock(struct folio *folio)
         |                                  ~~~~~~~~~~~~~~^~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
>> fs/ceph/addr.c:821:35: error: passing argument 1 of 'folio_test_dirty' from incompatible pointer type [-Werror=incompatible-pointer-types]
     821 |    if (unlikely(!folio_test_dirty(folio)) ||
         |                                   ^~~~~
         |                                   |
         |                                   struct page *
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
      33 |    ______r = __builtin_expect(!!(x), expect); \
         |                                  ^
   fs/ceph/addr.c:821:8: note: in expansion of macro 'unlikely'
     821 |    if (unlikely(!folio_test_dirty(folio)) ||
         |        ^~~~~~~~
   In file included from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/backing-dev.h:13,
                    from fs/ceph/addr.c:4:
   include/linux/page-flags.h:313:62: note: expected 'struct folio *' but argument is of type 'struct page *'
     313 | static __always_inline bool folio_test_##lname(struct folio *folio) \
         |                                                ~~~~~~~~~~~~~~^~~~~
   include/linux/page-flags.h:361:2: note: in expansion of macro 'TESTPAGEFLAG'
     361 |  TESTPAGEFLAG(uname, lname, policy)    \
         |  ^~~~~~~~~~~~
   include/linux/page-flags.h:412:1: note: in expansion of macro 'PAGEFLAG'
     412 | PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
         | ^~~~~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
>> fs/ceph/addr.c:821:35: error: passing argument 1 of 'folio_test_dirty' from incompatible pointer type [-Werror=incompatible-pointer-types]
     821 |    if (unlikely(!folio_test_dirty(folio)) ||
         |                                   ^~~~~
         |                                   |
         |                                   struct page *
   include/linux/compiler.h:35:19: note: in definition of macro '__branch_check__'
      35 |           expect, is_constant); \
         |                   ^~~~~~~~~~~
   fs/ceph/addr.c:821:8: note: in expansion of macro 'unlikely'
     821 |    if (unlikely(!folio_test_dirty(folio)) ||
         |        ^~~~~~~~
   In file included from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/backing-dev.h:13,
                    from fs/ceph/addr.c:4:
   include/linux/page-flags.h:313:62: note: expected 'struct folio *' but argument is of type 'struct page *'
     313 | static __always_inline bool folio_test_##lname(struct folio *folio) \
         |                                                ~~~~~~~~~~~~~~^~~~~
   include/linux/page-flags.h:361:2: note: in expansion of macro 'TESTPAGEFLAG'
     361 |  TESTPAGEFLAG(uname, lname, policy)    \
         |  ^~~~~~~~~~~~
   include/linux/page-flags.h:412:1: note: in expansion of macro 'PAGEFLAG'
     412 | PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
         | ^~~~~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
>> fs/ceph/addr.c:822:31: error: passing argument 1 of 'folio_mapping' from incompatible pointer type [-Werror=incompatible-pointer-types]
     822 |        unlikely(folio_mapping(folio) != mapping)) {
         |                               ^~~~~
         |                               |
         |                               struct page *
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
      33 |    ______r = __builtin_expect(!!(x), expect); \
         |                                  ^
   fs/ceph/addr.c:822:8: note: in expansion of macro 'unlikely'
     822 |        unlikely(folio_mapping(folio) != mapping)) {
         |        ^~~~~~~~
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:166:37: note: expected 'struct folio *' but argument is of type 'struct page *'
     166 | struct address_space *folio_mapping(struct folio *);
         |                                     ^~~~~~~~~~~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
>> fs/ceph/addr.c:822:31: error: passing argument 1 of 'folio_mapping' from incompatible pointer type [-Werror=incompatible-pointer-types]
     822 |        unlikely(folio_mapping(folio) != mapping)) {
         |                               ^~~~~
         |                               |
         |                               struct page *
   include/linux/compiler.h:35:19: note: in definition of macro '__branch_check__'
      35 |           expect, is_constant); \
         |                   ^~~~~~~~~~~
   fs/ceph/addr.c:822:8: note: in expansion of macro 'unlikely'
     822 |        unlikely(folio_mapping(folio) != mapping)) {
         |        ^~~~~~~~
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:166:37: note: expected 'struct folio *' but argument is of type 'struct page *'
     166 | struct address_space *folio_mapping(struct folio *);
         |                                     ^~~~~~~~~~~~~~
>> fs/ceph/addr.c:824:18: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     824 |     folio_unlock(folio);
         |                  ^~~~~
         |                  |
         |                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:828:33: error: passing argument 1 of 'folio_snap_context' from incompatible pointer type [-Werror=incompatible-pointer-types]
     828 |    pgsnapc = folio_snap_context(folio);
         |                                 ^~~~~
         |                                 |
         |                                 struct page *
   fs/ceph/addr.c:68:74: note: expected 'struct folio *' but argument is of type 'struct page *'
      68 | static inline struct ceph_snap_context *folio_snap_context(struct folio *folio)
         |                                                            ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:836:18: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     836 |     folio_unlock(folio);
         |                  ^~~~~
         |                  |
         |                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:839:23: error: passing argument 1 of 'folio_file_pos' from incompatible pointer type [-Werror=incompatible-pointer-types]
     839 |    if (folio_file_pos(folio) >= ceph_wbc.i_size) {
         |                       ^~~~~
         |                       |
         |                       struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:636:51: note: expected 'struct folio *' but argument is of type 'struct page *'
     636 | static inline loff_t folio_file_pos(struct folio *folio)
         |                                     ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:843:24: error: passing argument 1 of 'folio_file_pos' from incompatible pointer type [-Werror=incompatible-pointer-types]
     843 |         folio_file_pos(folio) >= i_size_read(inode)) &&
         |                        ^~~~~
         |                        |
         |                        struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:636:51: note: expected 'struct folio *' but argument is of type 'struct page *'
     636 | static inline loff_t folio_file_pos(struct folio *folio)
         |                                     ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:846:23: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
     846 |         0, folio_size(folio));
         |                       ^~~~~
         |                       |
         |                       struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:847:18: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     847 |     folio_unlock(folio);
         |                  ^~~~~
         |                  |
         |                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:850:39: error: passing argument 1 of 'folio_index' from incompatible pointer type [-Werror=incompatible-pointer-types]
     850 |    if (strip_unit_end && (folio_index(folio) > strip_unit_end)) {
         |                                       ^~~~~
         |                                       |
         |                                       struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:457:49: note: expected 'struct folio *' but argument is of type 'struct page *'
     457 | static inline pgoff_t folio_index(struct folio *folio)
         |                                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:852:18: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     852 |     folio_unlock(folio);
         |                  ^~~~~
         |                  |
         |                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:858:19: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     858 |      folio_unlock(folio);
         |                   ^~~~~
         |                   |
         |                   struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:867:18: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     867 |     folio_unlock(folio);
         |                  ^~~~~
         |                  |
         |                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:883:34: error: passing argument 1 of 'folio_file_pos' from incompatible pointer type [-Werror=incompatible-pointer-types]
     883 |     offset = (u64)folio_file_pos(folio);
         |                                  ^~~~~
         |                                  |
         |                                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:636:51: note: expected 'struct folio *' but argument is of type 'struct page *'
     636 | static inline loff_t folio_file_pos(struct folio *folio)
         |                                     ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:891:34: error: passing argument 1 of 'folio_index' from incompatible pointer type [-Werror=incompatible-pointer-types]
     891 |     strip_unit_end = folio_index(folio) +
         |                                  ^~~~~
         |                                  |
         |                                  struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:457:49: note: expected 'struct folio *' but argument is of type 'struct page *'
     457 | static inline pgoff_t folio_index(struct folio *folio)
         |                                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:906:27: error: passing argument 1 of 'folio_index' from incompatible pointer type [-Werror=incompatible-pointer-types]
     906 |    } else if (folio_index(folio) !=
         |                           ^~~~~
         |                           |
         |                           struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:457:49: note: expected 'struct folio *' but argument is of type 'struct page *'
     457 | static inline pgoff_t folio_index(struct folio *folio)
         |                                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:911:19: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     911 |      folio_unlock(folio);
         |                   ^~~~~
         |                   |
         |                   struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:916:34: error: passing argument 1 of 'folio_file_pos' from incompatible pointer type [-Werror=incompatible-pointer-types]
     916 |     offset = (u64)folio_file_pos(folio);
         |                                  ^~~~~
         |                                  |
         |                                  struct page *
   In file included from fs/ceph/addr.c:7:
--
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
   fs/ceph/addr.c:984:20: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
     984 |         folio_size(folio) - offset);
         |                    ^~~~~
         |                    |
         |                    struct page *
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
      33 |    ______r = __builtin_expect(!!(x), expect); \
         |                                  ^
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/ceph/addr.c:983:3: note: in expansion of macro 'BUG_ON'
     983 |   BUG_ON(len < folio_file_pos(pages[locked_pages - 1]) +
         |   ^~~~~~
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
   fs/ceph/addr.c:983:36: error: passing argument 1 of 'folio_file_pos' from incompatible pointer type [-Werror=incompatible-pointer-types]
     983 |   BUG_ON(len < folio_file_pos(pages[locked_pages - 1]) +
         |                               ~~~~~^~~~~~~~~~~~~~~~~~
         |                                    |
         |                                    struct page *
   include/linux/compiler.h:35:19: note: in definition of macro '__branch_check__'
      35 |           expect, is_constant); \
         |                   ^~~~~~~~~~~
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/ceph/addr.c:983:3: note: in expansion of macro 'BUG_ON'
     983 |   BUG_ON(len < folio_file_pos(pages[locked_pages - 1]) +
         |   ^~~~~~
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:636:51: note: expected 'struct folio *' but argument is of type 'struct page *'
     636 | static inline loff_t folio_file_pos(struct folio *folio)
         |                                     ~~~~~~~~~~~~~~^~~~~
   In file included from include/linux/string.h:5,
                    from include/linux/ceph/ceph_debug.h:7,
                    from fs/ceph/addr.c:2:
   fs/ceph/addr.c:984:20: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
     984 |         folio_size(folio) - offset);
         |                    ^~~~~
         |                    |
         |                    struct page *
   include/linux/compiler.h:35:19: note: in definition of macro '__branch_check__'
      35 |           expect, is_constant); \
         |                   ^~~~~~~~~~~
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/ceph/addr.c:983:3: note: in expansion of macro 'BUG_ON'
     983 |   BUG_ON(len < folio_file_pos(pages[locked_pages - 1]) +
         |   ^~~~~~
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:1014:22: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1014 |    len += folio_size(folio);
         |                      ^~~~~
         |                      |
         |                      struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:1023:39: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1023 |    u64 min_len = len + 1 - folio_size(folio);
         |                                       ^~~~~
         |                                       |
         |                                       struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:1024:49: error: passing argument 2 of 'get_writepages_data_length' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1024 |    len = get_writepages_data_length(inode, pages[i - 1],
         |                                            ~~~~~^~~~~~~
         |                                                 |
         |                                                 struct page *
   fs/ceph/addr.c:456:25: note: expected 'struct folio *' but argument is of type 'struct page *'
     456 |           struct folio *folio, u64 start)
         |           ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:1104:29: error: 'folio' undeclared (first use in this function)
    1104 |      if (folio_snap_context(folio) != snapc)
         |                             ^~~~~
   fs/ceph/addr.c: In function 'ceph_find_incompatible':
   fs/ceph/addr.c:1157:38: error: 'folio' undeclared (first use in this function)
    1157 |  struct inode *inode = folio_mapping(folio)->host;
         |                                      ^~~~~
>> fs/ceph/addr.c:1191:31: error: passing argument 1 of 'writepage_nounlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1191 |    int r = writepage_nounlock(page, NULL);
         |                               ^~~~
         |                               |
         |                               struct page *
   fs/ceph/addr.c:488:45: note: expected 'struct folio *' but argument is of type 'struct page *'
     488 | static int writepage_nounlock(struct folio *folio, struct writeback_control *wbc)
         |                               ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c: In function 'ceph_netfs_check_write_begin':
   fs/ceph/addr.c:1206:33: error: 'page' undeclared (first use in this function)
    1206 |  snapc = ceph_find_incompatible(page);
         |                                 ^~~~
   fs/ceph/addr.c: In function 'ceph_write_begin':
   fs/ceph/addr.c:1253:29: error: 'folio' undeclared (first use in this function)
    1253 |    if (!folio_test_uptodate(folio)) {
         |                             ^~~~~
>> fs/ceph/addr.c:1261:3: error: implicit declaration of function 'folio_set_uptodate'; did you mean 'folio_test_uptodate'? [-Werror=implicit-function-declaration]
    1261 |   folio_set_uptodate(folio);
         |   ^~~~~~~~~~~~~~~~~~
         |   folio_test_uptodate
   fs/ceph/addr.c:1265:61: error: passing argument 6 of 'netfs_write_begin' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1265 |  r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &page, NULL,
         |                                                             ^~~~~
         |                                                             |
         |                                                             struct page **
   In file included from fs/ceph/addr.c:15:
   include/linux/netfs.h:247:45: note: expected 'struct folio **' but argument is of type 'struct page **'
     247 |         loff_t, unsigned int, unsigned int, struct folio **,
         |                                             ^~~~~~~~~~~~~~~
   fs/ceph/addr.c: In function 'ceph_filemap_fault':
   fs/ceph/addr.c:1419:17: error: 'folio' undeclared (first use in this function)
    1419 |    folio_unlock(folio);
         |                 ^~~~~
   fs/ceph/addr.c: In function 'ceph_page_mkwrite':
   fs/ceph/addr.c:1451:30: error: 'folio' undeclared (first use in this function)
    1451 |  loff_t off = folio_file_pos(folio);
         |                              ^~~~~
   fs/ceph/addr.c: In function 'ceph_fill_inline_data':
>> fs/ceph/addr.c:1569:11: error: too many arguments to function 'filemap_get_folio'
    1569 |   folio = filemap_get_folio(mapping, 0,
         |           ^~~~~~~~~~~~~~~~~
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:340:29: note: declared here
     340 | static inline struct folio *filemap_get_folio(struct address_space *mapping,
         |                             ^~~~~~~~~~~~~~~~~
>> fs/ceph/addr.c:1569:9: error: assignment to 'struct page *' from incompatible pointer type 'struct folio *' [-Werror=incompatible-pointer-types]
    1569 |   folio = filemap_get_folio(mapping, 0,
         |         ^
>> fs/ceph/addr.c:1575:27: error: passing argument 1 of 'folio_test_uptodate' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1575 |   if (folio_test_uptodate(folio)) {
         |                           ^~~~~
         |                           |
         |                           struct page *
   In file included from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/backing-dev.h:13,
                    from fs/ceph/addr.c:4:
   include/linux/page-flags.h:607:54: note: expected 'struct folio *' but argument is of type 'struct page *'
     607 | static inline bool folio_test_uptodate(struct folio *folio)
         |                                        ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:1576:17: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1576 |    folio_unlock(folio);
         |                 ^~~~~
         |                 |
         |                 struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
>> fs/ceph/addr.c:1577:14: error: passing argument 1 of 'folio_put' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1577 |    folio_put(folio);
         |              ^~~~~
         |              |
         |              struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1265:44: note: expected 'struct folio *' but argument is of type 'struct page *'
    1265 | static inline void folio_put(struct folio *folio)
         |                              ~~~~~~~~~~~~~~^~~~~
   In file included from fs/ceph/addr.c:2:
   fs/ceph/addr.c:1583:38: error: 'locked_page' undeclared (first use in this function); did you mean 'lock_page'?
    1583 |       inode, ceph_vinop(inode), len, locked_page);
         |                                      ^~~~~~~~~~~
   include/linux/ceph/ceph_debug.h:26:29: note: in definition of macro 'dout'
      26 |    printk(KERN_DEBUG fmt, ##__VA_ARGS__); \
         |                             ^~~~~~~~~~~
   fs/ceph/addr.c:1586:29: error: 'page' undeclared (first use in this function)
    1586 |   void *kaddr = kmap_atomic(page);
         |                             ^~~~
   fs/ceph/addr.c:1592:24: error: passing argument 1 of 'folio_size' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1592 |   if (len < folio_size(folio))
         |                        ^~~~~
         |                        |
         |                        struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1721:47: note: expected 'struct folio *' but argument is of type 'struct page *'
    1721 | static inline size_t folio_size(struct folio *folio)
         |                                 ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:1598:16: error: passing argument 1 of 'folio_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1598 |   folio_unlock(folio);
         |                ^~~~~
         |                |
         |                struct page *
   In file included from fs/ceph/addr.c:7:
   include/linux/pagemap.h:685:33: note: expected 'struct folio *' but argument is of type 'struct page *'
     685 | void folio_unlock(struct folio *folio);
         |                   ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c:1599:13: error: passing argument 1 of 'folio_put' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1599 |   folio_put(folio);
         |             ^~~~~
         |             |
         |             struct page *
   In file included from include/linux/bvec.h:14,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:8,
                    from include/linux/backing-dev.h:15,
                    from fs/ceph/addr.c:4:
   include/linux/mm.h:1265:44: note: expected 'struct folio *' but argument is of type 'struct page *'
    1265 | static inline void folio_put(struct folio *folio)
         |                              ~~~~~~~~~~~~~~^~~~~
   fs/ceph/addr.c: At top level:
   fs/ceph/addr.c:1603:5: error: conflicting types for 'ceph_uninline_data'
    1603 | int ceph_uninline_data(struct file *filp, struct folio *locked_folio)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from fs/ceph/addr.c:17:
   fs/ceph/super.h:1193:12: note: previous declaration of 'ceph_uninline_data' was here
    1193 | extern int ceph_uninline_data(struct file *filp, struct page *locked_page);
         |            ^~~~~~~~~~~~~~~~~~
   fs/ceph/addr.c: In function 'ceph_uninline_data':
   fs/ceph/addr.c:1626:9: error: assignment to 'struct page *' from incompatible pointer type 'struct folio *' [-Werror=incompatible-pointer-types]
    1626 |   folio = locked_folio;
         |         ^
   In file included from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/backing-dev.h:13,
                    from fs/ceph/addr.c:4:
   fs/ceph/addr.c:1627:32: error: passing argument 1 of 'folio_test_uptodate' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1627 |   WARN_ON(!folio_test_uptodate(folio));
         |                                ^~~~~
         |                                |
         |                                struct page *
   include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_ON'
     121 |  int __ret_warn_on = !!(condition);    \
         |                         ^~~~~~~~~
   In file included from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/backing-dev.h:13,
                    from fs/ceph/addr.c:4:
   include/linux/page-flags.h:607:54: note: expected 'struct folio *' but argument is of type 'struct page *'


vim +/page +813 fs/ceph/addr.c

1d3576fd10f0d7 Sage Weil          2009-10-06   620  
1d3576fd10f0d7 Sage Weil          2009-10-06   621  /*
1d3576fd10f0d7 Sage Weil          2009-10-06   622   * async writeback completion handler.
1d3576fd10f0d7 Sage Weil          2009-10-06   623   *
1d3576fd10f0d7 Sage Weil          2009-10-06   624   * If we get an error, set the mapping error bit, but not the individual
1d3576fd10f0d7 Sage Weil          2009-10-06   625   * page error bits.
1d3576fd10f0d7 Sage Weil          2009-10-06   626   */
85e084feb47349 Ilya Dryomov       2016-04-28   627  static void writepages_finish(struct ceph_osd_request *req)
1d3576fd10f0d7 Sage Weil          2009-10-06   628  {
1d3576fd10f0d7 Sage Weil          2009-10-06   629  	struct inode *inode = req->r_inode;
1d3576fd10f0d7 Sage Weil          2009-10-06   630  	struct ceph_inode_info *ci = ceph_inode(inode);
87060c1089a94f Alex Elder         2013-04-03   631  	struct ceph_osd_data *osd_data;
bd62d82fbd1b69 David Howells      2021-08-11   632  	struct folio *folio;
5b64640cf65be4 Yan, Zheng         2016-01-07   633  	int num_pages, total_pages = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   634  	int i, j;
5b64640cf65be4 Yan, Zheng         2016-01-07   635  	int rc = req->r_result;
1d3576fd10f0d7 Sage Weil          2009-10-06   636  	struct ceph_snap_context *snapc = req->r_snapc;
1d3576fd10f0d7 Sage Weil          2009-10-06   637  	struct address_space *mapping = inode->i_mapping;
3d14c5d2b6e15c Yehuda Sadeh       2010-04-06   638  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
903f4fec78dd05 Xiubo Li           2021-05-13   639  	unsigned int len = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   640  	bool remove_page;
5b64640cf65be4 Yan, Zheng         2016-01-07   641  
5b64640cf65be4 Yan, Zheng         2016-01-07   642  	dout("writepages_finish %p rc %d\n", inode, rc);
26544c623e741a Jeff Layton        2017-04-04   643  	if (rc < 0) {
5b64640cf65be4 Yan, Zheng         2016-01-07   644  		mapping_set_error(mapping, rc);
26544c623e741a Jeff Layton        2017-04-04   645  		ceph_set_error_write(ci);
0b98acd6188309 Ilya Dryomov       2020-09-14   646  		if (rc == -EBLOCKLISTED)
0b98acd6188309 Ilya Dryomov       2020-09-14   647  			fsc->blocklisted = true;
26544c623e741a Jeff Layton        2017-04-04   648  	} else {
26544c623e741a Jeff Layton        2017-04-04   649  		ceph_clear_error_write(ci);
26544c623e741a Jeff Layton        2017-04-04   650  	}
1d3576fd10f0d7 Sage Weil          2009-10-06   651  
79788c698b2904 Sage Weil          2010-02-02   652  	/*
5b64640cf65be4 Yan, Zheng         2016-01-07   653  	 * We lost the cache cap, need to truncate the page before
5b64640cf65be4 Yan, Zheng         2016-01-07   654  	 * it is unlocked, otherwise we'd truncate it later in the
5b64640cf65be4 Yan, Zheng         2016-01-07   655  	 * page truncation thread, possibly losing some data that
5b64640cf65be4 Yan, Zheng         2016-01-07   656  	 * raced its way in
79788c698b2904 Sage Weil          2010-02-02   657  	 */
5b64640cf65be4 Yan, Zheng         2016-01-07   658  	remove_page = !(ceph_caps_issued(ci) &
5b64640cf65be4 Yan, Zheng         2016-01-07   659  			(CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO));
1d3576fd10f0d7 Sage Weil          2009-10-06   660  
1d3576fd10f0d7 Sage Weil          2009-10-06   661  	/* clean all pages */
5b64640cf65be4 Yan, Zheng         2016-01-07   662  	for (i = 0; i < req->r_num_ops; i++) {
5b64640cf65be4 Yan, Zheng         2016-01-07   663  		if (req->r_ops[i].op != CEPH_OSD_OP_WRITE)
5b64640cf65be4 Yan, Zheng         2016-01-07   664  			break;
5b64640cf65be4 Yan, Zheng         2016-01-07   665  
5b64640cf65be4 Yan, Zheng         2016-01-07   666  		osd_data = osd_req_op_extent_osd_data(req, i);
5b64640cf65be4 Yan, Zheng         2016-01-07   667  		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_PAGES);
903f4fec78dd05 Xiubo Li           2021-05-13   668  		len += osd_data->length;
5b64640cf65be4 Yan, Zheng         2016-01-07   669  		num_pages = calc_pages_for((u64)osd_data->alignment,
5b64640cf65be4 Yan, Zheng         2016-01-07   670  					   (u64)osd_data->length);
5b64640cf65be4 Yan, Zheng         2016-01-07   671  		total_pages += num_pages;
5b64640cf65be4 Yan, Zheng         2016-01-07   672  		for (j = 0; j < num_pages; j++) {
bd62d82fbd1b69 David Howells      2021-08-11   673  			folio = page_folio(osd_data->pages[j]);
bd62d82fbd1b69 David Howells      2021-08-11  @674  #warning ^^^ page or folio?
bd62d82fbd1b69 David Howells      2021-08-11   675  			BUG_ON(!folio);
bd62d82fbd1b69 David Howells      2021-08-11   676  			WARN_ON(!folio_test_uptodate(folio));
1d3576fd10f0d7 Sage Weil          2009-10-06   677  
5b64640cf65be4 Yan, Zheng         2016-01-07   678  			if (atomic_long_dec_return(&fsc->writeback_count) <
5b64640cf65be4 Yan, Zheng         2016-01-07   679  			     CONGESTION_OFF_THRESH(
5b64640cf65be4 Yan, Zheng         2016-01-07   680  					fsc->mount_options->congestion_kb))
09dc9fc24ba714 Jan Kara           2017-04-12   681  				clear_bdi_congested(inode_to_bdi(inode),
2baba25019ec56 Yehuda Sadeh       2009-12-18   682  						    BLK_RW_ASYNC);
2baba25019ec56 Yehuda Sadeh       2009-12-18   683  
bd62d82fbd1b69 David Howells      2021-08-11   684  			ceph_put_snap_context(folio_detach_private(folio));
bd62d82fbd1b69 David Howells      2021-08-11   685  			folio_end_writeback(folio);
bd62d82fbd1b69 David Howells      2021-08-11   686  			dout("unlocking %p\n", folio);
e63dc5c780ba32 Yehuda Sadeh       2010-02-19   687  
5b64640cf65be4 Yan, Zheng         2016-01-07   688  			if (remove_page)
5b64640cf65be4 Yan, Zheng         2016-01-07   689  				generic_error_remove_page(inode->i_mapping,
bd62d82fbd1b69 David Howells      2021-08-11   690  							  &folio->page);
e63dc5c780ba32 Yehuda Sadeh       2010-02-19   691  
bd62d82fbd1b69 David Howells      2021-08-11   692  			folio_unlock(folio);
1d3576fd10f0d7 Sage Weil          2009-10-06   693  		}
5b64640cf65be4 Yan, Zheng         2016-01-07   694  		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
5b64640cf65be4 Yan, Zheng         2016-01-07   695  		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
1d3576fd10f0d7 Sage Weil          2009-10-06   696  
96ac9158a230e4 John Hubbard       2019-08-08   697  		release_pages(osd_data->pages, num_pages);
5b64640cf65be4 Yan, Zheng         2016-01-07   698  	}
5b64640cf65be4 Yan, Zheng         2016-01-07   699  
903f4fec78dd05 Xiubo Li           2021-05-13   700  	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
903f4fec78dd05 Xiubo Li           2021-05-13   701  				  req->r_end_latency, len, rc);
903f4fec78dd05 Xiubo Li           2021-05-13   702  
5b64640cf65be4 Yan, Zheng         2016-01-07   703  	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
5b64640cf65be4 Yan, Zheng         2016-01-07   704  
5b64640cf65be4 Yan, Zheng         2016-01-07   705  	osd_data = osd_req_op_extent_osd_data(req, 0);
87060c1089a94f Alex Elder         2013-04-03   706  	if (osd_data->pages_from_pool)
a0102bda5bc099 Jeff Layton        2020-07-30   707  		mempool_free(osd_data->pages, ceph_wb_pagevec_pool);
1d3576fd10f0d7 Sage Weil          2009-10-06   708  	else
87060c1089a94f Alex Elder         2013-04-03   709  		kfree(osd_data->pages);
1d3576fd10f0d7 Sage Weil          2009-10-06   710  	ceph_osdc_put_request(req);
1d3576fd10f0d7 Sage Weil          2009-10-06   711  }
1d3576fd10f0d7 Sage Weil          2009-10-06   712  
1d3576fd10f0d7 Sage Weil          2009-10-06   713  /*
1d3576fd10f0d7 Sage Weil          2009-10-06   714   * initiate async writeback
1d3576fd10f0d7 Sage Weil          2009-10-06   715   */
1d3576fd10f0d7 Sage Weil          2009-10-06   716  static int ceph_writepages_start(struct address_space *mapping,
1d3576fd10f0d7 Sage Weil          2009-10-06   717  				 struct writeback_control *wbc)
1d3576fd10f0d7 Sage Weil          2009-10-06   718  {
1d3576fd10f0d7 Sage Weil          2009-10-06   719  	struct inode *inode = mapping->host;
1d3576fd10f0d7 Sage Weil          2009-10-06   720  	struct ceph_inode_info *ci = ceph_inode(inode);
fc2744aa12da71 Yan, Zheng         2013-05-31   721  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
fc2744aa12da71 Yan, Zheng         2013-05-31   722  	struct ceph_vino vino = ceph_vino(inode);
2a2d927e35dd8d Yan, Zheng         2017-09-01   723  	pgoff_t index, start_index, end = -1;
80e755fedebc8d Sage Weil          2010-03-31   724  	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
1d3576fd10f0d7 Sage Weil          2009-10-06   725  	struct pagevec pvec;
1d3576fd10f0d7 Sage Weil          2009-10-06   726  	int rc = 0;
93407472a21b82 Fabian Frederick   2017-02-27   727  	unsigned int wsize = i_blocksize(inode);
1d3576fd10f0d7 Sage Weil          2009-10-06   728  	struct ceph_osd_request *req = NULL;
1f934b00e90752 Yan, Zheng         2017-08-30   729  	struct ceph_writeback_ctl ceph_wbc;
590e9d9861f5f2 Yan, Zheng         2017-09-03   730  	bool should_loop, range_whole = false;
af9cc401ce7452 Yan, Zheng         2018-03-04   731  	bool done = false;
1d3576fd10f0d7 Sage Weil          2009-10-06   732  
3fb99d483e614b Yanhu Cao          2017-07-21   733  	dout("writepages_start %p (mode=%s)\n", inode,
1d3576fd10f0d7 Sage Weil          2009-10-06   734  	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
1d3576fd10f0d7 Sage Weil          2009-10-06   735  	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
1d3576fd10f0d7 Sage Weil          2009-10-06   736  
50c9132ddfb202 Jeff Layton        2020-09-25   737  	if (READ_ONCE(fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN) {
6c93df5db628e7 Yan, Zheng         2016-04-15   738  		if (ci->i_wrbuffer_ref > 0) {
6c93df5db628e7 Yan, Zheng         2016-04-15   739  			pr_warn_ratelimited(
6c93df5db628e7 Yan, Zheng         2016-04-15   740  				"writepage_start %p %lld forced umount\n",
6c93df5db628e7 Yan, Zheng         2016-04-15   741  				inode, ceph_ino(inode));
6c93df5db628e7 Yan, Zheng         2016-04-15   742  		}
a341d4df87487a Yan, Zheng         2015-07-01   743  		mapping_set_error(mapping, -EIO);
1d3576fd10f0d7 Sage Weil          2009-10-06   744  		return -EIO; /* we're in a forced umount, don't write! */
1d3576fd10f0d7 Sage Weil          2009-10-06   745  	}
95cca2b44e54b0 Yan, Zheng         2017-07-11   746  	if (fsc->mount_options->wsize < wsize)
3d14c5d2b6e15c Yehuda Sadeh       2010-04-06   747  		wsize = fsc->mount_options->wsize;
1d3576fd10f0d7 Sage Weil          2009-10-06   748  
8667982014d604 Mel Gorman         2017-11-15   749  	pagevec_init(&pvec);
1d3576fd10f0d7 Sage Weil          2009-10-06   750  
590e9d9861f5f2 Yan, Zheng         2017-09-03   751  	start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
590e9d9861f5f2 Yan, Zheng         2017-09-03   752  	index = start_index;
1d3576fd10f0d7 Sage Weil          2009-10-06   753  
1d3576fd10f0d7 Sage Weil          2009-10-06   754  retry:
1d3576fd10f0d7 Sage Weil          2009-10-06   755  	/* find oldest snap context with dirty data */
05455e1177f768 Yan, Zheng         2017-09-02   756  	snapc = get_oldest_context(inode, &ceph_wbc, NULL);
1d3576fd10f0d7 Sage Weil          2009-10-06   757  	if (!snapc) {
1d3576fd10f0d7 Sage Weil          2009-10-06   758  		/* hmm, why does writepages get called when there
1d3576fd10f0d7 Sage Weil          2009-10-06   759  		   is no dirty data? */
1d3576fd10f0d7 Sage Weil          2009-10-06   760  		dout(" no snap context with dirty data?\n");
1d3576fd10f0d7 Sage Weil          2009-10-06   761  		goto out;
1d3576fd10f0d7 Sage Weil          2009-10-06   762  	}
1d3576fd10f0d7 Sage Weil          2009-10-06   763  	dout(" oldest snapc is %p seq %lld (%d snaps)\n",
1d3576fd10f0d7 Sage Weil          2009-10-06   764  	     snapc, snapc->seq, snapc->num_snaps);
fc2744aa12da71 Yan, Zheng         2013-05-31   765  
2a2d927e35dd8d Yan, Zheng         2017-09-01   766  	should_loop = false;
2a2d927e35dd8d Yan, Zheng         2017-09-01   767  	if (ceph_wbc.head_snapc && snapc != last_snapc) {
2a2d927e35dd8d Yan, Zheng         2017-09-01   768  		/* where to start/end? */
2a2d927e35dd8d Yan, Zheng         2017-09-01   769  		if (wbc->range_cyclic) {
2a2d927e35dd8d Yan, Zheng         2017-09-01   770  			index = start_index;
2a2d927e35dd8d Yan, Zheng         2017-09-01   771  			end = -1;
2a2d927e35dd8d Yan, Zheng         2017-09-01   772  			if (index > 0)
2a2d927e35dd8d Yan, Zheng         2017-09-01   773  				should_loop = true;
2a2d927e35dd8d Yan, Zheng         2017-09-01   774  			dout(" cyclic, start at %lu\n", index);
2a2d927e35dd8d Yan, Zheng         2017-09-01   775  		} else {
2a2d927e35dd8d Yan, Zheng         2017-09-01   776  			index = wbc->range_start >> PAGE_SHIFT;
2a2d927e35dd8d Yan, Zheng         2017-09-01   777  			end = wbc->range_end >> PAGE_SHIFT;
2a2d927e35dd8d Yan, Zheng         2017-09-01   778  			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
2a2d927e35dd8d Yan, Zheng         2017-09-01   779  				range_whole = true;
2a2d927e35dd8d Yan, Zheng         2017-09-01   780  			dout(" not cyclic, %lu to %lu\n", index, end);
2a2d927e35dd8d Yan, Zheng         2017-09-01   781  		}
2a2d927e35dd8d Yan, Zheng         2017-09-01   782  	} else if (!ceph_wbc.head_snapc) {
2a2d927e35dd8d Yan, Zheng         2017-09-01   783  		/* Do not respect wbc->range_{start,end}. Dirty pages
2a2d927e35dd8d Yan, Zheng         2017-09-01   784  		 * in that range can be associated with newer snapc.
2a2d927e35dd8d Yan, Zheng         2017-09-01   785  		 * They are not writeable until we write all dirty pages
2a2d927e35dd8d Yan, Zheng         2017-09-01   786  		 * associated with 'snapc' get written */
1582af2eaaf17c Yan, Zheng         2018-03-06   787  		if (index > 0)
2a2d927e35dd8d Yan, Zheng         2017-09-01   788  			should_loop = true;
2a2d927e35dd8d Yan, Zheng         2017-09-01   789  		dout(" non-head snapc, range whole\n");
1d3576fd10f0d7 Sage Weil          2009-10-06   790  	}
2a2d927e35dd8d Yan, Zheng         2017-09-01   791  
2a2d927e35dd8d Yan, Zheng         2017-09-01   792  	ceph_put_snap_context(last_snapc);
1d3576fd10f0d7 Sage Weil          2009-10-06   793  	last_snapc = snapc;
1d3576fd10f0d7 Sage Weil          2009-10-06   794  
af9cc401ce7452 Yan, Zheng         2018-03-04   795  	while (!done && index <= end) {
5b64640cf65be4 Yan, Zheng         2016-01-07   796  		int num_ops = 0, op_idx;
0e5ecac7168366 Yan, Zheng         2017-08-31   797  		unsigned i, pvec_pages, max_pages, locked_pages = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   798  		struct page **pages = NULL, **data_pages;
bd62d82fbd1b69 David Howells      2021-08-11   799  		struct page *folio;
0e5ecac7168366 Yan, Zheng         2017-08-31   800  		pgoff_t strip_unit_end = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   801  		u64 offset = 0, len = 0;
a0102bda5bc099 Jeff Layton        2020-07-30   802  		bool from_pool = false;
1d3576fd10f0d7 Sage Weil          2009-10-06   803  
0e5ecac7168366 Yan, Zheng         2017-08-31   804  		max_pages = wsize >> PAGE_SHIFT;
1d3576fd10f0d7 Sage Weil          2009-10-06   805  
1d3576fd10f0d7 Sage Weil          2009-10-06   806  get_more_pages:
2e169296603470 Jeff Layton        2020-09-14   807  		pvec_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
2e169296603470 Jeff Layton        2020-09-14   808  						end, PAGECACHE_TAG_DIRTY);
0ed75fc8d288f4 Jan Kara           2017-11-15   809  		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
1d3576fd10f0d7 Sage Weil          2009-10-06   810  		if (!pvec_pages && !locked_pages)
1d3576fd10f0d7 Sage Weil          2009-10-06   811  			break;
1d3576fd10f0d7 Sage Weil          2009-10-06   812  		for (i = 0; i < pvec_pages && locked_pages < max_pages; i++) {
1d3576fd10f0d7 Sage Weil          2009-10-06  @813  			page = pvec.pages[i];
bd62d82fbd1b69 David Howells      2021-08-11  @814  			dout("? %p idx %lu\n", folio, folio_index(folio));
1d3576fd10f0d7 Sage Weil          2009-10-06   815  			if (locked_pages == 0)
bd62d82fbd1b69 David Howells      2021-08-11  @816  				folio_lock(folio);  /* first page */
bd62d82fbd1b69 David Howells      2021-08-11  @817  			else if (!folio_trylock(folio))
1d3576fd10f0d7 Sage Weil          2009-10-06   818  				break;
1d3576fd10f0d7 Sage Weil          2009-10-06   819  
1d3576fd10f0d7 Sage Weil          2009-10-06   820  			/* only dirty pages, or our accounting breaks */
bd62d82fbd1b69 David Howells      2021-08-11  @821  			if (unlikely(!folio_test_dirty(folio)) ||
bd62d82fbd1b69 David Howells      2021-08-11  @822  			    unlikely(folio_mapping(folio) != mapping)) {
1d3576fd10f0d7 Sage Weil          2009-10-06   823  				dout("!dirty or !mapping %p\n", page);
bd62d82fbd1b69 David Howells      2021-08-11  @824  				folio_unlock(folio);
0713e5f24b7deb Yan, Zheng         2017-08-31   825  				continue;
1d3576fd10f0d7 Sage Weil          2009-10-06   826  			}
af9cc401ce7452 Yan, Zheng         2018-03-04   827  			/* only if matching snap context */
bd62d82fbd1b69 David Howells      2021-08-11  @828  			pgsnapc = folio_snap_context(folio);
af9cc401ce7452 Yan, Zheng         2018-03-04   829  			if (pgsnapc != snapc) {
af9cc401ce7452 Yan, Zheng         2018-03-04   830  				dout("page snapc %p %lld != oldest %p %lld\n",
af9cc401ce7452 Yan, Zheng         2018-03-04   831  				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
1582af2eaaf17c Yan, Zheng         2018-03-06   832  				if (!should_loop &&
1582af2eaaf17c Yan, Zheng         2018-03-06   833  				    !ceph_wbc.head_snapc &&
1582af2eaaf17c Yan, Zheng         2018-03-06   834  				    wbc->sync_mode != WB_SYNC_NONE)
1582af2eaaf17c Yan, Zheng         2018-03-06   835  					should_loop = true;
bd62d82fbd1b69 David Howells      2021-08-11  @836  				folio_unlock(folio);
af9cc401ce7452 Yan, Zheng         2018-03-04   837  				continue;
1d3576fd10f0d7 Sage Weil          2009-10-06   838  			}
bd62d82fbd1b69 David Howells      2021-08-11  @839  			if (folio_file_pos(folio) >= ceph_wbc.i_size) {
1f934b00e90752 Yan, Zheng         2017-08-30   840  				dout("%p page eof %llu\n",
1f934b00e90752 Yan, Zheng         2017-08-30   841  				     page, ceph_wbc.i_size);
c95f1c5f436bad Erqi Chen          2019-07-24   842  				if ((ceph_wbc.size_stable ||
bd62d82fbd1b69 David Howells      2021-08-11  @843  				    folio_file_pos(folio) >= i_size_read(inode)) &&
c95f1c5f436bad Erqi Chen          2019-07-24   844  				    clear_page_dirty_for_io(page))
af9cc401ce7452 Yan, Zheng         2018-03-04   845  					mapping->a_ops->invalidatepage(page,
bd62d82fbd1b69 David Howells      2021-08-11  @846  								0, folio_size(folio));
bd62d82fbd1b69 David Howells      2021-08-11   847  				folio_unlock(folio);
af9cc401ce7452 Yan, Zheng         2018-03-04   848  				continue;
af9cc401ce7452 Yan, Zheng         2018-03-04   849  			}
bd62d82fbd1b69 David Howells      2021-08-11   850  			if (strip_unit_end && (folio_index(folio) > strip_unit_end)) {
af9cc401ce7452 Yan, Zheng         2018-03-04   851  				dout("end of strip unit %p\n", page);
bd62d82fbd1b69 David Howells      2021-08-11   852  				folio_unlock(folio);
1d3576fd10f0d7 Sage Weil          2009-10-06   853  				break;
1d3576fd10f0d7 Sage Weil          2009-10-06   854  			}
1d3576fd10f0d7 Sage Weil          2009-10-06   855  			if (PageWriteback(page)) {
0713e5f24b7deb Yan, Zheng         2017-08-31   856  				if (wbc->sync_mode == WB_SYNC_NONE) {
1d3576fd10f0d7 Sage Weil          2009-10-06   857  					dout("%p under writeback\n", page);
bd62d82fbd1b69 David Howells      2021-08-11   858  					folio_unlock(folio);
0713e5f24b7deb Yan, Zheng         2017-08-31   859  					continue;
0713e5f24b7deb Yan, Zheng         2017-08-31   860  				}
0713e5f24b7deb Yan, Zheng         2017-08-31   861  				dout("waiting on writeback %p\n", page);
0713e5f24b7deb Yan, Zheng         2017-08-31   862  				wait_on_page_writeback(page);
1d3576fd10f0d7 Sage Weil          2009-10-06   863  			}
1d3576fd10f0d7 Sage Weil          2009-10-06   864  
1d3576fd10f0d7 Sage Weil          2009-10-06   865  			if (!clear_page_dirty_for_io(page)) {
1d3576fd10f0d7 Sage Weil          2009-10-06   866  				dout("%p !clear_page_dirty_for_io\n", page);
bd62d82fbd1b69 David Howells      2021-08-11   867  				folio_unlock(folio);
0713e5f24b7deb Yan, Zheng         2017-08-31   868  				continue;
1d3576fd10f0d7 Sage Weil          2009-10-06   869  			}
1d3576fd10f0d7 Sage Weil          2009-10-06   870  
e5975c7c8eb6ae Alex Elder         2013-03-14   871  			/*
e5975c7c8eb6ae Alex Elder         2013-03-14   872  			 * We have something to write.  If this is
e5975c7c8eb6ae Alex Elder         2013-03-14   873  			 * the first locked page this time through,
5b64640cf65be4 Yan, Zheng         2016-01-07   874  			 * calculate max possinle write size and
5b64640cf65be4 Yan, Zheng         2016-01-07   875  			 * allocate a page array
e5975c7c8eb6ae Alex Elder         2013-03-14   876  			 */
1d3576fd10f0d7 Sage Weil          2009-10-06   877  			if (locked_pages == 0) {
5b64640cf65be4 Yan, Zheng         2016-01-07   878  				u64 objnum;
5b64640cf65be4 Yan, Zheng         2016-01-07   879  				u64 objoff;
dccbf08005df80 Ilya Dryomov       2018-02-17   880  				u32 xlen;
5b64640cf65be4 Yan, Zheng         2016-01-07   881  
1d3576fd10f0d7 Sage Weil          2009-10-06   882  				/* prepare async write request */
bd62d82fbd1b69 David Howells      2021-08-11   883  				offset = (u64)folio_file_pos(folio);
dccbf08005df80 Ilya Dryomov       2018-02-17   884  				ceph_calc_file_object_mapping(&ci->i_layout,
dccbf08005df80 Ilya Dryomov       2018-02-17   885  							      offset, wsize,
5b64640cf65be4 Yan, Zheng         2016-01-07   886  							      &objnum, &objoff,
dccbf08005df80 Ilya Dryomov       2018-02-17   887  							      &xlen);
dccbf08005df80 Ilya Dryomov       2018-02-17   888  				len = xlen;
8c71897be2ddfd Henry C Chang      2011-05-03   889  
3fb99d483e614b Yanhu Cao          2017-07-21   890  				num_ops = 1;
bd62d82fbd1b69 David Howells      2021-08-11   891  				strip_unit_end = folio_index(folio) +
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01   892  					((len - 1) >> PAGE_SHIFT);
88486957f9fbf5 Alex Elder         2013-03-14   893  
5b64640cf65be4 Yan, Zheng         2016-01-07   894  				BUG_ON(pages);
88486957f9fbf5 Alex Elder         2013-03-14   895  				max_pages = calc_pages_for(0, (u64)len);
6da2ec56059c3c Kees Cook          2018-06-12   896  				pages = kmalloc_array(max_pages,
6da2ec56059c3c Kees Cook          2018-06-12   897  						      sizeof(*pages),
fc2744aa12da71 Yan, Zheng         2013-05-31   898  						      GFP_NOFS);
88486957f9fbf5 Alex Elder         2013-03-14   899  				if (!pages) {
a0102bda5bc099 Jeff Layton        2020-07-30   900  					from_pool = true;
a0102bda5bc099 Jeff Layton        2020-07-30   901  					pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
e5975c7c8eb6ae Alex Elder         2013-03-14   902  					BUG_ON(!pages);
88486957f9fbf5 Alex Elder         2013-03-14   903  				}
5b64640cf65be4 Yan, Zheng         2016-01-07   904  
5b64640cf65be4 Yan, Zheng         2016-01-07   905  				len = 0;
bd62d82fbd1b69 David Howells      2021-08-11   906  			} else if (folio_index(folio) !=
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01   907  				   (offset + len) >> PAGE_SHIFT) {
a0102bda5bc099 Jeff Layton        2020-07-30   908  				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
5b64640cf65be4 Yan, Zheng         2016-01-07   909  							     CEPH_OSD_MAX_OPS)) {
5b64640cf65be4 Yan, Zheng         2016-01-07   910  					redirty_page_for_writepage(wbc, page);
bd62d82fbd1b69 David Howells      2021-08-11   911  					folio_unlock(folio);
5b64640cf65be4 Yan, Zheng         2016-01-07   912  					break;
5b64640cf65be4 Yan, Zheng         2016-01-07   913  				}
5b64640cf65be4 Yan, Zheng         2016-01-07   914  
5b64640cf65be4 Yan, Zheng         2016-01-07   915  				num_ops++;
bd62d82fbd1b69 David Howells      2021-08-11   916  				offset = (u64)folio_file_pos(folio);
5b64640cf65be4 Yan, Zheng         2016-01-07   917  				len = 0;
1d3576fd10f0d7 Sage Weil          2009-10-06   918  			}
1d3576fd10f0d7 Sage Weil          2009-10-06   919  
1d3576fd10f0d7 Sage Weil          2009-10-06   920  			/* note position of first page in pvec */
1d3576fd10f0d7 Sage Weil          2009-10-06   921  			dout("%p will write page %p idx %lu\n",
bd62d82fbd1b69 David Howells      2021-08-11   922  			     inode, page, folio_index(folio));
2baba25019ec56 Yehuda Sadeh       2009-12-18   923  
5b64640cf65be4 Yan, Zheng         2016-01-07   924  			if (atomic_long_inc_return(&fsc->writeback_count) >
5b64640cf65be4 Yan, Zheng         2016-01-07   925  			    CONGESTION_ON_THRESH(
3d14c5d2b6e15c Yehuda Sadeh       2010-04-06   926  				    fsc->mount_options->congestion_kb)) {
09dc9fc24ba714 Jan Kara           2017-04-12   927  				set_bdi_congested(inode_to_bdi(inode),
213c99ee0cf17f Sage Weil          2010-08-03   928  						  BLK_RW_ASYNC);
2baba25019ec56 Yehuda Sadeh       2009-12-18   929  			}
2baba25019ec56 Yehuda Sadeh       2009-12-18   930  
0713e5f24b7deb Yan, Zheng         2017-08-31   931  
0713e5f24b7deb Yan, Zheng         2017-08-31   932  			pages[locked_pages++] = page;
0713e5f24b7deb Yan, Zheng         2017-08-31   933  			pvec.pages[i] = NULL;
0713e5f24b7deb Yan, Zheng         2017-08-31   934  
bd62d82fbd1b69 David Howells      2021-08-11   935  			len += folio_size(folio);
1d3576fd10f0d7 Sage Weil          2009-10-06   936  		}
1d3576fd10f0d7 Sage Weil          2009-10-06   937  
1d3576fd10f0d7 Sage Weil          2009-10-06   938  		/* did we get anything? */
1d3576fd10f0d7 Sage Weil          2009-10-06   939  		if (!locked_pages)
1d3576fd10f0d7 Sage Weil          2009-10-06   940  			goto release_pvec_pages;
1d3576fd10f0d7 Sage Weil          2009-10-06   941  		if (i) {
0713e5f24b7deb Yan, Zheng         2017-08-31   942  			unsigned j, n = 0;
0713e5f24b7deb Yan, Zheng         2017-08-31   943  			/* shift unused page to beginning of pvec */
0713e5f24b7deb Yan, Zheng         2017-08-31   944  			for (j = 0; j < pvec_pages; j++) {
0713e5f24b7deb Yan, Zheng         2017-08-31   945  				if (!pvec.pages[j])
0713e5f24b7deb Yan, Zheng         2017-08-31   946  					continue;
0713e5f24b7deb Yan, Zheng         2017-08-31   947  				if (n < j)
0713e5f24b7deb Yan, Zheng         2017-08-31   948  					pvec.pages[n] = pvec.pages[j];
0713e5f24b7deb Yan, Zheng         2017-08-31   949  				n++;
0713e5f24b7deb Yan, Zheng         2017-08-31   950  			}
0713e5f24b7deb Yan, Zheng         2017-08-31   951  			pvec.nr = n;
1d3576fd10f0d7 Sage Weil          2009-10-06   952  
1d3576fd10f0d7 Sage Weil          2009-10-06   953  			if (pvec_pages && i == pvec_pages &&
1d3576fd10f0d7 Sage Weil          2009-10-06   954  			    locked_pages < max_pages) {
1d3576fd10f0d7 Sage Weil          2009-10-06   955  				dout("reached end pvec, trying for more\n");
0713e5f24b7deb Yan, Zheng         2017-08-31   956  				pagevec_release(&pvec);
1d3576fd10f0d7 Sage Weil          2009-10-06   957  				goto get_more_pages;
1d3576fd10f0d7 Sage Weil          2009-10-06   958  			}
1d3576fd10f0d7 Sage Weil          2009-10-06   959  		}
1d3576fd10f0d7 Sage Weil          2009-10-06   960  
5b64640cf65be4 Yan, Zheng         2016-01-07   961  new_request:
bd62d82fbd1b69 David Howells      2021-08-11   962  		offset = folio_file_pos(pages[0]);
5b64640cf65be4 Yan, Zheng         2016-01-07   963  		len = wsize;
5b64640cf65be4 Yan, Zheng         2016-01-07   964  
5b64640cf65be4 Yan, Zheng         2016-01-07   965  		req = ceph_osdc_new_request(&fsc->client->osdc,
5b64640cf65be4 Yan, Zheng         2016-01-07   966  					&ci->i_layout, vino,
5b64640cf65be4 Yan, Zheng         2016-01-07   967  					offset, &len, 0, num_ops,
1f934b00e90752 Yan, Zheng         2017-08-30   968  					CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
1f934b00e90752 Yan, Zheng         2017-08-30   969  					snapc, ceph_wbc.truncate_seq,
1f934b00e90752 Yan, Zheng         2017-08-30   970  					ceph_wbc.truncate_size, false);
5b64640cf65be4 Yan, Zheng         2016-01-07   971  		if (IS_ERR(req)) {
5b64640cf65be4 Yan, Zheng         2016-01-07   972  			req = ceph_osdc_new_request(&fsc->client->osdc,
5b64640cf65be4 Yan, Zheng         2016-01-07   973  						&ci->i_layout, vino,
5b64640cf65be4 Yan, Zheng         2016-01-07   974  						offset, &len, 0,
5b64640cf65be4 Yan, Zheng         2016-01-07   975  						min(num_ops,
5b64640cf65be4 Yan, Zheng         2016-01-07   976  						    CEPH_OSD_SLAB_OPS),
5b64640cf65be4 Yan, Zheng         2016-01-07   977  						CEPH_OSD_OP_WRITE,
54ea0046b6fe36 Ilya Dryomov       2017-02-11   978  						CEPH_OSD_FLAG_WRITE,
1f934b00e90752 Yan, Zheng         2017-08-30   979  						snapc, ceph_wbc.truncate_seq,
1f934b00e90752 Yan, Zheng         2017-08-30   980  						ceph_wbc.truncate_size, true);
5b64640cf65be4 Yan, Zheng         2016-01-07   981  			BUG_ON(IS_ERR(req));
5b64640cf65be4 Yan, Zheng         2016-01-07   982  		}
bd62d82fbd1b69 David Howells      2021-08-11   983  		BUG_ON(len < folio_file_pos(pages[locked_pages - 1]) +
bd62d82fbd1b69 David Howells      2021-08-11   984  			     folio_size(folio) - offset);
5b64640cf65be4 Yan, Zheng         2016-01-07   985  
5b64640cf65be4 Yan, Zheng         2016-01-07   986  		req->r_callback = writepages_finish;
5b64640cf65be4 Yan, Zheng         2016-01-07   987  		req->r_inode = inode;
5b64640cf65be4 Yan, Zheng         2016-01-07   988  
5b64640cf65be4 Yan, Zheng         2016-01-07   989  		/* Format the osd request message and submit the write */
5b64640cf65be4 Yan, Zheng         2016-01-07   990  		len = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   991  		data_pages = pages;
5b64640cf65be4 Yan, Zheng         2016-01-07   992  		op_idx = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07   993  		for (i = 0; i < locked_pages; i++) {
5b64640cf65be4 Yan, Zheng         2016-01-07   994  			u64 cur_offset = page_offset(pages[i]);
5b64640cf65be4 Yan, Zheng         2016-01-07   995  			if (offset + len != cur_offset) {
3fb99d483e614b Yanhu Cao          2017-07-21   996  				if (op_idx + 1 == req->r_num_ops)
5b64640cf65be4 Yan, Zheng         2016-01-07   997  					break;
5b64640cf65be4 Yan, Zheng         2016-01-07   998  				osd_req_op_extent_dup_last(req, op_idx,
5b64640cf65be4 Yan, Zheng         2016-01-07   999  							   cur_offset - offset);
5b64640cf65be4 Yan, Zheng         2016-01-07  1000  				dout("writepages got pages at %llu~%llu\n",
5b64640cf65be4 Yan, Zheng         2016-01-07  1001  				     offset, len);
5b64640cf65be4 Yan, Zheng         2016-01-07  1002  				osd_req_op_extent_osd_data_pages(req, op_idx,
5b64640cf65be4 Yan, Zheng         2016-01-07  1003  							data_pages, len, 0,
a0102bda5bc099 Jeff Layton        2020-07-30  1004  							from_pool, false);
5b64640cf65be4 Yan, Zheng         2016-01-07  1005  				osd_req_op_extent_update(req, op_idx, len);
5b64640cf65be4 Yan, Zheng         2016-01-07  1006  
5b64640cf65be4 Yan, Zheng         2016-01-07  1007  				len = 0;
5b64640cf65be4 Yan, Zheng         2016-01-07  1008  				offset = cur_offset; 
5b64640cf65be4 Yan, Zheng         2016-01-07  1009  				data_pages = pages + i;
5b64640cf65be4 Yan, Zheng         2016-01-07  1010  				op_idx++;
5b64640cf65be4 Yan, Zheng         2016-01-07  1011  			}
5b64640cf65be4 Yan, Zheng         2016-01-07  1012  
5b64640cf65be4 Yan, Zheng         2016-01-07  1013  			set_page_writeback(pages[i]);
bd62d82fbd1b69 David Howells      2021-08-11  1014  			len += folio_size(folio);
5b64640cf65be4 Yan, Zheng         2016-01-07  1015  		}
5b64640cf65be4 Yan, Zheng         2016-01-07  1016  
1f934b00e90752 Yan, Zheng         2017-08-30  1017  		if (ceph_wbc.size_stable) {
1f934b00e90752 Yan, Zheng         2017-08-30  1018  			len = min(len, ceph_wbc.i_size - offset);
5b64640cf65be4 Yan, Zheng         2016-01-07  1019  		} else if (i == locked_pages) {
e1966b49446a43 Yan, Zheng         2015-06-18  1020  			/* writepages_finish() clears writeback pages
e1966b49446a43 Yan, Zheng         2015-06-18  1021  			 * according to the data length, so make sure
e1966b49446a43 Yan, Zheng         2015-06-18  1022  			 * data length covers all locked pages */
bd62d82fbd1b69 David Howells      2021-08-11  1023  			u64 min_len = len + 1 - folio_size(folio);
1f934b00e90752 Yan, Zheng         2017-08-30  1024  			len = get_writepages_data_length(inode, pages[i - 1],
1f934b00e90752 Yan, Zheng         2017-08-30  1025  							 offset);
5b64640cf65be4 Yan, Zheng         2016-01-07  1026  			len = max(len, min_len);
e1966b49446a43 Yan, Zheng         2015-06-18  1027  		}
5b64640cf65be4 Yan, Zheng         2016-01-07  1028  		dout("writepages got pages at %llu~%llu\n", offset, len);
1d3576fd10f0d7 Sage Weil          2009-10-06  1029  
5b64640cf65be4 Yan, Zheng         2016-01-07  1030  		osd_req_op_extent_osd_data_pages(req, op_idx, data_pages, len,
a0102bda5bc099 Jeff Layton        2020-07-30  1031  						 0, from_pool, false);
5b64640cf65be4 Yan, Zheng         2016-01-07  1032  		osd_req_op_extent_update(req, op_idx, len);
e5975c7c8eb6ae Alex Elder         2013-03-14  1033  
5b64640cf65be4 Yan, Zheng         2016-01-07  1034  		BUG_ON(op_idx + 1 != req->r_num_ops);
e5975c7c8eb6ae Alex Elder         2013-03-14  1035  
a0102bda5bc099 Jeff Layton        2020-07-30  1036  		from_pool = false;
5b64640cf65be4 Yan, Zheng         2016-01-07  1037  		if (i < locked_pages) {
5b64640cf65be4 Yan, Zheng         2016-01-07  1038  			BUG_ON(num_ops <= req->r_num_ops);
5b64640cf65be4 Yan, Zheng         2016-01-07  1039  			num_ops -= req->r_num_ops;
5b64640cf65be4 Yan, Zheng         2016-01-07  1040  			locked_pages -= i;
5b64640cf65be4 Yan, Zheng         2016-01-07  1041  
5b64640cf65be4 Yan, Zheng         2016-01-07  1042  			/* allocate new pages array for next request */
5b64640cf65be4 Yan, Zheng         2016-01-07  1043  			data_pages = pages;
6da2ec56059c3c Kees Cook          2018-06-12  1044  			pages = kmalloc_array(locked_pages, sizeof(*pages),
5b64640cf65be4 Yan, Zheng         2016-01-07  1045  					      GFP_NOFS);
5b64640cf65be4 Yan, Zheng         2016-01-07  1046  			if (!pages) {
a0102bda5bc099 Jeff Layton        2020-07-30  1047  				from_pool = true;
a0102bda5bc099 Jeff Layton        2020-07-30  1048  				pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
5b64640cf65be4 Yan, Zheng         2016-01-07  1049  				BUG_ON(!pages);
5b64640cf65be4 Yan, Zheng         2016-01-07  1050  			}
5b64640cf65be4 Yan, Zheng         2016-01-07  1051  			memcpy(pages, data_pages + i,
5b64640cf65be4 Yan, Zheng         2016-01-07  1052  			       locked_pages * sizeof(*pages));
5b64640cf65be4 Yan, Zheng         2016-01-07  1053  			memset(data_pages + i, 0,
5b64640cf65be4 Yan, Zheng         2016-01-07  1054  			       locked_pages * sizeof(*pages));
5b64640cf65be4 Yan, Zheng         2016-01-07  1055  		} else {
5b64640cf65be4 Yan, Zheng         2016-01-07  1056  			BUG_ON(num_ops != req->r_num_ops);
5b64640cf65be4 Yan, Zheng         2016-01-07  1057  			index = pages[i - 1]->index + 1;
5b64640cf65be4 Yan, Zheng         2016-01-07  1058  			/* request message now owns the pages array */
5b64640cf65be4 Yan, Zheng         2016-01-07  1059  			pages = NULL;
5b64640cf65be4 Yan, Zheng         2016-01-07  1060  		}
e5975c7c8eb6ae Alex Elder         2013-03-14  1061  
fac02ddf910814 Arnd Bergmann      2018-07-13  1062  		req->r_mtime = inode->i_mtime;
9d6fcb081a4770 Sage Weil          2011-05-12  1063  		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
9d6fcb081a4770 Sage Weil          2011-05-12  1064  		BUG_ON(rc);
1d3576fd10f0d7 Sage Weil          2009-10-06  1065  		req = NULL;
1d3576fd10f0d7 Sage Weil          2009-10-06  1066  
5b64640cf65be4 Yan, Zheng         2016-01-07  1067  		wbc->nr_to_write -= i;
5b64640cf65be4 Yan, Zheng         2016-01-07  1068  		if (pages)
5b64640cf65be4 Yan, Zheng         2016-01-07  1069  			goto new_request;
5b64640cf65be4 Yan, Zheng         2016-01-07  1070  
2a2d927e35dd8d Yan, Zheng         2017-09-01  1071  		/*
2a2d927e35dd8d Yan, Zheng         2017-09-01  1072  		 * We stop writing back only if we are not doing
2a2d927e35dd8d Yan, Zheng         2017-09-01  1073  		 * integrity sync. In case of integrity sync we have to
2a2d927e35dd8d Yan, Zheng         2017-09-01  1074  		 * keep going until we have written all the pages
2a2d927e35dd8d Yan, Zheng         2017-09-01  1075  		 * we tagged for writeback prior to entering this loop.
2a2d927e35dd8d Yan, Zheng         2017-09-01  1076  		 */
2a2d927e35dd8d Yan, Zheng         2017-09-01  1077  		if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
af9cc401ce7452 Yan, Zheng         2018-03-04  1078  			done = true;
1d3576fd10f0d7 Sage Weil          2009-10-06  1079  
1d3576fd10f0d7 Sage Weil          2009-10-06  1080  release_pvec_pages:
1d3576fd10f0d7 Sage Weil          2009-10-06  1081  		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
1d3576fd10f0d7 Sage Weil          2009-10-06  1082  		     pvec.nr ? pvec.pages[0] : NULL);
1d3576fd10f0d7 Sage Weil          2009-10-06  1083  		pagevec_release(&pvec);
1d3576fd10f0d7 Sage Weil          2009-10-06  1084  	}
1d3576fd10f0d7 Sage Weil          2009-10-06  1085  
1d3576fd10f0d7 Sage Weil          2009-10-06  1086  	if (should_loop && !done) {
1d3576fd10f0d7 Sage Weil          2009-10-06  1087  		/* more to do; loop back to beginning of file */
1d3576fd10f0d7 Sage Weil          2009-10-06  1088  		dout("writepages looping back to beginning of file\n");
2a2d927e35dd8d Yan, Zheng         2017-09-01  1089  		end = start_index - 1; /* OK even when start_index == 0 */
f275635ee0b664 Yan, Zheng         2017-09-01  1090  
f275635ee0b664 Yan, Zheng         2017-09-01  1091  		/* to write dirty pages associated with next snapc,
f275635ee0b664 Yan, Zheng         2017-09-01  1092  		 * we need to wait until current writes complete */
f275635ee0b664 Yan, Zheng         2017-09-01  1093  		if (wbc->sync_mode != WB_SYNC_NONE &&
f275635ee0b664 Yan, Zheng         2017-09-01  1094  		    start_index == 0 && /* all dirty pages were checked */
f275635ee0b664 Yan, Zheng         2017-09-01  1095  		    !ceph_wbc.head_snapc) {
f275635ee0b664 Yan, Zheng         2017-09-01  1096  			struct page *page;
f275635ee0b664 Yan, Zheng         2017-09-01  1097  			unsigned i, nr;
f275635ee0b664 Yan, Zheng         2017-09-01  1098  			index = 0;
f275635ee0b664 Yan, Zheng         2017-09-01  1099  			while ((index <= end) &&
f275635ee0b664 Yan, Zheng         2017-09-01  1100  			       (nr = pagevec_lookup_tag(&pvec, mapping, &index,
67fd707f468142 Jan Kara           2017-11-15  1101  						PAGECACHE_TAG_WRITEBACK))) {
f275635ee0b664 Yan, Zheng         2017-09-01  1102  				for (i = 0; i < nr; i++) {
f275635ee0b664 Yan, Zheng         2017-09-01  1103  					page = pvec.pages[i];
bd62d82fbd1b69 David Howells      2021-08-11  1104  					if (folio_snap_context(folio) != snapc)
f275635ee0b664 Yan, Zheng         2017-09-01  1105  						continue;
f275635ee0b664 Yan, Zheng         2017-09-01  1106  					wait_on_page_writeback(page);
f275635ee0b664 Yan, Zheng         2017-09-01  1107  				}
f275635ee0b664 Yan, Zheng         2017-09-01  1108  				pagevec_release(&pvec);
f275635ee0b664 Yan, Zheng         2017-09-01  1109  				cond_resched();
f275635ee0b664 Yan, Zheng         2017-09-01  1110  			}
f275635ee0b664 Yan, Zheng         2017-09-01  1111  		}
f275635ee0b664 Yan, Zheng         2017-09-01  1112  
2a2d927e35dd8d Yan, Zheng         2017-09-01  1113  		start_index = 0;
1d3576fd10f0d7 Sage Weil          2009-10-06  1114  		index = 0;
1d3576fd10f0d7 Sage Weil          2009-10-06  1115  		goto retry;
1d3576fd10f0d7 Sage Weil          2009-10-06  1116  	}
1d3576fd10f0d7 Sage Weil          2009-10-06  1117  
1d3576fd10f0d7 Sage Weil          2009-10-06  1118  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
1d3576fd10f0d7 Sage Weil          2009-10-06  1119  		mapping->writeback_index = index;
1d3576fd10f0d7 Sage Weil          2009-10-06  1120  
1d3576fd10f0d7 Sage Weil          2009-10-06  1121  out:
1d3576fd10f0d7 Sage Weil          2009-10-06  1122  	ceph_osdc_put_request(req);
2a2d927e35dd8d Yan, Zheng         2017-09-01  1123  	ceph_put_snap_context(last_snapc);
2a2d927e35dd8d Yan, Zheng         2017-09-01  1124  	dout("writepages dend - startone, rc = %d\n", rc);
1d3576fd10f0d7 Sage Weil          2009-10-06  1125  	return rc;
1d3576fd10f0d7 Sage Weil          2009-10-06  1126  }
1d3576fd10f0d7 Sage Weil          2009-10-06  1127  

:::::: The code at line 813 was first introduced by commit
:::::: 1d3576fd10f0d7a104204267b81cf84a07028dad ceph: address space operations

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--G4iJoqBmSsgzjUCe
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--G4iJoqBmSsgzjUCe--
