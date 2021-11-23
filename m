Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD97345AC00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhKWTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:10:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:35824 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237126AbhKWTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:09:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="258983437"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="258983437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="457181296"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Nov 2021 11:06:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpb7v-0002By-Jq; Tue, 23 Nov 2021 19:06:47 +0000
Date:   Wed, 24 Nov 2021 03:06:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 15/38] arch/x86/kernel/process.o: warning:
 objtool: .altinstr_replacement+0x5: call without frame pointer save/setup
Message-ID: <202111240211.wdrjK2u4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   6de233e56ad1ba06ef0bbe20a9377c47f49e6366
commit: e565a4318c87e3d1243bb31b89c53aff081472c5 [15/38] x86/tdx: Add HLT support for TDX guests
config: x86_64-randconfig-a001-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240211.wdrjK2u4-lkp@intel.com/config.gz)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e565a4318c87e3d1243bb31b89c53aff081472c5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout e565a4318c87e3d1243bb31b89c53aff081472c5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/process.o: warning: objtool: .altinstr_replacement+0x5: call without frame pointer save/setup
   arch/x86/kernel/process.o: warning: objtool: .altinstr_replacement+0x0: call without frame pointer save/setup

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
