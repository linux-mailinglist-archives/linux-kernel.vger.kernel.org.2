Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC945F528
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhKZT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:28:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:22947 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhKZT03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:26:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222579122"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="222579122"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 11:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="539323646"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2021 11:23:13 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqgoS-0008Tn-Gd; Fri, 26 Nov 2021 19:23:12 +0000
Date:   Sat, 27 Nov 2021 03:23:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] powerpc: Simplify and move arch_randomize_brk()
Message-ID: <202111270342.b1Y85fuz-lkp@intel.com>
References: <4c5a2b18774552c2226573f7069ffeee71ad77cb.1637828367.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5a2b18774552c2226573f7069ffeee71ad77cb.1637828367.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on hnaz-mm/master linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211125-162916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc64-buildonly-randconfig-r006-20211125 (https://download.01.org/0day-ci/archive/20211127/202111270342.b1Y85fuz-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/554c475dfb73dc352708dff3589b55845b3dd751
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211125-162916
        git checkout 554c475dfb73dc352708dff3589b55845b3dd751
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/mm/book3s64/hash_utils.c:2077:15: warning: no previous prototype for 'arch_randomize_brk' [-Wmissing-prototypes]
    2077 | unsigned long arch_randomize_brk(struct mm_struct *mm)
         |               ^~~~~~~~~~~~~~~~~~


vim +/arch_randomize_brk +2077 arch/powerpc/mm/book3s64/hash_utils.c

  2076	
> 2077	unsigned long arch_randomize_brk(struct mm_struct *mm)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
