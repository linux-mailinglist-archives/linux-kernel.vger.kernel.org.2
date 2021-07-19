Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1403CF0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378534AbhGSXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441861AbhGSWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:13:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2ABC05BD29
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:23:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e20so28489585ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O2tFGMyrB07jg3h1yvm2qJn119u9lIk/lEjx1+0F15w=;
        b=P6a2N0TFZWT6YcoKO8LpqWLZeMkjLP+gHFYoUltOVXZuCqpJuLrAE8v71wwwr5VET7
         xLI8oB0sBRvdyX0A1WZ5jKz1I04iqC10RjV5KhnmHSF6sRjvkcqvqCV5GhxFpuD9c7A/
         aZXoBt3vfslK/FrJYu3HdVlwp1gR7lTZ32YwwWxf88fUQOqczAWm2laaXsc7O+TwSRMH
         B4CyRTsANvBYlqmmn2CVFgX6LXpwUAerw+1sEta2ouONoTvUr2wFZ5j1mG+pvC6DpFZl
         prdfw7Ou4UbPJo3FdYjkunqR0kXgYe2R8dGbYdIBtLOtK1JhP7cDfR8J4YVTMBUC6u4p
         JlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O2tFGMyrB07jg3h1yvm2qJn119u9lIk/lEjx1+0F15w=;
        b=WEkMzuzDT2xyVZz/Yjn6BaY3Uk5X5eocqJ9tEx3yhcLBVcAkAqlj3ANvsjwZUSv7Lj
         wg10k+ULAyX2Sptx7EQJjbJm86y/HwSVVxU0Dhu41b6lVwZAiJl7Z7Hy63h7npVOskzq
         DtltvKGy1wQ6ZQqGi5pdrtvkJ5jRjwqiKNJlS/4zP8bYliHW6SSs1aBGaN+Y2yostC5o
         MAzrV7++vQOQiJVHBdAc3JltQ3MV8vKgQTpgz+H/0yBYVA/lBWl4mqq1HDulYJKrfsUU
         THwtcZIAd84b8icKBdeE0WaP7MiQXsO8pTpwW0WbY33aZLhpJsC31DfBCEP4ah9WQO0M
         3cag==
X-Gm-Message-State: AOAM531CBfs4P0BM8+78VJvJyBzWIlFfWkWEie1JKPeV4j1uirNJUVFW
        RK5RxGMdh5CRa9L/f7CPqf9GYyTHUCg=
X-Google-Smtp-Source: ABdhPJz/s/UFGLIbvXFIipVL2Eh5qGIC5mVtMDUZ5QdgnnJ9fVOpoRL44CFEG3W6yb/QNK1hqGFdsQ==
X-Received: by 2002:a2e:7319:: with SMTP id o25mr19406365ljc.264.1626733427660;
        Mon, 19 Jul 2021 15:23:47 -0700 (PDT)
Received: from [192.168.2.145] (79-139-166-182.dynamic.spd-mgts.ru. [79.139.166.182])
        by smtp.googlemail.com with ESMTPSA id e7sm1504668lft.30.2021.07.19.15.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 15:23:47 -0700 (PDT)
Subject: Re: regulators-tegra20.c:undefined reference to
 `regulator_sync_voltage_rdev'
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107200504.B8RIfkWm-lkp@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e9f6254d-1ee1-8316-5c5c-33b08642eac9@gmail.com>
Date:   Tue, 20 Jul 2021 01:23:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107200504.B8RIfkWm-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.07.2021 00:45, kernel test robot пишет:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> commit: 03978d42ed0d69cb5d38dfb0aeb5216d19507c60 soc/tegra: regulators: Bump voltages on system reboot
> date:   7 weeks ago
> config: arm64-randconfig-r001-20210720 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03978d42ed0d69cb5d38dfb0aeb5216d19507c60
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 03978d42ed0d69cb5d38dfb0aeb5216d19507c60
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    aarch64-linux-ld: drivers/soc/tegra/regulators-tegra20.o: in function `tegra20_regulator_reboot':
>>> regulators-tegra20.c:(.text+0x260): undefined reference to `regulator_sync_voltage_rdev'
>    regulators-tegra20.c:(.text+0x260): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `regulator_sync_voltage_rdev'
>>> aarch64-linux-ld: regulators-tegra20.c:(.text+0x26c): undefined reference to `regulator_sync_voltage_rdev'
>    regulators-tegra20.c:(.text+0x26c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `regulator_sync_voltage_rdev'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

https://patchwork.ozlabs.org/project/linux-tegra/patch/20210621160739.22448-1-digetx@gmail.com/
