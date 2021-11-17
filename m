Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761D454A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhKQPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKQPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:51:50 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D16C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:48:51 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t13so6858641uad.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpKDoUYT1KXwCdQVhGqcGkH6pz6S1E8mB8lpDXZKZYk=;
        b=Azx7BINDrIrF6HBhOAtCzhB+yM1D9pHpEDwCj9ysctJE1EigY7oDoA8slivVpS0OGl
         T8PHPX97V08isHTPOjIoW1il8agYIfkfm1Qxhm7pZqD4k8UtbdFJsU5NGK8DabPcbPxe
         xWwzN+nkhLPVyyjnwrwp6GxOspvTXSSusdV1RwvKzEeBeOtJFqjSNJTYEFDPClqYKwkD
         52Hu8xEBoluxaeV6g/WmV/5MQyCptX/VPi11zcl4HOUTGWEgvdvscn4UTsb7u1sCo8bH
         q5Zu1rrdwxf6V8M9k5sBXOtWLivBY6geTMYAPLlD1TQ5y/KfQTQYOiF1xVjs0C5al6rM
         VEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpKDoUYT1KXwCdQVhGqcGkH6pz6S1E8mB8lpDXZKZYk=;
        b=3Z8N+SJzauN/rPK5c7aQ0zTBsmDftFk14aVcarZFXRQSLiHzSOzpLqsm0twE7eZPW2
         kg4rTbRMMyfo68sWrE4FFXWTHSzy3erItwTorIuIeig3uFTeZ1y6g2/yN1wSDWgHD9v4
         FlyjhFVSLkpi7y1nek5lsJ7EM3izrblpuL24lgNsBFfdfDf6qY6XW/SIY6b55PwKmIIr
         H4LlgtoZuhBgZBtOb384Odw8IjTONlbTQuCapkg8x5CwKGXpenv2MnYrpxIckdDNmFvu
         sy9nthFlU4hwz4W3EVejqoVCiUWFJ7jFORWKJbkVyB6T+OdZBmIhwIpaVmQw36JJitRo
         6oEw==
X-Gm-Message-State: AOAM530gpraesazqw+TdbO+tI1SoiqVjnMQmpdbkC+HwU+t42Hl9/D4q
        5aiKwaer0ynYEy4oIHHfxA2PC/lW6WT51oMZw6o=
X-Google-Smtp-Source: ABdhPJwvKZoG78l++K2sSY6AzSKpp3W6HqyU9eENrz5yF4sUBWXJp4mJv8L5sQyJiSZh8pfQJia0ed3Zr9mR0/23YgU=
X-Received: by 2002:a67:cb0c:: with SMTP id b12mr71409911vsl.13.1637164130341;
 Wed, 17 Nov 2021 07:48:50 -0800 (PST)
MIME-Version: 1.0
References: <202111172322.oo8vIBuS-lkp@intel.com>
In-Reply-To: <202111172322.oo8vIBuS-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 17 Nov 2021 16:48:38 +0100
Message-ID: <CAMhs-H8QwszxB09bkck-dAdhLy9nKWAHtdcsWQ86EqLiFYrcgg@mail.gmail.com>
Subject: Re: drivers/pci/controller/pcie-mt7621.c:151:16: sparse: sparse:
 symbol 'mt7621_pci_ops' was not declared. Should it be static?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 17, 2021 at 4:13 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ab774587903771821b59471cc723bba6d893942
> commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> date:   4 weeks ago
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/pci/controller/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>    command-line: note: in included file:
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>    builtin:0:0: sparse: this was the original definition
> >> drivers/pci/controller/pcie-mt7621.c:151:16: sparse: sparse: symbol 'mt7621_pci_ops' was not declared. Should it be static?

Thanks for reporting. Sparse is right. Symbol 'mt7621_pci_ops' should
be declared as static. Already sent patch with this change:
https://lkml.org/lkml/2021/11/17/635

Best regards,
    Sergio Paracuellos

>    drivers/pci/controller/pcie-mt7621.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:130:1: sparse:     got void [noderef] __iomem *
>    drivers/pci/controller/pcie-mt7621.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void const volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cpc.h:100:1: sparse:     got void [noderef] __iomem *
>    drivers/pci/controller/pcie-mt7621.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void volatile [noderef] __iomem *mem
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     expected void *
>    arch/mips/include/asm/mips-cm.h:202:1: sparse:     got void [noderef] __iomem *
>    arch/mips/include/asm/mips-cm.h:209:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>
> vim +/mt7621_pci_ops +151 drivers/pci/controller/pcie-mt7621.c
>
> 03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  150
> 8571c62d45cb7e9 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03 @151  struct pci_ops mt7621_pci_ops = {
> 8571c62d45cb7e9 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  152      .map_bus        = mt7621_pcie_map_bus,
> 8571c62d45cb7e9 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  153      .read           = pci_generic_config_read,
> 8571c62d45cb7e9 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  154      .write          = pci_generic_config_write,
> 03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  155  };
> 03f152e31f4ae89 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  156
>
> :::::: The code at line 151 was first introduced by commit
> :::::: 8571c62d45cb7e9fdff87fe5132002d17fbce7a3 staging: mt7621-pci: use generic kernel pci subsystem read and write
>
> :::::: TO: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
