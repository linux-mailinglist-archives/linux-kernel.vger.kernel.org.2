Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7B3E2EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhHFQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhHFQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:58:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF5C0617A2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 09:58:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so12723779ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgwG50222WXNSnZDFbFFmfq8ScgcYhX4k3g5dD+29I8=;
        b=ce4ConzvKP4c0JUSTNGDg7dzY7uYTO6Y6TPUDY6ZVq3I0XfBHI5M+B1xbTOGtV3+DP
         tgvjxJ2PL7zTFfb4RFFmh+SWMq9ItF0bAsPu7mNcjnJNa/lzqXZDiQBw18Z2EkeKgaB4
         pfZEKokXI8T5CXDKlm5FOgr6+n7C1kgmDdB3jvMnxM/AMp6moyCudIuv0JfONrJdMoZk
         wtw/8bgdBaT9ZyhbyngGT9c2lu0fGXND2q6bYljQ1Bx7+07yLnETMvaMe9YFF/PoBSuw
         qn/vhAYAfb2kYYwFf40SboceNh75+JFMXE88qQBBHp77jH98TJLXl1r2xFUsN/a4tldZ
         ay7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgwG50222WXNSnZDFbFFmfq8ScgcYhX4k3g5dD+29I8=;
        b=TRlFLKzx3mfLvuK8b+GnXtqiN6jX2xW0zw4DJ35qR6KJTfHrD/dChtYYdHVjTLZgtR
         Z4pESR+JWJ2Vsxs9Krjub9skmoidlceprYmqW0zTlEoIJQ/wDkHdtr76feLVF9krOvVO
         0yzEVallxwslzNeNY2TH41YnYqCLynqYumUGHCr1l9ZLWcfME1V1l5WiP+duqnsFwR92
         GtyHKNLuoR3LDaHG7XppNYSe43pBce/MlZQ2FysP5URITIue6AiulrNYQjWFKYEF7kw4
         QjtpbA5zGcYHwToxBTPRTTVKRcCgNZeyzhoBzpGJlVh7tdcebM+UAem0/CTsWzGvif5i
         NLHg==
X-Gm-Message-State: AOAM530qrb+ehxt1gWm/bIRxSiv2v9XUWO+BdruTueJdaLLH/umlpv7v
        XOZc2WzxWeGjcqIJCUGsjn1aAJpkLD6YW4hFFGR8nw==
X-Google-Smtp-Source: ABdhPJwh9X6VXp5jwfjj4nWlzKm+uhGHgWG8ga5D06FrxmQoPj7H5FzZ2hdfHKnAiVqX7JAdVNfQk721OFxNIB24fCo=
X-Received: by 2002:a2e:5352:: with SMTP id t18mr7071504ljd.495.1628269081263;
 Fri, 06 Aug 2021 09:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <202108041936.52T4sUU6-lkp@intel.com> <CAKwvOdmOTNTGvGeaRKSp4f6M1PC-HQLjMoaeQU6WM9ygxuU5_w@mail.gmail.com>
 <20210806102246.GB1330186@pl-dbox>
In-Reply-To: <20210806102246.GB1330186@pl-dbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Aug 2021 09:57:49 -0700
Message-ID: <CAKwvOdmP1Bb0wkyUJAs-n5wT-obH56jw2zcBpT7jpV84id4tfw@mail.gmail.com>
Subject: Re: ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko]
 undefined!
To:     Philip Li <philip.li@intel.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 3:28 AM Philip Li <philip.li@intel.com> wrote:
>
> On Wed, Aug 04, 2021 at 10:18:10AM -0700, Nick Desaulniers wrote:
> > On Wed, Aug 4, 2021 at 4:39 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Nathan,
> > >
> > > First bad commit (maybe != root cause):
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   d5ad8ec3cfb56a017de6a784835666475b4be349
> > > commit: 6fef087d0d37ba7dba8f3d75566eb4c256cd6742 hexagon: handle {,SOFT}IRQENTRY_TEXT in linker script
> > > date:   4 weeks ago
> > > config: hexagon-randconfig-r023-20210804 (attached as .config)
> >
> > cool, one of the first reports from 0day bot of hexagon :)
> :-) yeah, we just enabled it. BTW: we use one specific version of clang,
> does such hexagon support work in latest clang 14.0.0?

Yes, it ought to; we're using ToT llvm to build it in our CI.  I'm not
precisely sure about clang-13 yet until the apt.llvm.org binaries
exist for that branch.

>
> Thanks
>
> >
> > > compiler: clang version 12.0.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6fef087d0d37ba7dba8f3d75566eb4c256cd6742
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 6fef087d0d37ba7dba8f3d75566eb4c256cd6742
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > >> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> > > >> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
