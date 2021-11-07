Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6791B44738C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhKGPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbhKGPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:40:33 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6FC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:37:51 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id a129so7028977vkb.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EMwAMyAmOfWJ5BPToKn4IYqV04VjCk9/c95/Kr4VN4=;
        b=hJpQA2QtCb/uGnVCDj2KreuqiQji2liL9WIH7xqZs52HY7p1iGG05FCSEqk0XUEMsD
         hrZH4128la1FDDARxBf5nYsMWOl1hFTgauZ3bbrXk+8hfdN8fG65J1GavHnl6qz2fh9M
         nNvLpuK5pzE/HFpNUdZHDMXfE7iTmPfdrADWDkiyg5vIGRlXZw/KCZ4jJE+F8NZPeQ7w
         MQTsY6WLUr3fozyLMDa/AQn5Q45a8HTNML2bjnmTHjiB0cAS3vSR3+IhwJwaB4qPMPsd
         HeQZICAZMfB45GKU90SRqDqLVFD8BktpSwsh76CAO1ebZeFzP9i6kOf9Uqoro7Bzwfxl
         VakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EMwAMyAmOfWJ5BPToKn4IYqV04VjCk9/c95/Kr4VN4=;
        b=YlGOArG1Ot4y0id3DALxf4vvxzN3DSJYFVJXrPe0Cg9EfqsrsBZ5dKH3pgsPeg1en3
         eeMOEgZceSs522/qiXujvb13erzg4vappQ7iGMeKh5GR/cRMLwzortcGiInmoS+GKljo
         gESiEZF2cVC4dQ+it/gjZ+1gpl7HY8ou7wbP11SHGnQ8RJiaQrsMNLaXjXHAvYGIY68i
         xdWLmArlnhxv7s+WgtGCmNFPbnR8+uehPkh3Lj64VlZPg5BlFyGi/yNlWr/LblUbf9MW
         oDID0YueAWDNcyusxmXn1gWB0SGhUGBcOvihZ9Pci3unJgXTQvXc38f/akJ9h7Y6SAYS
         dtjg==
X-Gm-Message-State: AOAM531TkQ3Crfnvj3X+tewzKdtVWdWH1iAv5UitP1gYg7Kk7YdQQ/y6
        FqpIhhdcv9RGn9UFshXs9YJ4A0NcFhMyGP9W2e4=
X-Google-Smtp-Source: ABdhPJwvP9wOH0OFsw1T3P5Lt6qIpu+jwbjGClanFi5/caHnkZVsKMo8JjrVKHaR8Sc0H9qV+IseuVhYZtKuHZQomhE=
X-Received: by 2002:a1f:2502:: with SMTP id l2mr77958929vkl.4.1636299469638;
 Sun, 07 Nov 2021 07:37:49 -0800 (PST)
MIME-Version: 1.0
References: <202111072250.F8k5Xg7A-lkp@intel.com>
In-Reply-To: <202111072250.F8k5Xg7A-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 7 Nov 2021 16:37:38 +0100
Message-ID: <CAMhs-H-cx0MRjZDUnNJXP0U9QA4SfHOX_xYG_VwAJN5Q5io4LA@mail.gmail.com>
Subject: Re: drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit
 declaration of function 'mips_cps_numiocu'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 7, 2021 at 3:46 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b5013d084e03e82ceeab4db8ae8ceeaebe76b0eb
> commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> date:   2 weeks ago
> config: mips-randconfig-r006-20211031 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d321548c3ce987f4f21350ba1c81fdb5d4354224)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/pci/controller/pcie-mt7621.c:224:6: error: implicit declaration of function 'mips_cps_numiocu' [-Werror,-Wimplicit-function-declaration]
>            if (mips_cps_numiocu(0)) {
>                ^
> >> drivers/pci/controller/pcie-mt7621.c:232:3: error: implicit declaration of function 'write_gcr_reg1_base' [-Werror,-Wimplicit-function-declaration]
>                    write_gcr_reg1_base(entry->res->start);
>                    ^
> >> drivers/pci/controller/pcie-mt7621.c:233:3: error: implicit declaration of function 'write_gcr_reg1_mask' [-Werror,-Wimplicit-function-declaration]
>                    write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>                    ^
>    drivers/pci/controller/pcie-mt7621.c:233:3: note: did you mean 'write_gcr_reg1_base'?
>    drivers/pci/controller/pcie-mt7621.c:232:3: note: 'write_gcr_reg1_base' declared here
>                    write_gcr_reg1_base(entry->res->start);
>                    ^
> >> drivers/pci/controller/pcie-mt7621.c:233:30: error: use of undeclared identifier 'CM_GCR_REGn_MASK_CMTGT_IOCU0'
>                    write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>                                               ^
> >> drivers/pci/controller/pcie-mt7621.c:235:25: error: implicit declaration of function 'read_gcr_reg1_base' [-Werror,-Wimplicit-function-declaration]
>                             (unsigned long long)read_gcr_reg1_base(),
>                                                 ^
>    drivers/pci/controller/pcie-mt7621.c:235:25: note: did you mean 'write_gcr_reg1_base'?
>    drivers/pci/controller/pcie-mt7621.c:232:3: note: 'write_gcr_reg1_base' declared here
>                    write_gcr_reg1_base(entry->res->start);
>                    ^
> >> drivers/pci/controller/pcie-mt7621.c:236:25: error: implicit declaration of function 'read_gcr_reg1_mask' [-Werror,-Wimplicit-function-declaration]
>                             (unsigned long long)read_gcr_reg1_mask());
>                                                 ^
>    drivers/pci/controller/pcie-mt7621.c:236:25: note: did you mean 'read_gcr_reg1_base'?
>    drivers/pci/controller/pcie-mt7621.c:235:25: note: 'read_gcr_reg1_base' declared here
>                             (unsigned long long)read_gcr_reg1_base(),
>                                                 ^
>    include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>            dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                             ^
>    include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                    _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                                        ^
>    6 errors generated.

These functions are MIPS specific arch headers included in
'arch/mips/include/asm'. There is no specific include for this files
in driver code since MIPS platforms include directly this directory
through cflags and driver compiles without problem. But it seems they
are not available directly for randconfigs and a specific include is
needed here? We are currently thinking of a way to move this MIPS
specific stuff into ralink platform code to allow this driver to
properly be compile tested for any architecture [0]. If the specific
MIPS code finally is not moved anywhere, I will send a patch to
explicitly include the MIPS needed headers here.

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
