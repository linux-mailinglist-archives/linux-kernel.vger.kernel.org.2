Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5435F6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350236AbhDNOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350092AbhDNOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:54:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25507C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:53:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso10988450pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ip7FnEIzFtr7p8LhnNS3bCrGwA7KpyX3f50D2+hQRk=;
        b=gtZb6s4HxoH+TUgAahCeZ054rf0hbt04JLoKZTQjEAXU6uZLlk0/RIO6WHHQQY75uO
         Wzp4YqXQZuNznGH9p1xmxYn3d7LSaT2Rkl1ZJFQSYjyb6PGWI/yKgrlYPH+oDrrB0WA8
         A6owOiJM3pRuPdNja/gkpIm7RFwP4J/3H/EYLHafEwIx8RIKNKAA8WwKzt/ZnAiJl4OF
         RI7ZwT3EmOy1r0xBZRcOvgegy5sbO1/dme42cBWxd5csyZ4glRbW7kMhjjeVX+n4pQlF
         /it7VI14+qRRgOAo+FBIjJ5Z8oZGwiw85x9bs7z71CxYEJwRHHhlurBmM5yxP0FywUjU
         KXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ip7FnEIzFtr7p8LhnNS3bCrGwA7KpyX3f50D2+hQRk=;
        b=in+PRlyZa/03ouhRusdlRF4HLdxRX0L34dP9Ree8zBTgCrCwq7cuP8aCydP2DoVqsd
         RqgJvzjKCCijmv5ThkdTnzyneb7k984KYF5IVDi2Hq1GVK/EZKrJi3czDnrRgqdPDdwA
         hoN+h7xqKWqvYgUvLrjah8/vfnCnO8DOr3vg42qbF2ZXyEJ+OPLCg7e3BjyUVqaBx6p0
         cJZkH/h3U1UfBuaHOstgMFxLh20qqdNW0SOhbVvnPhKWhnafc8UFFukg4x4oaCMY5VUG
         R2xseSj+ws/Z8IO7U6WSyCa5OOidF+YftYIdxgUw6mwDxy8ZoOnljjyQnEyKP8H9Vi9F
         wLKQ==
X-Gm-Message-State: AOAM533xYdMZHaqlwSfqI7a1qN8V75i7xoqIqCJxejrfwH/U07nAnk1f
        OVH59rgowbROgShnNlI5wkAVjvfpofzJvCeQ8YY=
X-Google-Smtp-Source: ABdhPJw+il/CAnZbCXJPG/BCOewahUZkix55LvxFQkdonRnWniAiXm9wfwAE0fqIjJo9kYDg7fVlWDXJSkDcrRDK7ew=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr37676239plq.17.1618412038566; Wed, 14
 Apr 2021 07:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <202104140604.hH9CHHBR-lkp@intel.com>
In-Reply-To: <202104140604.hH9CHHBR-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Apr 2021 17:53:42 +0300
Message-ID: <CAHp75VdRNGNscyONgVsMqw9F_DQ_noK5dE4d8mexq=4t_2xTXg@mail.gmail.com>
Subject: Re: drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:21 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eebe426d32e1a10ac7c35f8ffab5f818c32a2454
> commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
> date:   8 months ago
> config: alpha-randconfig-s032-20210414 (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-280-g2cd6d34e-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I believe after my patch series [1] at least part of this will be
gone. Can you confirm?

[1]: https://lore.kernel.org/netdev/20210325173412.82911-1-andriy.shevchenko@linux.intel.com/T/#u

> sparse warnings: (new ones prefixed by >>)
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2135:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2135:41: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2135:41: sparse:     got unsigned int [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] uid_hi @@     got restricted __be16 [usertype] @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:33: sparse:     expected unsigned short [usertype] uid_hi
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:33: sparse:     got restricted __be16 [usertype]
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] uid_lo @@     got restricted __be32 [usertype] @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:45: sparse:     expected unsigned int [usertype] uid_lo
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:45: sparse:     got restricted __be32 [usertype]
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:56: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] seqid @@     got restricted __be16 [usertype] @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:56: sparse:     expected unsigned short [usertype] seqid
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:157:56: sparse:     got restricted __be16 [usertype]
> >> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *reg @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26: sparse:     expected void const [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26: sparse:     got void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:336:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:336:33: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:336:33: sparse:     got unsigned int [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:343:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:343:33: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:343:33: sparse:     got unsigned int [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:356:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:356:33: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:356:33: sparse:     got unsigned int [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:397:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:397:33: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:397:33: sparse:     got unsigned int [noderef] __iomem *
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:466:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *reg @@     got unsigned int [noderef] __iomem * @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:466:41: sparse:     expected void *reg
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:466:41: sparse:     got unsigned int [noderef] __iomem *
>
> vim +306 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  294
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  295  /**
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  296   * pch_gbe_wait_clr_bit - Wait to clear a bit
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  297   * @reg: Pointer of register
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  298   * @busy:        Busy bit
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  299   */
> 191cc687740834 drivers/net/pch_gbe/pch_gbe_main.c                   stephen hemminger 2010-10-15  300  static void pch_gbe_wait_clr_bit(void *reg, u32 bit)
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  301  {
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  302   u32 tmp;
> 453ca931f51516 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Andy Shevchenko   2013-06-28  303
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  304   /* wait busy */
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  305   tmp = 1000;
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21 @306   while ((ioread32(reg) & bit) && --tmp)
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  307           cpu_relax();
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  308   if (!tmp)
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  309           pr_err("Error: busy bit is not cleared\n");
> 77555ee7228234 drivers/net/pch_gbe/pch_gbe_main.c                   Masayuki Ohtake   2010-09-21  310  }
> 124d770a6459be drivers/net/pch_gbe/pch_gbe_main.c                   Toshiharu Okada   2011-09-01  311
>
> :::::: The code at line 306 was first introduced by commit
> :::::: 77555ee7228234257957fd54daa0b69178906320 net: Add Gigabit Ethernet driver of Topcliff PCH
>
> :::::: TO: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko
