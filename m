Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558A337AE75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhEKS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:27:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:26:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so23464441lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhZvq9NigfldJZ4Wc+DFOgWX9q8/F8c7ps2aCL3SG2g=;
        b=rPLtW+eS2hFVw5ZyflDGUAd+SCBdD7MSgFPrQ4t9Yhy7oX1BN0efADK/dMUDY8WFO1
         nb6/jRoYbt2tHPh/osipdyzlCPhY/WAJX9hwYT1w28pPKIjS7Fatvg1JmdUO7FSW67EX
         mlzqSPykCXG7ZYLGUwuSrsmGBxQfiS1JhvwoEDa+yezrCKvUMSrm3suDlpgFSyiN4Sgi
         yn5avpBWvvGDIzkzf+qgJjEVwt4Zkl10cu7NNW7T47oQmkidofs/E0WfNONd7YqaNw4O
         MwJZ2rOu11tQV0t/QtSGzWec5Mn875ZfyKLukEmcVXbSImPbAjeCAB2Bga30pSx2bIZC
         G1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhZvq9NigfldJZ4Wc+DFOgWX9q8/F8c7ps2aCL3SG2g=;
        b=uCkNTT1DQZ5TMfOwxTf7wg4Nnr1e2LXKW1wGnO1UU2V9oOf1itcFq3Md16tzcL21Kh
         lZf0ZHAIOxeDvHcpY6sm/16sK600BXmuruWdvcUqRUNk3xOM+zSSS/IZlNlWEuilPR7X
         txUbXZRj4RNT25WKp5ae8e+NwUKosx6pHNqOjWp0708BYSwLNwTZWKgWN6167vnGKJx1
         Mz8YtlvliOo+EmsVfzsY6UkQqBbiQz628NvntMPUCBd3NizrqYJX+SxuiAcd1EyiXbf8
         5t5kV29nNcd4gg/AD0iRl2R6rMM1Tc5L1TbvAtUR4MLM8AK8PORysa9Rscyi/7pyHlv3
         tDDg==
X-Gm-Message-State: AOAM5302rUp6/tkrBkoMPWD8fzlU1+1M9wAerkHgATHO12U7hQf0nPsZ
        aRMV2uTH82C3sescFlMTStL66pPtPqsMsClmKA2BFA==
X-Google-Smtp-Source: ABdhPJxX3ZhLnA0m24HvMI97PdVkWs3y4OAJjkKzD75lYZNG83VRZYEIji6TZy8xZ//DYWHqIWUWo9Dz5NNJQqHNu24=
X-Received: by 2002:a19:ac09:: with SMTP id g9mr22064527lfc.547.1620757601606;
 Tue, 11 May 2021 11:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <202105010813.KwuE0a5t-lkp@intel.com> <CAKwvOdnQ+hiGxfsG5VeJO4qGqfRPvf=Mp7TRgjKzZnTspZjntA@mail.gmail.com>
 <CAKwvOd=0_KbumyVLS2dn2DiKes50oG3te4Cd4aTAxnc5moERuw@mail.gmail.com> <20210511140712.GA24463@lpieralisi>
In-Reply-To: <20210511140712.GA24463@lpieralisi>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 May 2021 11:26:30 -0700
Message-ID: <CAKwvOdkS87-zgPyfxPFyXFFo+rs3ijp9LR4emzzfcUVP4p8sEw@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table'
 from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Arnd Bergmann <arnd@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        khilman@kernel.org, robherring2@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 7:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, May 06, 2021 at 12:09:46PM -0700, Nick Desaulniers wrote:
> > + folks from commit 449e056c76cc ("ARM: cpuidle: Add a cpuidle ops
> > structure to be used for DT")
>
> Hi Nick,
>
> I thought this patch was meant to be merged upstream to fix it:
>
> https://lore.kernel.org/linux-arm-kernel/20201230155506.1085689-1-arnd@kernel.org
>
> I can add a review tag to it but I don't think that's necessary, just
> let me know please.

Ah right, thanks for the reminder.  Arnd?

>
> Thanks,
> Lorenzo
>
> > On Thu, May 6, 2021 at 12:05 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Apr 30, 2021 at 5:11 PM kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > Hi Kees,
> > > >
> > > > FYI, the error/warning still remains.
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   65ec0a7d24913b146cd1500d759b8c340319d55e
> > > > commit: 5a17850e251a55bba6d65aefbfeacfa9888cd2cd arm/build: Warn on orphan section placement
> > > > date:   8 months ago
> > > > config: arm-randconfig-r024-20210501 (attached as .config)
> > > > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> > > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >         git fetch --no-tags linus master
> > > >         git checkout 5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > > > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > >
> > > Filed: https://github.com/ClangBuiltLinux/linux/issues/1372 (though
> > > this isn't specific to clang).
-- 
Thanks,
~Nick Desaulniers
