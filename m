Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C456C43C8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhJ0Liy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhJ0Lix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:38:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B18C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:36:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so4203403ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jNE0OAxgmiWrM2U7QGcqx5yCfZsfhHL6W85yfZy/RiA=;
        b=MpT6L7+3/uE5qrm4RZw7GgGon4IJASy3xTC09G0TUVB7EmupJ3mL+iatYAa32HXVCT
         4wLiSbLA/zFAnGatVunZM8+lAYpRMH6N7xXWiR7TEVzX5uo3o24EkCbKytyJcOM33KzC
         BQm09Ca/PzY/zjhQEjN0z1zkL294yTJ4yZx604LjYqeLRchTFyLQRI2FSG1nvxjSo00/
         wY17BcooKQxTGEzcW/LQ6uPsaNTKQNl1+QwkLUwk7gwsHXQQWPq0B52yF7mez27StC63
         2be8st5tEKHf54QApxnBwMbroqW6KGzEAsQkuYRTm38CaARhuFfgsSUssrqN7aWPoxCN
         FRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jNE0OAxgmiWrM2U7QGcqx5yCfZsfhHL6W85yfZy/RiA=;
        b=MQcu9WILSgr+nHT/u4q9LQ16GQ+UqLiRGVwueeQa0323e+b74O3iKbYwH2spaGXToR
         hHtx1Jei3l8p4U7kEKNJLbeqUAI6sKRM2BCQULtsjZ3M+GVvFBOKB6lUF7AJuVd8GLpa
         kf1SKbfjOHzm+1AmO9HXSnbZkraiYrKFUs7BdcydTQdaO4lQWl9C/j2y+1X0zuhUuvFV
         Z1caIX3s49AI4j5AuS6ZDKbvmiqXzQqvxiPyYelj1gQjcZGXO9UXktMBe7ZcAMTUVJIA
         9iOj+8a7GXKjXIjbUU0CrV3nVHdIGKOafPiHNE8K8UJhhshjW7UzVX/8Hxmc1DdH8Ryr
         vpIQ==
X-Gm-Message-State: AOAM532HYCU0E2969NWN15WnfxlAG5i4G7WNtAlS3o8xljSvI/hnm2yM
        NJzzVMLPTLb5PMF7LH8Rb6pISoxLvx7pfg==
X-Google-Smtp-Source: ABdhPJzHcmUtgyf1r4xjWSINOIjBz8i1ONAASfC9vY3KZORmA2qLUbjTublG7UKHOY5k9dHtnEks+w==
X-Received: by 2002:a2e:85d8:: with SMTP id h24mr7465142ljj.130.1635334586039;
        Wed, 27 Oct 2021 04:36:26 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id o2sm618941lfq.260.2021.10.27.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:36:25 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:36:24 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [sailus-media-tree:master 1/5] max96712.c:undefined reference to
 `v4l2_async_unregister_subdev'
Message-ID: <YXk5uK9eqMT0dPhE@oden.dyn.berto.se>
References: <202110271818.TcGzSbjQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202110271818.TcGzSbjQ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

What would be the best fix for this do you think adding 'depends on 
VIDEO_DEV' to VIDEO_MAX96712 is the right path? I tested it and it 
solves this problem but not sure if it's the correct solution.

On 2021-10-27 18:03:25 +0800, kernel test robot wrote:
> tree:   git://linuxtv.org/sailus/media_tree.git master
> head:   dad71f55b69025a58cc54db95ed1a9e8cedbb08e
> commit: d7fb3f13fef118db0598eab49b915f23f943511e [1/5] media: staging: max96712: Add basic support for MAX96712 GMSL2 deserializer
> config: m68k-randconfig-r005-20211027 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add sailus-media-tree git://linuxtv.org/sailus/media_tree.git
>         git fetch --no-tags sailus-media-tree master
>         git checkout d7fb3f13fef118db0598eab49b915f23f943511e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    m68k-linux-ld: section .rodata VMA [0000000000001000,00000000005b1f17] overlaps section .text VMA [0000000000000400,0000000000653bbf]
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>    time.c:(.text+0xe4): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xa2): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0x120): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: arch/m68k/kernel/machine_kexec.o: in function `machine_kexec':
>    machine_kexec.c:(.text+0x136): undefined reference to `m68k_mmutype'
>    m68k-linux-ld: machine_kexec.c:(.text+0x13e): undefined reference to `m68k_cputype'
>    m68k-linux-ld: arch/m68k/kernel/relocate_kernel.o:(.m68k_fixup+0x0): undefined reference to `M68K_FIXUP_MEMOFFSET'
>    m68k-linux-ld: arch/m68k/kernel/relocate_kernel.o:(.m68k_fixup+0x8): undefined reference to `M68K_FIXUP_MEMOFFSET'
>    m68k-linux-ld: arch/m68k/kernel/uboot.o: in function `process_uboot_commandline':
>    uboot.c:(.init.text+0x32): undefined reference to `_init_sp'
>    m68k-linux-ld: drivers/staging/media/max96712/max96712.o: in function `max96712_remove':
> >> max96712.c:(.text+0x54): undefined reference to `v4l2_async_unregister_subdev'
>    m68k-linux-ld: drivers/staging/media/max96712/max96712.o: in function `max96712_probe':
> >> max96712.c:(.text+0x1c2): undefined reference to `v4l2_fwnode_endpoint_parse'
> >> m68k-linux-ld: max96712.c:(.text+0x332): undefined reference to `v4l2_ctrl_handler_init_class'
> >> m68k-linux-ld: max96712.c:(.text+0x38c): undefined reference to `v4l2_ctrl_new_std'
> >> m68k-linux-ld: max96712.c:(.text+0x3b4): undefined reference to `v4l2_ctrl_new_std_menu_items'
> >> m68k-linux-ld: max96712.c:(.text+0x3ca): undefined reference to `v4l2_ctrl_handler_free'
> >> m68k-linux-ld: max96712.c:(.text+0x406): undefined reference to `v4l2_async_register_subdev'
>    m68k-linux-ld: max96712.c:(.text+0x416): undefined reference to `v4l2_ctrl_handler_free'
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
>    Depends on MEDIA_SUPPORT && VIDEO_DEV && MEDIA_CONTROLLER
>    Selected by
>    - VIDEO_MAX96712 && STAGING && STAGING_MEDIA && MEDIA_SUPPORT && I2C && OF_GPIO
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Regards,
Niklas Söderlund
