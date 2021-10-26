Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE45243BB37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhJZTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:51:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:38751 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237048AbhJZTvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:51:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229857293"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="gz'50?scan'50,208,50";a="229857293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="gz'50?scan'50,208,50";a="486333488"
Received: from lkp-server01.sh.intel.com (HELO 072b454ebba8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2021 12:49:11 -0700
Received: from kbuild by 072b454ebba8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfSRa-0000Ns-AI; Tue, 26 Oct 2021 19:49:10 +0000
Date:   Wed, 27 Oct 2021 03:48:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <me@pmachata.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 1/4]
 drivers/net/netdevsim/netdevsim.h:105:22: error: field 'buffer' has
 incomplete type
Message-ID: <202110270305.os0l49ia-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/jpirko/linux_mlxsw petrm_soft_counters
head:   a8a72b09197b26075b17e1722bf534d141e26034
commit: 33151ced43f15dd778ccb057cc752eedee86b9ec [1/4] netdevsim DCB
config: x86_64-kexec (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/33151ced43f15dd778ccb057cc752eedee86b9ec
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_soft_counters
        git checkout 33151ced43f15dd778ccb057cc752eedee86b9ec
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/netdevsim/dev.c:36:
>> drivers/net/netdevsim/netdevsim.h:105:22: error: field 'buffer' has incomplete type
     105 |  struct dcbnl_buffer buffer;
         |                      ^~~~~~
>> drivers/net/netdevsim/netdevsim.h:106:18: error: field 'ets' has incomplete type
     106 |  struct ieee_ets ets;
         |                  ^~~
>> drivers/net/netdevsim/netdevsim.h:107:22: error: field 'maxrate' has incomplete type
     107 |  struct ieee_maxrate maxrate;
         |                      ^~~~~~~
>> drivers/net/netdevsim/netdevsim.h:108:18: error: field 'pfc' has incomplete type
     108 |  struct ieee_pfc pfc;
         |                  ^~~
--
   In file included from drivers/net/netdevsim/netdev.c:27:
>> drivers/net/netdevsim/netdevsim.h:105:22: error: field 'buffer' has incomplete type
     105 |  struct dcbnl_buffer buffer;
         |                      ^~~~~~
>> drivers/net/netdevsim/netdevsim.h:106:18: error: field 'ets' has incomplete type
     106 |  struct ieee_ets ets;
         |                  ^~~
>> drivers/net/netdevsim/netdevsim.h:107:22: error: field 'maxrate' has incomplete type
     107 |  struct ieee_maxrate maxrate;
         |                      ^~~~~~~
>> drivers/net/netdevsim/netdevsim.h:108:18: error: field 'pfc' has incomplete type
     108 |  struct ieee_pfc pfc;
         |                  ^~~
   drivers/net/netdevsim/netdev.c: In function 'nsim_dcb_dcbnl_buffer_update_total_size':
>> drivers/net/netdevsim/netdev.c:286:18: error: 'DCBX_MAX_BUFFERS' undeclared (first use in this function)
     286 |  for (i = 0; i < DCBX_MAX_BUFFERS; i++)
         |                  ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:286:18: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/netdevsim/netdev.c:287:20: error: dereferencing pointer to incomplete type 'struct dcbnl_buffer'
     287 |   total_size += buf->buffer_size[i];
         |                    ^~
   drivers/net/netdevsim/netdev.c: At top level:
   drivers/net/netdevsim/netdev.c:291:5: warning: no previous prototype for 'nsim_dcb_dcbnl_getbuffer' [-Wmissing-prototypes]
     291 | int nsim_dcb_dcbnl_getbuffer(struct net_device *dev, struct dcbnl_buffer *buf)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:302:5: warning: no previous prototype for 'nsim_dcb_dcbnl_setbuffer' [-Wmissing-prototypes]
     302 | int nsim_dcb_dcbnl_setbuffer(struct net_device *dev, struct dcbnl_buffer *buf)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:311:5: warning: no previous prototype for 'nsim_dcb_ieee_getets' [-Wmissing-prototypes]
     311 | int nsim_dcb_ieee_getets(struct net_device *dev, struct ieee_ets *ets)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c: In function 'nsim_dcb_ieee_getets':
>> drivers/net/netdevsim/netdev.c:316:2: error: dereferencing pointer to incomplete type 'struct ieee_ets'
     316 |  *ets = ns->ets;
         |  ^~~~
   drivers/net/netdevsim/netdev.c: At top level:
   drivers/net/netdevsim/netdev.c:320:5: warning: no previous prototype for 'nsim_dcb_ieee_setets' [-Wmissing-prototypes]
     320 | int nsim_dcb_ieee_setets(struct net_device *dev, struct ieee_ets *ets)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:329:5: warning: no previous prototype for 'nsim_dcb_ieee_getmaxrate' [-Wmissing-prototypes]
     329 | int nsim_dcb_ieee_getmaxrate(struct net_device *dev, struct ieee_maxrate *maxrate)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c: In function 'nsim_dcb_ieee_getmaxrate':
>> drivers/net/netdevsim/netdev.c:334:2: error: dereferencing pointer to incomplete type 'struct ieee_maxrate'
     334 |  *maxrate = ns->maxrate;
         |  ^~~~~~~~
   drivers/net/netdevsim/netdev.c: At top level:
   drivers/net/netdevsim/netdev.c:338:5: warning: no previous prototype for 'nsim_dcb_ieee_setmaxrate' [-Wmissing-prototypes]
     338 | int nsim_dcb_ieee_setmaxrate(struct net_device *dev, struct ieee_maxrate *maxrate)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:347:5: warning: no previous prototype for 'nsim_dcb_ieee_getpfc' [-Wmissing-prototypes]
     347 | int nsim_dcb_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c: In function 'nsim_dcb_ieee_getpfc':
>> drivers/net/netdevsim/netdev.c:355:18: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
     355 |  for (i = 1; i < IEEE_8021QAZ_MAX_TCS; i++)
         |                  ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:362:2: error: dereferencing pointer to incomplete type 'struct ieee_pfc'
     362 |  *pfc = ns->pfc;
         |  ^~~~
   drivers/net/netdevsim/netdev.c: At top level:
   drivers/net/netdevsim/netdev.c:366:5: warning: no previous prototype for 'nsim_dcb_ieee_setpfc' [-Wmissing-prototypes]
     366 | int nsim_dcb_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:379:57: warning: 'struct ieee_qcn' declared inside parameter list will not be visible outside of this definition or declaration
     379 | int nsim_dcb_ieee_getqcn(struct net_device *dev, struct ieee_qcn *qcn)
         |                                                         ^~~~~~~~
   drivers/net/netdevsim/netdev.c:379:5: warning: no previous prototype for 'nsim_dcb_ieee_getqcn' [-Wmissing-prototypes]
     379 | int nsim_dcb_ieee_getqcn(struct net_device *dev, struct ieee_qcn *qcn)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:385:57: warning: 'struct ieee_qcn' declared inside parameter list will not be visible outside of this definition or declaration
     385 | int nsim_dcb_ieee_setqcn(struct net_device *dev, struct ieee_qcn *qcn)
         |                                                         ^~~~~~~~
   drivers/net/netdevsim/netdev.c:385:5: warning: no previous prototype for 'nsim_dcb_ieee_setqcn' [-Wmissing-prototypes]
     385 | int nsim_dcb_ieee_setqcn(struct net_device *dev, struct ieee_qcn *qcn)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:391:62: warning: 'struct ieee_qcn_stats' declared inside parameter list will not be visible outside of this definition or declaration
     391 | int nsim_dcb_ieee_getqcnstats(struct net_device *dev, struct ieee_qcn_stats *qcn_stats)
         |                                                              ^~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:391:5: warning: no previous prototype for 'nsim_dcb_ieee_getqcnstats' [-Wmissing-prototypes]
     391 | int nsim_dcb_ieee_getqcnstats(struct net_device *dev, struct ieee_qcn_stats *qcn_stats)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:397:5: warning: no previous prototype for 'nsim_dcb_ieee_peer_getets' [-Wmissing-prototypes]
     397 | int nsim_dcb_ieee_peer_getets(struct net_device *dev, struct ieee_ets *ets)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:403:5: warning: no previous prototype for 'nsim_dcb_ieee_peer_getpfc' [-Wmissing-prototypes]
     403 | int nsim_dcb_ieee_peer_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:409:4: warning: no previous prototype for 'nsim_dcb_getstate' [-Wmissing-prototypes]
     409 | u8 nsim_dcb_getstate(struct net_device *dev)
         |    ^~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:415:4: warning: no previous prototype for 'nsim_dcb_setstate' [-Wmissing-prototypes]
     415 | u8 nsim_dcb_setstate(struct net_device *dev, u8 enabled)
         |    ^~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:421:6: warning: no previous prototype for 'nsim_dcb_getpermhwaddr' [-Wmissing-prototypes]
     421 | void nsim_dcb_getpermhwaddr(struct net_device *dev, u8 *perm_addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:426:6: warning: no previous prototype for 'nsim_dcb_setpgtccfgtx' [-Wmissing-prototypes]
     426 | void nsim_dcb_setpgtccfgtx(struct net_device *dev, int prio, u8 prio_type,
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:432:6: warning: no previous prototype for 'nsim_dcb_setpgbwgcfgtx' [-Wmissing-prototypes]
     432 | void nsim_dcb_setpgbwgcfgtx(struct net_device *dev, int pgid, u8 bw_pct)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:437:6: warning: no previous prototype for 'nsim_dcb_setpgtccfgrx' [-Wmissing-prototypes]
     437 | void nsim_dcb_setpgtccfgrx(struct net_device *dev, int prio, u8 prio_type,
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:443:6: warning: no previous prototype for 'nsim_dcb_setpgbwgcfgrx' [-Wmissing-prototypes]
     443 | void nsim_dcb_setpgbwgcfgrx(struct net_device *dev, int pgid, u8 bw_pct)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:448:6: warning: no previous prototype for 'nsim_dcb_getpgtccfgtx' [-Wmissing-prototypes]
     448 | void nsim_dcb_getpgtccfgtx(struct net_device *dev, int tc, u8 *prio_type,
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:454:6: warning: no previous prototype for 'nsim_dcb_getpgbwgcfgtx' [-Wmissing-prototypes]
     454 | void nsim_dcb_getpgbwgcfgtx(struct net_device *dev, int pgid, u8 *bw_pct)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:459:6: warning: no previous prototype for 'nsim_dcb_getpgtccfgrx' [-Wmissing-prototypes]
     459 | void nsim_dcb_getpgtccfgrx(struct net_device *dev, int tc, u8 *prio,
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:465:6: warning: no previous prototype for 'nsim_dcb_getpgbwgcfgrx' [-Wmissing-prototypes]
     465 | void nsim_dcb_getpgbwgcfgrx(struct net_device *dev, int pg_id, u8 *bw_pct)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:470:6: warning: no previous prototype for 'nsim_dcb_setpfccfg' [-Wmissing-prototypes]
     470 | void nsim_dcb_setpfccfg(struct net_device *dev, int prio, u8 enabled)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:475:6: warning: no previous prototype for 'nsim_dcb_getpfccfg' [-Wmissing-prototypes]
     475 | void nsim_dcb_getpfccfg(struct net_device *dev, int prio, u8 *enabled)
         |      ^~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:480:4: warning: no previous prototype for 'nsim_dcb_setall' [-Wmissing-prototypes]
     480 | u8 nsim_dcb_setall(struct net_device *dev)
         |    ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:486:4: warning: no previous prototype for 'nsim_dcb_getcap' [-Wmissing-prototypes]
     486 | u8 nsim_dcb_getcap(struct net_device *dev, int capid, u8 *cap)
         |    ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:492:5: warning: no previous prototype for 'nsim_dcb_getnumtcs' [-Wmissing-prototypes]
     492 | int nsim_dcb_getnumtcs(struct net_device *dev, int tcs_id, u8 *num)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:498:5: warning: no previous prototype for 'nsim_dcb_setnumtcs' [-Wmissing-prototypes]
     498 | int nsim_dcb_setnumtcs(struct net_device *dev, int tcs_id, u8 num)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:504:4: warning: no previous prototype for 'nsim_dcb_getpfcstate' [-Wmissing-prototypes]
     504 | u8 nsim_dcb_getpfcstate(struct net_device *dev)
         |    ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:510:6: warning: no previous prototype for 'nsim_dcb_setpfcstate' [-Wmissing-prototypes]
     510 | void nsim_dcb_setpfcstate(struct net_device *dev, u8 enabled)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:515:5: warning: no previous prototype for 'nsim_dcb_setapp' [-Wmissing-prototypes]
     515 | int nsim_dcb_setapp(struct net_device *dev, u8 sel, u16 pid, u8 prio)
         |     ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:521:5: warning: no previous prototype for 'nsim_dcb_getapp' [-Wmissing-prototypes]
     521 | int nsim_dcb_getapp(struct net_device *dev, u8 sel, u16 pid)
         |     ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:527:4: warning: no previous prototype for 'nsim_dcb_getfeatcfg' [-Wmissing-prototypes]
     527 | u8 nsim_dcb_getfeatcfg(struct net_device *dev, int feat_id, u8 *flags)
         |    ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:533:4: warning: no previous prototype for 'nsim_dcb_setfeatcfg' [-Wmissing-prototypes]
     533 | u8 nsim_dcb_setfeatcfg(struct net_device *dev, int feat_id, u8 flags)
         |    ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:539:4: warning: no previous prototype for 'nsim_dcb_getdcbx' [-Wmissing-prototypes]
     539 | u8 nsim_dcb_getdcbx(struct net_device *dev)
         |    ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:546:4: warning: no previous prototype for 'nsim_dcb_setdcbx' [-Wmissing-prototypes]
     546 | u8 nsim_dcb_setdcbx(struct net_device *dev, u8 mode)
         |    ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:554:61: warning: 'struct dcb_peer_app_info' declared inside parameter list will not be visible outside of this definition or declaration
     554 | int nsim_dcb_peer_getappinfo(struct net_device *dev, struct dcb_peer_app_info *info, u16 *count)
         |                                                             ^~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:554:5: warning: no previous prototype for 'nsim_dcb_peer_getappinfo' [-Wmissing-prototypes]
     554 | int nsim_dcb_peer_getappinfo(struct net_device *dev, struct dcb_peer_app_info *info, u16 *count)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:560:62: warning: 'struct dcb_app' declared inside parameter list will not be visible outside of this definition or declaration
     560 | int nsim_dcb_peer_getapptable(struct net_device *dev, struct dcb_app *table)
         |                                                              ^~~~~~~
   drivers/net/netdevsim/netdev.c:560:5: warning: no previous prototype for 'nsim_dcb_peer_getapptable' [-Wmissing-prototypes]
     560 | int nsim_dcb_peer_getapptable(struct net_device *dev, struct dcb_app *table)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:566:60: warning: 'struct cee_pg' declared inside parameter list will not be visible outside of this definition or declaration
     566 | int nsim_dcb_cee_peer_getpg(struct net_device *dev, struct cee_pg *pg)
         |                                                            ^~~~~~
   drivers/net/netdevsim/netdev.c:566:5: warning: no previous prototype for 'nsim_dcb_cee_peer_getpg' [-Wmissing-prototypes]
     566 | int nsim_dcb_cee_peer_getpg(struct net_device *dev, struct cee_pg *pg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:572:61: warning: 'struct cee_pfc' declared inside parameter list will not be visible outside of this definition or declaration
     572 | int nsim_dcb_cee_peer_getpfc(struct net_device *dev, struct cee_pfc *pfc)
         |                                                             ^~~~~~~
   drivers/net/netdevsim/netdev.c:572:5: warning: no previous prototype for 'nsim_dcb_cee_peer_getpfc' [-Wmissing-prototypes]
     572 | int nsim_dcb_cee_peer_getpfc(struct net_device *dev, struct cee_pfc *pfc)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:578:21: error: variable 'nsim_dcbnl_ops' has initializer but incomplete type
     578 | static const struct dcbnl_rtnl_ops nsim_dcbnl_ops = {
         |                     ^~~~~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:579:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_getets'
     579 |  .ieee_getets = nsim_dcb_ieee_getets,
         |   ^~~~~~~~~~~
>> drivers/net/netdevsim/netdev.c:579:17: warning: excess elements in struct initializer
     579 |  .ieee_getets = nsim_dcb_ieee_getets,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:579:17: note: (near initialization for 'nsim_dcbnl_ops')
>> drivers/net/netdevsim/netdev.c:580:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_setets'
     580 |  .ieee_setets = nsim_dcb_ieee_setets,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:580:17: warning: excess elements in struct initializer
     580 |  .ieee_setets = nsim_dcb_ieee_setets,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:580:17: note: (near initialization for 'nsim_dcbnl_ops')
>> drivers/net/netdevsim/netdev.c:581:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_getmaxrate'
     581 |  .ieee_getmaxrate = nsim_dcb_ieee_getmaxrate,
         |   ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:581:21: warning: excess elements in struct initializer
     581 |  .ieee_getmaxrate = nsim_dcb_ieee_getmaxrate,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:581:21: note: (near initialization for 'nsim_dcbnl_ops')
>> drivers/net/netdevsim/netdev.c:582:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_setmaxrate'
     582 |  .ieee_setmaxrate = nsim_dcb_ieee_setmaxrate,
         |   ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:582:21: warning: excess elements in struct initializer
     582 |  .ieee_setmaxrate = nsim_dcb_ieee_setmaxrate,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:582:21: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:583:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_getqcn'
     583 |  .ieee_getqcn = nsim_dcb_ieee_getqcn,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:583:17: warning: excess elements in struct initializer
     583 |  .ieee_getqcn = nsim_dcb_ieee_getqcn,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:583:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:584:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_setqcn'
     584 |  .ieee_setqcn = nsim_dcb_ieee_setqcn,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:584:17: warning: excess elements in struct initializer
     584 |  .ieee_setqcn = nsim_dcb_ieee_setqcn,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:584:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:585:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_getqcnstats'
     585 |  .ieee_getqcnstats = nsim_dcb_ieee_getqcnstats,
         |   ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:585:22: warning: excess elements in struct initializer
     585 |  .ieee_getqcnstats = nsim_dcb_ieee_getqcnstats,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:585:22: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:586:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_getpfc'
     586 |  .ieee_getpfc = nsim_dcb_ieee_getpfc,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:586:17: warning: excess elements in struct initializer
     586 |  .ieee_getpfc = nsim_dcb_ieee_getpfc,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:586:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:587:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_setpfc'
     587 |  .ieee_setpfc = nsim_dcb_ieee_setpfc,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:587:17: warning: excess elements in struct initializer
     587 |  .ieee_setpfc = nsim_dcb_ieee_setpfc,
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:587:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:588:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_setapp'
     588 |  .ieee_setapp = dcb_ieee_setapp,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:588:17: error: 'dcb_ieee_setapp' undeclared here (not in a function)
     588 |  .ieee_setapp = dcb_ieee_setapp,
         |                 ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:588:17: warning: excess elements in struct initializer
   drivers/net/netdevsim/netdev.c:588:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:589:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_delapp'
     589 |  .ieee_delapp = dcb_ieee_delapp,
         |   ^~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:589:17: error: 'dcb_ieee_delapp' undeclared here (not in a function)
     589 |  .ieee_delapp = dcb_ieee_delapp,
         |                 ^~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:589:17: warning: excess elements in struct initializer
   drivers/net/netdevsim/netdev.c:589:17: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:590:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_peer_getets'
     590 |  .ieee_peer_getets = nsim_dcb_ieee_peer_getets,
         |   ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:590:22: warning: excess elements in struct initializer
     590 |  .ieee_peer_getets = nsim_dcb_ieee_peer_getets,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:590:22: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:591:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'ieee_peer_getpfc'
     591 |  .ieee_peer_getpfc = nsim_dcb_ieee_peer_getpfc,
         |   ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:591:22: warning: excess elements in struct initializer
     591 |  .ieee_peer_getpfc = nsim_dcb_ieee_peer_getpfc,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:591:22: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:593:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'getstate'
     593 |  .getstate = nsim_dcb_getstate,
         |   ^~~~~~~~
   drivers/net/netdevsim/netdev.c:593:14: warning: excess elements in struct initializer
     593 |  .getstate = nsim_dcb_getstate,
         |              ^~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:593:14: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:594:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'setstate'
     594 |  .setstate = nsim_dcb_setstate,
         |   ^~~~~~~~
   drivers/net/netdevsim/netdev.c:594:14: warning: excess elements in struct initializer
     594 |  .setstate = nsim_dcb_setstate,
         |              ^~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:594:14: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:595:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'getpermhwaddr'
     595 |  .getpermhwaddr = nsim_dcb_getpermhwaddr,
         |   ^~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:595:19: warning: excess elements in struct initializer
     595 |  .getpermhwaddr = nsim_dcb_getpermhwaddr,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:595:19: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:596:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'setpgtccfgtx'
     596 |  .setpgtccfgtx = nsim_dcb_setpgtccfgtx,
         |   ^~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:596:18: warning: excess elements in struct initializer
     596 |  .setpgtccfgtx = nsim_dcb_setpgtccfgtx,
         |                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/netdev.c:596:18: note: (near initialization for 'nsim_dcbnl_ops')
   drivers/net/netdevsim/netdev.c:597:3: error: 'const struct dcbnl_rtnl_ops' has no member named 'setpgbwgcfgtx'


vim +/buffer +105 drivers/net/netdevsim/netdevsim.h

    71	
    72	struct netdevsim {
    73		struct net_device *netdev;
    74		struct nsim_dev *nsim_dev;
    75		struct nsim_dev_port *nsim_dev_port;
    76	
    77		u64 tx_packets;
    78		u64 tx_bytes;
    79		struct u64_stats_sync syncp;
    80	
    81		struct nsim_bus_dev *nsim_bus_dev;
    82	
    83		struct bpf_prog	*bpf_offloaded;
    84		u32 bpf_offloaded_id;
    85	
    86		struct xdp_attachment_info xdp;
    87		struct xdp_attachment_info xdp_hw;
    88	
    89		bool bpf_tc_accept;
    90		bool bpf_tc_non_bound_accept;
    91		bool bpf_xdpdrv_accept;
    92		bool bpf_xdpoffload_accept;
    93	
    94		bool bpf_map_accept;
    95		struct nsim_ipsec ipsec;
    96		struct {
    97			u32 inject_error;
    98			u32 sleep;
    99			u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
   100			u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
   101			struct debugfs_u32_array dfs_ports[2];
   102		} udp_ports;
   103	
   104		struct nsim_ethtool ethtool;
 > 105		struct dcbnl_buffer buffer;
 > 106		struct ieee_ets ets;
 > 107		struct ieee_maxrate maxrate;
 > 108		struct ieee_pfc pfc;
   109		u8 dcbx;
   110	};
   111	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FOYGN3sQL/e9FEMy4PB/vmVopMnbAQA=

--BXVAT5kNtrzKuDFl--
