Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82545D085
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 23:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbhKXW4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 17:56:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:48204 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhKXW4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:56:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259289163"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="259289163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 14:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="497849603"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 14:53:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq18S-0005ST-9T; Wed, 24 Nov 2021 22:53:04 +0000
Date:   Thu, 25 Nov 2021 06:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous
 prototype for 'efifb_setup_from_dmi'
Message-ID: <202111250607.RsWYy3Lg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: 71260b9a7020751623bcda2a5377834a100dfb30 drivers/firmware: fix SYSFB depends to prevent build failures
date:   4 months ago
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20211125/202111250607.RsWYy3Lg-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71260b9a7020751623bcda2a5377834a100dfb30
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71260b9a7020751623bcda2a5377834a100dfb30
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous prototype for 'efifb_setup_from_dmi' [-Wmissing-prototypes]
      72 | void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/efifb_setup_from_dmi +72 drivers/firmware/efi/sysfb_efi.c

2995e506276bfd arch/x86/kernel/sysfb_efi.c David Herrmann 2013-08-02  71  
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25 @72  void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  73  {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  74  	int i;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  75  
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  76  	for (i = 0; i < M_UNKNOWN; i++) {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  77  		if (efifb_dmi_list[i].base != 0 &&
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  78  		    !strcmp(opt, efifb_dmi_list[i].optname)) {
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  79  			si->lfb_base = efifb_dmi_list[i].base;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  80  			si->lfb_linelength = efifb_dmi_list[i].stride;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  81  			si->lfb_width = efifb_dmi_list[i].width;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  82  			si->lfb_height = efifb_dmi_list[i].height;
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  83  		}
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  84  	}
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  85  }
21289ec02b41c4 arch/x86/kernel/sysfb_efi.c Ard Biesheuvel 2016-04-25  86  

:::::: The code at line 72 was first introduced by commit
:::::: 21289ec02b41c4b928a0b3de1778b325d714eea3 x86/efi/efifb: Move DMI based quirks handling out of generic code

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
