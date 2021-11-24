Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6489645CA80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbhKXRES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:04:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:59471 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhKXREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:04:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321556790"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="321556790"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 08:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="554251783"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2021 08:43:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpvND-00053o-6N; Wed, 24 Nov 2021 16:43:55 +0000
Date:   Thu, 25 Nov 2021 00:43:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 113/144] arch/x86/boot/compressed/misc.c:443:17:
 warning: cast from pointer to integer of different size
Message-ID: <202111250023.2nQP8Msm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: f6aa202e95b516db1b1b365f08a338387a3b78d7 [113/144] x86/boot/compressed: Handle unaccepted memory
config: i386-randconfig-c021-20211122 (https://download.01.org/0day-ci/archive/20211125/202111250023.2nQP8Msm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/f6aa202e95b516db1b1b365f08a338387a3b78d7
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout f6aa202e95b516db1b1b365f08a338387a3b78d7
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/boot/compressed/misc.c: In function 'extract_kernel':
>> arch/x86/boot/compressed/misc.c:443:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     443 |   accept_memory((phys_addr_t)output,
         |                 ^
   arch/x86/boot/compressed/misc.c:444:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     444 |          (phys_addr_t)output + needed_size);
         |          ^


vim +443 arch/x86/boot/compressed/misc.c

   437	
   438		debug_putstr("\nDecompressing Linux... ");
   439	
   440		if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
   441		    boot_params->unaccepted_memory) {
   442			debug_putstr("Accepting memory... ");
 > 443			accept_memory((phys_addr_t)output,
   444				      (phys_addr_t)output + needed_size);
   445		}
   446	
   447		__decompress(input_data, input_len, NULL, NULL, output, output_len,
   448				NULL, error);
   449		parse_elf(output);
   450		handle_relocations(output, output_len, virt_addr);
   451		debug_putstr("done.\nBooting the kernel.\n");
   452	
   453		/* Disable exception handling before booting the kernel */
   454		cleanup_exception_handling();
   455	
   456		return output;
   457	}
   458	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
