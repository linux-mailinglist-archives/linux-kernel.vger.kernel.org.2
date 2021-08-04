Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA333E06A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhHDRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbhHDRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:18:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CEDC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:18:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x8so5727606lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEMSlLo/4eh/Hj8rGHRAwqVIGlNxyDjckrl7zG49UZU=;
        b=s0SYWEmyqzG8E3OqYenfSTqbSEJfVxO5VO1UKgWV5luA7mZLTQnIEWyrDR1G+SKYG4
         j6mU3ylcl0vCC5v8N7/M98yfYD3A9RLAYu/uM2sX4QLIt66ZAVA+3Ty+6n2P8dxsDZJF
         Zc1jrBIr7woNQW0eeIZK1o0vz5rMhtjjrN5g6RBB2skpB001IesD7ghcptBsP4YhYMhg
         ZcbkRURclcm/MaRne783l9Mz5Ck/xJsoo4/50N952Oif/iker6T3LXHWikCzqkKTUdss
         a3h0azNmOI1Zeapfo6qwfqYEWaV9CrzMlQ2wyNWmBJykDT/WjFgtQkxw0YjJAlm1FoSq
         wADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEMSlLo/4eh/Hj8rGHRAwqVIGlNxyDjckrl7zG49UZU=;
        b=r1LtrJ/6MWBlKjTgiW9gnHTQYlRXniu3tp9pXjDXb9YHHw5+LgkT8/tIEQ4k0+/+Bf
         ZIIzQV+elp59Hox5ZwlBRG4FB0OkgPr368o/FsFqCltA35zMabXsEwWRtNb9ewAczFLZ
         G91qCMT8lCS4b6uG6HO0UCObMMO6h6cj/ep5ic+w3jwXCp2nHfGJKg0cJekl//qIdLr0
         tOtIcoz7tEaqr40Kch09iIYAMxAlDhW1gsaT7gvEkwjYu6Zc5tep0bei4toYO1f0e6Ku
         6YJjWDqNheaJqFvJ1XSSUtmkRECHw2DbrRpMtRNWk2wR5L1JkJATCadx0mijoIgXULNX
         a6Hg==
X-Gm-Message-State: AOAM530f+bmawjcYaXIO402MLvNOCyK1GuPvA/pNImcRsIjzvRiUIMUU
        cj02FhK9Ofr3ujwAjCoe9vARm7vfYsm3ew7aJUIvqPupVL7cjw==
X-Google-Smtp-Source: ABdhPJzFUWbfdSUmjcKOz5zqZmHo9hyzefo+K3cplbHAFwQKp0np9RT0yrCABkpmAjnXdi1oOJ7t22Lg1HgVjR3Fr9g=
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr196778lfu.547.1628097502271;
 Wed, 04 Aug 2021 10:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <202108041936.52T4sUU6-lkp@intel.com>
In-Reply-To: <202108041936.52T4sUU6-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Aug 2021 10:18:10 -0700
Message-ID: <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
Subject: Re: ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko]
 undefined!
To:     Chen Rong <rong.a.chen@intel.com>, Philip Li <philip.li@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 4:39 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nathan,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d5ad8ec3cfb56a017de6a784835666475b4be349
> commit: 6fef087d0d37ba7dba8f3d75566eb4c256cd6742 hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
> date:   4 weeks ago
> config: hexagon-randconfig-r023-20210804 (attached as .config)

cool, one of the first reports from 0day bot of hexagon :)

> compiler: clang version 12.0.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6fef087d0d37ba7dba8f3d75566eb4c256cd6742
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6fef087d0d37ba7dba8f3d75566eb4c256cd6742
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> >> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
