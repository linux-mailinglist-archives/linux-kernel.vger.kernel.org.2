Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9141A3E4456
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhHILBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHILBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:01:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D8C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:00:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p38so5463623lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EWh3qmrXI9DtO1vFXKCcRxnt+qQ9josKdpjaBxdfMs=;
        b=rw/fb4w7WpwxXO9xQu/Q/4o1qk7KieWrxaYGYcG1bdOSGS92TvaGyOjUMC9Y8Fodnl
         iAx3k3Sm19XYsvnY4APyE+CnGqE1z+W3eOHmuQkbmvNOshHkP57P2UhQiEfFy+T04M8c
         uZkXjWu5AVlpgNtZJaEJZOftJBd+53VjwFnsh0S2i2IhlfNBPOMbEaXYfWRSqb8U0vjZ
         pQJdRt1iwuKCAsnMM0AMQgde6Eu0cxawmbNOTl8/jWc44RMsCqDgJRWYhJGOkoEXyBV/
         ZcG0tQMOnRO+4HWqU+hIf2/WWqj0pf57SDwVEPQZmH5qTDn/bv4R2K1+UWS5hVjtjfz/
         Mnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EWh3qmrXI9DtO1vFXKCcRxnt+qQ9josKdpjaBxdfMs=;
        b=uZyE6QtRiBbvyc0AXBB7Ec9jyqNR3LlZY/CIaB8j8lfD8a9lAcQ1i+qiphh30swC9S
         eZ0X2IrUYJ0MZXExPoy3eRqe5p7RfHRjp4qS7StpvkQVUlcbcDnKK/WYMjDj+jplIKGb
         QnU1i+3AjgFNWiRBUIyeNRWdl4hm1/tqHwF1xb8QKVJFvajwEP0KDBxlkiNswOTcVHjX
         rS1fP4vH0xAItrf/pZIcRDdbmWODszboK3KT9B+5N6wCa0ws4hyMjkfAmB0sE9F34zAk
         bICWCFNueVh06BVJ4OQC9iD3H9xH7g9mH/FN+vvXfNCsPMISQpb/ZpFsCA9op+R/t1B/
         G9AA==
X-Gm-Message-State: AOAM533+XG+XH1ee7IpjKgPQt3827FaqnJhpmjruF7gWhtwgfBGjyk1Y
        3Scx5x2aNOvdBiaaXtzXQcGoJKeIxZ/jJw==
X-Google-Smtp-Source: ABdhPJxpgDecUwpFGe66d7u6nV7HAkbAtfPmIhr/QwsL2v3p1TytfjGwbbtGD3mvlIHceJmFn5wX1Q==
X-Received: by 2002:ac2:4c19:: with SMTP id t25mr15505663lfq.260.1628506847796;
        Mon, 09 Aug 2021 04:00:47 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id f6sm575851lft.231.2021.08.09.04.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 04:00:47 -0700 (PDT)
Subject: Re: drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret'
 is never read [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <rong.a.chen@intel.com>,
        Petko Manolov <petkan@nucleusys.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202108080902.ZhmxmJZr-lkp@intel.com>
 <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <3dea0c17-35cc-6a94-1478-a44ef8fe0191@gmail.com>
Date:   Mon, 9 Aug 2021 14:00:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <28df02cc-8b34-3d4e-2ed6-30af0ff44a42@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 1:37 PM, kernel test robot wrote:
> 
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   85a90500f9a1717c4e142ce92e6c1cb1a339ec78
> commit: 8a160e2e9aeb8318159b48701ad8a6e22274372d net: usb: pegasus:
> Check the return value of get_geristers() and friends;
> date:   4 days ago
> :::::: branch date: 8 hours ago
> :::::: commit date: 4 days ago
> config: x86_64-randconfig-c001-20210808 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> 41a6b50c25961addc04438b567ee1f4ef9e40f98)
> reproduce (this is a W=1 build):
>           wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>           chmod +x ~/bin/make.cross
>           # install x86_64 cross compiling tool for clang build
>           # apt-get install binutils-x86-64-linux-gnu
>           #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a160e2e9aeb8318159b48701ad8a6e22274372d
>           git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>           git fetch --no-tags linus master
>           git checkout 8a160e2e9aeb8318159b48701ad8a6e22274372d
>           # save the attached .config to linux build tree
>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=x86_64 clang-analyzer
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

[snip]

>>> drivers/net/usb/pegasus.c:461:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>              ret = set_registers(pegasus, EthCtrl0, 3, data);
>              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/usb/pegasus.c:461:2: note: Value stored to 'ret' is
> never read
>              ret = set_registers(pegasus, EthCtrl0, 3, data);
>              ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/usb/pegasus.c:778:18: warning: The left operand of '>>'
> is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
>              interval = data >> 8;
>                              ^

This is fixed by commit af35fc37354c ("net: pegasus: fix uninit-value in
get_interrupt_interval")


>      drivers/net/usb/pegasus.c:1157:2: note: Taking false branch
>              if (pegasus_blacklisted(dev))
>              ^
>      drivers/net/usb/pegasus.c:1161:6: note: Assuming 'net' is non-null
>              if (!net)
>                  ^~~~
>      drivers/net/usb/pegasus.c:1161:2: note: Taking false branch
>              if (!net)
>              ^
>      drivers/net/usb/pegasus.c:1168:6: note: 'res' is >= 0
>              if (res < 0) {
>                  ^~~
>      drivers/net/usb/pegasus.c:1168:2: note: Taking false branch
>              if (res < 0) {
>              ^
>      drivers/net/usb/pegasus.c:1175:2: note: Loop condition is false.
> Exiting loop
>              INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
>              ^
>      include/linux/workqueue.h:272:2: note: expanded from macro
> 'INIT_DELAYED_WORK'
>              __INIT_DELAYED_WORK(_work, _func, 0)
>              ^
>      include/linux/workqueue.h:257:3: note: expanded from macro
> '__INIT_DELAYED_WORK'
>                      INIT_WORK(&(_work)->work, (_func));
>       \
>                      ^
>      include/linux/workqueue.h:250:2: note: expanded from macro 'INIT_WORK'
>              __INIT_WORK((_work), (_func), 0)
>              ^
>      include/linux/workqueue.h:230:2: note: expanded from macro '__INIT_WORK'
>              do {
>       \
>              ^
>      drivers/net/usb/pegasus.c:1175:2: note: Loop condition is false.
> Exiting loop
>              INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
>              ^
>      include/linux/workqueue.h:272:2: note: expanded from macro
> 'INIT_DELAYED_WORK'
>              __INIT_DELAYED_WORK(_work, _func, 0)
>              ^
>      include/linux/workqueue.h:258:3: note: expanded from macro
> '__INIT_DELAYED_WORK'
>                      __init_timer(&(_work)->timer,
>       \
>                      ^
>      include/linux/timer.h:113:2: note: expanded from macro '__init_timer'
>              do {
>       \
>              ^
>      drivers/net/usb/pegasus.c:1175:2: note: Loop condition is false.
> Exiting loop
>              INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
>              ^
>      include/linux/workqueue.h:272:2: note: expanded from macro
> 'INIT_DELAYED_WORK'
>              __INIT_DELAYED_WORK(_work, _func, 0)
>              ^
>      include/linux/workqueue.h:256:2: note: expanded from macro
> '__INIT_DELAYED_WORK'
>              do {
>       \
>              ^
>      drivers/net/usb/pegasus.c:1194:2: note: Calling 'get_interrupt_interval'
>              get_interrupt_interval(pegasus);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/usb/pegasus.c:774:2: note: 'data' declared without an
> initial value
>              u16 data;
>              ^~~~~~~~
>      drivers/net/usb/pegasus.c:777:2: note: Calling 'read_eprom_word'
>              read_eprom_word(pegasus, 4, &data);

This is fixed by commit af35fc37354c ("net: pegasus: fix uninit-value in
get_interrupt_interval")


>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>      drivers/net/usb/pegasus.c:279:2: note: Loop condition is true.
> Entering loop body
>              for (i = 0; i < REG_TIMEOUT; i++) {
>              ^
>      drivers/net/usb/pegasus.c:281:7: note: Assuming 'ret' is < 0
>                      if (ret < 0)
>                          ^~~~~~~
>      drivers/net/usb/pegasus.c:281:3: note: Taking true branch
>                      if (ret < 0)
>                      ^
>      drivers/net/usb/pegasus.c:282:4: note: Control jumps to line 298
>                              goto fail;
>                              ^
>      drivers/net/usb/pegasus.c:298:2: note: Taking false branch
>              netif_dbg(pegasus, drv, pegasus->net, "%s failed\n", __func__);
>              ^
>      include/linux/netdevice.h:5352:2: note: expanded from macro 'netif_dbg'
>              if (netif_msg_##type(priv))                             \
>              ^
>      drivers/net/usb/pegasus.c:298:2: note: Loop condition is false.
> Exiting loop
>              netif_dbg(pegasus, drv, pegasus->net, "%s failed\n", __func__);
>              ^
>      include/linux/netdevice.h:5350:57: note: expanded from macro 'netif_dbg'
>      #define netif_dbg(priv, type, netdev, format, args...)          \
>                                                                      ^
>      drivers/net/usb/pegasus.c:299:2: note: Returning without writing to
> '*retdata'
>              return ret;
>              ^
>      drivers/net/usb/pegasus.c:777:2: note: Returning from 'read_eprom_word'
>              read_eprom_word(pegasus, 4, &data);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/usb/pegasus.c:778:18: note: The left operand of '>>' is
> a garbage value
>              interval = data >> 8;

This is fixed by commit af35fc37354c ("net: pegasus: fix uninit-value in
get_interrupt_interval")


> 
> vim +/ret +461 drivers/net/usb/pegasus.c
> 
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  439
>    ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 440  static int enable_net_traffic(struct net_device *dev, struct
> usb_device *usb)
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  441  {
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 442  	pegasus_t *pegasus = netdev_priv(dev);
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 443  	int ret;
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 444  	__u16 linkpart;
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 445  	__u8 data[4];
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  446
>    8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 447  	ret = read_mii_word(pegasus, pegasus->phy, MII_LPA, &linkpart);
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 448  	if (ret < 0)
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 449  		goto fail;
> 1a8deec09d12c1 drivers/net/usb/pegasus.c Petko Manolov  2016-04-27
> 450  	data[0] = 0xc8; /* TX & RX enable, append status, no CRC */
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 451  	data[1] = 0;
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 452  	if (linkpart & (ADVERTISE_100FULL | ADVERTISE_10FULL))
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 453  		data[1] |= 0x20;	/* set full duplex */
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 454  	if (linkpart & (ADVERTISE_100FULL | ADVERTISE_100HALF))
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 455  		data[1] |= 0x10;	/* set 100 Mbps */
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 456  	if (mii_mode)
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 457  		data[1] = 0;
> 681f16232c49de drivers/net/usb/pegasus.c Dan Carpenter  2011-12-23
> 458  	data[2] = loopback ? 0x09 : 0x01;
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  459
>    ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 460  	memcpy(pegasus->eth_regs, data, sizeof(data));
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> @461  	ret = set_registers(pegasus, EthCtrl0, 3, data);
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  462
>    ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 463  	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
> efafe6fb72b2bb drivers/usb/net/pegasus.c Malte Doersam  2006-01-28
> 464  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 465  	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_DLINK) {
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16
> 466  		u16 auxmode;
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 467  		ret = read_mii_word(pegasus, 0, 0x1b, &auxmode);
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 468  		if (ret < 0)
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
>    469  			goto fail;
> 2bd647018fe1b2 drivers/net/usb/pegasus.c Petko Manolov  2013-04-25
> 470  		auxmode |= 4;
> 2bd647018fe1b2 drivers/net/usb/pegasus.c Petko Manolov  2013-04-25
> 471  		write_mii_word(pegasus, 0, 0x1b, &auxmode);
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  472  	}
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  473
>    8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 474  	return 0;
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03  475
>    fail:
> 8a160e2e9aeb83 drivers/net/usb/pegasus.c Petko Manolov  2021-08-03
> 476  	netif_dbg(pegasus, drv, pegasus->net, "%s failed\n", __func__);
> 4a1728a28a193a drivers/usb/net/pegasus.c Petko Manolov  2005-11-15
> 477  	return ret;
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  478  }
> ^1da177e4c3f41 drivers/usb/net/pegasus.c Linus Torvalds 2005-04-16  479
> :::::: The code at line 461 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


With regards,
Pavel Skripkin
