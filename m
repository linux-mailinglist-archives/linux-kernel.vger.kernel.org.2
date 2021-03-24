Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4F347690
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhCXKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:53:36 -0400
Received: from muru.com ([72.249.23.125]:46390 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233755AbhCXKxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:53:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C76018057;
        Wed, 24 Mar 2021 10:54:12 +0000 (UTC)
Date:   Wed, 24 Mar 2021 12:53:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: arch/arm/mach-omap2/board-generic.c:36:28: warning: no previous
 prototype for 'omap_init_time_of'
Message-ID: <YFsaGGLilisiguPr@atomide.com>
References: <202102262120.mYjsdIAN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102262120.mYjsdIAN-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* kernel test robot <lkp@intel.com> [210226 13:11]:
> Hi Tony,
> 
> FYI, the error/warning still remains.

Thanks for the report and sorry for the delay in responding. I've posted
a fix for this at:

https://lore.kernel.org/linux-omap/20210324105102.7286-1-tony@atomide.com/T/#u

Regards,

Tony


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2c87f7a38f930ef6f6a7bdd04aeb82ce3971b54b
> commit: e69b4e1a7577c169e9f52edf977401734a6a29eb ARM: OMAP2+: Add omap_init_time_of()
> date:   9 months ago
> config: arm-randconfig-r012-20210226 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e69b4e1a7577c169e9f52edf977401734a6a29eb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e69b4e1a7577c169e9f52edf977401734a6a29eb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm/mach-omap2/board-generic.c:36:28: warning: no previous prototype for 'omap_init_time_of' [-Wmissing-prototypes]
>       36 | void __init __maybe_unused omap_init_time_of(void)
>          |                            ^~~~~~~~~~~~~~~~~
> 
> 
> vim +/omap_init_time_of +36 arch/arm/mach-omap2/board-generic.c
> 
>     34	
>     35	/* Clocks are needed early, see drivers/clocksource for the rest */
>   > 36	void __init __maybe_unused omap_init_time_of(void)
>     37	{
>     38		omap_clk_init();
>     39		timer_probe();
>     40	}
>     41	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


