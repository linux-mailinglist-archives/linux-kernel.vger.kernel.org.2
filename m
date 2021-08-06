Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C263E2890
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbhHFK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:29:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:44193 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245094AbhHFK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:29:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="194617369"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="194617369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="459325358"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2021 03:28:53 -0700
Date:   Fri, 6 Aug 2021 18:22:46 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: ERROR: modpost: "__raw_writesl"
 [drivers/i3c/master/i3c-master-cdns.ko] undefined!
Message-ID: <20210806102246.GB1330186@pl-dbox>
References: <202108041936.52T4sUU6-lkp@intel.com>
 <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 10:18:10AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 4, 2021 at 4:39 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Nathan,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d5ad8ec3cfb56a017de6a784835666475b4be349
> > commit: 6fef087d0d37ba7dba8f3d75566eb4c256cd6742 hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
> > date:   4 weeks ago
> > config: hexagon-randconfig-r023-20210804 (attached as .config)
> 
> cool, one of the first reports from 0day bot of hexagon :)
:-) yeah, we just enabled it. BTW: we use one specific version of clang,
does such hexagon support work in latest clang 14.0.0?

Thanks

> 
> > compiler: clang version 12.0.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6fef087d0d37ba7dba8f3d75566eb4c256cd6742
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 6fef087d0d37ba7dba8f3d75566eb4c256cd6742
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> > >> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
