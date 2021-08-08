Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF743E3AF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhHHPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 11:01:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhHHPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 11:01:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 799446D;
        Sun,  8 Aug 2021 08:00:41 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E3C3F718;
        Sun,  8 Aug 2021 08:00:40 -0700 (PDT)
Date:   Sun, 8 Aug 2021 16:00:33 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [skn:for-next/scmi 16/24] include/linux/compiler_types.h:328:38:
 error: call to '__compiletime_assert_382' declared with attribute error:
 BUILD_BUG_ON failed: !IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)
Message-ID: <20210808150033.GV6592@e120937-lin>
References: <202108080642.jLO69nNZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108080642.jLO69nNZ-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:01:49AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/scmi
> head:   1e7cbfaa66d39e78bd24df0c78b55df68176b59e
> commit: e8419c24bacee45bfe3504814e91fc89ff8c23de [16/24] firmware: arm_scmi: Make SCMI transports configurable
> config: arm64-randconfig-r021-20210808 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=e8419c24bacee45bfe3504814e91fc89ff8c23de
>         git remote add skn https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
>         git fetch --no-tags skn for-next/scmi
>         git checkout e8419c24bacee45bfe3504814e91fc89ff8c23de
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/arm_scmi/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    drivers/firmware/arm_scmi/driver.c: In function 'scmi_driver_init':
> >> include/linux/compiler_types.h:328:38: error: call to '__compiletime_assert_382' declared with attribute error: BUILD_BUG_ON failed: !IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)
>      328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                      ^
>    include/linux/compiler_types.h:309:4: note: in definition of macro '__compiletime_assert'
>      309 |    prefix ## suffix();    \
>          |    ^~~~~~
>    include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
>      328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |  ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |  ^~~~~~~~~~~~~~~~
>    drivers/firmware/arm_scmi/driver.c:2011:2: note: in expansion of macro 'BUILD_BUG_ON'
>     2011 |  BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT));
>          |  ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_382 +328 include/linux/compiler_types.h
> 

Hi,

so the attached/used random configuration (SCMI snippet) is:

# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
# CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
# CONFIG_ARM_SCMI_TRANSPORT_SMC is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

and it's just the kind of situation which

BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT))

was meant to trap: you should not build an SCMI stack without at least
one transport configured; I could not put this constraint into the Kconfig
due to circular dependencies so I used BUILD_BUG_ON() (thinking it was
a legit use case...wrong ?)

Removing the BUILD_BUG_ON() above and allowing compilation of an SCMI stack
without any transport defined leads to an SCMI stack silently not working:
it builds and boots fine but no SCMI stack will be ever initialized since
not a single compatible from the DT will be matched.

Thanks,
Cristian

> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  315  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  317  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  325   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  327  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @328  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  329  
> 
> :::::: The code at line 328 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


