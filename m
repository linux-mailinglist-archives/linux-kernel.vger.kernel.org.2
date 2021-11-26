Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDD45EDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352564AbhKZMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:37:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:44524 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377259AbhKZMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:35:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299061174"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="299061174"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 04:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="457648785"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 04:28:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqaLZ-00085P-J0; Fri, 26 Nov 2021 12:28:57 +0000
Date:   Fri, 26 Nov 2021 20:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: mm/kasan/sw_tags.c:211:6: warning: no previous prototype for
 function 'kasan_tag_mismatch'
Message-ID: <202111262016.vdEfdFNO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 1cbdf60bd1b74e397d48aa877367cfc621f45ffe kasan: arm64: support specialized outlined tag mismatch checks
date:   6 months ago
config: arm64-randconfig-r003-20211116 (https://download.01.org/0day-ci/archive/20211126/202111262016.vdEfdFNO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/sw_tags.c:211:6: warning: no previous prototype for function 'kasan_tag_mismatch' [-Wmissing-prototypes]
   void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
        ^
   mm/kasan/sw_tags.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
   ^
   static 
   1 warning generated.


vim +/kasan_tag_mismatch +211 mm/kasan/sw_tags.c

   210	
 > 211	void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
