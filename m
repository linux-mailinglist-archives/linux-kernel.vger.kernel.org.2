Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF9460739
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358143AbhK1Prv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:47:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:40323 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358115AbhK1Ppu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:45:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="296637787"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="296637787"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 07:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="594263102"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2021 07:42:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrMJy-000ApU-1h; Sun, 28 Nov 2021 15:42:30 +0000
Date:   Sun, 28 Nov 2021 23:42:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-upstream 22/28]
 arch/x86/mm/pat/set_memory.c:1990:10: error: implicit declaration of
 function 'pgprot_cc_encrypted'
Message-ID: <202111282341.viH6fVs6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   da9f66a9b3a1f4ad0e9cb76472f628acf6f22dd5
commit: 0813e6258859bba3fd520771b318dab072137527 [22/28] x86/mm/cpa: Add support for TDX shared memory
config: i386-randconfig-r002-20211128 (https://download.01.org/0day-ci/archive/20211128/202111282341.viH6fVs6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5c64d8ef8cc0c0ed3e0f2ae693d99e7f70f20a84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/0813e6258859bba3fd520771b318dab072137527
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 0813e6258859bba3fd520771b318dab072137527
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/mm/pat/set_memory.c:1990:10: error: implicit declaration of function 'pgprot_cc_encrypted' [-Werror,-Wimplicit-function-declaration]
                   return pgprot_cc_encrypted(__pgprot(0));
                          ^
>> arch/x86/mm/pat/set_memory.c:1990:10: error: returning 'int' from a function with incompatible result type 'pgprot_t' (aka 'struct pgprot')
                   return pgprot_cc_encrypted(__pgprot(0));
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/mm/pat/set_memory.c:1992:10: error: implicit declaration of function 'pgprot_cc_decrypted' [-Werror,-Wimplicit-function-declaration]
                   return pgprot_cc_decrypted(__pgprot(0));
                          ^
   arch/x86/mm/pat/set_memory.c:1992:10: note: did you mean 'pgprot_cc_encrypted'?
   arch/x86/mm/pat/set_memory.c:1990:10: note: 'pgprot_cc_encrypted' declared here
                   return pgprot_cc_encrypted(__pgprot(0));
                          ^
   arch/x86/mm/pat/set_memory.c:1992:10: error: returning 'int' from a function with incompatible result type 'pgprot_t' (aka 'struct pgprot')
                   return pgprot_cc_decrypted(__pgprot(0));
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +/pgprot_cc_encrypted +1990 arch/x86/mm/pat/set_memory.c

  1986	
  1987	static pgprot_t pgprot_cc_mask(bool enc)
  1988	{
  1989		if (enc)
> 1990			return pgprot_cc_encrypted(__pgprot(0));
  1991		else
> 1992			return pgprot_cc_decrypted(__pgprot(0));
  1993	}
  1994	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
