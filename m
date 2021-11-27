Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9445FB45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbhK0Bhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:37:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:57463 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351096AbhK0Bfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:35:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222960268"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="222960268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 17:25:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="498613168"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 17:25:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqmSw-0008rv-Mw; Sat, 27 Nov 2021 01:25:22 +0000
Date:   Sat, 27 Nov 2021 09:24:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ayala Beker <ayala.beker@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [iwlwifi-next:mac80211-next 4/5] net/wireless/scan.c:1803:6: error:
 use of undeclared identifier 'channel'
Message-ID: <202111270902.oVy0Aumb-lkp@intel.com>
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
config: arm-randconfig-r011-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270902.oVy0Aumb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=8efcf18569753acc522e58966fedd773ad358ee3
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next mac80211-next
        git checkout 8efcf18569753acc522e58966fedd773ad358ee3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/wireless/scan.c:1803:6: error: use of undeclared identifier 'channel'
           if (channel->band == NL80211_BAND_6GHZ) {
               ^
   net/wireless/scan.c:1815:12: error: use of undeclared identifier 'channel'
                                   return channel;
                                          ^
>> net/wireless/scan.c:1817:4: error: use of undeclared identifier 'freq'
                           freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
                           ^
   net/wireless/scan.c:1824:12: error: use of undeclared identifier 'freq'
                               abs(freq - channel->center_freq) <= 80 &&
                                   ^
   net/wireless/scan.c:1824:19: error: use of undeclared identifier 'channel'
                               abs(freq - channel->center_freq) <= 80 &&
                                          ^
   net/wireless/scan.c:1824:12: error: use of undeclared identifier 'freq'
                               abs(freq - channel->center_freq) <= 80 &&
                                   ^
   net/wireless/scan.c:1824:19: error: use of undeclared identifier 'channel'
                               abs(freq - channel->center_freq) <= 80 &&
                                          ^
   net/wireless/scan.c:1823:8: error: use of undeclared identifier 'freq'
                           if (freq != channel->center_freq &&
                               ^
   net/wireless/scan.c:1823:16: error: use of undeclared identifier 'channel'
                           if (freq != channel->center_freq &&
                                       ^
>> net/wireless/scan.c:1825:9: error: use of undeclared identifier 'ftype'; did you mean '_ctype'?
                               (ftype != CFG80211_BSS_FTYPE_BEACON ||
                                ^~~~~
                                _ctype
   include/linux/ctype.h:21:28: note: '_ctype' declared here
   extern const unsigned char _ctype[];
                              ^
   10 errors generated.


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
