Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBC3E9EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhHLGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHLGlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:41:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44AC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:40:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso6223620wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K41j9DktzdPkzZcW4NynOEKUrMsYRmyYnRWzSkHUVqU=;
        b=BZR2HXeM/4OF9XwjtXbnFAq4p4tzJgIiiuo2QtCBlHh2W7k1/Ns/Lr3xn4sV6P1itN
         o1/lGkA2GIcXXJIEhoQqwYdfDEw3Gv2FcKvjs+n1spGG6Fggnke/CN3t0ikCcbaIScEw
         YyWKso+fbm3wX3ECf5tZLvOrhh5zk2Eo/80RebKPxU/X/48pUeI1OSctARmIXiaFYauc
         dB1wuYx5JIQuNgNp6bKkzBTzZoEa5OG4ofE1CVIAQMiEPVtdCw8hBuGX4aq2vJTtbDSp
         JZ6VDed9GFA2a6IVn6ailSjnBc4TSNSWbFbtC+/Nwql6u0ErkUGje5j3X76aPmZwuAsJ
         eTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K41j9DktzdPkzZcW4NynOEKUrMsYRmyYnRWzSkHUVqU=;
        b=CLJLXtdESUzUXfvfU9VRgrBHwplalDkZdxrQwGwyieKhkQ/Qtgh2G4o+i7kkQRSMg1
         mm7+RG76Jk1akQnhRs73chA5YG+e2kJIh9G4U8mwGB6Q1r0mWCb4qrq1Lm+obzF2oCGS
         dPwD12wMflg8BKvOm8kl44p+gVWByBXbZXbD0DGspi9pHY2jpCk1fmS9bboWU2pzPqx6
         WY2mOhIl6sf7XN2ohsQJTVU3/BNL0NO7BGJmr7OXfFwV0Afwq1zZiWT1whmVls8MNZ62
         AfVrqX0ne6dTdXY8wuDA5M1VRDqooSy0aFsNC14ahImk+Ty7wv4Ig6aQNasxfdMWEUvm
         bClA==
X-Gm-Message-State: AOAM530Lo/Ni4a047g2ixURhxVTNy4zB45AYyrCrq+9spiSkrm3MqmG2
        3m+/8bKCLnJcsYRJbMBFITzqABSGSsQO2AcHOes=
X-Google-Smtp-Source: ABdhPJyoTvAq1oeHwSVJxr1FsguqOrH9G7PJDq3pl+utMSHcVhjPExw5pZV+4jhVq01zQfFcjkwz01Iq1Y8PyraQn2g=
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr2232936wms.97.1628750434144;
 Wed, 11 Aug 2021 23:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210715065455.392923-2-zhang.lyra@gmail.com> <202108011431.Nx7sS0uY-lkp@intel.com>
In-Reply-To: <202108011431.Nx7sS0uY-lkp@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 12 Aug 2021 14:39:57 +0800
Message-ID: <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init markings
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 at 14:18, kernel test robot <lkp@intel.com> wrote:
>
> Hi Chunyan,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on linux/master linus/master v5.14-rc3 next-20210730]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/Add-module-build-support-for-timer-driver/20210715-145711
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
> config: s390-buildonly-randconfig-r003-20210728 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c49df15c278857adecd12db6bb1cdc96885f7079)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://github.com/0day-ci/linux/commit/8e3c2c4da32affdbca933979110050e564351c84
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Chunyan-Zhang/Add-module-build-support-for-timer-driver/20210715-145711
>         git checkout 8e3c2c4da32affdbca933979110050e564351c84
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_attach':
>    main.c:(.text+0x21a): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: main.c:(.text+0x270): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
>    main.c:(.text+0x478): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: main.c:(.text+0x4d4): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
>    main.c:(.text+0x70c): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: main.c:(.text+0x83e): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: main.c:(.text+0x8b6): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: main.c:(.text+0x93a): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>    xillybus_of.c:(.text+0x9a): undefined reference to `devm_platform_ioremap_resource'
>    s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
>    arc-rimi.c:(.text+0x5c): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: arc-rimi.c:(.text+0xc2): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
>    arc-rimi.c:(.exit.text+0x44): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
>    arc-rimi.c:(.init.text+0x37c): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x3c8): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x614): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x674): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x6de): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_probe':
>    fmvj18x_cs.c:(.text+0x756): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x788): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x7e0): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_detach':
>    fmvj18x_cs.c:(.text+0xce0): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
>    fmvj18x_cs.c:(.text+0x27d4): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x2940): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
>    cistpl.c:(.text+0x9c): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
>    cistpl.c:(.text+0x46c): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0x4a8): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0x4e6): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0x4f8): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: drivers/crypto/ccree/cc_driver.o: in function `ccree_probe':
>    cc_driver.c:(.text+0x5a8): undefined reference to `devm_ioremap_resource'
>    s390x-linux-gnu-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
>    cc_debugfs.c:(.text+0xac): undefined reference to `debugfs_create_regset32'
>    s390x-linux-gnu-ld: cc_debugfs.c:(.text+0x190): undefined reference to `debugfs_create_regset32'
>    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>    timer-of.c:(.text+0x104): undefined reference to `of_iomap'
> >> s390x-linux-gnu-ld: timer-of.c:(.text+0x306): undefined reference to `iounmap'

Seems TIMER_OF should depend on HAS_IOMEM, but this error is not
related with changes in the above patch?


>    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
>    timer-of.c:(.text+0x5f2): undefined reference to `iounmap'
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
