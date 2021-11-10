Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA944BDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhKJJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:39:13 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:38714 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKJJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:39:12 -0500
Received: by mail-ua1-f54.google.com with SMTP id o26so3496721uab.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjRoJDGMYdtXmSz7TTJxLp3mJHyckkoVCe4HjPrG/DM=;
        b=abRvR8+OaKOUlB5eYw67BEnCd7iyVS6GjUDgvMuzLYgXLB55CVSF52kegKqWXaek2/
         diRUzFl/FX0qqZsL5wjGFW4U9XSIWJWnFCdadnmXPzDrknks2pgdPRDejHfd5rH+EROq
         XNSWHXThyuNCTaVhO7f0Jlls1RL5YLwhDs6Il8CWz8VhiI25XPxB72meo77irDqFKm3m
         SzZdPTSGlL0RVjNq/dsnwRiLJXunyTRJ1oZoceYGEwcl1RvEJsaZtWbC9+2ko9rBa4Yg
         G9oj/vEiqfgF2yCIzRBlEOJShsrguizDKJWRMdhNUUtk7eUn303IW9aa6SlFXfcSsG9Y
         I1Xw==
X-Gm-Message-State: AOAM533N1ZQntYxazCq14zmRJ6zjVT4tjqPZ7tijiwPU0hG0i5tTLCMZ
        vdDxFnDn5xUNZ2dVTtygT/BlwGe7fBaHGQ==
X-Google-Smtp-Source: ABdhPJyLHZ9LVvIPwKNaXJWi6SSfhjM8LLneIilWtx/nv9BTM2VaVKcNuDpsK4/Vmb73tfheZ0HmJg==
X-Received: by 2002:a05:6102:160f:: with SMTP id cu15mr14591131vsb.11.1636536984541;
        Wed, 10 Nov 2021 01:36:24 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id g28sm592061vkl.16.2021.11.10.01.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 01:36:24 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id az37so3398971uab.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:36:23 -0800 (PST)
X-Received: by 2002:a05:6102:1354:: with SMTP id j20mr52487004vsl.41.1636536983716;
 Wed, 10 Nov 2021 01:36:23 -0800 (PST)
MIME-Version: 1.0
References: <202111100840.gaI6caTo-lkp@intel.com>
In-Reply-To: <202111100840.gaI6caTo-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Nov 2021 10:36:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXYv8eSd6FY5JzjZ9bR1sfGT4jgwdj4qvD6heG9ue7Mw@mail.gmail.com>
Message-ID: <CAMuHMdUXYv8eSd6FY5JzjZ9bR1sfGT4jgwdj4qvD6heG9ue7Mw@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no
 previous prototype for 'fdt_check_mem_start'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Test Robot,

On Wed, Nov 10, 2021 at 1:39 AM kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.

Indeed, and currently there are no plans to fix that.
Please add it to the ignorelist.

Thanks!

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cb690f5238d71f543f4ce874aa59237cf53a877c
> commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
> date:   9 months ago
> config: arm-randconfig-r022-20210927 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for 'fdt_check_mem_start' [-Wmissing-prototypes]
>       62 | uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>          |          ^~~~~~~~~~~~~~~~~~~

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
