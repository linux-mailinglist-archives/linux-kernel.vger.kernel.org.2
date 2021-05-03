Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D073723A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhECXkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhECXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:40:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBC8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 16:39:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e12so6624355ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDlO7ibgMo5jEq/lW7jtotFKHZ7j7yAL2L7qDy7Fdbo=;
        b=Wt9n90oYSUF5NHi67F91Xj0zDo/GUp8rJ7409g5+I2uWuT2o8+PZJZycTrxMiERafP
         YXUUVq6IQ92p4i1MEtzLmfTtz/L291JeLe0N1pxSjqBa1umCX8NtiL5x6o8VHGkb7s/U
         ZYb7VlesyuiVxFyMrfbM65Cj0O8UspfBOfgbmqo2N8ytDpSd00qOKpAInnSCJ88Piiio
         h6bMgiT2ASzioDtwB+Lwty4hYsgzxIArEKCadx7l7bGTvcEHiceTgizTwMXCy+hDkn8N
         gJW47lhQhYUrPu+PRyfTViAFE0Mzydc6DwJ0w5sXrk5VhWMTbvTrkjdVZYZtCKFFwDWq
         qONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDlO7ibgMo5jEq/lW7jtotFKHZ7j7yAL2L7qDy7Fdbo=;
        b=udmgzIJJHGzzUkJE/xZ9RengJ/ESrmpLss5mGYZQD+z/nPXSoVhqFnI/vdxMadDv29
         iAmpHfmHRKiX4CIRJXYFAxYKToAuZ+CrVEb8z7qtSiyvXdl4C5WpY+6AKJN9psMrbMD6
         8XjI0F6RxQwaklxZrc05cnlz0HCkRvOWVII+/+nhD0RGPnG+ut+OjmYBo56wp9r6TbZB
         jETmP2CZMs/dTpoNv1gW9LVmkpoMaNFzAGf9Uh8gf31opUpdGzoItnkTSVV+/DqN+oHJ
         TLsvWbJgYhg94AjpZyluktI9nI27D+m6ApfzPTs+xoA/910UK3nDflwS+ZS9izcEq7KG
         GWEw==
X-Gm-Message-State: AOAM533tLjUT01BZTGuC3B7rD102V8VMaHh8D2zCnKRmlmag/x6Z+HNX
        FmpKjfg4YddvZxWqLeYtajPq2mg8E/eLBc9KwZ3S2w==
X-Google-Smtp-Source: ABdhPJzxe+WUAghjw+nXgPOLoq7fr6fJm5tkqCNIsvo5fMaMZUD/P5FSMsVgmoYzOiJwhIuFMvXHqyWTpyuUD6lu0/U=
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr7161879ljk.244.1620085165144;
 Mon, 03 May 2021 16:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <202105030653.cyQpw8yD-lkp@intel.com> <CAHp75Vd9kXo7=g35x_AosWBHJH0KBVeX4qgkpbTz31m3w3s3gA@mail.gmail.com>
 <CAKwvOdmg80badHYBv1T4PKgEpgWSBtU0YewfLLS1X3QWCA_FyA@mail.gmail.com>
In-Reply-To: <CAKwvOdmg80badHYBv1T4PKgEpgWSBtU0YewfLLS1X3QWCA_FyA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 May 2021 16:39:13 -0700
Message-ID: <CAKwvOd=2vLrjzDnqeqA39BX-Wd+dn+UKPhRvzCjYR0js44y6BQ@mail.gmail.com>
Subject: Re: drivers/gpio/gpio-dwapb.c:678:12: warning: stack frame size of
 2064 bytes in function 'dwapb_gpio_probe'
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Luo Jiaxing <luojiaxing@huawei.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 1:49 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, May 3, 2021 at 1:40 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, May 3, 2021 at 1:54 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   27787ba3fa4904422b3928b898d1bd3d74d98bea
> > > commit: 60593df667e087b009ee0fc20d92e9c4c096a9b5 gpio: dwapb: fix NULL pointer dereference at dwapb_gpio_suspend()
> > > date:   5 months ago
> > > config: powerpc64-randconfig-r026-20210430 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install powerpc64 cross compiling tool for clang build
> > >         # apt-get install binutils-powerpc64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60593df667e087b009ee0fc20d92e9c4c096a9b5
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 60593df667e087b009ee0fc20d92e9c4c096a9b5
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/gpio/gpio-dwapb.c:678:12: warning: stack frame size of 2064 bytes in function 'dwapb_gpio_probe' [-Wframe-larger-than=]
> > >    static int dwapb_gpio_probe(struct platform_device *pdev)
> > >               ^
> > >    1 warning generated.
> >
> > Another Clang bug?
>
> We have a KI with ASAN's requirements on additional stack usage for
> shadow stacks not being considered when making decisions whether or
> not to inline. Looks like KASAN isn't enabled by this randconfig;
> UBSAN is.  I don't know if UBSAN has similar additional stack usage to
> KASAN.
>
> I can reproduce this warning on mainline with:
> $ wget https://groups.google.com/group/clang-built-linux/attach/983d2ad77c1d/.config.gz\?part\=0.1
> -O - | gunzip > .config
> $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j72
> drivers/gpio/gpio-dwapb.o
>
> If I enable CONFIG_DEBUG_INFO, then rebuild, I have a utility for
> helping track these down from parsing the DWARF debug info.
> Unfortunately, it depends on pyelftools which doesn't know any ppc64
> relocations; let me see if I can implement that real quick, which
> should help debug this further.

https://github.com/eliben/pyelftools/pull/360
-- 
Thanks,
~Nick Desaulniers
