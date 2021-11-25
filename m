Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64FD45E2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbhKYVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:50:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:25768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235889AbhKYVsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:48:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216280236"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216280236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:41:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="592106788"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 13:41:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqMV6-0006xT-38; Thu, 25 Nov 2021 21:41:52 +0000
Date:   Fri, 26 Nov 2021 05:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/firmware/efi/sysfb_efi.c:70:6: warning: no previous
 prototype for function 'efifb_setup_from_dmi'
Message-ID: <202111260502.49nh07NH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: d391c58271072d0b0fad93c82018d495b2633448 drivers/firmware: move x86 Generic System Framebuffers support
date:   4 months ago
config: x86_64-randconfig-a016-20210927 (https://download.01.org/0day-ci/archive/20211126/202111260502.49nh07NH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d391c58271072d0b0fad93c82018d495b2633448
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d391c58271072d0b0fad93c82018d495b2633448
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/sysfb_efi.c:70:6: warning: no previous prototype for function 'efifb_setup_from_dmi' [-Wmissing-prototypes]
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
        ^
   drivers/firmware/efi/sysfb_efi.c:70:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
   ^
   static 
   drivers/firmware/efi/sysfb_efi.c:270:1: warning: attribute declaration must precede definition [-Wignored-attributes]
   __init void sysfb_apply_efi_quirks(void)
   ^
   include/linux/init.h:50:17: note: expanded from macro '__init'
   #define __init          __section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
                           ^
   include/linux/compiler_attributes.h:263:56: note: expanded from macro '__section'
   #define __section(section)              __attribute__((__section__(section)))
                                                          ^
   include/linux/sysfb.h:65:20: note: previous definition is here
   static inline void sysfb_apply_efi_quirks(void)
                      ^
   drivers/firmware/efi/sysfb_efi.c:270:1: warning: attribute declaration must precede definition [-Wignored-attributes]
   __init void sysfb_apply_efi_quirks(void)
   ^
   include/linux/init.h:50:41: note: expanded from macro '__init'
   #define __init          __section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
                                                   ^
   include/linux/compiler_attributes.h:92:56: note: expanded from macro '__cold'
   #define __cold                          __attribute__((__cold__))
                                                          ^
   include/linux/sysfb.h:65:20: note: previous definition is here
   static inline void sysfb_apply_efi_quirks(void)
                      ^
   drivers/firmware/efi/sysfb_efi.c:270:1: warning: attribute declaration must precede definition [-Wignored-attributes]
   __init void sysfb_apply_efi_quirks(void)
   ^
   include/linux/init.h:50:84: note: expanded from macro '__init'
   #define __init          __section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
                                                                                              ^
   include/linux/compiler-clang.h:65:33: note: expanded from macro '__nocfi'
   #define __nocfi         __attribute__((__no_sanitize__("cfi")))
                                          ^
   include/linux/sysfb.h:65:20: note: previous definition is here
   static inline void sysfb_apply_efi_quirks(void)
                      ^
   drivers/firmware/efi/sysfb_efi.c:270:13: error: redefinition of 'sysfb_apply_efi_quirks'
   __init void sysfb_apply_efi_quirks(void)
               ^
   include/linux/sysfb.h:65:20: note: previous definition is here
   static inline void sysfb_apply_efi_quirks(void)
                      ^
   4 warnings and 1 error generated.


vim +/efifb_setup_from_dmi +70 drivers/firmware/efi/sysfb_efi.c

2995e506276bfdc arch/x86/kernel/sysfb_efi.c David Herrmann 2013-08-02  69  
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25 @70  void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  71  {
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  72  	int i;
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  73  
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  74  	for (i = 0; i < M_UNKNOWN; i++) {
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  75  		if (efifb_dmi_list[i].base != 0 &&
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  76  		    !strcmp(opt, efifb_dmi_list[i].optname)) {
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  77  			si->lfb_base = efifb_dmi_list[i].base;
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  78  			si->lfb_linelength = efifb_dmi_list[i].stride;
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  79  			si->lfb_width = efifb_dmi_list[i].width;
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  80  			si->lfb_height = efifb_dmi_list[i].height;
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  81  		}
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  82  	}
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  83  }
21289ec02b41c4b arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  84  

:::::: The code at line 70 was first introduced by commit
:::::: 21289ec02b41c4b928a0b3de1778b325d714eea3 x86/efi/efifb: Move DMI based quirks handling out of generic code

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
