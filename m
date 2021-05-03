Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890F9372205
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhECUui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhECUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:50:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C123DC061348
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 13:49:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so10071792lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcPLLdxhGeawr/klKlG9sXo/Lmp0oTZkiVZ65hpVpF4=;
        b=nEIWZsBjPcM11OR+W0hRIaAYJQ1gb7Q8bkRXLvnTwV+7o8+vLEEyijEIcqt+tpZ+aI
         Y1ZvP24l2wAzIZqzYTPRLF4MYbtZ+ECYW6BZW8YJ2/iEKr94wZLWrNPR4Obih2UY75sC
         VGJFmDlmvhG00xszyrs4ei+8VH9Gq1aF1Qfbo5g5vb9nju8JfiaX2ALw3Isu/ANToARl
         pJW+rRs3dUruvXEvBcHJX3s7zPvUszsGLG1+W7MNYsDcW8fgwPDg6AlIDuda+zcTMAeJ
         ZXBQki6d6Kqz/NkR43B2QOEH5jDVHAy8YFOTnd0X+mvqk3bL4JvjLs/CZu+bYsKlReI0
         dPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcPLLdxhGeawr/klKlG9sXo/Lmp0oTZkiVZ65hpVpF4=;
        b=K4M30RsTEnplDerYJRkhKM2i1gwgI0PBQe3jL7yqq3woI6mbrCBbhI9zt6cpiZbmIn
         /VdPH1sxPJo3lJhvtK0BGRGXHBMCy2plVTN+mfOVCvDe/gHpwGChcYeJKAL0Vnvh7bAS
         xnYHZRN4kM9Sv9NW2c6ZvXkotWti0tIeoHWVXsx+bUb71haghTGA1OZYgopquon0TRp2
         7B+6ca9Lyw+Zx6K0xYg9N+wIZuE1U7x1qmeodCxmDMyhP1ucfY8k7jaT/VR9iqXELvhb
         ENBGMyxxPTVFc+EacRXE+pxHznwaKOPYNIiiYLY8FgH8Aq4FraejlgirYxunA+8ohWl+
         QSDg==
X-Gm-Message-State: AOAM53379NYfFmINHJyLNC1hKqkjxUcqnt5/Y7cXvj+QAhQtPiuoQQ9C
        YGh2MV+DkeiIkEn604fNTA4NACgG0DmbBeVQPXtpwg==
X-Google-Smtp-Source: ABdhPJwatPAcagxt9a41AcOAdplhlvUiMDRzgSee46Kc3QHbplzh1acvf6FTFnu2fCg3xA8qC3nmWQqQ8olaTNQenOI=
X-Received: by 2002:ac2:54b6:: with SMTP id w22mr10662206lfk.543.1620074975883;
 Mon, 03 May 2021 13:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <202105030653.cyQpw8yD-lkp@intel.com> <CAHp75Vd9kXo7=g35x_AosWBHJH0KBVeX4qgkpbTz31m3w3s3gA@mail.gmail.com>
In-Reply-To: <CAHp75Vd9kXo7=g35x_AosWBHJH0KBVeX4qgkpbTz31m3w3s3gA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 May 2021 13:49:24 -0700
Message-ID: <CAKwvOdmg80badHYBv1T4PKgEpgWSBtU0YewfLLS1X3QWCA_FyA@mail.gmail.com>
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

On Mon, May 3, 2021 at 1:40 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, May 3, 2021 at 1:54 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   27787ba3fa4904422b3928b898d1bd3d74d98bea
> > commit: 60593df667e087b009ee0fc20d92e9c4c096a9b5 gpio: dwapb: fix NULL pointer dereference at dwapb_gpio_suspend()
> > date:   5 months ago
> > config: powerpc64-randconfig-r026-20210430 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install powerpc64 cross compiling tool for clang build
> >         # apt-get install binutils-powerpc64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60593df667e087b009ee0fc20d92e9c4c096a9b5
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 60593df667e087b009ee0fc20d92e9c4c096a9b5
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/gpio/gpio-dwapb.c:678:12: warning: stack frame size of 2064 bytes in function 'dwapb_gpio_probe' [-Wframe-larger-than=]
> >    static int dwapb_gpio_probe(struct platform_device *pdev)
> >               ^
> >    1 warning generated.
>
> Another Clang bug?

We have a KI with ASAN's requirements on additional stack usage for
shadow stacks not being considered when making decisions whether or
not to inline. Looks like KASAN isn't enabled by this randconfig;
UBSAN is.  I don't know if UBSAN has similar additional stack usage to
KASAN.

I can reproduce this warning on mainline with:
$ wget https://groups.google.com/group/clang-built-linux/attach/983d2ad77c1d/.config.gz\?part\=0.1
-O - | gunzip > .config
$ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j72
drivers/gpio/gpio-dwapb.o

If I enable CONFIG_DEBUG_INFO, then rebuild, I have a utility for
helping track these down from parsing the DWARF debug info.
Unfortunately, it depends on pyelftools which doesn't know any ppc64
relocations; let me see if I can implement that real quick, which
should help debug this futher.

>
> > vim +/dwapb_gpio_probe +678 drivers/gpio/gpio-dwapb.c
> >
> > a72b8c4a63e2a3 Hoan Tran                        2017-02-21  677
> > 7779b34556978f Jamie Iles                       2014-02-25 @678  static int dwapb_gpio_probe(struct platform_device *pdev)
> > 7779b34556978f Jamie Iles                       2014-02-25  679  {
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  680         unsigned int i;
> > 7779b34556978f Jamie Iles                       2014-02-25  681         struct dwapb_gpio *gpio;
> > 7779b34556978f Jamie Iles                       2014-02-25  682         int err;
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  683         struct device *dev = &pdev->dev;
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  684         struct dwapb_platform_data *pdata = dev_get_platdata(dev);
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  685
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  686         if (!pdata) {
> > 4ba8cfa79f44a9 Jiang Qiu                        2016-04-28  687                 pdata = dwapb_gpio_get_pdata(dev);
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  688                 if (IS_ERR(pdata))
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  689                         return PTR_ERR(pdata);
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  690         }
> > 7779b34556978f Jamie Iles                       2014-02-25  691
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  692         if (!pdata->nports)
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  693                 return -ENODEV;
> > 7779b34556978f Jamie Iles                       2014-02-25  694
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  695         gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  696         if (!gpio)
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  697                 return -ENOMEM;
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  698
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  699         gpio->dev = &pdev->dev;
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  700         gpio->nr_ports = pdata->nports;
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  701
> > 4731d80f5ea9b8 Serge Semin                      2020-07-30  702         err = dwapb_get_reset(gpio);
> > 4731d80f5ea9b8 Serge Semin                      2020-07-30  703         if (err)
> > 4731d80f5ea9b8 Serge Semin                      2020-07-30  704                 return err;
> > 07901a94f9f9b1 Alan Tull                        2017-10-11  705
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  706         gpio->ports = devm_kcalloc(&pdev->dev, gpio->nr_ports,
> > 7779b34556978f Jamie Iles                       2014-02-25  707                                    sizeof(*gpio->ports), GFP_KERNEL);
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  708         if (!gpio->ports)
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  709                 return -ENOMEM;
> > 7779b34556978f Jamie Iles                       2014-02-25  710
> > 2a7194e9759586 Enrico Weigelt, metux IT consult 2019-03-11  711         gpio->regs = devm_platform_ioremap_resource(pdev, 0);
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  712         if (IS_ERR(gpio->regs))
> > da9df93e9e0fd1 Axel Lin                         2014-12-28  713                 return PTR_ERR(gpio->regs);
> > 7779b34556978f Jamie Iles                       2014-02-25  714
> > daa3f58d180c07 Serge Semin                      2020-07-30  715         err = dwapb_get_clks(gpio);
> > daa3f58d180c07 Serge Semin                      2020-07-30  716         if (err)
> > e6bf37736f6495 Phil Edworthy                    2018-03-12  717                 return err;
> > e6bf37736f6495 Phil Edworthy                    2018-03-12  718
> > 9826bbe1fef0b5 Andy Shevchenko                  2020-04-15  719         gpio->flags = (uintptr_t)device_get_match_data(dev);
> > a72b8c4a63e2a3 Hoan Tran                        2017-02-21  720
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  721         for (i = 0; i < gpio->nr_ports; i++) {
> > 3d2613c4289ff2 Weike Chen                       2014-09-17  722                 err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);
> > 7779b34556978f Jamie Iles                       2014-02-25  723                 if (err)
> > 7779b34556978f Jamie Iles                       2014-02-25  724                         return err;
> > 7779b34556978f Jamie Iles                       2014-02-25  725         }
> > 7779b34556978f Jamie Iles                       2014-02-25  726
> > 60593df667e087 Luo Jiaxing                      2020-11-27  727         platform_set_drvdata(pdev, gpio);
> > 60593df667e087 Luo Jiaxing                      2020-11-27  728
> > 7779b34556978f Jamie Iles                       2014-02-25  729         return 0;
> > 7779b34556978f Jamie Iles                       2014-02-25  730  }
> > 7779b34556978f Jamie Iles                       2014-02-25  731
> >
> > :::::: The code at line 678 was first introduced by commit
> > :::::: 7779b34556978f6771a78bd87557523623e0405b gpio: add a driver for the Synopsys DesignWare APB GPIO block
> >
> > :::::: TO: Jamie Iles <jamie@jamieiles.com>
> > :::::: CC: Linus Walleij <linus.walleij@linaro.org>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAHp75Vd9kXo7%3Dg35x_AosWBHJH0KBVeX4qgkpbTz31m3w3s3gA%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
