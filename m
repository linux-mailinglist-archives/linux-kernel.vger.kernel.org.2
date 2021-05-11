Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812A137A884
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhEKOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:08:29 -0400
Received: from foss.arm.com ([217.140.110.172]:48490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhEKOI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:08:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D0E101E;
        Tue, 11 May 2021 07:07:19 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251A53F718;
        Tue, 11 May 2021 07:07:18 -0700 (PDT)
Date:   Tue, 11 May 2021 15:07:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        khilman@kernel.org, robherring2@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: arm-linux-gnueabi-ld: warning: orphan section
 `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being
 placed in section `__cpuidle_method_of_table'
Message-ID: <20210511140712.GA24463@lpieralisi>
References: <202105010813.KwuE0a5t-lkp@intel.com>
 <CAKwvOdnQ+hiGxfsG5VeJO4qGqfRPvf=Mp7TRgjKzZnTspZjntA@mail.gmail.com>
 <CAKwvOd=0_KbumyVLS2dn2DiKes50oG3te4Cd4aTAxnc5moERuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=0_KbumyVLS2dn2DiKes50oG3te4Cd4aTAxnc5moERuw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 12:09:46PM -0700, Nick Desaulniers wrote:
> + folks from commit 449e056c76cc ("ARM: cpuidle: Add a cpuidle ops
> structure to be used for DT")

Hi Nick,

I thought this patch was meant to be merged upstream to fix it:

https://lore.kernel.org/linux-arm-kernel/20201230155506.1085689-1-arnd@kernel.org

I can add a review tag to it but I don't think that's necessary, just
let me know please.

Thanks,
Lorenzo

> On Thu, May 6, 2021 at 12:05 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 5:11 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Kees,
> > >
> > > FYI, the error/warning still remains.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   65ec0a7d24913b146cd1500d759b8c340319d55e
> > > commit: 5a17850e251a55bba6d65aefbfeacfa9888cd2cd arm/build: Warn on orphan section placement
> > > date:   8 months ago
> > > config: arm-randconfig-r024-20210501 (attached as .config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> >
> > Filed: https://github.com/ClangBuiltLinux/linux/issues/1372 (though
> > this isn't specific to clang).
> > --
> > Thanks,
> > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
