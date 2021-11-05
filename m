Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF58644641A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhKEN2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:28:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:31362 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhKEN2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:28:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231739843"
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="scan'208";a="231739843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 06:25:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="scan'208";a="600611503"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 06:25:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mizDu-003nix-3L;
        Fri, 05 Nov 2021 15:25:38 +0200
Date:   Fri, 5 Nov 2021 15:25:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [hnaz-mm:master 343/435] arch/riscv/lib/delay.c:77:3: error:
 implicit declaration of function 'cpu_relax'
Message-ID: <YYUw0aoQEPb0tiDS@smile.fi.intel.com>
References: <202111051510.ucX2TyQw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111051510.ucX2TyQw-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 03:11:20PM +0800, kernel test robot wrote:
> tree:   https://github.com/hnaz/linux-mm master
> head:   b8280145cf2a894c873fdf91fb2af474c52ac6cc
> commit: eaadd3a1784064254eb06b36fbd4b653f0228478 [343/435] include/linux/delay.h: replace kernel.h with the necessary inclusions
> config: riscv-randconfig-r031-20211103 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 264d3b6d4e08401c5b50a85bd76e80b3461d77e6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/hnaz/linux-mm/commit/eaadd3a1784064254eb06b36fbd4b653f0228478
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout eaadd3a1784064254eb06b36fbd4b653f0228478
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

AFAIR the fix is pending to be squashed.


-- 
With Best Regards,
Andy Shevchenko


