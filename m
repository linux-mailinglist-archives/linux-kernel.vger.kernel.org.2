Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7244F7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhKNLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhKNLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:38:00 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11A1C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 03:35:06 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p2so28570530uad.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxjGJOQmRZX28FeM6SVMQPOfPppgdjqxFiHT9DPBCiw=;
        b=Qyzvhke/vkvakifnAeRDFKN65IDEJPq75z2aScv+l7/1MfQb4xgGwjdb+SCT9+iR90
         4gp5sOV++8LzQu23CYCuj7HSBBhLiFMr3wxkZZnQaPbrsZBJT573vWjZBKZVcSOg9cXk
         PsL/v9SelgKk2XsbFKDW217G74AK3TnS8onU0EgVkBc302jDyoajYeaAZ7nfcqh2mayk
         71wjWEwSvlVoBaDXQkc2ciEUa9p+qJJRt4i+E7q1FNiT8FM6RvnFq3zlgj5F6GAuKvkd
         yatqJGlcpZA05xsFnhnj2qySnjYJ8GXM34fXlEPajLWE9ryu10KxK+aUMruKReDFGw0P
         yx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxjGJOQmRZX28FeM6SVMQPOfPppgdjqxFiHT9DPBCiw=;
        b=Ybq8maC47oz9Frt7y1cF7UALSddeEROToB1l+lxGnIyAgQUQYwfyblz/E/prTibtkP
         ZBwAS8VwHF+MNMfbaXRNi1C6i5Mf0HAhbHwQl4NUxE71Me6MRrah7UAqOrd1ZmZfnRLz
         mnJ4/xD1uynJf/rBe3GRjld3qFGOzsJ55ttM2hyvonYudFUWM5OLhYNNcMihTnAwcCJv
         h3cTLTPR+RqfFFxnxVhWkMcgB4NBTMpQkGC3SXlNCVRHDBlWKyok9wyUDB7rdppPyUuz
         yOUYgDtuw8fWRmF82mSMo4ie7Hssa5AGzo/OMcRgs/+YyinV5nYEDg7N1umUiIy0Atuy
         vtDQ==
X-Gm-Message-State: AOAM532OPifvZfil+2Q0zRqhGd5YYTBGpL3Fk0sFa8BRyl0tOmF8RStD
        cseXTHFskiXStnOGLpdM8tHMWJLQ0h2yjpsagZQ=
X-Google-Smtp-Source: ABdhPJw1fgifwBENwVu+GZ+yFZvMlmOs1rhmb3NAWdHTuwzoyzd7MA295mJR9cq3xLfp2q0gwvyp/Tfoo5dFOOuhjkg=
X-Received: by 2002:a05:6102:3a11:: with SMTP id b17mr30895649vsu.28.1636889705649;
 Sun, 14 Nov 2021 03:35:05 -0800 (PST)
MIME-Version: 1.0
References: <202111141959.UefyvLfa-lkp@intel.com>
In-Reply-To: <202111141959.UefyvLfa-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 14 Nov 2021 12:34:54 +0100
Message-ID: <CAMhs-H_yugWd4v1OnBR8iqTVQS_T-S3pdrJbZq=MC646QSyb4Q@mail.gmail.com>
Subject: Re: drivers/pci/controller/pcie-mt7621.c:224:13: error: implicit
 declaration of function 'mips_cps_numiocu'
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

On Sun, Nov 14, 2021 at 12:13 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c8c109546a19613d323a319d0c921cb1f317e629
> commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> date:   3 weeks ago
> config: mips-randconfig-r001-20211114 (attached as .config)
> compiler: mips64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/pci/controller/pcie-mt7621.c: In function 'setup_cm_memory_region':
> >> drivers/pci/controller/pcie-mt7621.c:224:13: error: implicit declaration of function 'mips_cps_numiocu' [-Werror=implicit-function-declaration]
>      224 |         if (mips_cps_numiocu(0)) {
>          |             ^~~~~~~~~~~~~~~~
> >> drivers/pci/controller/pcie-mt7621.c:232:17: error: implicit declaration of function 'write_gcr_reg1_base'; did you mean 'write_gc0_ebase'? [-Werror=implicit-function-declaration]
>      232 |                 write_gcr_reg1_base(entry->res->start);
>          |                 ^~~~~~~~~~~~~~~~~~~
>          |                 write_gc0_ebase
> >> drivers/pci/controller/pcie-mt7621.c:233:17: error: implicit declaration of function 'write_gcr_reg1_mask'; did you mean 'write_gc0_pagemask'? [-Werror=implicit-function-declaration]
>      233 |                 write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>          |                 ^~~~~~~~~~~~~~~~~~~
>          |                 write_gc0_pagemask
> >> drivers/pci/controller/pcie-mt7621.c:233:44: error: 'CM_GCR_REGn_MASK_CMTGT_IOCU0' undeclared (first use in this function)
>      233 |                 write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/controller/pcie-mt7621.c:233:44: note: each undeclared identifier is reported only once for each function it appears in
>    In file included from include/linux/device.h:15,
>                     from include/linux/of_platform.h:9,
>                     from drivers/pci/controller/pcie-mt7621.c:26:
> >> drivers/pci/controller/pcie-mt7621.c:235:46: error: implicit declaration of function 'read_gcr_reg1_base'; did you mean 'read_gc0_ebase'? [-Werror=implicit-function-declaration]
>      235 |                          (unsigned long long)read_gcr_reg1_base(),
>          |                                              ^~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>          |                                     ^~~~~~~~~~~
>    drivers/pci/controller/pcie-mt7621.c:234:17: note: in expansion of macro 'dev_info'
>      234 |                 dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>          |                 ^~~~~~~~
> >> drivers/pci/controller/pcie-mt7621.c:236:46: error: implicit declaration of function 'read_gcr_reg1_mask'; did you mean 'read_gc0_pagemask'? [-Werror=implicit-function-declaration]
>      236 |                          (unsigned long long)read_gcr_reg1_mask());
>          |                                              ^~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>          |                                     ^~~~~~~~~~~
>    drivers/pci/controller/pcie-mt7621.c:234:17: note: in expansion of macro 'dev_info'
>      234 |                 dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>          |                 ^~~~~~~~
>    cc1: some warnings being treated as errors

These functions are MIPS specific arch headers included in
'arch/mips/include/asm'. There is no specific include for this files
in driver code since MIPS platforms include directly this directory
through cflags and driver compiles without problem. But, yes, passing
-Werror got this ugly implicit stuff as errors.
We are currently thinking of a way to move this MIPS
specific stuff into ralink platform code to allow this driver to
properly be compile tested for any architecture [0]. If the specific
MIPS code finally is not moved anywhere, I will send a patch to
explicitly include the MIPS needed headers here.

Bjorn, if you prefer me to send a patch for this first, let me know.

Best regards,
     Sergio Paracuellos

[0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t

>
>
> vim +/mips_cps_numiocu +224 drivers/pci/controller/pcie-mt7621.c
>
> e51844bf825169 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-24  210
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  211  static int setup_cm_memory_region(struct pci_host_bridge *host)
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  212  {
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  213       struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
> d936550784a23b drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  214       struct device *dev = pcie->dev;
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  215       struct resource_entry *entry;
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  216       resource_size_t mask;
> 8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  217
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  218       entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  219       if (!entry) {
> 2bdd5238e756aa drivers/pci/controller/pcie-mt7621.c    Sergio Paracuellos 2021-09-22  220               dev_err(dev, "cannot get memory resource\n");
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  221               return -EINVAL;
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  222       }
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  223
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @224       if (mips_cps_numiocu(0)) {
> d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  225               /*
> d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  226                * FIXME: hardware doesn't accept mask values with 1s after
> d4e3a1f6cea79e drivers/staging/mt7621-pci/pci-mt7621.c NeilBrown          2018-05-04  227                * 0s (e.g. 0xffef), so it would be great to warn if that's
> d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  228                * about to happen
> d2bac2fd6daa91 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  229                */
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14  230               mask = ~(entry->res->end - entry->res->start);
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  231
> b15606e63ea90c drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-14 @232               write_gcr_reg1_base(entry->res->start);
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @233               write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> d936550784a23b drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  234               dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @235                        (unsigned long long)read_gcr_reg1_base(),
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15 @236                        (unsigned long long)read_gcr_reg1_mask());
> 03f152e31f4ae8 drivers/staging/mt7621-pci/pci-mt7621.c John Crispin       2018-03-15  237       }
> 09dd629eeabb8a drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-18  238
> 8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  239       return 0;
> 8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  240  }
> 8571c62d45cb7e drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-08-03  241
>
> :::::: The code at line 224 was first introduced by commit
> :::::: 03f152e31f4ae89c37ab240f45dd77c8a916dd26 staging: mt7621-pci: MIPS/ralink: add MT7621 pcie driver
>
> :::::: TO: John Crispin <blogic@openwrt.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
