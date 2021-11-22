Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E75458B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhKVJfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Nov 2021 04:35:47 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34021 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbhKVJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:35:46 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BCFB960002;
        Mon, 22 Nov 2021 09:32:38 +0000 (UTC)
Date:   Mon, 22 Nov 2021 10:32:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: denali_dt.c:undefined reference to
 `devm_platform_ioremap_resource_byname'
Message-ID: <20211122103237.30f7fbb7@xps13>
In-Reply-To: <202111202305.crExu5hF-lkp@intel.com>
References: <202111202305.crExu5hF-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

lkp@intel.com wrote on Sat, 20 Nov 2021 23:46:14 +0800:

> Hi Cai,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The fix has been applied at the end of last week and should be in
linux-next already.

> head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
> commit: 5f14a8ca1b493a3c633ff549fb7d494887d7804a mtd: rawnand: denali: Make use of the helper function devm_platform_ioremap_resource_byname()
> date:   10 weeks ago
> config: s390-buildonly-randconfig-r002-20211120 (attached as .config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f14a8ca1b493a3c633ff549fb7d494887d7804a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5f14a8ca1b493a3c633ff549fb7d494887d7804a
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>    irq-al-fic.c:(.init.text+0x46): undefined reference to `of_iomap'
>    s390-linux-ld: irq-al-fic.c:(.init.text+0x3cc): undefined reference to `iounmap'
>    s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>    xillybus_of.c:(.text+0x304): undefined reference to `devm_platform_ioremap_resource'
>    s390-linux-ld: drivers/mtd/nand/raw/denali_dt.o: in function `denali_dt_probe':
> >> denali_dt.c:(.text+0x166): undefined reference to `devm_platform_ioremap_resource_byname'
> >> s390-linux-ld: denali_dt.c:(.text+0x194): undefined reference to `devm_platform_ioremap_resource_byname'  
>    s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>    timer-of.c:(.init.text+0xd6): undefined reference to `of_iomap'
>    s390-linux-ld: timer-of.c:(.init.text+0x4e4): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
>    timer-of.c:(.init.text+0x5f8): undefined reference to `iounmap'
>    s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
>    timer-microchip-pit64b.c:(.init.text+0x118): undefined reference to `of_iomap'
>    s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0x6f4): undefined reference to `iounmap'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Thanks,
Miquèl
