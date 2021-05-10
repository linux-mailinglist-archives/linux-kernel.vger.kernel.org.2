Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23A2379141
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhEJOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbhEJOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:48:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF857C0611F0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:03:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m124so13330758pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdSORtAfUIV+iX7fRj6W8/weTOPW870A7GgAibxGeIM=;
        b=DVCJtZs5JHiZvx5Eo04ZIV8NCwsBgcXsVhZvoQcHbcNgTfh99mqZ6ID4eJS5kxYq/R
         fS3cXw0+ea2IRDAUlfEEU51zyGqdL+zx4TqwYwjaCW2bpDmLR5t5OPrkSmxoVxKmvxk3
         rzTjZoW9MjIIp2HYbwiW2A4R8cMJYhQCbYAfFnhGvMpgQoQuOJUXXfFoAQaBzJKZlVB1
         w3EVmrj3OAlHDU0fgDKfvkgMK/fOIuLJ6KcvFh2VPrjda9S6BepPvhp2pkWkdDJM96Xq
         HIEsUIgblY7FOTPlrQrxdOrgtouAAV/3srinIEEikjfn+iqBIFMi9H8N4ODwOVjPc/Dx
         +O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdSORtAfUIV+iX7fRj6W8/weTOPW870A7GgAibxGeIM=;
        b=jsTYUayQSVtPyqOUnL+pGC8hDKWPftME7DA9HFX4J6Aoeec99K8HjPR4cpib7VQMVc
         REj4yWRvqeCzc+zqsS2HAeJO7y7/wHp0Yz+dDxxgyoZskd6r6He/NKXu6xNJ1KCRwiNS
         1MzsMfQGx2uFyHBuvY7uhpfMUH6M4mKBpwakEvj3vQSB03jYeWcvE32B3M7ep9GAEmgE
         FYfaT/Lczzd53yBfBxes81O/b1pQFogj/Tg1F5a5HnpGgYdUI+nOmtccwwr+3MQl0XKL
         M5KE3VQgFvsOg3QSQM3hM1Rtvj7LZQe6Jn6NYN/ITH1tZESNbx1nrQhmPl2zqqImkcp3
         jMbg==
X-Gm-Message-State: AOAM533gr7w9FX4fO46f0XqLmUJ6vFRL2dlU/xvIMHurM7AXKNdo4U2y
        u5/oDnyWO+2itO12AoaBiDzwi7nJ8MPXz0i9D5o=
X-Google-Smtp-Source: ABdhPJw1IZ/mGWqMpJ20qJVhgD7MsEuGTAXDrHNr09OeF8WNh9ISOaimZyiFUrxDQl1AIK2XKFRStC8FLOYBT832rEM=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr21921333pgc.203.1620655430348;
 Mon, 10 May 2021 07:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <202105102120.WFbgbP3I-lkp@intel.com>
In-Reply-To: <202105102120.WFbgbP3I-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 May 2021 17:03:34 +0300
Message-ID: <CAHp75Ve556kxeqMQAOePTK8jt7--zRiqJHUi5-A=wWgcajAXMQ@mail.gmail.com>
Subject: Re: drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 4:31 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6efb943b8616ec53a5e444193dccf1af9ad627b5
> commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
> date:   5 months ago
> config: powerpc-randconfig-s032-20210510 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Okay, I will rebase on top of v5.13-rc1 my patch series and will add
the above line to certain patches in it.

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
> >> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *reg @@
>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:306:26: sparse:     expected void const volatile [noderef] __iomem *addr
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
> d0ea5cbdc286de drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c Jesse Brandeburg  2020-09-25  298   * @bit: Busy bit
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
