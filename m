Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6343DAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJ1GOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:14:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:51050 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhJ1GOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:14:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230280586"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="gz'50?scan'50,208,50";a="230280586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 23:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="gz'50?scan'50,208,50";a="665276009"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Oct 2021 23:12:23 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfyeE-0001eT-OH; Thu, 28 Oct 2021 06:12:22 +0000
Date:   Thu, 28 Oct 2021 14:11:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rmk-arm:zii 80/94] drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:6:
 warning: variable 'err' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202110281428.vtbiRTIi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.armlinux.org.uk/~rmk/linux-arm zii
head:   63399fbad78b99ef5619e4e62852e196a08ea23d
commit: 148b1cb5788a164699680d379ce9e93c7c4b3734 [80/94] net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs *EXPERIMENTAL*
config: arm-randconfig-c002-20211027 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7568a6a1fcb408eb8988abdaff2a225a8eb72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add rmk-arm git://git.armlinux.org.uk/~rmk/linux-arm
        git fetch --no-tags rmk-arm zii
        git checkout 148b1cb5788a164699680d379ce9e93c7c4b3734
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (oldpage >= 0)
               ^~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:120:53: note: uninitialized use occurs here
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                                                              ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:2: note: remove the 'if' if its condition is always true
           if (oldpage >= 0)
           ^~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:113:18: note: initialize the variable 'err' to silence this warning
           int oldpage, err;
                           ^
                            = 0
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (oldpage >= 0)
               ^~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:193:53: note: uninitialized use occurs here
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                                                              ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:2: note: remove the 'if' if its condition is always true
           if (oldpage >= 0)
           ^~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:182:23: note: initialize the variable 'err' to silence this warning
           int oldpage, adv, err;
                                ^
                                 = 0
   2 warnings generated.


clang-analyzer warnings: (new ones prefixed by >>)
                   list = list_first_entry(&qgroup->groups,
                          ^
   include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
           list_entry((ptr)->next, type, member)
           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   include/linux/kernel.h:495:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:308:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   fs/btrfs/qgroup.c:232:10: note: Loop condition is false.  Exiting loop
                   list = list_first_entry(&qgroup->groups,
                          ^
   include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
           list_entry((ptr)->next, type, member)
           ^
   include/linux/list.h:511:2: note: expanded from macro 'list_entry'
           container_of(ptr, type, member)
           ^
   include/linux/kernel.h:495:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:306:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   fs/btrfs/qgroup.c:234:3: note: Calling 'list_del'
                   list_del(&list->next_group);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:147:14: note: Use of memory after it is freed
           entry->next = LIST_POISON1;
           ~~~~~~~~~~~ ^
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   8 warnings generated.
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:120:9: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:200:2: note: Calling 'marvell_c22_pcs_modify'
           marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_ANRESTART, BMCR_ANRESTART);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:113:15: note: 'err' declared without an initial value
           int oldpage, err;
                        ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:6: note: 'oldpage' is < 0
           if (oldpage >= 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:2: note: Taking false branch
           if (oldpage >= 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:120:9: note: 3rd function call argument is an uninitialized value
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:193:9: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:182:20: note: 'err' declared without an initial value
           int oldpage, adv, err;
                             ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:185:6: note: Assuming 'adv' is >= 0
           if (adv < 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:185:2: note: Taking false branch
           if (adv < 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:6: note: 'oldpage' is < 0
           if (oldpage >= 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:2: note: Taking false branch
           if (oldpage >= 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:193:9: note: 3rd function call argument is an uninitialized value
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
>> drivers/net/dsa/mv88e6xxx/serdes-6352.c:228:8: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage [clang-analyzer-core.uninitialized.Assign]
                   bmcr |= BMCR_FULLDPLX;
                   ~~~~ ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:209:2: note: 'bmcr' declared without an initial value
           u16 bmcr;
           ^~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Calling 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:9: note: Assuming 'mode' is not equal to MLO_AN_INBAND
           return mode == MLO_AN_INBAND;
                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:2: note: Returning zero, which participates in a condition later
           return mode == MLO_AN_INBAND;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Returning from 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:2: note: Taking false branch
           if (phylink_autoneg_inband(mode))
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:215:2: note: 'Default' branch taken. Execution continues on line 227
           switch (speed) {
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:6: note: Assuming 'duplex' is equal to DUPLEX_FULL
           if (duplex == DUPLEX_FULL)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:2: note: Taking true branch
           if (duplex == DUPLEX_FULL)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:228:8: note: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
                   bmcr |= BMCR_FULLDPLX;
                   ~~~~ ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:230:8: warning: 4th function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_SPEED100 |
                 ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:209:2: note: 'bmcr' declared without an initial value
           u16 bmcr;
           ^~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Calling 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:9: note: Assuming 'mode' is not equal to MLO_AN_INBAND
           return mode == MLO_AN_INBAND;
                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:2: note: Returning zero, which participates in a condition later
           return mode == MLO_AN_INBAND;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Returning from 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:2: note: Taking false branch
           if (phylink_autoneg_inband(mode))
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:215:2: note: 'Default' branch taken. Execution continues on line 227
           switch (speed) {
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:6: note: Assuming 'duplex' is not equal to DUPLEX_FULL
           if (duplex == DUPLEX_FULL)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:2: note: Taking false branch
           if (duplex == DUPLEX_FULL)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:230:8: note: 4th function call argument is an uninitialized value
           err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_SPEED100 |
                 ^
   Suppressed 4 warnings (2 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   drivers/dma/sf-pdma/sf-pdma.c:59:6: warning: Access to field 'desc' results in a dereference of a null pointer (loaded from variable 'chan') [clang-analyzer-core.NullDereference]
           if (chan->desc && !chan->desc->in_use) {
               ^
   drivers/dma/sf-pdma/sf-pdma.c:95:30: note: Calling 'to_sf_pdma_chan'
           struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
                                       ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/sf-pdma/sf-pdma.c:44:9: note: Left side of '&&' is false
           return container_of(dchan, struct sf_pdma_chan, vchan.chan);
                  ^
   include/linux/kernel.h:495:61: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                      ^
   drivers/dma/sf-pdma/sf-pdma.c:44:9: note: Taking false branch
           return container_of(dchan, struct sf_pdma_chan, vchan.chan);
                  ^
   include/linux/kernel.h:495:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
--
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   8 warnings generated.
   net/vmw_vsock/af_vsock.c:917:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:917:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1131:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1131:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1303:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1303:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1675:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1675:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1732:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:1732:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:2075:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = 0;
           ^     ~
   net/vmw_vsock/af_vsock.c:2075:2: note: Value stored to 'err' is never read
           err = 0;
           ^     ~
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   8 warnings generated.
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:120:9: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:200:2: note: Calling 'marvell_c22_pcs_modify'
           marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_ANRESTART, BMCR_ANRESTART);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:113:15: note: 'err' declared without an initial value
           int oldpage, err;
                        ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:6: note: 'oldpage' is < 0
           if (oldpage >= 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:116:2: note: Taking false branch
           if (oldpage >= 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:120:9: note: 3rd function call argument is an uninitialized value
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:193:9: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:182:20: note: 'err' declared without an initial value
           int oldpage, adv, err;
                             ^~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:185:6: note: Assuming 'adv' is >= 0
           if (adv < 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:185:2: note: Taking false branch
           if (adv < 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:6: note: 'oldpage' is < 0
           if (oldpage >= 0)
               ^~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:189:2: note: Taking false branch
           if (oldpage >= 0)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:193:9: note: 3rd function call argument is an uninitialized value
           return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
                  ^                                           ~~~
>> drivers/net/dsa/mv88e6xxx/serdes-6352.c:228:8: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage [clang-analyzer-core.uninitialized.Assign]
                   bmcr |= BMCR_FULLDPLX;
                   ~~~~ ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:209:2: note: 'bmcr' declared without an initial value
           u16 bmcr;
           ^~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Calling 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:9: note: Assuming 'mode' is not equal to MLO_AN_INBAND
           return mode == MLO_AN_INBAND;
                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:2: note: Returning zero, which participates in a condition later
           return mode == MLO_AN_INBAND;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Returning from 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:2: note: Taking false branch
           if (phylink_autoneg_inband(mode))
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:215:2: note: 'Default' branch taken. Execution continues on line 227
           switch (speed) {
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:6: note: Assuming 'duplex' is equal to DUPLEX_FULL
           if (duplex == DUPLEX_FULL)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:2: note: Taking true branch
           if (duplex == DUPLEX_FULL)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:228:8: note: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
                   bmcr |= BMCR_FULLDPLX;
                   ~~~~ ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:230:8: warning: 4th function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_SPEED100 |
                 ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:209:2: note: 'bmcr' declared without an initial value
           u16 bmcr;
           ^~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Calling 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:9: note: Assuming 'mode' is not equal to MLO_AN_INBAND
           return mode == MLO_AN_INBAND;
                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/phylink.h:27:2: note: Returning zero, which participates in a condition later
           return mode == MLO_AN_INBAND;
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:6: note: Returning from 'phylink_autoneg_inband'
           if (phylink_autoneg_inband(mode))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:212:2: note: Taking false branch
           if (phylink_autoneg_inband(mode))
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:215:2: note: 'Default' branch taken. Execution continues on line 227
           switch (speed) {
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:6: note: Assuming 'duplex' is not equal to DUPLEX_FULL
           if (duplex == DUPLEX_FULL)
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:227:2: note: Taking false branch
           if (duplex == DUPLEX_FULL)
           ^
   drivers/net/dsa/mv88e6xxx/serdes-6352.c:230:8: note: 4th function call argument is an uninitialized value
           err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_SPEED100 |
                 ^
   Suppressed 4 warnings (2 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   net/key/af_key.c:1166:2: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
           err = -ENOBUFS;
           ^     ~~~~~~~~
   net/key/af_key.c:1166:2: note: Value stored to 'err' is never read
           err = -ENOBUFS;
           ^     ~~~~~~~~
   net/key/af_key.c:1182:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcpy(x->aalg->alg_name, a->name);
                   ^~~~~~
   net/key/af_key.c:1182:3: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                   strcpy(x->aalg->alg_name, a->name);
                   ^~~~~~
   net/key/af_key.c:1204:4: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                           strcpy(x->calg->alg_name, a->name);
                           ^~~~~~
   net/key/af_key.c:1204:4: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                           strcpy(x->calg->alg_name, a->name);
                           ^~~~~~
   net/key/af_key.c:1221:4: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                           strcpy(x->ealg->alg_name, a->name);
                           ^~~~~~
   net/key/af_key.c:1221:4: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                           strcpy(x->ealg->alg_name, a->name);
                           ^~~~~~
   net/key/af_key.c:1486:44: warning: Dereference of null pointer [clang-analyzer-core.NullDereference]
           hdr->sadb_msg_satype = pfkey_proto2satype(x->id.proto);
                                                     ^
   net/key/af_key.c:3057:20: note: Assuming 'x' is null
           struct net *net = x ? xs_net(x) : c->net;

vim +116 drivers/net/dsa/mv88e6xxx/serdes-6352.c

   109	
   110	static int marvell_c22_pcs_modify(struct marvell_c22_pcs *mpcs, u8 reg,
   111					  u16 mask, u16 val)
   112	{
   113		int oldpage, err;
   114	
   115		oldpage = marvell_c22_pcs_set_fiber_page(mpcs);
 > 116		if (oldpage >= 0)
   117			err = __mdiobus_modify(mpcs->mdio.bus, mpcs->mdio.addr,
   118					       reg, mask, val);
   119	
   120		return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
   121	}
   122	
   123	static int marvell_c22_pcs_control_irq(struct marvell_c22_pcs *mpcs,
   124					       bool enable)
   125	{
   126		u16 val = enable ? MII_M1011_IMASK_LINK_CHANGE : 0;
   127	
   128		return marvell_c22_pcs_modify(mpcs, MII_M1011_IMASK,
   129					      MII_M1011_IMASK_LINK_CHANGE, val);
   130	}
   131	
   132	static int marvell_c22_pcs_enable(struct phylink_pcs *pcs)
   133	{
   134		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   135		int err;
   136	
   137		err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_PDOWN, 0);
   138		if (err || !mpcs->irq)
   139			return err;
   140	
   141		return marvell_c22_pcs_control_irq(mpcs, true);
   142	}
   143	
   144	static void marvell_c22_pcs_disable(struct phylink_pcs *pcs)
   145	{
   146		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   147	
   148		marvell_c22_pcs_control_irq(mpcs, false);
   149		marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
   150	}
   151	
   152	static void marvell_c22_pcs_get_state(struct phylink_pcs *pcs,
   153					    struct phylink_link_state *state)
   154	{
   155		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   156		int oldpage, bmsr, lpa;
   157	
   158		state->link = false;
   159	
   160		if (mpcs->link_check && !mpcs->link_check(mpcs))
   161			return;
   162	
   163		oldpage = marvell_c22_pcs_set_fiber_page(mpcs);
   164		if (oldpage >= 0) {
   165			bmsr = __mdiobus_read(mpcs->mdio.bus, mpcs->mdio.addr,
   166					      MII_BMSR);
   167			lpa = __mdiobus_read(mpcs->mdio.bus, mpcs->mdio.addr, MII_LPA);
   168		}
   169	
   170		if (marvell_c22_pcs_restore_page(mpcs, oldpage, 0) >= 0 &&
   171		    bmsr >= 0 && lpa >= 0)
   172			phylink_mii_c22_pcs_decode_state(state, bmsr, lpa);
   173	}
   174	
   175	static int marvell_c22_pcs_config(struct phylink_pcs *pcs,
   176					unsigned int mode,
   177				        phy_interface_t interface,
   178				        const unsigned long *advertise,
   179				        bool permit_pause_to_mac)
   180	{
   181		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   182		int oldpage, adv, err;
   183	
   184		adv = phylink_mii_c22_pcs_encode_advertisement(interface, advertise);
   185		if (adv < 0)
   186			return 0;
   187	
   188		oldpage = marvell_c22_pcs_set_fiber_page(mpcs);
 > 189		if (oldpage >= 0)
   190			err = __mdiobus_modify_changed(mpcs->mdio.bus, mpcs->mdio.addr,
   191						       MII_ADVERTISE, 0xffff, adv);
   192	
   193		return marvell_c22_pcs_restore_page(mpcs, oldpage, err);
   194	}
   195	
   196	static void marvell_c22_pcs_an_restart(struct phylink_pcs *pcs)
   197	{
   198		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   199	
   200		marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_ANRESTART, BMCR_ANRESTART);
   201	}
   202	
   203	static void marvell_c22_pcs_link_up(struct phylink_pcs *pcs,
   204					  unsigned int mode,
   205					  phy_interface_t interface,
   206					  int speed, int duplex)
   207	{
   208		struct marvell_c22_pcs *mpcs = pcs_to_marvell_c22_pcs(pcs);
   209		u16 bmcr;
   210		int err;
   211	
   212		if (phylink_autoneg_inband(mode))
   213			return;
   214	
   215		switch (speed) {
   216		case SPEED_1000:
   217			bmcr = BMCR_SPEED1000;
   218			break;
   219		case SPEED_100:
   220			bmcr = BMCR_SPEED100;
   221			break;
   222		case SPEED_10:
   223			bmcr = 0;
   224			break;
   225		}
   226	
   227		if (duplex == DUPLEX_FULL)
 > 228			bmcr |= BMCR_FULLDPLX;
   229	
   230		err = marvell_c22_pcs_modify(mpcs, MII_BMCR, BMCR_SPEED100 |
   231					     BMCR_FULLDPLX | BMCR_SPEED1000, bmcr);
   232		if (err)
   233			dev_err(mpcs->mdio.dev.parent,
   234				"%s: failed to configure mpcs: %pe\n", mpcs->name,
   235				ERR_PTR(err));
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
