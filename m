Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7719E371283
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhECIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:41:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:40:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d10so3120486pgf.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnyqlZ5VnQEt4D3zjxmJ8HRBvB4VqfbCtVVXI1GLz4o=;
        b=rliVb5NpJqGYUZJOv8y5jWm3xKBgFLmptItoZjbkxBRL+g5vjrr7MOgv50FEgPhSov
         z6bnqVnS7urzNvTRkA71bqIm3xYeLkakZB/Vc4O6kHvk3I2XS8K7u9XC3zahiZvxCHT7
         ZxB+CTCKcSKa83POu524QxVCFh8qmjTEkAzOaZhyfrYhGaMTTRm1FHEbqxxKb00Aq76q
         9yYySExhjKmwSkX0llG4CwybeHq+U9LMU+FYtpE6oHAjysLXNaqjvfPglx5uKSUvdlBO
         wlpC6cFbfqNAM4VNmT3VPYduezV14qPIfiuctFmt0ej7bg8n4/vIPZwPo7aIU+YR+uS+
         doAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnyqlZ5VnQEt4D3zjxmJ8HRBvB4VqfbCtVVXI1GLz4o=;
        b=NlYSupy4V4MbmVo2vM0QM33jl+ZtGsD4yhCWpZdOwlwbCtK3N7K8baBCBj0mfuRU9k
         IX35eNBs37IKLGCazbYrFtFB27jQamMamBat8BC2pNtmDZftugdcZ8zNQsmFy9p4Ll4O
         W71WEu4W2nQT93dweoP1HuIk+pq+m6qPA0wB1D0L0WGGBqMFDwe3h3yoHZCdVHLy+xR7
         KS/mx/PETpzwKMwR8su6EpnL7H9uP9it2RFcE6Iz2faQj4euuvYtIFWbIW8wK0/o+9Pf
         UV1v7TNtAl7aYh0QORlYV+CWKgb3RLP7/k8r8Yk9IQZ89K4r46iB19MQAZdt6XiBgYyA
         rPqA==
X-Gm-Message-State: AOAM5337OveNJxzHoFfxPeap+d7X0xOWfW+l9W7ITqSpphRQ8AC3NPeq
        w/jMxSmb2mYJlcLMBMX/gCyS98E6FHJL5PZBBoU=
X-Google-Smtp-Source: ABdhPJzimOqR7D2spAD9eyr6zN/rFBBS7205y35op1UoXzKOxKHkx8fPXVpV3zEzAgwrhVx4tWvzHld5To6ya+SMhxA=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr17068377pgg.74.1620031215171;
 Mon, 03 May 2021 01:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <202105030653.cyQpw8yD-lkp@intel.com>
In-Reply-To: <202105030653.cyQpw8yD-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 May 2021 11:39:58 +0300
Message-ID: <CAHp75Vd9kXo7=g35x_AosWBHJH0KBVeX4qgkpbTz31m3w3s3gA@mail.gmail.com>
Subject: Re: drivers/gpio/gpio-dwapb.c:678:12: warning: stack frame size of
 2064 bytes in function 'dwapb_gpio_probe'
To:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 1:54 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27787ba3fa4904422b3928b898d1bd3d74d98bea
> commit: 60593df667e087b009ee0fc20d92e9c4c096a9b5 gpio: dwapb: fix NULL pointer dereference at dwapb_gpio_suspend()
> date:   5 months ago
> config: powerpc64-randconfig-r026-20210430 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60593df667e087b009ee0fc20d92e9c4c096a9b5
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 60593df667e087b009ee0fc20d92e9c4c096a9b5
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/gpio/gpio-dwapb.c:678:12: warning: stack frame size of 2064 bytes in function 'dwapb_gpio_probe' [-Wframe-larger-than=]
>    static int dwapb_gpio_probe(struct platform_device *pdev)
>               ^
>    1 warning generated.

Another Clang bug?

> vim +/dwapb_gpio_probe +678 drivers/gpio/gpio-dwapb.c
>
> a72b8c4a63e2a3 Hoan Tran                        2017-02-21  677
> 7779b34556978f Jamie Iles                       2014-02-25 @678  static int dwapb_gpio_probe(struct platform_device *pdev)
> 7779b34556978f Jamie Iles                       2014-02-25  679  {
> 3d2613c4289ff2 Weike Chen                       2014-09-17  680         unsigned int i;
> 7779b34556978f Jamie Iles                       2014-02-25  681         struct dwapb_gpio *gpio;
> 7779b34556978f Jamie Iles                       2014-02-25  682         int err;
> 3d2613c4289ff2 Weike Chen                       2014-09-17  683         struct device *dev = &pdev->dev;
> 3d2613c4289ff2 Weike Chen                       2014-09-17  684         struct dwapb_platform_data *pdata = dev_get_platdata(dev);
> 3d2613c4289ff2 Weike Chen                       2014-09-17  685
> da9df93e9e0fd1 Axel Lin                         2014-12-28  686         if (!pdata) {
> 4ba8cfa79f44a9 Jiang Qiu                        2016-04-28  687                 pdata = dwapb_gpio_get_pdata(dev);
> 3d2613c4289ff2 Weike Chen                       2014-09-17  688                 if (IS_ERR(pdata))
> 3d2613c4289ff2 Weike Chen                       2014-09-17  689                         return PTR_ERR(pdata);
> 3d2613c4289ff2 Weike Chen                       2014-09-17  690         }
> 7779b34556978f Jamie Iles                       2014-02-25  691
> da9df93e9e0fd1 Axel Lin                         2014-12-28  692         if (!pdata->nports)
> da9df93e9e0fd1 Axel Lin                         2014-12-28  693                 return -ENODEV;
> 7779b34556978f Jamie Iles                       2014-02-25  694
> 3d2613c4289ff2 Weike Chen                       2014-09-17  695         gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> da9df93e9e0fd1 Axel Lin                         2014-12-28  696         if (!gpio)
> da9df93e9e0fd1 Axel Lin                         2014-12-28  697                 return -ENOMEM;
> da9df93e9e0fd1 Axel Lin                         2014-12-28  698
> 3d2613c4289ff2 Weike Chen                       2014-09-17  699         gpio->dev = &pdev->dev;
> 3d2613c4289ff2 Weike Chen                       2014-09-17  700         gpio->nr_ports = pdata->nports;
> 3d2613c4289ff2 Weike Chen                       2014-09-17  701
> 4731d80f5ea9b8 Serge Semin                      2020-07-30  702         err = dwapb_get_reset(gpio);
> 4731d80f5ea9b8 Serge Semin                      2020-07-30  703         if (err)
> 4731d80f5ea9b8 Serge Semin                      2020-07-30  704                 return err;
> 07901a94f9f9b1 Alan Tull                        2017-10-11  705
> 3d2613c4289ff2 Weike Chen                       2014-09-17  706         gpio->ports = devm_kcalloc(&pdev->dev, gpio->nr_ports,
> 7779b34556978f Jamie Iles                       2014-02-25  707                                    sizeof(*gpio->ports), GFP_KERNEL);
> da9df93e9e0fd1 Axel Lin                         2014-12-28  708         if (!gpio->ports)
> da9df93e9e0fd1 Axel Lin                         2014-12-28  709                 return -ENOMEM;
> 7779b34556978f Jamie Iles                       2014-02-25  710
> 2a7194e9759586 Enrico Weigelt, metux IT consult 2019-03-11  711         gpio->regs = devm_platform_ioremap_resource(pdev, 0);
> da9df93e9e0fd1 Axel Lin                         2014-12-28  712         if (IS_ERR(gpio->regs))
> da9df93e9e0fd1 Axel Lin                         2014-12-28  713                 return PTR_ERR(gpio->regs);
> 7779b34556978f Jamie Iles                       2014-02-25  714
> daa3f58d180c07 Serge Semin                      2020-07-30  715         err = dwapb_get_clks(gpio);
> daa3f58d180c07 Serge Semin                      2020-07-30  716         if (err)
> e6bf37736f6495 Phil Edworthy                    2018-03-12  717                 return err;
> e6bf37736f6495 Phil Edworthy                    2018-03-12  718
> 9826bbe1fef0b5 Andy Shevchenko                  2020-04-15  719         gpio->flags = (uintptr_t)device_get_match_data(dev);
> a72b8c4a63e2a3 Hoan Tran                        2017-02-21  720
> 3d2613c4289ff2 Weike Chen                       2014-09-17  721         for (i = 0; i < gpio->nr_ports; i++) {
> 3d2613c4289ff2 Weike Chen                       2014-09-17  722                 err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);
> 7779b34556978f Jamie Iles                       2014-02-25  723                 if (err)
> 7779b34556978f Jamie Iles                       2014-02-25  724                         return err;
> 7779b34556978f Jamie Iles                       2014-02-25  725         }
> 7779b34556978f Jamie Iles                       2014-02-25  726
> 60593df667e087 Luo Jiaxing                      2020-11-27  727         platform_set_drvdata(pdev, gpio);
> 60593df667e087 Luo Jiaxing                      2020-11-27  728
> 7779b34556978f Jamie Iles                       2014-02-25  729         return 0;
> 7779b34556978f Jamie Iles                       2014-02-25  730  }
> 7779b34556978f Jamie Iles                       2014-02-25  731
>
> :::::: The code at line 678 was first introduced by commit
> :::::: 7779b34556978f6771a78bd87557523623e0405b gpio: add a driver for the Synopsys DesignWare APB GPIO block
>
> :::::: TO: Jamie Iles <jamie@jamieiles.com>
> :::::: CC: Linus Walleij <linus.walleij@linaro.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
With Best Regards,
Andy Shevchenko
