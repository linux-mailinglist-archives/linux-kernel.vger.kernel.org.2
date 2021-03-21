Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4E3432F9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCUOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 10:20:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:9240 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 10:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616336373; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lUgqxVmAQR/AZewSv5TFXO0uEcI4CCfN+mAj1ClkrKuaZbMyQ0dgyPGGhbHhF0WeMC
    aYk+c91zGv8o59653tX1WwdxBkkthRrmt1wEhET5bDKIkQFd7vvrtjhBVHBcbK3R47JA
    JyvA7A8PWokvKozj7T5rFN3vNZWL35o3+sFEn8q2H7gY3oafTWOb/nXR5/Fot6UNc7yk
    CJvmuutcUW9/n3ER2HSBdiN2SUm5T0rijl2CI0E9wB18WQd0lotEUwzGxEtkGX3cneeU
    zY61dl3aoKZ1VfdmjYWUJFLkx8eDclejs4VntL3LkZbXOTPW492tAgRtEz2OVlDlYZmr
    uESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616336373;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=EM/clA8DCQoBH/pP2E1MT2oWcggNEdEJWVQhF4sSMoA=;
    b=iiBewLn72ZySpVsE/WKb4yzpQmwy/+Z0gtl8yf4I3AiqfuvjmenY6an5aV8m9S8OTy
    ma9YkfPRWeoJ7GnBnfWmtKrRZgGBZeyJUfhvhNFshtKP/WgIhB3FIJ0IZ/NEA8bqbgCE
    zTj2qjTy1zEhMt1Dbe+dcawnqP6+mqSBXEjxJdTcd06wEKdTNVhiNiAGHTUSALT/StUS
    5uGtS19drWdWJiLj8RB/glpkV5m6zxSa4hVDsyQ+VEfYtwUGR3+/ATev6/jh1kHLU7O8
    +kM0hgSlN/POOIRfFPAM4nDnNFNcyNVGE9XgNjVGHx6rF1TJDJFYM/O7QPs300uUc+lw
    dDUA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616336373;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=EM/clA8DCQoBH/pP2E1MT2oWcggNEdEJWVQhF4sSMoA=;
    b=qfTEJBfoHVT0O/uYMoTSY/e2xNkPLeg0PRp9le6G+q4INCVV1h0tAdR6Z0ohiYkMTP
    IIwrW8FPY32Trz2SGB7qJ5nJ+gL+Twheup3xscl97U77Vx/RVoTXPzVOIFPPsE2fWkUK
    RIv0/94odkVvALH76+kOF16HIcbD4q9KOp75gXRUp8MLNu59z8VyjI5gJ2GRCVUqdauZ
    4Oqd8+Ba0zaOcFkrMVOToYfljXImQd3B9vkUyjm8McAimx6IhsN6+FtJRxKmygCQuF/L
    6QaBKxnDIwbKZ4fKzWpF0txfpKjcGcWKFbbb5LyONlKKDE1wCLaB/RKt8c6K1q8UmMfa
    g2fw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMIVsh5lk6d"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2LEJW9aL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Mar 2021 15:19:32 +0100 (CET)
Subject: Re: include/linux/compiler_types.h:315:38: error: call to
 '__compiletime_assert_536' declared with attribute error: BUILD_BUG_ON
 failed: offsetof(struct can_frame, len) != offsetof(struct canfd_frame, len)
 || offsetof(struct can_frame, data) != offsetof(struc...
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <202103210435.I0fiBGAC-lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
Date:   Sun, 21 Mar 2021 15:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103210435.I0fiBGAC-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two reminders in two days? ;-)

Did you check my answer here?
https://lore.kernel.org/lkml/afffeb73-ba4c-ca2c-75d0-9e7899e5cbe1@hartkopp.net/

And did you try the partly revert?

Maybe there's a mismatch in include files - or BUILD_BUG_ON() generally 
does not work with unions on ARM as assumed here:

https://lore.kernel.org/lkml/6e57d5d2-9b88-aee6-fb7a-82e24144d179@hartkopp.net/

In both cases I can not really fix the issue.
When the partly revert (suggested above) works, this would be a hack too.

Best,
Oliver

On 20.03.21 21:43, kernel test robot wrote:
> Hi Oliver,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   812da4d39463a060738008a46cfc9f775e4bfcf6
> commit: c7b74967799b1af52b3045d69d4c26836b2d41de can: replace can_dlc as variable/element for payload length
> date:   4 months ago
> config: arm-randconfig-r016-20210321 (attached as .config)
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
>>> include/linux/compiler_types.h:315:38: error: call to '__compiletime_assert_536' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struct canfd_frame, data)
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
> vim +/__compiletime_assert_536 +315 include/linux/compiler_types.h
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
