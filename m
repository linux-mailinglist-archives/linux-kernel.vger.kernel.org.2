Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B7745B0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 01:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKXAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 19:37:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:48782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhKXAhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:37:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="295974434"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="295974434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 16:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="457269373"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Nov 2021 16:34:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpgEk-0003I9-9F; Wed, 24 Nov 2021 00:34:10 +0000
Date:   Wed, 24 Nov 2021 08:33:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, linux-imx@nxp.com,
        festevam@gmail.com, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dts: imx8mq: Add interconnect for lcdif"
Message-ID: <202111240841.CMphNMc6-lkp@intel.com>
References: <20211123114545.411787-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123114545.411787-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.16-rc2 next-20211123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Martin-Kepplinger/Revert-arm64-dts-imx8mq-Add-interconnect-for-lcdif/20211123-194812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r006-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240841.CMphNMc6-lkp@intel.com/config.gz)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7c0ba67703bd4e42499c76d0953b46aba38b74af
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Martin-Kepplinger/Revert-arm64-dts-imx8mq-Add-interconnect-for-lcdif/20211123-194812
        git checkout 7c0ba67703bd4e42499c76d0953b46aba38b74af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/imx8mq.dtsi:1117.27-28 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
