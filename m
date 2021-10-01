Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA841F721
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355553AbhJAVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhJAVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:54:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E92C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:52:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g6so6296997ybb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUylDIFdqokzCQr3QgCrf8/eFiZ45GiE2mI3tefbDeQ=;
        b=ZJbXVtrVx1+vhc7mBd0qN5Xd5q6LK7Vcw2ejOLJuYeHZkg8Uf9NmaiFk+kSOmregLl
         RwXVFN1UPzojCkQ+NsGn1pVsapfHU7z+CMAOyJIHR4CCIyjaF4Sr6gNmRdkQzHDZrF3i
         kOaecF61AgI5DpOMWZAHeE/AaoI9OaXWFL/VO9+KYou19aiJEVqMpDeMPTFTQVXzLDQX
         xlfww7Rwzxks7/bY/YarJsTKJj2/q+d5Iyldlvh9nGLz2nYsKlGwPIy3PZMlF39Okvf3
         z1KWTlj5yLIiAdz65eijOShGudzElUmtq8pVVyp2gE/VweYdutDf2cL5YIost+wyVtn0
         mQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUylDIFdqokzCQr3QgCrf8/eFiZ45GiE2mI3tefbDeQ=;
        b=5fwLsRaLLS20qDG9mVG5fNzhMnm4hLbfFHWEHnidpk+LeyiMiG+2FSSkRU6eN4E96e
         gI1UYbP2DmUyKjkMIZaobOf/lTIYCS1zEZND8cxrIxS94YmIO93NOVhCAI6hRcb2Ijai
         CVdH8f3sqQhm2m7tJqUAjZsENv+tArgEv2r78U8DLP/IK7azHTrlzcwzYN5Dsw/D8GVi
         nB5CH5Hnk8Pz4jldAElx1/Ul5yRWG8UpcRVPh0PhCwpXcqRsRe4i3eiY6Pf/ru7nBelv
         4j+FtybvKcEzQ0j8w8xS2r9C1MMXjkq5DYJDyAM3yw6Zo6v+0ewtFu6kMKGpjACo1LUd
         yWSQ==
X-Gm-Message-State: AOAM533hdPeILo3S2Q2nZHVbnt5CkByGmd4G7GOfM80C4+82Bc19/gHG
        9yBfDKgHkN4mHLG7WjQEC9RxRjHkTrziKLCOPkUTyQ==
X-Google-Smtp-Source: ABdhPJyohC349WYU3R2zBwR9Bnq2k+HBcT3yiniMni8C00NhTk/xBO89G0OaBzslokDNt81Qp6UdKI2GORSUNo/tMIo=
X-Received: by 2002:a25:7307:: with SMTP id o7mr194738ybc.291.1633125167093;
 Fri, 01 Oct 2021 14:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211001174947.135123-1-eric.dumazet@gmail.com> <202110020437.tn6NOlcO-lkp@intel.com>
In-Reply-To: <202110020437.tn6NOlcO-lkp@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Oct 2021 14:52:35 -0700
Message-ID: <CANn89iKP5D2CvVg28-FmPsJ7U9uLuBy-UtunS=arhKSwf0H=gg@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING
 | MPOL_LOCAL in mbind()
To:     kernel test robot <lkp@intel.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 1:25 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Eric,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on hnaz-mm/master]
>
> url:    https://github.com/0day-ci/linux/commits/Eric-Dumazet/mm-mempolicy-do-not-allow-illegal-MPOL_F_NUMA_BALANCING-MPOL_LOCAL-in-mbind/20211002-015054
> base:   https://github.com/hnaz/linux-mm master
> config: ia64-defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/fe87354835a4bf5cad6d885f0ba558c767fee6f1
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Eric-Dumazet/mm-mempolicy-do-not-allow-illegal-MPOL_F_NUMA_BALANCING-MPOL_LOCAL-in-mbind/20211002-015054
>         git checkout fe87354835a4bf5cad6d885f0ba558c767fee6f1
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    mm/mempolicy.c: In function 'sanitize_mpol_flags':
> >> mm/mempolicy.c:1452:26: warning: comparison between pointer and integer
>     1452 |                 if (mode != MPOL_BIND)
>          |                          ^~

Oh well, last minute changes, and indeed my compiler warned me while I
was away :/

mm/mempolicy.c:1452:12: warning: comparison between pointer and
integer ('int *' and 'int') [-Wpointer-integer-compare]
                if (mode != MPOL_BIND)
                    ~~~~ ^  ~~~~~~~~~

I am sending a v2, thanks.

>
>
> vim +1452 mm/mempolicy.c
>
>   1440
>   1441  /* Basic parameter sanity check used by both mbind() and set_mempolicy() */
>   1442  static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>   1443  {
>   1444          *flags = *mode & MPOL_MODE_FLAGS;
>   1445          *mode &= ~MPOL_MODE_FLAGS;
>   1446
>   1447          if ((unsigned int)(*mode) >=  MPOL_MAX)
>   1448                  return -EINVAL;
>   1449          if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>   1450                  return -EINVAL;
>   1451          if (*flags & MPOL_F_NUMA_BALANCING) {
> > 1452                  if (mode != MPOL_BIND)
>   1453                          return -EINVAL;
>   1454                  *flags |= (MPOL_F_MOF | MPOL_F_MORON);
>   1455          }
>   1456          return 0;
>   1457  }
>   1458
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
