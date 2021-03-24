Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BE347699
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhCXK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:56:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:52380 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233932AbhCXKz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:55:59 -0400
IronPort-SDR: 6CRp1juP1Hb6i6TaxnP08DVKzcnyZEUhk8iQTDdj+Bfs/qRWmcc+CdDo7G3qrAcjOgt7Jj+tB+
 p6IkmXb4Mjew==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="275789950"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="275789950"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 03:55:58 -0700
IronPort-SDR: zrlADPxBCGiZjdOeie7VR00aTqTsEZrL0JADe+wyvX3TjzPKOgGYCJk4dT2NeFt+eeY8f9Ocfc
 ixaU8deJiA7w==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="391257695"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 03:55:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP1B4-00Fe7T-GT; Wed, 24 Mar 2021 12:55:54 +0200
Date:   Wed, 24 Mar 2021 12:55:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: ERROR: "devm_platform_ioremap_resource" undefined!
Message-ID: <YFsaulvNkN6pG8Yt@smile.fi.intel.com>
References: <202103241300.gHagtjGJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103241300.gHagtjGJ-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:58:06PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7acac4b3196caee5e21fb5ea53f8bc124e6a16fc
> commit: a9c56721d6ae99b22e983d0722e6b1b53a11dd59 dmaengine: dw: platform: Use devm_platform_ioremap_resource()
> date:   1 year, 7 months ago
> config: s390-randconfig-r013-20210324 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9c56721d6ae99b22e983d0722e6b1b53a11dd59
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a9c56721d6ae99b22e983d0722e6b1b53a11dd59
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "devm_platform_ioremap_resource" [drivers/dma/dw/dw_dmac.ko] undefined!

Because s390 does not have IOMEM (IIRC). I forgot how it's usually fixed.

Again IIRC it should be done somewhere in the generic files, otherwise we have
to have add 'depends on HAVE_IOMEM' everywhere.

Okay, seems it's not. Fine, I'll send a patch soon.

-- 
With Best Regards,
Andy Shevchenko


