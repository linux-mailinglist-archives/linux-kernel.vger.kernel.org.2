Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABF460655
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhK1NIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhK1NGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:06:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0FC061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:03:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4F560FD7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 13:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25823C53FC7;
        Sun, 28 Nov 2021 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638104597;
        bh=aYwVpeLfIXH6Mu/pJPAwzKqF8YSklMByMuPefZ9hCTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO475MLZnrrRDWzGsNhlXj4MV41Mg5+FAY0Yi9ZaCuU0mu5sHw2zMHKX/SOkZMj6S
         Hi4OWu04vvdCtjzjdHwBjgQCS/K7neFt+9ScTConwhvMb7sduqtcCmXKQqlij487kZ
         NOGKp4ojy2llM/Em96YzTX/RoWCatm8EycfFukMo=
Date:   Sun, 28 Nov 2021 14:03:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:linux-4.19.y 565/981]
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error:
 initializer element is not constant
Message-ID: <YaN+E5fuvU2VO+W5@kroah.com>
References: <202111271017.dLo8jJ8p-lkp@intel.com>
 <CAMo8BfL88Qc6o=WheT6+n4pOpXQbnw220UQa_GCQb98F=S9ffA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfL88Qc6o=WheT6+n4pOpXQbnw220UQa_GCQb98F=S9ffA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 07:10:56AM -0800, Max Filippov wrote:
> On Fri, Nov 26, 2021 at 6:33 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > head:   1f244a54b39dd02c69f79001b38e2650e96f1ea8
> > commit: 1c21a8df144f1edb3b6f5f24559825780c227a7d [565/981] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
> > config: xtensa-randconfig-r001-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271017.dLo8jJ8p-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1c21a8df144f1edb3b6f5f24559825780c227a7d
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc linux-4.19.y
> >         git checkout 1c21a8df144f1edb3b6f5f24559825780c227a7d
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from include/linux/kernel.h:10,
> >                     from arch/xtensa/platforms/xtfpga/setup.c:19:
> >    include/linux/dma-mapping.h: In function 'dma_map_resource':
> >    arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
> >      182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> >          |                ^~
> >    include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
> >       77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
> >          |                                             ^
> >    include/linux/dma-mapping.h:329:9: note: in expansion of macro 'BUG_ON'
> >      329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
> >          |         ^~~~~~
> >    include/linux/dma-mapping.h:329:16: note: in expansion of macro 'pfn_valid'
> >      329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
> >          |                ^~~~~~~~~
> >    In file included from arch/xtensa/platforms/xtfpga/setup.c:37:
> >    arch/xtensa/platforms/xtfpga/setup.c: At top level:
> > >> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error: initializer element is not constant
> >       50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
> >          |                                 ^
> 
> This happens because the backported change
> 1c21a8df144f1edb3b6f5f24559825780c227a7d depends on the change
> d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of CONFIG_OF")
> which is not in that stable tree.
> 
> Should I send the backported version of the d67ed2510d28 or should
> the change 1c21a8df144f1edb3b6f5f24559825780c227a7d be reverted
> from the stable? (IMO they are not the stable material).

I have queued up d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of
CONFIG_OF") to hopefully resolve this.

thanks,

greg k-h
