Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B045F6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbhKZW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:57:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:31126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhKZWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:55:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235963415"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="235963415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 14:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="539382857"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2021 14:52:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqk4p-0008iG-2s; Fri, 26 Nov 2021 22:52:19 +0000
Date:   Sat, 27 Nov 2021 06:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ayala Beker <ayala.beker@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:mac80211-next 4/5] net/wireless/scan.c:1803:13: error:
 'channel' undeclared
Message-ID: <202111270633.yT1YwvDA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git mac80211-next
head:   690c735dc56561a2cf331dcded3eecdbad1edd7f
commit: 8efcf18569753acc522e58966fedd773ad358ee3 [4/5] cfg80211: Use the HE operation IE to determine a 6GHz BSS channel
config: ia64-randconfig-r034-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270633.yT1YwvDA-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=8efcf18569753acc522e58966fedd773ad358ee3
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next mac80211-next
        git checkout 8efcf18569753acc522e58966fedd773ad358ee3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/wireless/scan.c: In function 'cfg80211_get_ies_channel_number':
>> net/wireless/scan.c:1803:13: error: 'channel' undeclared (first use in this function)
    1803 |         if (channel->band == NL80211_BAND_6GHZ) {
         |             ^~~~~~~
   net/wireless/scan.c:1803:13: note: each undeclared identifier is reported only once for each function it appears in
>> net/wireless/scan.c:1817:25: error: 'freq' undeclared (first use in this function); did you mean 'ifreq'?
    1817 |                         freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
         |                         ^~~~
         |                         ifreq
   In file included from include/linux/kernel.h:16,
                    from net/wireless/scan.c:10:
>> include/linux/math.h:136:17: error: first argument to '__builtin_choose_expr' not a constant
     136 |                 __builtin_choose_expr(                                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:135:17: note: in expansion of macro '__abs_choose_expr'
     135 |                 __abs_choose_expr(x, char,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:135:17: note: in expansion of macro '__abs_choose_expr'
     135 |                 __abs_choose_expr(x, char,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:134:17: note: in expansion of macro '__abs_choose_expr'
     134 |                 __abs_choose_expr(x, short,                             \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/math.h:133:17: note: in expansion of macro '__abs_choose_expr'
     133 |                 __abs_choose_expr(x, int,                               \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:144:61: note: in definition of macro '__abs_choose_expr'
     144 |         ({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
         |                                                             ^~~~~
   include/linux/math.h:132:17: note: in expansion of macro '__abs_choose_expr'
     132 |                 __abs_choose_expr(x, long,                              \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
   include/linux/math.h:141:43: error: first argument to '__builtin_choose_expr' not a constant
     141 | #define __abs_choose_expr(x, type, other) __builtin_choose_expr(        \
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   include/linux/math.h:131:17: note: in expansion of macro '__abs_choose_expr'
     131 | #define abs(x)  __abs_choose_expr(x, long long,                         \
         |                 ^~~~~~~~~~~~~~~~~
   net/wireless/scan.c:1824:29: note: in expansion of macro 'abs'
    1824 |                             abs(freq - channel->center_freq) <= 80 &&
         |                             ^~~
>> net/wireless/scan.c:1825:30: error: 'ftype' undeclared (first use in this function); did you mean 'cftype'?
    1825 |                             (ftype != CFG80211_BSS_FTYPE_BEACON ||
         |                              ^~~~~
         |                              cftype


vim +/channel +1803 net/wireless/scan.c

  1796	
  1797	int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
  1798					    enum nl80211_band band)
  1799	{
  1800		const u8 *tmp;
  1801		int channel_number = -1;
  1802	
> 1803		if (channel->band == NL80211_BAND_6GHZ) {
  1804			const struct element *elem;
  1805	
  1806			elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie,
  1807						      ielen);
  1808			if (elem && elem->datalen >= ieee80211_he_oper_size(&elem->data[1])) {
  1809				struct ieee80211_he_operation *he_oper =
  1810					(void *)(&elem->data[1]);
  1811				const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
  1812	
  1813				he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
  1814				if (!he_6ghz_oper)
  1815					return channel;
  1816	
> 1817				freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
  1818								      NL80211_BAND_6GHZ);
  1819	
  1820				/* duplicated beacon indication is relevant for beacons
  1821				 * only
  1822				 */
  1823				if (freq != channel->center_freq &&
  1824				    abs(freq - channel->center_freq) <= 80 &&
> 1825				    (ftype != CFG80211_BSS_FTYPE_BEACON ||
  1826				     he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON))
  1827					channel_number = he_6ghz_oper->primary;
  1828			}
  1829		} else if (band == NL80211_BAND_S1GHZ) {
  1830			tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
  1831			if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
  1832				struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
  1833	
  1834				channel_number = s1gop->primary_ch;
  1835			}
  1836		} else {
  1837			tmp = cfg80211_find_ie(WLAN_EID_DS_PARAMS, ie, ielen);
  1838			if (tmp && tmp[1] == 1) {
  1839				channel_number = tmp[2];
  1840			} else {
  1841				tmp = cfg80211_find_ie(WLAN_EID_HT_OPERATION, ie, ielen);
  1842				if (tmp && tmp[1] >= sizeof(struct ieee80211_ht_operation)) {
  1843					struct ieee80211_ht_operation *htop = (void *)(tmp + 2);
  1844	
  1845					channel_number = htop->primary_chan;
  1846				}
  1847			}
  1848		}
  1849	
  1850		return channel_number;
  1851	}
  1852	EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
  1853	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
