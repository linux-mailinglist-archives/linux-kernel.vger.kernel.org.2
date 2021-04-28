Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9F36D426
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhD1IoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:44:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:3498 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1IoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:44:22 -0400
IronPort-SDR: 4iCEf6igrdok3svtktVitXLqdM7E3hpcC6Adfe1znRKfc9gfGdishIx7xwcMbl6SHf8Lnqttv8
 6wGz41zfyylg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="217405963"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="217405963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:43:38 -0700
IronPort-SDR: sttpcSwQ4nJj1ugazyCYKIgI92nVSzcr0jm4AfSqUo9GfXaepdM9ve6UKQAJgFcUCW4+lBFx5D
 uh322Sqs4wLA==
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="458076432"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:43:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lbfnB-007pmY-M5; Wed, 28 Apr 2021 11:43:33 +0300
Date:   Wed, 28 Apr 2021 11:43:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/pinctrl/intel/pinctrl-intel.c:1663:14: warning: variable
 'dummy' set but not used
Message-ID: <YIkgNWRJ+9BpEtvb@smile.fi.intel.com>
References: <202104280827.lscZW8Xg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104280827.lscZW8Xg-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Arnd and Nick

(Seems like a clang bug)

On Wed, Apr 28, 2021 at 08:10:34AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e359bce39d9085ab24eaa0bb0778bb5f6894144a
> commit: 10c857f063fc63902160755a6e23fa594290c6d3 pinctrl: cherryview: Switch to use intel_pinctrl_get_soc_data()
> date:   8 months ago
> config: x86_64-randconfig-a005-20210426 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 87fc97169e7901dfe56ca0da0d92da0c02d2ef48)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c857f063fc63902160755a6e23fa594290c6d3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 10c857f063fc63902160755a6e23fa594290c6d3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/pinctrl/intel/pinctrl-intel.c:1663:14: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
>            const char *dummy;
>                        ^
>    1 warning generated.

Seems to me a bug in clang. The variable is used to check if the body of the
loop should be executed or not.

> vim +/dummy +1663 drivers/pinctrl/intel/pinctrl-intel.c
> 
> a0a5f7661e1c49 Chris Chiu      2019-04-15  1656  
> 7101e022523bfb Andy Shevchenko 2019-10-22  1657  static void intel_restore_hostown(struct intel_pinctrl *pctrl, unsigned int c,
> 7101e022523bfb Andy Shevchenko 2019-10-22  1658  				  void __iomem *base, unsigned int gpp, u32 saved)
> 7101e022523bfb Andy Shevchenko 2019-10-22  1659  {
> 7101e022523bfb Andy Shevchenko 2019-10-22  1660  	const struct intel_community *community = &pctrl->communities[c];
> 7101e022523bfb Andy Shevchenko 2019-10-22  1661  	const struct intel_padgroup *padgrp = &community->gpps[gpp];
> 7101e022523bfb Andy Shevchenko 2019-10-22  1662  	struct device *dev = pctrl->dev;
> d1bfd0229ec4de Andy Shevchenko 2020-06-10 @1663  	const char *dummy;
> d1bfd0229ec4de Andy Shevchenko 2020-06-10  1664  	u32 requested = 0;
> d1bfd0229ec4de Andy Shevchenko 2020-06-10  1665  	unsigned int i;
> 7101e022523bfb Andy Shevchenko 2019-10-22  1666  
> e5a4ab6a55e230 Andy Shevchenko 2020-04-13  1667  	if (padgrp->gpio_base == INTEL_GPIO_BASE_NOMAP)
> 7101e022523bfb Andy Shevchenko 2019-10-22  1668  		return;
> 7101e022523bfb Andy Shevchenko 2019-10-22  1669  
> d1bfd0229ec4de Andy Shevchenko 2020-06-10  1670  	for_each_requested_gpio_in_range(&pctrl->chip, i, padgrp->gpio_base, padgrp->size, dummy)
> d1bfd0229ec4de Andy Shevchenko 2020-06-10  1671  		requested |= BIT(i);
> d1bfd0229ec4de Andy Shevchenko 2020-06-10  1672  
> 942c5ea49ffbe2 Andy Shevchenko 2019-10-22  1673  	if (!intel_gpio_update_reg(base + gpp * 4, requested, saved))
> 7101e022523bfb Andy Shevchenko 2019-10-22  1674  		return;
> 7101e022523bfb Andy Shevchenko 2019-10-22  1675  
> 764cfe33517f7c Andy Shevchenko 2019-10-22  1676  	dev_dbg(dev, "restored hostown %u/%u %#08x\n", c, gpp, readl(base + gpp * 4));
> 7101e022523bfb Andy Shevchenko 2019-10-22  1677  }
> 7101e022523bfb Andy Shevchenko 2019-10-22  1678  
> 
> :::::: The code at line 1663 was first introduced by commit
> :::::: d1bfd0229ec4deb53e61f95c050b524152fd0d9e pinctrl: intel: Make use of for_each_requested_gpio_in_range()
> 
> :::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> :::::: CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko


