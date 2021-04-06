Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB381354DED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhDFHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhDFHei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:34:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 00:34:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id c15so3445018ilj.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1rz64W3qpTMmQiYeFsZQrw5A/71EhMPvbEVoO9GiM8=;
        b=rHnELZY2vTf8uQe6TrlBh1XmoULlKNq81R3ss4YyC+X5JYsXcJwk061jBAWhzWmX80
         TO4cJMaaifaFRL0T2FnIo43ktg9aHkNquZ3ax7LPkd/+kzMHyJ8UK+UjMXvSb5dX+92G
         CJxhQSf4uogc2WsjKIty2WQ2Yc1InBgc9QnlHdxOkacS8720Y9H0Z0+zGSUh88stSrbs
         LnX2gAL/nk3mE9vOaYmSFVuxGomBn8l4HvAWnq+EbY87ibaOkD/kHtweQtb6kTOy2bpI
         kd43+V648onFnBuqXwPaBNfDaqQcoD6D4LkOtULZo3dyIt4C7B9ABPOQ2ofvna7J5CTd
         VdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1rz64W3qpTMmQiYeFsZQrw5A/71EhMPvbEVoO9GiM8=;
        b=en/xqe4YaZvDNI+dqTYI+WfEsdOXMyA8zcudUSLF1h7odfe4sh91wUWe+uYsdtRRT4
         FAOqfKgcn80RdKOW3GIwmlnknRFtH4AHa5bARL03yrVZ63AKydI4ercnjh6CYnaJb6N2
         klvZSuU1JV9t8to+TPGf3U8yHfc9z1SUfLA/0LpeyitcghgTlrbvnXEZwbI3ohSICUR4
         kJKGfRC2YauyzcCkkG7ZpsYSPnN1pxqpiLUrmU8reGSnUmChDrVvHq/F5eUkA28LJBBj
         /oRJeSNJo+zvr31lopcftQHRHwna67A+82ENe1VMfxcHY9CjQJEswvt3g8WiZreuJg+W
         waCg==
X-Gm-Message-State: AOAM5309+gvH86+LbmnaoTPBTs20z2zE2Zd8ngAl2yVDvWxbdqge1ObY
        EiSj2P3r5TQvLgtX6hRinUDpgJSkniQu2L7VDfcd9A==
X-Google-Smtp-Source: ABdhPJxdpJWc/bqgEpDdB3OhLaSF+VgJma/urmc9afLm5l0TFhPdPsKtb0+1JsfjRBxHm3u0ejmnMoHJFQnXnkQjo74=
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr22800336ili.134.1617694470261;
 Tue, 06 Apr 2021 00:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210405200821.2203458-2-fparent@baylibre.com> <202104060814.berYSn6V-lkp@intel.com>
In-Reply-To: <202104060814.berYSn6V-lkp@intel.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 6 Apr 2021 09:34:19 +0200
Message-ID: <CAOwMV_xn2pv1vVoqz5qb+jNsssCKwVtNGG=yEtcA324adau6Rg@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: mt8167: add smi_common node
To:     kernel test robot <lkp@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I forgot to mention it, but this series depends on
https://patchwork.kernel.org/project/linux-mediatek/patch/20210405172836.2038526-1-fparent@baylibre.com/

On Tue, Apr 6, 2021 at 2:25 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Fabien,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on arm/for-next keystone/next soc/for-next rockchip/for-next arm64/for-next/core shawnguo/for-next clk/clk-next v5.12-rc6 next-20210401]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Fabien-Parent/arm64-dts-mediatek-mt8167-add-mmsys-node/20210406-041016
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-randconfig-r011-20210406 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 2760a808b9916a2839513b7fd7314a464f52481e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/bbbf216a8432b5af475e4e709bf481475c1af58f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Fabien-Parent/arm64-dts-mediatek-mt8167-add-mmsys-node/20210406-041016
>         git checkout bbbf216a8432b5af475e4e709bf481475c1af58f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> Error: arch/arm64/boot/dts/mediatek/mt8167.dtsi:73.26-27 syntax error
>    FATAL ERROR: Unable to parse input tree
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
