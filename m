Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2F375B73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhEFTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhEFTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:10:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291CDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:10:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u25so8449095ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG9jOwFiA84QsvXeKtkPJx4Wd5oR6cikulbbKxFKoQw=;
        b=XwOmjoHSDYUzOZZo9RM8yRKjry3QYdWPX9wedIcb+FdAk0/pBANK4czeF/58w1USaw
         h4JoovWnrBM3/coVJ1f4cdJm3kL6hHpIVDlkXDSN8lbTDtyATY0jGMqTpgrR/8YxbfgH
         2Is8UxzBgZnII6egIRNVsKCcR+v4azm22/GdmTwF8r4tfO/pMVbAKw9thVuayOIDXWOb
         plOiEgXxLk9qK2qAPZz4YFk/uSAxYFDK1ORkybdZrU1ZUKqEOJCn/lQyLFq0X5L1dZcM
         YTO2vG7xXwH1lqV4cK2N7ZNO7EvZVxlv0rbo4AvWNmAfkkNGlwHf02Hqo7Qfhsb7UN5T
         pmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG9jOwFiA84QsvXeKtkPJx4Wd5oR6cikulbbKxFKoQw=;
        b=VDSck+GwM5t5T/w0GN6jZqEh5MKPQgbf5V0PQ4I8lIGfIW+DnAdWQe+j+ddkIjf3yN
         m5kz+WtV8GIUsWV+laIVMkc9UYdLQyZ97bQDdd642db5DgxHLLuF/whUtFgQJTdbEtv4
         YvGLpfJVlqG5SckzRaedhCCdALVP1IQUArcTbTM1C/6Gu0F+MS6sqqR9r3Gcjxf2IX51
         eOjBr/kmlCHpq5oSYwJOwqsRrtd0qp2diyNhuDKuK6kZqgqYAawCk8S3XLb7eJSdrWUS
         CHEdYpy0LVbYDbn+zWp2xmJnXIFerqdKe5gaIINHZ9AzmwEuRkVe1qXf2e+w2CNLf/Bt
         p39A==
X-Gm-Message-State: AOAM530jk2NdbAlxoxVCOx0mqcKkz8KL4ZnP2JxuaSxk8Ed1Z+E1uhbA
        jF69gpvnOqPt84DdUQfEQDowpPMaQpCtnjmHSCrYkW0sG2Zbig==
X-Google-Smtp-Source: ABdhPJy2n3sVUbfxiOKY+siaumEFBIdy1vSubLcdsd0ToLaORI5orWis1403DhOVtZqPRCJd3R7uuxs9Tmgr0yr1LJY=
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr4681534ljk.244.1620328198003;
 Thu, 06 May 2021 12:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <202105010813.KwuE0a5t-lkp@intel.com> <CAKwvOdnQ+hiGxfsG5VeJO4qGqfRPvf=Mp7TRgjKzZnTspZjntA@mail.gmail.com>
In-Reply-To: <CAKwvOdnQ+hiGxfsG5VeJO4qGqfRPvf=Mp7TRgjKzZnTspZjntA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 May 2021 12:09:46 -0700
Message-ID: <CAKwvOd=0_KbumyVLS2dn2DiKes50oG3te4Cd4aTAxnc5moERuw@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table'
 from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
To:     Kees Cook <keescook@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        khilman@kernel.org, robherring2@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ folks from commit 449e056c76cc ("ARM: cpuidle: Add a cpuidle ops
structure to be used for DT")

On Thu, May 6, 2021 at 12:05 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 30, 2021 at 5:11 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Kees,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   65ec0a7d24913b146cd1500d759b8c340319d55e
> > commit: 5a17850e251a55bba6d65aefbfeacfa9888cd2cd arm/build: Warn on orphan section placement
> > date:   8 months ago
> > config: arm-randconfig-r024-20210501 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 5a17850e251a55bba6d65aefbfeacfa9888cd2cd
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> > >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
>
> Filed: https://github.com/ClangBuiltLinux/linux/issues/1372 (though
> this isn't specific to clang).
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
