Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94383BA0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhGBM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:59:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:47182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232183AbhGBM7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:59:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208680606"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="gz'50?scan'50,208,50";a="208680606"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 05:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="gz'50?scan'50,208,50";a="409292637"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2021 05:56:41 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzIin-000B5L-1f; Fri, 02 Jul 2021 12:56:41 +0000
Date:   Fri, 2 Jul 2021 20:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, dave.hansen@intel.com,
        yury.norov@gmail.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com
Subject: Re: [PATCH v5 2/3] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Message-ID: <202107022036.ildB59LN-lkp@intel.com>
References: <20210702092559.8776-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20210702092559.8776-3-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Barry,

I love your patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on staging/staging-testing linus/master v5.13 next-20210701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Barry-Song/use-bin_attribute-to-break-the-size-limitation-of-cpumap-ABI/20210702-172727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3b1f941536af17537da09a7552c8e74804dd6823
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/647347a6350cefabb7ef767a0ab304be4395eeb2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Barry-Song/use-bin_attribute-to-break-the-size-limitation-of-cpumap-ABI/20210702-172727
        git checkout 647347a6350cefabb7ef767a0ab304be4395eeb2
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/base/topology.o: in function `thread_siblings_list_read':
   topology.c:(.text+0x4c): undefined reference to `cpumap_print_to_buf'
>> nds32le-linux-ld: topology.c:(.text+0x50): undefined reference to `cpumap_print_to_buf'
   nds32le-linux-ld: drivers/base/topology.o: in function `thread_siblings_read':
   topology.c:(.text+0xa8): undefined reference to `cpumap_print_to_buf'
   nds32le-linux-ld: topology.c:(.text+0xac): undefined reference to `cpumap_print_to_buf'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--0F1p//8PRICkK4MW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--0F1p//8PRICkK4MW--
