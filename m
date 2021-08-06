Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F93E2F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbhHFSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:04:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:36185 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242503AbhHFSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:04:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="214151703"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="214151703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 11:04:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="467954976"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 11:04:16 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mC4CX-0069y8-1T; Fri, 06 Aug 2021 21:04:09 +0300
Date:   Fri, 6 Aug 2021 21:04:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, yury.norov@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com
Subject: Re: [PATCH v9 2/5] lib: test_bitmap: add
 bitmap_print_bitmask/list_to_buf test cases
Message-ID: <YQ15mVkwmeUCIZL0@smile.fi.intel.com>
References: <20210806110251.560-3-song.bao.hua@hisilicon.com>
 <202108070109.TQClJ7dP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108070109.TQClJ7dP-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 01:51:36AM +0800, kernel test robot wrote:
> Hi Barry,
> 
> I love your patch! Perhaps something to improve:

I recall that I saw it ~1 year ago and informed Max about it.
Don't remember what was the outcome, though.

> [auto build test WARNING on driver-core/driver-core-testing]
> [also build test WARNING on staging/staging-testing linus/master v5.14-rc4 next-20210805]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Barry-Song/use-bin_attribute-to-break-the-size-limitation-of-cpumap-ABI/20210806-190735
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 112cedc8e600b668688eb809bf11817adec58ddc
> config: xtensa-randconfig-r011-20210805 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/cc67b898a0f6f1a93163c0c296cfa77b1f04f72d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Barry-Song/use-bin_attribute-to-break-the-size-limitation-of-cpumap-ABI/20210806-190735
>         git checkout cc67b898a0f6f1a93163c0c296cfa77b1f04f72d
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.data:print_buf
> The function bitmap_equal() references
> the variable __initdata print_buf.
> This is often because bitmap_equal lacks a __initdata
> annotation or the annotation of print_buf is wrong.
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko


