Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4E37AABB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhEKPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:32:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhEKPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:32:24 -0400
Received: from mail-vk1-f197.google.com ([209.85.221.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgULs-0000CH-Tc
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 15:31:17 +0000
Received: by mail-vk1-f197.google.com with SMTP id r85-20020a1fc1580000b02901f918091a78so1614980vkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4+KMSSJfs6285aprQFfxRR2fhyW9Dgy1161xUmoMREg=;
        b=SmrwUtlvHAgqY2pD5J6RhEjM9oN8T3OPUDDK2KJQZrLZizqcaOjkPxzUFjncrAWxkm
         V/9qTW2z3q24u5uXjM6CGJ1fXq7zS+mrQseA1QKCXaTYZS44MqLExkyuOEH6VZKQPo+5
         5YoCb2oVkbZHYV1HnD8QU/Nj3PeqNOgAcUBxlBVZNAiWnAsFTwuOO5pI/HpowAxr0OGz
         J5hxg9Lnv+ke+VrCxZfcJKv3ztRHTyCdiTehLu2p33oCp1dtql5R7O49YZoTkb6lfk1F
         xukL09of+Xc35CxZ1GJ0l3EPOpRfluO0+yClPKWUdeMnpUs6FPedRtdzzvzNQEg+TFbL
         mVaQ==
X-Gm-Message-State: AOAM533UtP6irPhSfgpq0yP5HrVkAi8BZM2k4oCRdOE8WIIC8d0fFaKG
        aBGChSq1Q4krtrepkfqT2iaH+SGE5PCyx5lvF2Q+so6/hJmlkOZ01ayZrpLZOtjLIf1SAVHLhZI
        pXG1psR898/DwVQTjuYoOYI7x7u9twkQo1LMBs9jFvg==
X-Received: by 2002:a67:ec12:: with SMTP id d18mr25988790vso.7.1620747075097;
        Tue, 11 May 2021 08:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqDMUs/v0Xcwl5Yvx5QCtahvd9WLnq4NjrGuWgs1ozarszbCqEF8zbb9jxtEiIz0fE2jKJbA==
X-Received: by 2002:a67:ec12:: with SMTP id d18mr25988754vso.7.1620747074830;
        Tue, 11 May 2021 08:31:14 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id o5sm2281864vke.32.2021.05.11.08.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:31:14 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] memory: tegra: Enable compile testing for all
 drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210510213729.7095-3-digetx@gmail.com>
 <202105112125.VctfC6sX-lkp@intel.com>
 <dd0b550e-76a0-bfbc-9d6f-5d867812046d@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <06addbf3-0090-b76f-65cf-e0c10d284c69@canonical.com>
Date:   Tue, 11 May 2021 11:31:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <dd0b550e-76a0-bfbc-9d6f-5d867812046d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 11:17, Dmitry Osipenko wrote:
> 11.05.2021 16:58, kernel test robot пишет:
>> Hi Dmitry,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on tegra/for-next]
>> [also build test WARNING on v5.13-rc1 next-20210511]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Enable-compile-testing-for-Tegra-memory-drivers/20210511-053910
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
>> config: powerpc-randconfig-r032-20210511 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a0fed635fe1701470062495a6ffee1c608f3f1bc)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install powerpc cross compiling tool for clang build
>>         # apt-get install binutils-powerpc-linux-gnu
>>         # https://github.com/0day-ci/linux/commit/ecd67b1d49eb33c9821130a2b3b896bab395118d
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Dmitry-Osipenko/Enable-compile-testing-for-Tegra-memory-drivers/20210511-053910
>>         git checkout ecd67b1d49eb33c9821130a2b3b896bab395118d
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    __do_insb
>>    ^
>>    arch/powerpc/include/asm/io.h:556:56: note: expanded from macro '__do_insb'
>>    #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra30-emc.c:18:
>>    In file included from include/linux/interrupt.h:11:
>>    In file included from include/linux/hardirq.h:10:
>>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>>    In file included from include/linux/irq.h:20:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:211:1: note: expanded from here
>>    __do_insw
>>    ^
>>    arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
>>    #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra30-emc.c:18:
>>    In file included from include/linux/interrupt.h:11:
>>    In file included from include/linux/hardirq.h:10:
>>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>>    In file included from include/linux/irq.h:20:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:213:1: note: expanded from here
>>    __do_insl
>>    ^
>>    arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
>>    #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra30-emc.c:18:
>>    In file included from include/linux/interrupt.h:11:
>>    In file included from include/linux/hardirq.h:10:
>>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>>    In file included from include/linux/irq.h:20:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:215:1: note: expanded from here
>>    __do_outsb
>>    ^
>>    arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
>>    #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra30-emc.c:18:
>>    In file included from include/linux/interrupt.h:11:
>>    In file included from include/linux/hardirq.h:10:
>>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>>    In file included from include/linux/irq.h:20:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:217:1: note: expanded from here
>>    __do_outsw
>>    ^
>>    arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
>>    #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra30-emc.c:18:
>>    In file included from include/linux/interrupt.h:11:
>>    In file included from include/linux/hardirq.h:10:
>>    In file included from arch/powerpc/include/asm/hardirq.h:6:
>>    In file included from include/linux/irq.h:20:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:219:1: note: expanded from here
>>    __do_outsl
>>    ^
>>    arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
>>    #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>>> drivers/memory/tegra/tegra30-emc.c:757:18: warning: implicit conversion from 'unsigned long' to 'u32' (aka 'unsigned int') changes value from 18446744071562067985 to 2147483665 [-Wconstant-conversion]
>>                    writel_relaxed(EMC_ZQ_CAL_LONG_CMD_DEV0,
>>                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/memory/tegra/tegra30-emc.c:161:36: note: expanded from macro 'EMC_ZQ_CAL_LONG_CMD_DEV0'
>>            (DRAM_DEV_SEL_0 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
>>                                              ^
>>    arch/powerpc/include/asm/io.h:679:40: note: expanded from macro 'writel_relaxed'
>>    #define writel_relaxed(v, addr) writel(v, addr)
>>                                    ~~~~~~ ^
>>    13 warnings generated.
>> --
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:203:1: note: expanded from here
>>    __do_outl
>>    ^
>>    arch/powerpc/include/asm/io.h:537:62: note: expanded from macro '__do_outl'
>>    #define __do_outl(val, port)    writel(val,(PCI_IO_ADDR)_IO_BASE+port);
>>                                               ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:217:1: note: expanded from here
>>    __do_insb
>>    ^
>>    arch/powerpc/include/asm/io.h:556:56: note: expanded from macro '__do_insb'
>>    #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:219:1: note: expanded from here
>>    __do_insw
>>    ^
>>    arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
>>    #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:221:1: note: expanded from here
>>    __do_insl
>>    ^
>>    arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
>>    #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                           ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:223:1: note: expanded from here
>>    __do_outsb
>>    ^
>>    arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
>>    #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:225:1: note: expanded from here
>>    __do_outsw
>>    ^
>>    arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
>>    #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>    In file included from drivers/memory/tegra/tegra124-emc.c:16:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/powerpc/include/asm/io.h:619:
>>    arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>    DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                    __do_##name al;                                 \
>>                    ^~~~~~~~~~~~~~
>>    <scratch space>:227:1: note: expanded from here
>>    __do_outsl
>>    ^
>>    arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
>>    #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>>> drivers/memory/tegra/tegra124-emc.c:802:26: warning: implicit conversion from 'unsigned long' to 'u32' (aka 'unsigned int') changes value from 18446744071562067985 to 2147483665 [-Wconstant-conversion]
>>                    emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_DEV0, EMC_ZQ_CAL);
>>                    ~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/memory/tegra/tegra124-emc.c:154:36: note: expanded from macro 'EMC_ZQ_CAL_LONG_CMD_DEV0'
>>            (DRAM_DEV_SEL_0 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
>>    13 warnings generated.
> 
> This doesn't look like a useful warning from clang, it should see that
> the constant value itself isn't truncated, hence it should be a problem
> of clang. Do you think it's okay to ignore this nonsense?

I admit I also do not see the real issue here. The DRAM_DEV_SEL_0 fits
in u32 and there is no other bitwise arithmetic than just OR, so why
clang assumes it can have 32 most signifcant bits toggled on?

+Cc Nathan and Nick,
Maybe you could shed some light here on this warning?

Dmitry,
In general you should not ignore it because:
1. This breaks allyesconfig with clang on powerpc (or it is one of the
stoppers),
2. We might want in some future to build it with clang.


Best regards,
Krzysztof
