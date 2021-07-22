Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673BD3D22D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhGVKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhGVKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:55:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:35:55 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ck17so2412287qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gesMtrUah0NJ2jTkz8KPEiCEAERPBYdYVkAExdI+OCM=;
        b=qqqhRjJVXDV6cHyzYu2NBGPWCOXvThtoilCR5G4xsxXFhqAZgPtF5q/92MFKyRohE2
         YtIIa/twuh8rzWgP+1OpM8UE64oxw34xZ6T7ZABoFPfJwqhhdsN6sNlJPa3k0mXPLhEe
         BqQS6vjHa+X3OO7NcduNjsaP6ApSFAX1NJMNHIPFPChzB0oZ1Vgvuwg/Mr56GbeRu/d0
         +VCYNVR821S+WpnJv3E+Py7S1Lml+I4pmNIeruKiOqnJmTrhgp0npudvOfiManFzd7Kx
         7GXNxtIMtYIs2yoWSBkquhRKYX5rpWYwGp3zwA2nLkiL2kJySAcKnrd5YyAxqykZvSR4
         Szog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gesMtrUah0NJ2jTkz8KPEiCEAERPBYdYVkAExdI+OCM=;
        b=nMK+qyt7d0V/zVo8xi9NB17gIkIDhmZgSCkV+KKeULUdq90+G3X1OGpeTidpQ3S0Mz
         ov5M1XjxT+kn4FXU1GPiB7KWxs5cuJr1KjRERuzUPrZZEkfqAWgUk9sRbTD2Jj6Knfxa
         Y4C4dgJDP2Vo1/kjCId55P+JPH7tY+MTtS8sA1bcUY54u7G9XrzrZwxtNNHyEgLq/58+
         py5Iif9UQXGG9S9f8yngBZ4MmaULaYyyO0KQbDufjh6R2mPi9QKcLDJzYfs9eQRtXvvW
         JcFLjLN4GNOXlcBe1gRKplrFR5LjlkxGMR3Ik8d2JmhbWHNLOqyTNZIDaF2YjNSjvHHK
         zgJQ==
X-Gm-Message-State: AOAM530TkHTY/2Pd+jzmjwoFEGjwaFt01MsnyJp26e6wle8tV/uwvOH5
        EKkocQP3SCuDVjyKcHqWdXmd/sbFuP7klZDshTy5TC/VhWw=
X-Google-Smtp-Source: ABdhPJzdUxLlGHv3McZYt8XIoEZKPTnKnB6h4BMTvkOnd5yh4+vtdzkb0UyNGO/kIniWG5X6Mflvojo3tpvjBlPYqN4=
X-Received: by 2002:a0c:ecc9:: with SMTP id o9mr39905665qvq.59.1626953754434;
 Thu, 22 Jul 2021 04:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <202107221908.f0JFmEis-lkp@intel.com>
In-Reply-To: <202107221908.f0JFmEis-lkp@intel.com>
From:   Dongjiu Geng <gengdongjiu1@gmail.com>
Date:   Thu, 22 Jul 2021 19:35:43 +0800
Message-ID: <CABSBigQwHFyyCFtVSDHt4bLOsi=TSqOW++3-6gGdDfUHuzM8zQ@mail.gmail.com>
Subject: Re: clk-hi3559a.c:undefined reference to `hisi_reset_exit'
To:     kernel test robot <lkp@intel.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Dongjiu,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   3d5895cd351757f69c9a66fb5fc8cf19f454d773
> commit: 6c81966107dc0caa5d2ebedbcebb5f10d865064d clk: hisilicon: Add cloc=
k driver for hi3559A SoC
> date:   3 weeks ago
> config: arm64-randconfig-p001-20210722 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6c81966107dc0caa5d2ebedbcebb5f10d865064d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6c81966107dc0caa5d2ebedbcebb5f10d865064d
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0 make.cro=
ss O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi=
3559av100_crg_remove':
> >> clk-hi3559a.c:(.text+0x24c): undefined reference to `hisi_reset_exit'
>    aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi=
3559av100_crg_probe':
> >> clk-hi3559a.c:(.text+0x2c0): undefined reference to `hisi_reset_init'
> >> aarch64-linux-ld: clk-hi3559a.c:(.text+0x318): undefined reference to =
`hisi_reset_exit'


Hi Stephen,

     Can we apply below patch to fix this issues today? Thanks a lot.
     https://lore.kernel.org/lkml/20210717043159.12566-1-rdunlap@infradead.=
org/

>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
