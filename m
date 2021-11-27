Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7344D45FF91
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 16:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbhK0PQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 10:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhK0POY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:14:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE50C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 07:11:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so51633351edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjlmdsLgAtz4NzqXsAhkQsWkfptqwKSqRwT8CWQ7q5c=;
        b=VQWjzhfFwOp09sOHPQJRn0BZZUCfS7xRXwOQrH2VhaKgpiCv92pkjrMRf/H1sHMTv9
         zhBZIKKxVNWjPdZMxXQkqtp0sJrHgwxkXFEhqYdzTwmCEAJVHhkNWmEZAjQN73HMhJWt
         8igMvfdyH4lT7VM/9KrbW1/EIT38C7N3U84dB4A10gNpYCQ+nT8vzjtdKB1f+9t1FEmv
         R32u/HC/T8cIlG9c3V1h01mQeffmj5H7RN5Og7CuNVF0hviFTnqQi3rMA0R5YL7T4/1f
         MhVc4kcO+zwG2bvElwph8sK+avefucx3bXyiiJVmufElIS7LEdgCJiA7GfK/8AWTdrez
         XASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjlmdsLgAtz4NzqXsAhkQsWkfptqwKSqRwT8CWQ7q5c=;
        b=vMI70EhbtuKADn0Xf2Sb53aS9vQCiBx7+kScdPQ3zbM6SvNIDoGljbFyz4r6AZoRbu
         BuASbwVHSSxCXj/nKyJvF/WT4zZ2+lRMZ0R9fV1G+lR8BCxlMtahojcVyo+sDck/Xs7C
         j0dcaEXgJ1cnGVoJABdpPHAVTxhqa+eZzIUX4JzxUKot5PYKKFuNwlyX21kv7hpd3NbT
         nXU4+cTW8KAMTRMVsIqVWH6t1iTrqGIIqHz1sbmNKsy7iK9OE6KXx8AJUqE/yYhNk8xE
         pgs1DIQ5Uz9eRyMafAtie2Xybd68Ub/v8pZIzgmVCkkzL/8RfahUJjpdfL4GjdkPTajh
         mNZQ==
X-Gm-Message-State: AOAM531DSLONdWWAN4q5pNX5LkdSNditXLqknvzGDrW8rsaReOhkV55o
        lsqr616OHTBMWbpJn1wqsI77aUg9YfUY2Onfkbw=
X-Google-Smtp-Source: ABdhPJy17y4eqnPYwTitRBGt3bjzpNuWpKQATXYoz5BKcTMokwHoWIM+LEdhq5aX6Easx6rY53+3zIwDkfaVtx2f/A0=
X-Received: by 2002:a17:907:6ea1:: with SMTP id sh33mr46809783ejc.150.1638025868309;
 Sat, 27 Nov 2021 07:11:08 -0800 (PST)
MIME-Version: 1.0
References: <202111271017.dLo8jJ8p-lkp@intel.com>
In-Reply-To: <202111271017.dLo8jJ8p-lkp@intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 27 Nov 2021 07:10:56 -0800
Message-ID: <CAMo8BfL88Qc6o=WheT6+n4pOpXQbnw220UQa_GCQb98F=S9ffA@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-4.19.y 565/981] arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33:
 error: initializer element is not constant
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 6:33 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> head:   1f244a54b39dd02c69f79001b38e2650e96f1ea8
> commit: 1c21a8df144f1edb3b6f5f24559825780c227a7d [565/981] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
> config: xtensa-randconfig-r001-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271017.dLo8jJ8p-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1c21a8df144f1edb3b6f5f24559825780c227a7d
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-4.19.y
>         git checkout 1c21a8df144f1edb3b6f5f24559825780c227a7d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:10,
>                     from arch/xtensa/platforms/xtfpga/setup.c:19:
>    include/linux/dma-mapping.h: In function 'dma_map_resource':
>    arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
>      182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>          |                ^~
>    include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
>       77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>          |                                             ^
>    include/linux/dma-mapping.h:329:9: note: in expansion of macro 'BUG_ON'
>      329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
>          |         ^~~~~~
>    include/linux/dma-mapping.h:329:16: note: in expansion of macro 'pfn_valid'
>      329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
>          |                ^~~~~~~~~
>    In file included from arch/xtensa/platforms/xtfpga/setup.c:37:
>    arch/xtensa/platforms/xtfpga/setup.c: At top level:
> >> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error: initializer element is not constant
>       50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
>          |                                 ^

This happens because the backported change
1c21a8df144f1edb3b6f5f24559825780c227a7d depends on the change
d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of CONFIG_OF")
which is not in that stable tree.

Should I send the backported version of the d67ed2510d28 or should
the change 1c21a8df144f1edb3b6f5f24559825780c227a7d be reverted
from the stable? (IMO they are not the stable material).
-- 
Thanks.
-- Max
