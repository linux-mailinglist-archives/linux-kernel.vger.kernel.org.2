Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BD429DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhJLGrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:47:24 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:39686 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhJLGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:47:22 -0400
Received: by mail-ua1-f50.google.com with SMTP id f3so13187601uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWPJleEiE+gVZvrcGOiWmft2F+gj6ko8JyHEGetfhVQ=;
        b=KuV90g7pVcvfqlI3r4DnVsxj2vKM9jASYyZY0Ra/DyEz6FBal6N6oJJqYAbkVnYcB1
         +6JTWEaZeiBwdZrSbHwvjwk7L7DOH75qCeapU1G4okAzoTw+q2UDGpDM6q1takAkLr03
         AyHOfNA1RphwXDNaSCdsLea0gLjeL7higfnD7ACQWC8xEwiHEMNf+KlAItEuGoNEqXpf
         dcfYEJ+oZ/h/ZZCaa9XD2ME9NwiBUPqa+iHprMY5FGJ/5oJ6OY0y01D/y4NvWpq4VeUX
         N4YSAG0GzRQn5S327ZuseRsYMb9zIThGIOdSFrHqMVXT443pi3bZRg+C4UUQz7Vk3Eq+
         GZ1w==
X-Gm-Message-State: AOAM532Pz4repYzCbDmOJ5mmoFTm5vfPKdmwJGblPzJSwdWqv+zzbi0R
        bEAGkTl+p/o9d3VomFV6PdLVMLt+vVK9UrTRinQ=
X-Google-Smtp-Source: ABdhPJxuzIhTk17saXykKBoZYi6Lc9Pg3rBxOtURrGCe+Uo4iET197lYmvK8cWuKC6902dAATf0O6aS5WFg5GKe5cZw=
X-Received: by 2002:a67:ac04:: with SMTP id v4mr28776833vse.50.1634021121297;
 Mon, 11 Oct 2021 23:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <202110120411.Ye2uGBNg-lkp@intel.com>
In-Reply-To: <202110120411.Ye2uGBNg-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Oct 2021 08:45:09 +0200
Message-ID: <CAMuHMdVJJtZJr4ZxV5g2EzO4KRszBFg3ysjX-OYsd2jXGx_z3Q@mail.gmail.com>
Subject: Re: [rogerq:ti-5.10/am64-nand-1.0 3/11] drivers/memory/omap-gpmc.c:1457:29:
 warning: format '%llx' expects argument of type 'long long unsigned int', but
 argument 3 has type 'resource_size_t' {aka 'unsigned int'}
To:     kernel test robot <lkp@intel.com>
Cc:     Roger Quadros <rogerq@kernel.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:38 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/rogerq/linux ti-5.10/am64-nand-1.0
> head:   10d87efaf33242b8e38807319ce22ee16c1ca438
> commit: 956722fabd30d83fc4671bb70a7554c2b40701b8 [3/11] memory: omap-gpmc: Add support for GPMC on AM64 SoC
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/rogerq/linux/commit/956722fabd30d83fc4671bb70a7554c2b40701b8
>         git remote add rogerq https://github.com/rogerq/linux
>         git fetch --no-tags rogerq ti-5.10/am64-nand-1.0
>         git checkout 956722fabd30d83fc4671bb70a7554c2b40701b8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/device.h:15,
>                     from include/linux/gpio/driver.h:5,
>                     from drivers/memory/omap-gpmc.c:20:
>    drivers/memory/omap-gpmc.c: In function 'gpmc_mem_init':
> >> drivers/memory/omap-gpmc.c:1457:29: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);

Use %pR to print resources, cfr. Documentation/core-api/printk-formats.rst

>          |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
>       19 | #define dev_fmt(fmt) fmt
>          |                      ^~~
>    drivers/memory/omap-gpmc.c:1457:9: note: in expansion of macro 'dev_info'
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);
>          |         ^~~~~~~~
>    drivers/memory/omap-gpmc.c:1457:42: note: format string is defined here
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);
>          |                                       ~~~^
>          |                                          |
>          |                                          long long unsigned int
>          |                                       %x
>    In file included from include/linux/device.h:15,
>                     from include/linux/gpio/driver.h:5,
>                     from drivers/memory/omap-gpmc.c:20:
>    drivers/memory/omap-gpmc.c:1457:29: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);

Likewise.

>          |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
>       19 | #define dev_fmt(fmt) fmt
>          |                      ^~~
>    drivers/memory/omap-gpmc.c:1457:9: note: in expansion of macro 'dev_info'
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);
>          |         ^~~~~~~~
>    drivers/memory/omap-gpmc.c:1457:55: note: format string is defined here
>     1457 |         dev_info(gpmc->dev, "start: 0x%llx, end: 0x%llx\n", gpmc_mem_root.start, gpmc_mem_root.end);
>          |                                                    ~~~^
>          |                                                       |
>          |                                                       long long unsigned int
>          |                                                    %x
>    In file included from include/linux/device.h:15,
>                     from include/linux/gpio/driver.h:5,
>                     from drivers/memory/omap-gpmc.c:20:
>    drivers/memory/omap-gpmc.c: In function 'gpmc_probe_generic_child':
> >> drivers/memory/omap-gpmc.c:2178:34: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]

Use %pa to format phys_addr_t.

>     2178 |                                  "GPMC CS %d start cannot be lesser than 0x%llx\n",
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
>       19 | #define dev_fmt(fmt) fmt
>          |                      ^~~
>    drivers/memory/omap-gpmc.c:2177:25: note: in expansion of macro 'dev_info'
>     2177 |                         dev_info(&pdev->dev,
>          |                         ^~~~~~~~
>    drivers/memory/omap-gpmc.c:2178:79: note: format string is defined here
>     2178 |                                  "GPMC CS %d start cannot be lesser than 0x%llx\n",
>          |                                                                            ~~~^
>          |                                                                               |
>          |                                                                               long long unsigned int
>          |                                                                            %x
>    In file included from include/linux/device.h:15,
>                     from include/linux/gpio/driver.h:5,
>                     from drivers/memory/omap-gpmc.c:20:
>    drivers/memory/omap-gpmc.c:2182:34: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
>     2182 |                                  "GPMC CS %d end cannot be greater than 0x%llx\n",

Likewise.

>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
>       19 | #define dev_fmt(fmt) fmt
>          |                      ^~~
>    drivers/memory/omap-gpmc.c:2181:25: note: in expansion of macro 'dev_info'
>     2181 |                         dev_info(&pdev->dev,
>          |                         ^~~~~~~~
>    drivers/memory/omap-gpmc.c:2182:78: note: format string is defined here
>     2182 |                                  "GPMC CS %d end cannot be greater than 0x%llx\n",
>          |                                                                           ~~~^
>          |                                                                              |
>          |                                                                              long long unsigned int
>          |                                                                           %x

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
