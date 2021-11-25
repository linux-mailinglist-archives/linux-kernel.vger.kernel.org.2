Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCAC45D9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhKYMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:08:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:10777 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240462AbhKYMGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:06:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235442591"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235442591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:58:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="475621281"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 03:58:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqDOc-0006JF-8C; Thu, 25 Nov 2021 11:58:34 +0000
Date:   Thu, 25 Nov 2021 19:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: drivers/bluetooth/hci_qca.c:1860:37: warning: unused variable
 'qca_soc_data_wcn6750'
Message-ID: <202111251945.DaHpCtny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkata,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: d8f97da1b92d2fe89d51c673ecf80c4016119e5c Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750
date:   5 months ago
config: x86_64-buildonly-randconfig-r005-20211118 (https://download.01.org/0day-ci/archive/20211125/202111251945.DaHpCtny-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8f97da1b92d2fe89d51c673ecf80c4016119e5c
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bluetooth/hci_qca.c:1821:37: warning: unused variable 'qca_soc_data_wcn3990' [-Wunused-const-variable]
   static const struct qca_device_data qca_soc_data_wcn3990 = {
                                       ^
   drivers/bluetooth/hci_qca.c:1832:37: warning: unused variable 'qca_soc_data_wcn3991' [-Wunused-const-variable]
   static const struct qca_device_data qca_soc_data_wcn3991 = {
                                       ^
   drivers/bluetooth/hci_qca.c:1844:37: warning: unused variable 'qca_soc_data_wcn3998' [-Wunused-const-variable]
   static const struct qca_device_data qca_soc_data_wcn3998 = {
                                       ^
>> drivers/bluetooth/hci_qca.c:1860:37: warning: unused variable 'qca_soc_data_wcn6750' [-Wunused-const-variable]
   static const struct qca_device_data qca_soc_data_wcn6750 = {
                                       ^
   4 warnings generated.


vim +/qca_soc_data_wcn6750 +1860 drivers/bluetooth/hci_qca.c

  1859	
> 1860	static const struct qca_device_data qca_soc_data_wcn6750 = {
  1861		.soc_type = QCA_WCN6750,
  1862		.vregs = (struct qca_vreg []) {
  1863			{ "vddio", 5000 },
  1864			{ "vddaon", 26000 },
  1865			{ "vddbtcxmx", 126000 },
  1866			{ "vddrfacmn", 12500 },
  1867			{ "vddrfa0p8", 102000 },
  1868			{ "vddrfa1p7", 302000 },
  1869			{ "vddrfa1p2", 257000 },
  1870			{ "vddrfa2p2", 1700000 },
  1871			{ "vddasd", 200 },
  1872		},
  1873		.num_vregs = 9,
  1874		.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
  1875	};
  1876	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
