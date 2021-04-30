Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63443703CA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhD3WzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhD3WzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:55:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE68C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:54:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x19so82106608lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXeedSSOrsmb6qb67Du7dd041/fe2IS6Q+d3Ob+OEEM=;
        b=f7WaMElQ975FejxarLC2EcZ5PI8DXKV5Xd3NrpV2TxhrYwub1uaocn2bk1ctcZeG5R
         4JcE3oPV1fAvQ2yokm2zPHynw8xT0eDQJ5pMUWsCPbHvH+vCvgFtZ9B6jLjtU4UVFf1+
         ZOJRnfC8Cnv+AEFOqURVE/8eV8k6XGolgB8pP76X7m1doWzclrTu8co/8D2x3WxjH081
         m9a2tN1CE0FKS/9PeWJCSCjybsY0JxxzZcb8az9DkhcKcHy0LXTqoy/5EqFY5tDwkfG4
         xHEdsRM9mTGnqwwQagsxun0QC9BZBXlTqo0xN52+fWqqBLP5dm+T3iHtQV4bjSSabv0T
         aY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXeedSSOrsmb6qb67Du7dd041/fe2IS6Q+d3Ob+OEEM=;
        b=tRsyP2/UNmF/YS1F8lpRaW6Zg47oBumI8k9WvlyPBak+z8WmKJ9icji4BNldbkkjmh
         xh+uiuDsU22PX/sHPzlAqi0a6UScsMA4l20sT4oN+an1Hd9vLeoVUFiQKjo3yMouyh2h
         WCVNe4OPNW0TwV+zwGHHfhT4jRlRMHmYbI9d5AIuPscuqAD+6/rvQ2/zlHWlVkDsF/+T
         KuGGEWhrtnDZ9S/GIGMBQg7T7otun4yO3OyqGKEF4njZscjNh5AST1FIVoRid9Qt3/no
         7CqkfZwui83r7gyCavN154cHwkwsTDdIhI9w34OmYl5WiJevwauYFglkmMu+0vWTEkSj
         oKuA==
X-Gm-Message-State: AOAM532/i4S+Ozim+a/cZQT8R5mALGPEw1iW7geJ/WmMZp5exPbsCsJO
        9/Yxc4ogxK8jwKTCXTgEHpEn1X5ShpXvD9zwbCJJ4w==
X-Google-Smtp-Source: ABdhPJy7STQvOKYhURNqJ6Q98DceiZ+t82vVH3R08QUrjDp6DMuQkc4gZsoijSk5UFO6gsMz/bPsyP6L0X1sbM1ucfE=
X-Received: by 2002:a05:6512:159:: with SMTP id m25mr5029057lfo.73.1619823265217;
 Fri, 30 Apr 2021 15:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <202104280827.lscZW8Xg-lkp@intel.com> <YIkgNWRJ+9BpEtvb@smile.fi.intel.com>
 <YIkhNjYTBgFpgcia@smile.fi.intel.com>
In-Reply-To: <YIkhNjYTBgFpgcia@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 15:54:14 -0700
Message-ID: <CAKwvOdk9wiGaSPMg6Ltj=aU4LvM0fnkgjWLNnTeLtpMJ1RYrMQ@mail.gmail.com>
Subject: Re: drivers/pinctrl/intel/pinctrl-intel.c:1663:14: warning: variable
 'dummy' set but not used
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 1:47 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 28, 2021 at 11:43:33AM +0300, Andy Shevchenko wrote:
> > +Cc: Arnd and Nick
> >
> > (Seems like a clang bug)
> >
> > On Wed, Apr 28, 2021 at 08:10:34AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e359bce39d9085ab24eaa0bb0778bb5f6894144a
> > > commit: 10c857f063fc63902160755a6e23fa594290c6d3 pinctrl: cherryview: Switch to use intel_pinctrl_get_soc_data()
> > > date:   8 months ago
> > > config: x86_64-randconfig-a005-20210426 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 87fc97169e7901dfe56ca0da0d92da0c02d2ef48)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c857f063fc63902160755a6e23fa594290c6d3
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 10c857f063fc63902160755a6e23fa594290c6d3
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/pinctrl/intel/pinctrl-intel.c:1663:14: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
> > >            const char *dummy;
> > >                        ^
> > >    1 warning generated.
> >
> > Seems to me a bug in clang. The variable is used to check if the body of the
> > loop should be executed or not.
>
> The only way of make this variable being unused is to avoid the loop being
> executed at all. This may be the case iff (mind to f:s) the supplied size
> parameter is 0, but how on earth clang can prove it (esp. taking into
> consideration that it's not true in real life)?!

Yep, the patch that enabled support for this warning in clang was
reported after multiple reports from projects; I'm working on helping
the author revise it based on cases it still flags from the kernel.
-- 
Thanks,
~Nick Desaulniers
