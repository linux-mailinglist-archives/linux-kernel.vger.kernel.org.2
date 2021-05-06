Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F0375B62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhEFTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEFTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:07:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB35C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:06:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so9265628lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NdQibKnHEdQUK2PlGMLKqJjV1Iooerno1oueN2ggmw=;
        b=cv21ktlF/4Rns6HXJXW5UcaUMVeA/utxLwl7OtKBQSWwcXPq/qHZaAWl5S7O90lI8p
         saXEisLrTjZhWX9P/u9wGbNSjBUZ4smfV6+E9JBRw+vxOjsnYPNROk1TdapbkN3JB7D2
         nfbixQav4hh8DWRagYVXUrcmte1K8XVFn9JgQae+tbhuQRDkZb8uV0dH4m4BsQdY3AeQ
         LibQP/BzFdgZl1bL5x+G4Z2g9/F7NqSwfVO5FVYN8kLNkN0EIw49RcpWBgHPAxFWYvv4
         BbcE085/IVkttfLm2/bMHOl8t+i0lhrLPhoCm5hhdaDEPcF5hM8JLwyj51CSWMqMteJg
         DV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NdQibKnHEdQUK2PlGMLKqJjV1Iooerno1oueN2ggmw=;
        b=Wiu12doazAK14CLLIk07HsMA5BbuHtNpaykPkgDLTwiYmT1lgZw1MgyaIbDPUZZxXx
         SQ0OheJt8HxxdTX74uXhYYDi/DofiWSXYzLj5MxbcdbQYxF1UKssFyeAas9pca5p3uh4
         JnKSKCC/GE5zAP+h4HKcVqWBsn/mwHtb60Q4a8qg/Z/UcSNCw2FDHn/ZhtxlHI1G932c
         Ha0oucFlkOBaFdilbZGuLqXz/PyJ6SKlk8APNoWfw4Yd875oMZ16v8UzoJxF7PLkgG7o
         gOcF2L+d0NpJyBH5SbjKV45LHYamSKsHSaguXFbVZa11cKGBSRKn2AbMYs1MyTKi4Fzx
         RnTA==
X-Gm-Message-State: AOAM533I0LGNn7z+be8s5EWxeyPfFusxXSotDSDFqUEHlp5sIwyibFKB
        7VNIK7AXadyYinUY2l8Cu8we6OCY1qH2IV1T//VBIg==
X-Google-Smtp-Source: ABdhPJwIuamjq0gLYlU+hEQ1wuem2GBW5yAIEBDAzm+sLdIeod/YdIi4hCR2GaUSBw1IScR7cNjXzgbxUVaMSPbjORQ=
X-Received: by 2002:ac2:528d:: with SMTP id q13mr4114753lfm.73.1620327963078;
 Thu, 06 May 2021 12:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <202105010813.KwuE0a5t-lkp@intel.com>
In-Reply-To: <202105010813.KwuE0a5t-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 May 2021 12:05:51 -0700
Message-ID: <CAKwvOdnQ+hiGxfsG5VeJO4qGqfRPvf=Mp7TRgjKzZnTspZjntA@mail.gmail.com>
Subject: Re: arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table'
 from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 5:11 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Kees,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   65ec0a7d24913b146cd1500d759b8c340319d55e
> commit: 5a17850e251a55bba6d65aefbfeacfa9888cd2cd arm/build: Warn on orphan section placement
> date:   8 months ago
> config: arm-randconfig-r024-20210501 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a17850e251a55bba6d65aefbfeacfa9888cd2cd
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5a17850e251a55bba6d65aefbfeacfa9888cd2cd
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'
> >> arm-linux-gnueabi-ld: warning: orphan section `__cpuidle_method_of_table' from `arch/arm/mach-omap2/pm33xx-core.o' being placed in section `__cpuidle_method_of_table'

Filed: https://github.com/ClangBuiltLinux/linux/issues/1372 (though
this isn't specific to clang).
-- 
Thanks,
~Nick Desaulniers
