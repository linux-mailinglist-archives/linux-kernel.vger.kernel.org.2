Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8513376022
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhEGGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:14:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C33C061574;
        Thu,  6 May 2021 23:13:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id c3so7735091oic.8;
        Thu, 06 May 2021 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jssVR0Ke4gLMQ/8TddZ8ZY5oO2gPFQyrLTbIarga+9o=;
        b=hbTeQO65TovJ3XcoFIDfpyfG+aTqL2MFmbcAfnRM+lIuOuDHW6ZUDRi4c90QMRwROS
         cBbKBWLJTbsZnTrS2Qw4mn/5PONi1q1BLH/1oXyo4BvAcoJ4TF4v9bSWDsOQpo0PwMRA
         fgijnAyNMg3xBP+JnMglxxEz9p9Znvfggu0x2oduB01wVNGIQKYoZ9eVddFtcD0P4jQ1
         PtPh7yL1+O83VksUXCSP+u6Lq6Pf06KJa6Gj27SiHxbyMP+2MbRyK91e6c9wrqRl2cRO
         qmP9B6JCwKmMaH/q1sryxUHfgPOVArBZvfcfEqgzBqYPDkdhlWwNnsRMLRqacHxos3ci
         BnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jssVR0Ke4gLMQ/8TddZ8ZY5oO2gPFQyrLTbIarga+9o=;
        b=oarmLa4JgxJMPvNVXCzvoztwtd8gTzbR8ui7atYmgA2qRBpn2gP2VTWM7rxHhNnTNf
         eArWvHPuNkpKdGeqtvT4JnkpKJhvO+aPx7jR2SqiG6zAXi0CxmxRhmGz47ZB1QBXMhYX
         6b5pTmaKO6MfBBcuNyBeCXxuvDSK0aYVIIa8VyVOilcVYZAjHymLemsIToMw/efgugM0
         vykgSL+d2SzwEv6ac3A3l7bZ+ebIz3L+hbb1NaIUZLb8sA5Uw+OZFkbBvzhyGyCJGs8e
         MijhlDernYhTs/POu98v4acimxkfzUWj+qTqK5gQIjc2aOTr4oXbKXbYo69fMkr7HGo8
         OqbA==
X-Gm-Message-State: AOAM533eQydYK/l/S3L0ppTSdZbnTR5ur4H2sHPSfDpem2ypcN51AE0Z
        ur+FzbjpKGLeJ7ltBLZvED68EAGXPmTwN+HCfl0=
X-Google-Smtp-Source: ABdhPJyoCPd33xMnPAYYHlpG8rCeh13HzqdvvU0flD8iFLlastr/nnkeqFI4ZxJsRbHXTOG6T9CIRSgCjWLQxzpQeXs=
X-Received: by 2002:aca:2813:: with SMTP id 19mr13972251oix.23.1620368012432;
 Thu, 06 May 2021 23:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210506111531.21978-5-sergio.paracuellos@gmail.com> <202105062302.YjXZOAuy-lkp@intel.com>
In-Reply-To: <202105062302.YjXZOAuy-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 7 May 2021 08:13:21 +0200
Message-ID: <CAMhs-H9Y=Q7PVT0sS02LzwHSj2PbePF2_qgLM+U569PyFBmAEA@mail.gmail.com>
Subject: Re: [PATCH 4/5] phy: ralink: Kconfig: enable COMPILE_TEST on
 mt7621-pci-phy driver
To:     kernel test robot <lkp@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, kbuild-all@lists.01.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 6, 2021 at 5:59 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sergio,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on staging/staging-testing]
> [also build test WARNING on linus/master next-20210506]
> [cannot apply to robh/for-next v5.12]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Sergio-Paracuellos/phy-ralink-mt7621-pci-phy-some-improvements/20210506-191714
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git e120332923e13d8d9386594a83dc7cbf327e3edf
> config: sparc-allyesconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/44e8bb824a0a4af6fc41d67b70ec3a678bd8125f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Sergio-Paracuellos/phy-ralink-mt7621-pci-phy-some-improvements/20210506-191714
>         git checkout 44e8bb824a0a4af6fc41d67b70ec3a678bd8125f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=sparc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/device.h:15,
>                     from include/linux/node.h:18,
>                     from include/linux/cpu.h:17,
>                     from include/linux/of_device.h:5,
>                     from drivers/phy/ralink/phy-mt7621-pci.c:13:
>    drivers/phy/ralink/phy-mt7621-pci.c: In function 'mt7621_pcie_phy_of_xlate':
> >> drivers/phy/ralink/phy-mt7621-pci.c:277:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      277 |    (unsigned int)mt7621_phy->port_base, mt7621_phy->has_dual_port);
>          |    ^
>    include/linux/dev_printk.h:118:33: note: in definition of macro 'dev_info'
>      118 |  _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                                 ^~~~~~~~~~~
>

Thanks!, COMPILE_TEST is doing a good job there :). Ok, so I have just
sent a patch for this:
See: https://lkml.org/lkml/2021/5/7/28

Best regards,
    Sergio Paracuellos

>
> vim +277 drivers/phy/ralink/phy-mt7621-pci.c
>
> d87da32372a03c Sergio Paracuellos 2020-11-21  265
> d87da32372a03c Sergio Paracuellos 2020-11-21  266  static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
> d87da32372a03c Sergio Paracuellos 2020-11-21  267                                           struct of_phandle_args *args)
> d87da32372a03c Sergio Paracuellos 2020-11-21  268  {
> d87da32372a03c Sergio Paracuellos 2020-11-21  269       struct mt7621_pci_phy *mt7621_phy = dev_get_drvdata(dev);
> d87da32372a03c Sergio Paracuellos 2020-11-21  270
> d87da32372a03c Sergio Paracuellos 2020-11-21  271       if (WARN_ON(args->args[0] >= MAX_PHYS))
> d87da32372a03c Sergio Paracuellos 2020-11-21  272               return ERR_PTR(-ENODEV);
> d87da32372a03c Sergio Paracuellos 2020-11-21  273
> d87da32372a03c Sergio Paracuellos 2020-11-21  274       mt7621_phy->has_dual_port = args->args[0];
> d87da32372a03c Sergio Paracuellos 2020-11-21  275
> d87da32372a03c Sergio Paracuellos 2020-11-21  276       dev_info(dev, "PHY for 0x%08x (dual port = %d)\n",
> d87da32372a03c Sergio Paracuellos 2020-11-21 @277                (unsigned int)mt7621_phy->port_base, mt7621_phy->has_dual_port);
> d87da32372a03c Sergio Paracuellos 2020-11-21  278
> d87da32372a03c Sergio Paracuellos 2020-11-21  279       return mt7621_phy->phy;
> d87da32372a03c Sergio Paracuellos 2020-11-21  280  }
> d87da32372a03c Sergio Paracuellos 2020-11-21  281
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
