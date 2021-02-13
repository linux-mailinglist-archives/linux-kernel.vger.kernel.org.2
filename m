Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0931ADF1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 21:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 15:26:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:31063 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 15:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1613247766;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
        From:Subject:Sender;
        bh=QTfgDHZO8/OLOHwTmX91GDJ45BYhvSLmHkUZ8l36UTY=;
        b=Aw6Q9gm6LEfRxY51bfKW3Yc9njK5SWQWpYuEjINiKccXR3ZUeW846+82k3eXUzZczO
        hFVt4jO/vmk1BINwaFswFIlCboOSNWYLk5Ut3jbV1Lll8XJJCj2vBHC0yITuEEQCfR4m
        68xgfTiy5CFXfihkfv5eXUjVgM89QTUdlrseKxIDO1nIircVSIwQ8wp9JLLsaUqSXw3b
        MhqXqmFh0N2VT2B34rjKrPkLu5ggob0kNiiFkrx4Vb8hWmyplXs8t5LBkGR9s8Xny6QI
        BMjSmqd5Ein8/ZoVSoHr2FhuZfUW8lhkj+bUl/BMnWO9RVWMkZxNUYVpYm9bSY4rpJFR
        ywPQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJXsh5lEWV"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.17.1 DYNA|AUTH)
        with ESMTPSA id J0aa2dx1DKMdCZX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 13 Feb 2021 21:22:39 +0100 (CET)
Subject: Re: include/linux/compiler_types.h:315:38: error: call to
 '__compiletime_assert_515' declared with attribute error: BUILD_BUG_ON
 failed: offsetof(struct can_frame, len) != offsetof(struct canfd_frame, len)
 || offsetof(struct can_frame, data) != offsetof(struc...
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <202102140356.yeQQNGjV-lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <6e57d5d2-9b88-aee6-fb7a-82e24144d179@hartkopp.net>
Date:   Sat, 13 Feb 2021 21:22:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102140356.yeQQNGjV-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.02.21 20:57, kernel test robot wrote:
> Hi Oliver,
> 
> FYI, the error/warning still remains.

Yes, because of the this union, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/can.h?id=c7b74967799b1af52b3045d69d4c26836b2d41de#n109

Maybe I was not clear on this.

On ARM the BUILD_BUG_ON() seems to stumble about this new union{} 
introduced here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/can.h?id=ea7800565a128c1adafa1791ce80afd6016fe21c

So every commit after ea7800565a128c1 ("can: add optional DLC element to 
Classical CAN frame structure") should show this issue UNTIL 
BUILD_BUG_ON() is fixed on ARM (my assuption) so that the union{} is 
supported like on the x86.

Best,
Oliver

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
> commit: c7b74967799b1af52b3045d69d4c26836b2d41de can: replace can_dlc as variable/element for payload length
> date:   3 months ago
> config: arm-randconfig-r013-20210214 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7b74967799b1af52b3045d69d4c26836b2d41de
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout c7b74967799b1af52b3045d69d4c26836b2d41de
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from <command-line>:
>     net/can/af_can.c: In function 'can_init':
>>> include/linux/compiler_types.h:315:38: error: call to '__compiletime_assert_515' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struct canfd_frame, data)
>       315 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |                                      ^
>     include/linux/compiler_types.h:296:4: note: in definition of macro '__compiletime_assert'
>       296 |    prefix ## suffix();    \
>           |    ^~~~~~
>     include/linux/compiler_types.h:315:2: note: in expansion of macro '_compiletime_assert'
>       315 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |  ^~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>        50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>           |  ^~~~~~~~~~~~~~~~
>     net/can/af_can.c:891:2: note: in expansion of macro 'BUILD_BUG_ON'
>       891 |  BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>           |  ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_515 +315 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  301
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  302  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  303  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  304
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  306   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  307   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  308   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  309   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @315  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316
> 
> :::::: The code at line 315 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
