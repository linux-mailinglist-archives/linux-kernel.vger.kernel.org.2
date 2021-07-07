Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1781E3BE804
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhGGMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:33:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:32222 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhGGMdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:33:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189670179"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="gz'50?scan'50,208,50";a="189670179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 05:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="gz'50?scan'50,208,50";a="628015335"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2021 05:30:50 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m16hV-000DaA-Gb; Wed, 07 Jul 2021 12:30:49 +0000
Date:   Wed, 7 Jul 2021 20:29:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: net/mac80211/led.c:34:15: error: 'struct led_trigger' has no member
 named 'name'
Message-ID: <202107072032.elX17BOo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77d34a4683b053108ecd466cc7c4193b45805528
commit: b64acb28da8394485f0762e657470c9fc33aca4d ath9k: fix build error with LEDS_CLASS=m
date:   5 months ago
config: powerpc64-randconfig-r006-20210707 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b64acb28da8394485f0762e657470c9fc33aca4d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b64acb28da8394485f0762e657470c9fc33aca4d
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mac80211/led.c: In function 'ieee80211_alloc_led_names':
>> net/mac80211/led.c:34:15: error: 'struct led_trigger' has no member named 'name'
      34 |  local->rx_led.name = kasprintf(GFP_KERNEL, "%srx",
         |               ^
   net/mac80211/led.c:36:15: error: 'struct led_trigger' has no member named 'name'
      36 |  local->tx_led.name = kasprintf(GFP_KERNEL, "%stx",
         |               ^
   net/mac80211/led.c:38:18: error: 'struct led_trigger' has no member named 'name'
      38 |  local->assoc_led.name = kasprintf(GFP_KERNEL, "%sassoc",
         |                  ^
   net/mac80211/led.c:40:18: error: 'struct led_trigger' has no member named 'name'
      40 |  local->radio_led.name = kasprintf(GFP_KERNEL, "%sradio",
         |                  ^
   net/mac80211/led.c: In function 'ieee80211_free_led_names':
   net/mac80211/led.c:46:21: error: 'struct led_trigger' has no member named 'name'
      46 |  kfree(local->rx_led.name);
         |                     ^
   net/mac80211/led.c:47:21: error: 'struct led_trigger' has no member named 'name'
      47 |  kfree(local->tx_led.name);
         |                     ^
   net/mac80211/led.c:48:24: error: 'struct led_trigger' has no member named 'name'
      48 |  kfree(local->assoc_led.name);
         |                        ^
   net/mac80211/led.c:49:24: error: 'struct led_trigger' has no member named 'name'
      49 |  kfree(local->radio_led.name);
         |                        ^
   In file included from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/mac80211/led.c:7:
   net/mac80211/led.c: In function 'ieee80211_tx_led_activate':
>> net/mac80211/led.c:54:55: error: 'struct led_classdev' has no member named 'trigger'
      54 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/kernel.h:693:26: note: in definition of macro 'container_of'
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   In file included from <command-line>:
>> net/mac80211/led.c:54:55: error: 'struct led_classdev' has no member named 'trigger'
      54 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   net/mac80211/led.c:54:34: note: in expansion of macro 'container_of'
      54 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
>> net/mac80211/led.c:54:55: error: 'struct led_classdev' has no member named 'trigger'
      54 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:695:6: note: in expansion of macro '__same_type'
     695 |     !__same_type(*(ptr), void),   \
         |      ^~~~~~~~~~~
   net/mac80211/led.c:54:34: note: in expansion of macro 'container_of'
      54 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   In file included from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/mac80211/led.c:7:
   net/mac80211/led.c: In function 'ieee80211_tx_led_deactivate':
   net/mac80211/led.c:65:55: error: 'struct led_classdev' has no member named 'trigger'
      65 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/kernel.h:693:26: note: in definition of macro 'container_of'
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   In file included from <command-line>:
   net/mac80211/led.c:65:55: error: 'struct led_classdev' has no member named 'trigger'
      65 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   net/mac80211/led.c:65:34: note: in expansion of macro 'container_of'
      65 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   net/mac80211/led.c:65:55: error: 'struct led_classdev' has no member named 'trigger'
      65 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:695:6: note: in expansion of macro '__same_type'
     695 |     !__same_type(*(ptr), void),   \
         |      ^~~~~~~~~~~
   net/mac80211/led.c:65:34: note: in expansion of macro 'container_of'
      65 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   In file included from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/mac80211/led.c:7:
   net/mac80211/led.c: In function 'ieee80211_rx_led_activate':
   net/mac80211/led.c:74:55: error: 'struct led_classdev' has no member named 'trigger'
      74 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/kernel.h:693:26: note: in definition of macro 'container_of'
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   In file included from <command-line>:
   net/mac80211/led.c:74:55: error: 'struct led_classdev' has no member named 'trigger'
      74 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
--
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   In file included from <command-line>:
   net/mac80211/led.c:134:55: error: 'struct led_classdev' has no member named 'trigger'
     134 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   net/mac80211/led.c:134:34: note: in expansion of macro 'container_of'
     134 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   net/mac80211/led.c:134:55: error: 'struct led_classdev' has no member named 'trigger'
     134 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:695:6: note: in expansion of macro '__same_type'
     695 |     !__same_type(*(ptr), void),   \
         |      ^~~~~~~~~~~
   net/mac80211/led.c:134:34: note: in expansion of macro 'container_of'
     134 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   In file included from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/mac80211/led.c:7:
   net/mac80211/led.c: In function 'ieee80211_tpt_led_deactivate':
   net/mac80211/led.c:145:55: error: 'struct led_classdev' has no member named 'trigger'
     145 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/kernel.h:693:26: note: in definition of macro 'container_of'
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   In file included from <command-line>:
   net/mac80211/led.c:145:55: error: 'struct led_classdev' has no member named 'trigger'
     145 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   net/mac80211/led.c:145:34: note: in expansion of macro 'container_of'
     145 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   net/mac80211/led.c:145:55: error: 'struct led_classdev' has no member named 'trigger'
     145 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                                       ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:695:6: note: in expansion of macro '__same_type'
     695 |     !__same_type(*(ptr), void),   \
         |      ^~~~~~~~~~~
   net/mac80211/led.c:145:34: note: in expansion of macro 'container_of'
     145 |  struct ieee80211_local *local = container_of(led_cdev->trigger,
         |                                  ^~~~~~~~~~~~
   net/mac80211/led.c: In function 'ieee80211_led_init':
>> net/mac80211/led.c:155:15: error: 'struct led_trigger' has no member named 'activate'
     155 |  local->rx_led.activate = ieee80211_rx_led_activate;
         |               ^
>> net/mac80211/led.c:156:15: error: 'struct led_trigger' has no member named 'deactivate'
     156 |  local->rx_led.deactivate = ieee80211_rx_led_deactivate;
         |               ^
   net/mac80211/led.c:157:19: error: 'struct led_trigger' has no member named 'name'
     157 |  if (local->rx_led.name && led_trigger_register(&local->rx_led)) {
         |                   ^
>> net/mac80211/led.c:157:28: error: implicit declaration of function 'led_trigger_register'; did you mean 'led_trigger_remove'? [-Werror=implicit-function-declaration]
     157 |  if (local->rx_led.name && led_trigger_register(&local->rx_led)) {
         |                            ^~~~~~~~~~~~~~~~~~~~
         |                            led_trigger_remove
   net/mac80211/led.c:158:22: error: 'struct led_trigger' has no member named 'name'
     158 |   kfree(local->rx_led.name);
         |                      ^
   net/mac80211/led.c:159:16: error: 'struct led_trigger' has no member named 'name'
     159 |   local->rx_led.name = NULL;
         |                ^
   net/mac80211/led.c:163:15: error: 'struct led_trigger' has no member named 'activate'
     163 |  local->tx_led.activate = ieee80211_tx_led_activate;
         |               ^
   net/mac80211/led.c:164:15: error: 'struct led_trigger' has no member named 'deactivate'
     164 |  local->tx_led.deactivate = ieee80211_tx_led_deactivate;
         |               ^
   net/mac80211/led.c:165:19: error: 'struct led_trigger' has no member named 'name'
     165 |  if (local->tx_led.name && led_trigger_register(&local->tx_led)) {
         |                   ^
   net/mac80211/led.c:166:22: error: 'struct led_trigger' has no member named 'name'
     166 |   kfree(local->tx_led.name);
         |                      ^
   net/mac80211/led.c:167:16: error: 'struct led_trigger' has no member named 'name'
     167 |   local->tx_led.name = NULL;
         |                ^
   net/mac80211/led.c:171:18: error: 'struct led_trigger' has no member named 'activate'
     171 |  local->assoc_led.activate = ieee80211_assoc_led_activate;
         |                  ^
   net/mac80211/led.c:172:18: error: 'struct led_trigger' has no member named 'deactivate'
     172 |  local->assoc_led.deactivate = ieee80211_assoc_led_deactivate;
         |                  ^
   net/mac80211/led.c:173:22: error: 'struct led_trigger' has no member named 'name'
     173 |  if (local->assoc_led.name && led_trigger_register(&local->assoc_led)) {
         |                      ^
   net/mac80211/led.c:174:25: error: 'struct led_trigger' has no member named 'name'
     174 |   kfree(local->assoc_led.name);
         |                         ^
   net/mac80211/led.c:175:19: error: 'struct led_trigger' has no member named 'name'
     175 |   local->assoc_led.name = NULL;
         |                   ^
   net/mac80211/led.c:179:18: error: 'struct led_trigger' has no member named 'activate'
     179 |  local->radio_led.activate = ieee80211_radio_led_activate;
         |                  ^
   net/mac80211/led.c:180:18: error: 'struct led_trigger' has no member named 'deactivate'
     180 |  local->radio_led.deactivate = ieee80211_radio_led_deactivate;
         |                  ^
   net/mac80211/led.c:181:22: error: 'struct led_trigger' has no member named 'name'
     181 |  if (local->radio_led.name && led_trigger_register(&local->radio_led)) {
         |                      ^
   net/mac80211/led.c:182:25: error: 'struct led_trigger' has no member named 'name'
     182 |   kfree(local->radio_led.name);
         |                         ^
   net/mac80211/led.c:183:19: error: 'struct led_trigger' has no member named 'name'
     183 |   local->radio_led.name = NULL;
         |                   ^
   net/mac80211/led.c:188:17: error: 'struct led_trigger' has no member named 'activate'
     188 |   local->tpt_led.activate = ieee80211_tpt_led_activate;
         |                 ^
   net/mac80211/led.c:189:17: error: 'struct led_trigger' has no member named 'deactivate'
     189 |   local->tpt_led.deactivate = ieee80211_tpt_led_deactivate;
         |                 ^
   net/mac80211/led.c: In function 'ieee80211_led_exit':
   net/mac80211/led.c:199:22: error: 'struct led_trigger' has no member named 'name'
     199 |  if (local->radio_led.name)
         |                      ^
>> net/mac80211/led.c:200:3: error: implicit declaration of function 'led_trigger_unregister'; did you mean 'driver_unregister'? [-Werror=implicit-function-declaration]
     200 |   led_trigger_unregister(&local->radio_led);
         |   ^~~~~~~~~~~~~~~~~~~~~~
         |   driver_unregister
   net/mac80211/led.c:201:22: error: 'struct led_trigger' has no member named 'name'
     201 |  if (local->assoc_led.name)
         |                      ^
   net/mac80211/led.c:203:19: error: 'struct led_trigger' has no member named 'name'
     203 |  if (local->tx_led.name)
         |                   ^
   net/mac80211/led.c:205:19: error: 'struct led_trigger' has no member named 'name'
     205 |  if (local->rx_led.name)
         |                   ^
   net/mac80211/led.c: In function '__ieee80211_get_radio_led_name':
   net/mac80211/led.c:218:25: error: 'struct led_trigger' has no member named 'name'
     218 |  return local->radio_led.name;
         |                         ^
   net/mac80211/led.c: In function '__ieee80211_get_assoc_led_name':
   net/mac80211/led.c:226:25: error: 'struct led_trigger' has no member named 'name'
     226 |  return local->assoc_led.name;
         |                         ^
   net/mac80211/led.c: In function '__ieee80211_get_tx_led_name':
   net/mac80211/led.c:234:22: error: 'struct led_trigger' has no member named 'name'
     234 |  return local->tx_led.name;
         |                      ^
   net/mac80211/led.c: In function '__ieee80211_get_rx_led_name':
   net/mac80211/led.c:242:22: error: 'struct led_trigger' has no member named 'name'
     242 |  return local->rx_led.name;
         |                      ^
   In file included from include/linux/spinlock.h:312,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from net/mac80211/led.c:8:
   net/mac80211/led.c: In function 'tpt_trig_timer':
   net/mac80211/led.c:286:27: error: 'struct led_trigger' has no member named 'leddev_list_lock'
     286 |  read_lock(&local->tpt_led.leddev_list_lock);
         |                           ^
   include/linux/rwlock.h:71:41: note: in definition of macro 'read_lock'
      71 | #define read_lock(lock)  _raw_read_lock(lock)
         |                                         ^~~~
   In file included from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/mac80211/led.c:7:
   net/mac80211/led.c:287:47: error: 'struct led_trigger' has no member named 'led_cdevs'
     287 |  list_for_each_entry(led_cdev, &local->tpt_led.led_cdevs, trig_list)
         |                                               ^
   include/linux/kernel.h:693:26: note: in definition of macro 'container_of'
     693 |  void *__mptr = (void *)(ptr);     \
         |                          ^~~
   include/linux/list.h:522:2: note: in expansion of macro 'list_entry'
     522 |  list_entry((ptr)->next, type, member)
         |  ^~~~~~~~~~
   include/linux/list.h:628:13: note: in expansion of macro 'list_first_entry'
     628 |  for (pos = list_first_entry(head, typeof(*pos), member); \
         |             ^~~~~~~~~~~~~~~~
   net/mac80211/led.c:287:2: note: in expansion of macro 'list_for_each_entry'
     287 |  list_for_each_entry(led_cdev, &local->tpt_led.led_cdevs, trig_list)
         |  ^~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   net/mac80211/led.c:287:47: error: 'struct led_trigger' has no member named 'led_cdevs'
     287 |  list_for_each_entry(led_cdev, &local->tpt_led.led_cdevs, trig_list)
         |                                               ^
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:20: note: in expansion of macro '__same_type'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                    ^~~~~~~~~~~
   include/linux/list.h:511:2: note: in expansion of macro 'container_of'
     511 |  container_of(ptr, type, member)
         |  ^~~~~~~~~~~~
   include/linux/list.h:522:2: note: in expansion of macro 'list_entry'
     522 |  list_entry((ptr)->next, type, member)
         |  ^~~~~~~~~~
   include/linux/list.h:628:13: note: in expansion of macro 'list_first_entry'
     628 |  for (pos = list_first_entry(head, typeof(*pos), member); \
         |             ^~~~~~~~~~~~~~~~
   net/mac80211/led.c:287:2: note: in expansion of macro 'list_for_each_entry'
     287 |  list_for_each_entry(led_cdev, &local->tpt_led.led_cdevs, trig_list)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:694:51: error: 'struct led_classdev' has no member named 'trig_list'
     694 |  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
         |                                                   ^~
   include/linux/compiler_types.h:300:9: note: in definition of macro '__compiletime_assert'
     300 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro '_compiletime_assert'
     320 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MAC80211_LEDS
   Depends on NET && WIRELESS && MAC80211 && (LEDS_CLASS || LEDS_CLASS
   Selected by
   - ATH5K && NETDEVICES && WLAN && WLAN_VENDOR_ATH && (PCI || ATH25) && MAC80211


vim +34 net/mac80211/led.c

cdcb006fbe7a74 net/mac80211/ieee80211_led.c Ivo van Doorn    2008-01-07   31  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   32  void ieee80211_alloc_led_names(struct ieee80211_local *local)
fe67c913f1ec2a net/mac80211/led.c           Johannes Berg    2010-11-27   33  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  @34  	local->rx_led.name = kasprintf(GFP_KERNEL, "%srx",
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   35  				       wiphy_name(local->hw.wiphy));
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   36  	local->tx_led.name = kasprintf(GFP_KERNEL, "%stx",
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   37  				       wiphy_name(local->hw.wiphy));
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   38  	local->assoc_led.name = kasprintf(GFP_KERNEL, "%sassoc",
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   39  					  wiphy_name(local->hw.wiphy));
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   40  	local->radio_led.name = kasprintf(GFP_KERNEL, "%sradio",
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   41  					  wiphy_name(local->hw.wiphy));
fe67c913f1ec2a net/mac80211/led.c           Johannes Berg    2010-11-27   42  }
fe67c913f1ec2a net/mac80211/led.c           Johannes Berg    2010-11-27   43  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   44  void ieee80211_free_led_names(struct ieee80211_local *local)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   45  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   46  	kfree(local->rx_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   47  	kfree(local->tx_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   48  	kfree(local->assoc_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   49  	kfree(local->radio_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   50  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   51  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   52  static int ieee80211_tx_led_activate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   53  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  @54  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   55  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   56  						     tx_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   57  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   58  	atomic_inc(&local->tx_led_active);
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   59  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   60  	return 0;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   61  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   62  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   63  static void ieee80211_tx_led_deactivate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   64  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   65  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   66  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   67  						     tx_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   68  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   69  	atomic_dec(&local->tx_led_active);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   70  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   71  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   72  static int ieee80211_rx_led_activate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   73  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   74  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   75  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   76  						     rx_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   77  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   78  	atomic_inc(&local->rx_led_active);
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   79  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   80  	return 0;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   81  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   82  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   83  static void ieee80211_rx_led_deactivate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   84  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   85  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   86  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   87  						     rx_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   88  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   89  	atomic_dec(&local->rx_led_active);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   90  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   91  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   92  static int ieee80211_assoc_led_activate(struct led_classdev *led_cdev)
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05   93  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   94  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   95  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   96  						     assoc_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   97  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23   98  	atomic_inc(&local->assoc_led_active);
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02   99  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  100  	return 0;
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  101  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  102  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  103  static void ieee80211_assoc_led_deactivate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  104  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  105  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  106  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  107  						     assoc_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  108  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  109  	atomic_dec(&local->assoc_led_active);
47f0c502209056 net/mac80211/ieee80211_led.c Michael Buesch   2007-09-27  110  }
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  111  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  112  static int ieee80211_radio_led_activate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  113  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  114  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  115  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  116  						     radio_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  117  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  118  	atomic_inc(&local->radio_led_active);
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  119  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  120  	return 0;
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  121  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  122  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  123  static void ieee80211_radio_led_deactivate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  124  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  125  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  126  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  127  						     radio_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  128  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  129  	atomic_dec(&local->radio_led_active);
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  130  }
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  131  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  132  static int ieee80211_tpt_led_activate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  133  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  134  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  135  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  136  						     tpt_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  137  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  138  	atomic_inc(&local->tpt_led_active);
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  139  
2282e125a406e0 net/mac80211/led.c           Uwe Kleine-König 2018-07-02  140  	return 0;
47f0c502209056 net/mac80211/ieee80211_led.c Michael Buesch   2007-09-27  141  }
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  142  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  143  static void ieee80211_tpt_led_deactivate(struct led_classdev *led_cdev)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  144  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  145  	struct ieee80211_local *local = container_of(led_cdev->trigger,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  146  						     struct ieee80211_local,
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  147  						     tpt_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  148  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  149  	atomic_dec(&local->tpt_led_active);
47f0c502209056 net/mac80211/ieee80211_led.c Michael Buesch   2007-09-27  150  }
cdcb006fbe7a74 net/mac80211/ieee80211_led.c Ivo van Doorn    2008-01-07  151  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  152  void ieee80211_led_init(struct ieee80211_local *local)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  153  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  154  	atomic_set(&local->rx_led_active, 0);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23 @155  	local->rx_led.activate = ieee80211_rx_led_activate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23 @156  	local->rx_led.deactivate = ieee80211_rx_led_deactivate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23 @157  	if (local->rx_led.name && led_trigger_register(&local->rx_led)) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  158  		kfree(local->rx_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  159  		local->rx_led.name = NULL;
cdcb006fbe7a74 net/mac80211/ieee80211_led.c Ivo van Doorn    2008-01-07  160  	}
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  161  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  162  	atomic_set(&local->tx_led_active, 0);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  163  	local->tx_led.activate = ieee80211_tx_led_activate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  164  	local->tx_led.deactivate = ieee80211_tx_led_deactivate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  165  	if (local->tx_led.name && led_trigger_register(&local->tx_led)) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  166  		kfree(local->tx_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  167  		local->tx_led.name = NULL;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  168  	}
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  169  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  170  	atomic_set(&local->assoc_led_active, 0);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  171  	local->assoc_led.activate = ieee80211_assoc_led_activate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  172  	local->assoc_led.deactivate = ieee80211_assoc_led_deactivate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  173  	if (local->assoc_led.name && led_trigger_register(&local->assoc_led)) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  174  		kfree(local->assoc_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  175  		local->assoc_led.name = NULL;
cdcb006fbe7a74 net/mac80211/ieee80211_led.c Ivo van Doorn    2008-01-07  176  	}
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  177  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  178  	atomic_set(&local->radio_led_active, 0);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  179  	local->radio_led.activate = ieee80211_radio_led_activate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  180  	local->radio_led.deactivate = ieee80211_radio_led_deactivate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  181  	if (local->radio_led.name && led_trigger_register(&local->radio_led)) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  182  		kfree(local->radio_led.name);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  183  		local->radio_led.name = NULL;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  184  	}
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  185  
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  186  	atomic_set(&local->tpt_led_active, 0);
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  187  	if (local->tpt_led_trigger) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  188  		local->tpt_led.activate = ieee80211_tpt_led_activate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  189  		local->tpt_led.deactivate = ieee80211_tpt_led_deactivate;
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  190  		if (led_trigger_register(&local->tpt_led)) {
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  191  			kfree(local->tpt_led_trigger);
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  192  			local->tpt_led_trigger = NULL;
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  193  		}
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  194  	}
47f0c502209056 net/mac80211/ieee80211_led.c Michael Buesch   2007-09-27  195  }
47f0c502209056 net/mac80211/ieee80211_led.c Michael Buesch   2007-09-27  196  
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  197  void ieee80211_led_exit(struct ieee80211_local *local)
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  198  {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  199  	if (local->radio_led.name)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23 @200  		led_trigger_unregister(&local->radio_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  201  	if (local->assoc_led.name)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  202  		led_trigger_unregister(&local->assoc_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  203  	if (local->tx_led.name)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  204  		led_trigger_unregister(&local->tx_led);
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  205  	if (local->rx_led.name)
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  206  		led_trigger_unregister(&local->rx_led);
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  207  
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  208  	if (local->tpt_led_trigger) {
8d5c25856859bd net/mac80211/led.c           Johannes Berg    2015-04-23  209  		led_trigger_unregister(&local->tpt_led);
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  210  		kfree(local->tpt_led_trigger);
e1e5406854378d net/mac80211/led.c           Johannes Berg    2010-11-30  211  	}
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  212  }
f0706e828e96d0 net/mac80211/ieee80211_led.c Jiri Benc        2007-05-05  213  

:::::: The code at line 34 was first introduced by commit
:::::: 8d5c25856859bd826aca4b88103552a80b344cef mac80211: make LED triggering depend on activation

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--h31gzZEtNLTqOjlF--
