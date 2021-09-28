Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4841B427
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbhI1QpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhI1QpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FB661262;
        Tue, 28 Sep 2021 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632847415;
        bh=DhJjFTTFkazjP1XuwCae41RMyEElrP/mXzZaoteYjUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/RzLMhQRcyIEjAFhh0GhTf993U7L7630Owtw6N494O+uUDxaqiutCHMveFCeJuuS
         22pp3ILDAtbbmxJDALokVoZ94L3CVtvderAJsof2sfZaMtP0iL8ngG4Ecxlk2eNFFz
         W3bXjGbNlox6m/oPdQ6biFJYW7Xt6EVr6zr/eCxzK91kMqIjrCsJSrdglt4QfidLv3
         tk4mxVZ7f8I7G8m1f2cNuBHNKjZedSP3Knccax6eam6Qmjw1PVOj8Ip9uwRV//yzu0
         AEJRrDkv1B7+Z/15bFKbllxQ9FKkCNCVAoTYgJF6YuFqrgf0SDjBSXTatLTDZXAHGP
         j+lN6FzSUM3Ug==
Date:   Tue, 28 Sep 2021 09:43:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function
 'set_test_mode_src_osc_freq_target_low_bits'
Message-ID: <YVNGMg/TI+jo/1R1@archlinux-ax161>
References: <202109282205.VsHhj6PP-lkp@intel.com>
 <CAMuHMdX0Zm_hMheZ0e1Xu991jnUr=aY_cDBHHGFvQ1sKqM1b9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX0Zm_hMheZ0e1Xu991jnUr=aY_cDBHHGFvQ1sKqM1b9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Sep 28, 2021 at 05:39:19PM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 28, 2021 at 5:09 PM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0513e464f9007b70b96740271a948ca5ab6e7dd7
> > commit: ade896460e4a62f5e4a892a98d254937f6f5b64c drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
> > date:   11 months ago
> > config: mips-randconfig-r013-20210928 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ade896460e4a62f5e4a892a98d254937f6f5b64c
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ade896460e4a62f5e4a892a98d254937f6f5b64c
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/kmb/ drivers/net/ethernet/mellanox/mlxsw/ mm/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
> >    set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi
> >    ^
> > >> drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'
> >    set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi
> 
> These two functions are "static inline", so there should not be such
> warning. Toolchain issue?

No toolchain issue, Masahiro specifically made clang W=1 builds warns on
static inline unused functions because of instances like this, see
commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
functions for W=1 build").

Cheers,
Nathan
