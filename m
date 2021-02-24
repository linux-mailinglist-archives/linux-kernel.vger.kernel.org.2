Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BC3238D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhBXIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234539AbhBXIj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:39:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F58264ED6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614155926;
        bh=js1QlWJlitsFZrR0Rg5ILWFvVbVJKg/oOAHlh2xG76w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=espoFEfA06X6fpnH54hGdG8+jHadSzrbFWC3NacQuoec6LQwnCXkys24m3OG0MJRw
         8z+dLieLitjpJJUCvJvNTS735I05Dka3aszl830tg4YsSMLZoEobNkyUAlXaIlZGk6
         mT2+e+gy5/DTYOwqq8Z1LrSA89r/BGSESlWQHK08tis/4o53+BW498RgZEAlalA94m
         inG2f0l81bvgOd8KcOPn2FoqWGM+gQr954ctsh2YO8CQ6+Xex72d1gDZ+JToLST0Tw
         gDQwTz3AbXvLGHkgqQZqbNy6eTSgJjOmXoh8nmZtQYDnXHCXvlcy99hy8yXab0Lt/I
         Ip03aDdZXVQ9A==
Received: by mail-oi1-f174.google.com with SMTP id z126so1654841oiz.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:38:46 -0800 (PST)
X-Gm-Message-State: AOAM533nBIec8kZr1XDqavirf73D8HSiL8XR3U+C3Ytv1/9Rn2cBrasO
        p626YO+VXfR5QP7z+lpKETOafdFxHb6EmGJeA+Y=
X-Google-Smtp-Source: ABdhPJyQArhicbKOE3+jiFNKc6a5pkxbY0M0MS74wlKXN/w4TzsCFbFoOlf1Ba5P3ZDb9gNUKMXKhhlu9yC7AoCJeGM=
X-Received: by 2002:aca:b457:: with SMTP id d84mr2068966oif.4.1614155925485;
 Wed, 24 Feb 2021 00:38:45 -0800 (PST)
MIME-Version: 1.0
References: <202102221437.vHlLwHmG-lkp@intel.com> <33c7cb1f-b6c0-24bf-0e6c-23d5472e4c29@infradead.org>
In-Reply-To: <33c7cb1f-b6c0-24bf-0e6c-23d5472e4c29@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Feb 2021 09:38:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
Message-ID: <CAK8P3a1zfwJs3=mhvTGpLLak1Lqq6N-4N+zHrh-4KMRE75HP8w@mail.gmail.com>
Subject: Re: (.text.ks8851_probe_common+0x370): undefined reference to `__this_module'
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>,
        Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 3:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/21/21 10:12 PM, kernel test robot wrote:
> > Hi Marek,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   31caf8b2a847214be856f843e251fc2ed2cd1075
> > commit: ef3631220d2b3d8d14cf64464760505baa60d6ac net: ks8851: Register MDIO bus and the internal PHY
> > date:   7 weeks ago
> > config: parisc-randconfig-r034-20210222 (attached as .config)
> > compiler: hppa-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef3631220d2b3d8d14cf64464760505baa60d6ac
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout ef3631220d2b3d8d14cf64464760505baa60d6ac
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >     hppa-linux-ld: drivers/net/ethernet/micrel/ks8851_common.o: in function `ks8851_probe_common':
> >>> (.text.ks8851_probe_common+0x370): undefined reference to `__this_module'
> >>> hppa-linux-ld: (.text.ks8851_probe_common+0x374): undefined reference to `__this_module'
>
> Hey Arnd-
>
> I wanted to see if you had any ideas about this problem.
>
> CONFIG_KS8851=y
> CONFIG_KS8851_MLL=m
>
> The problem is that 2 drivers share some common code, but in one case
> the shared code is builtin and for the other driver it is a loadable
> module. The common code is first built as builtin, so it does not have
> the "__this_module" symbol.

This is the patch I sent for it:

https://lore.kernel.org/lkml/20210125121937.3900988-1-arnd@kernel.org/T/#u

        Arnd
