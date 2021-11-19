Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26F457557
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhKSRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236210AbhKSRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:23:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8635161A62;
        Fri, 19 Nov 2021 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637342439;
        bh=i0Y6VeAiAsytmvyrSJfjhoI0lF6Nb+gt32xiPfawQOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESAp7LAj58Rovc6ej0RoMsfAKteE+JFSiDRvqMst0ULOmILXlW47aKTqEPTtKU6ax
         wRkKd5kGnRd885ck1Q4jkYW2RZkCpttCs9tuPubUdU+zyFjue7d+CGp3kEgZU1GTrf
         3epuY5yhRtWZvGXF9HIqU4+6ANBn5ULOoTcyY98QFE1lyMdUc412oT6wrk6ZTPTy0g
         h3SBgE233ywAhsEcIfvWddrhVyjnr0WWXy77CIGFXo1lW7WpjcPfbJRKi71UfDjavJ
         /0Z0nn69yW3OPnurIPndLt5d9tXscN3xohjW6hFwqLIFVyoqKGgOaDWciyn4+rybtO
         vTTZXg67b4lWg==
Date:   Fri, 19 Nov 2021 10:20:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [pinctrl-intel:review-andy 18/19]
 drivers/pinctrl/pinctrl-zynqmp.c:825:13: warning: variable 'pin' is
 uninitialized when used here
Message-ID: <YZfc4wmvcQW9Kpcz@archlinux-ax161>
References: <202111191618.SSj1gGvK-lkp@intel.com>
 <YZdhYEVCgqh5MB3J@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZdhYEVCgqh5MB3J@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:33:36AM +0200, Andy Shevchenko wrote:
> On Fri, Nov 19, 2021 at 04:08:32PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git review-andy
> > head:   c25441ca551164c56b34885df3d657e2ea4d623f
> > commit: 9122cda6a325f80564f02b7899cc063009f5e1f9 [18/19] pinctrl: zynqmp: Unify pin naming
> > config: arm64-buildonly-randconfig-r004-20211118 (attached as .config)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git/commit/?id=9122cda6a325f80564f02b7899cc063009f5e1f9
> >         git remote add pinctrl-intel https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git
> >         git fetch --no-tags pinctrl-intel review-andy
> >         git checkout 9122cda6a325f80564f02b7899cc063009f5e1f9
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/pinctrl/pinctrl-zynqmp.c:825:13: warning: variable 'pin' is uninitialized when used here [-Wuninitialized]
> >            if (IS_ERR(pin->name))
> >                       ^~~
> >    drivers/pinctrl/pinctrl-zynqmp.c:811:37: note: initialize the variable 'pin' to silence this warning
> >            struct pinctrl_pin_desc *pins, *pin;
> >                                               ^
> >                                                = NULL
> >    1 warning generated.
> 
> Utterly inappropriate suggestion by the compiler (it found an actual error,
> though).
> 
> Can be Clang fixed, really?

I reported this upstream: https://bugs.llvm.org/show_bug.cgi?id=52559

Cheers,
Nathan
