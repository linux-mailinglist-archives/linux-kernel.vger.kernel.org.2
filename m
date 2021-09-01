Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413A3FD88D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhIALT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:19:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:30490 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239191AbhIALTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:19:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="240988251"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="240988251"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 04:18:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="498795819"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 04:18:20 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mLOG1-00GLXp-8T;
        Wed, 01 Sep 2021 14:18:17 +0300
Date:   Wed, 1 Sep 2021 14:18:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:102:28:
 warning: taking address of packed member 'csr_ops' of class or structure
 'adf_hw_device_data' may result in an unaligned pointer value
Message-ID: <YS9heetW+E+1Nr1w@smile.fi.intel.com>
References: <202109010001.5r11IRSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109010001.5r11IRSX-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:19:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b91db6a0b52e019b6bdabea3f1dbe36d85c7e52c
> commit: f9c697c4bfc6002d92e8015b65fe2a79acadb416 crypto: qat - split transport CSR access logic
> date:   10 months ago
> config: i386-randconfig-r012-20210831 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9c697c4bfc6002d92e8015b65fe2a79acadb416
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f9c697c4bfc6002d92e8015b65fe2a79acadb416
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    clang-14: warning: optimization flag '-falign-jumps=0' is not supported [-Wignored-optimization-argument]
>    In file included from drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:3:
>    In file included from drivers/crypto/qat/qat_c62xvf/../qat_common/adf_accel_devices.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:5:
>    In file included from include/linux/context_tracking_state.h:5:
>    In file included from include/linux/percpu.h:6:
>    In file included from include/linux/preempt.h:78:
>    In file included from arch/x86/include/asm/preempt.h:7:
>    In file included from include/linux/thread_info.h:38:
>    arch/x86/include/asm/thread_info.h:183:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>            oldframe = __builtin_frame_address(1);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/include/asm/thread_info.h:185:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
>                    frame = __builtin_frame_address(2);

Funny, but it's not related to the reported issue.

>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:102:28: warning: taking address of packed member 'csr_ops' of class or structure 'adf_hw_device_data' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
>                                      ^~~~~~~~~~~~~~~~
>    3 warnings generated.


Why on Earth the struct adf_hw_device_data, that contains a lot of pointers,
marked as __packed?! That __packed has to be dropped.

-- 
With Best Regards,
Andy Shevchenko


