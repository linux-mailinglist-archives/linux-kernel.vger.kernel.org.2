Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B615E4460AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhKEIdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:33:39 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48890
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhKEIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:33:35 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3DBB3F1D5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636101050;
        bh=3zeX0Rs0QKASIs8P8BVkrOrhEZ27zDCKjAHzwPWKbxk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=D/ZdXONJwRVMylmlWakf65orinSLuLXacdnmYXFODW+eo9cFdb8RltoNM+PqCzBxo
         hzDb4KKpPj3J1JNbrAvc4Y2D2nkE+EVKC9ihEozO7DRrPI7p/kV2HD42h3uIDjqf/t
         iPZ7iUgVwWFw3QV9IuR4x3rL2H8wmY2wzcsNz3xJ2I4tdMGCKu8aKBm+RPadIgO+i6
         MYKQeJSQj+E8ATB206VZhdktdEj0iCM6Hb2mhRgkKcgWQtB4V8GdGgXu5C9d8HlZvJ
         74BkLIsXLFnDolJDpW4a4Xc8nxFkPPYwp5Ty1ROkrkMQyg6pr24ijeOsYWUKGOG9xQ
         cdi5KR54TDjKQ==
Received: by mail-ed1-f72.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so8204316edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 01:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zeX0Rs0QKASIs8P8BVkrOrhEZ27zDCKjAHzwPWKbxk=;
        b=xDA8ew0zuF4g0wjdAhBk3eW5f0wI9HYJwtO7im17YOe0lhshp4GOUX4mdkyLARbypg
         FZ3/WtmjKEcVfh1HByJ3/9ldRWi1VhfEjMjCa8V3a6ng+YzQPs0ZGMh5JTFVjV60GuqX
         O9OLPoT1qMmcMf+oWB14afuN0bQgOSayEB9N+873E0e9f6lqpu8zaOVNDZGy+/1Kf+of
         NF1SAF+o2f5j/PLsuQSpMldoTbDhYTP5WVv1qqvioXPHFV/08LPpdZJO3752IpbxhF5b
         gcjkE45B4BhdF52j5qutauuDo5+FUDrJwy9f6tgneDsEq8mhlNzdsxYBTLU9mYB0h+yZ
         TNUw==
X-Gm-Message-State: AOAM532fvAjHCfGkDPh4wxLm8L9UhHEhGZxjJVUp86GXbGsKDhz6LT3H
        tB02Vzxt4sD65K5ETI2CE/wfGebyLoNzbrSNgtKJ5TChHMGFQmz92z5gzd7A+iwsKWIDvcWBGhK
        +BiNwLgLMSESHM21lm5gelceuh5KEShoHz/EwVVmh1q+m3QDv3+r3zjbnZw==
X-Received: by 2002:a17:906:308e:: with SMTP id 14mr6456325ejv.241.1636101050195;
        Fri, 05 Nov 2021 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHmU/hYX9I6re446MlWTX+YEuOJXgDYsGf7tF4bSpVFgB/Hyn7E/qQdyMvr13nAYWujE4cAQBSKmBgHnyzTY0=
X-Received: by 2002:a17:906:308e:: with SMTP id 14mr6456311ejv.241.1636101049998;
 Fri, 05 Nov 2021 01:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <202111051651.GG52FPnU-lkp@intel.com>
In-Reply-To: <202111051651.GG52FPnU-lkp@intel.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 5 Nov 2021 09:30:39 +0100
Message-ID: <CA+zEjCujX+LyHUfekV6=PUxGwkGhG=47cbMSv1y6c--pNNODgw@mail.gmail.com>
Subject: Re: [atishp04:ox_v5.14_working 4/13] arch/riscv/mm/init.c:714:83:
 warning: suggest braces around empty body in an 'if' statement
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:20 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/atishp04/linux ox_v5.14_working
> head:   9d2e326476c44eade0d6b7ee54c4eb8918d6aa94
> commit: 7c0cb480378b7fc7ccc693fc867c4d62c420732d [4/13] riscv: Implement sv48 support
> config: riscv-rv32_defconfig (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/atishp04/linux/commit/7c0cb480378b7fc7ccc693fc867c4d62c420732d
>         git remote add atishp04 https://github.com/atishp04/linux
>         git fetch --no-tags atishp04 ox_v5.14_working
>         git checkout 7c0cb480378b7fc7ccc693fc867c4d62c420732d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    arch/riscv/mm/init.c: In function 'create_fdt_early_page_table':
> >> arch/riscv/mm/init.c:714:83: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
>      714 |                                    (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>          |                                                                                   ^
>

Indeed, create_pud_mapping is an empty macro in 32-bit, I'll fix that
in the next version.

Thanks,

Alex

>
> vim +/if +714 arch/riscv/mm/init.c
>
>    696
>    697  /*
>    698   * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
>    699   * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
>    700   * entry.
>    701   */
>    702  static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>    703  {
>    704  #ifndef CONFIG_BUILTIN_DTB
>    705          uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
>    706
>    707          create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
>    708                             IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
>    709                             PGDIR_SIZE,
>    710                             IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
>    711
>    712          if (pgtable_l4_enabled)
>    713                  create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
>  > 714                                     (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>    715
>    716          if (IS_ENABLED(CONFIG_64BIT)) {
>    717                  create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
>    718                                     pa, PMD_SIZE, PAGE_KERNEL);
>    719                  create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
>    720                                     pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>    721          }
>    722
>    723          dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
>    724  #else
>    725          /*
>    726           * For 64-bit kernel, __va can't be used since it would return a linear
>    727           * mapping address whereas dtb_early_va will be used before
>    728           * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
>    729           * kernel is mapped in the linear mapping, that makes no difference.
>    730           */
>    731          dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
>    732  #endif
>    733
>    734          dtb_early_pa = dtb_pa;
>    735  }
>    736
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
