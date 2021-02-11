Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75EE319414
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhBKUOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBKUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:14:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F96C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:14:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u15so3933429plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0+Rd3SMlnTZL3B0kN7kR2b8yNSNIxsbDEg4HntAOQk=;
        b=JyBYEa2dDOxrXBiJWu4Ew/7uSg1ej8/qXgmyIQuKpp3YR3QExH98xWVSihkdv2shfs
         q24NrMlzViSwomDDdaCaK+m8vLxAHiYPkn2sH+hWx9S26EkDPVRDoV/MmnRYiNdfn8bC
         FGMRVzcPlXBUSwBhl1FZnvU8pXVDYVuJbkt+jmqyBrMKO+kDQ8Rv6sCfhVWChNBWuNI9
         dfCanHX6UTtm4aFYPkNaiiaeruU6OLaSOzTER2FFAg45Xw4lwIpmVKiaF8y5JYz83znp
         aMbeb2REQXnlul4u9+JAHK1LERLBZ92b4TK+9Idapl2K8yBfmxw7kLlaHUepkxP4oVgs
         L+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0+Rd3SMlnTZL3B0kN7kR2b8yNSNIxsbDEg4HntAOQk=;
        b=bv3Po7F7Fb5JZwWb3vs1z7RWH+agdwrkPmchYMxEO5goyOA5mPPw3NWLpB2I/Yh2Bh
         rCu6gC47prK6D5PCxsob8wKJwCKOO7WakitfJHuN5Mcd6suI1CtAa6rjEcfOlOxARK9W
         M5q5GtCj/QQh51cwnzS5vn/A8ojQSE1pU9Nz/v63VJDfP+CBTpRwtVO2ins8isijE8Rm
         XHTksx4G0F3aIM6HBfU0AKCP5EcXJ8vhdst3XkeZbF6bvZsaKycJQ6YAZ0nhqKfv4j8b
         Hafo34hOVWW0cFHwF+xIBOHk2gR5i9MB5DOpsKC65ZWTqDqNqKgdxBGVl0Ii9HlOdPQx
         O07Q==
X-Gm-Message-State: AOAM5326T2rHGcVjnzhVexIfwgVXgdvMcxCFOkJGrlv7ThLTy6rc0Qim
        OEbKGpwRSuPz+hiw/jxOUkgAdqO+faQpEdlprWZbsQ==
X-Google-Smtp-Source: ABdhPJw9cHHFD4VpMWJpJEZ4Ku1SeaDKze75gzCy5L+9OwcT8ryvRGliF0ocAJ9f8f2XDSB4axthzo8a48LPfH68HMY=
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr5503516pjo.136.1613074442341;
 Thu, 11 Feb 2021 12:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-4-vincenzo.frascino@arm.com> <202102120313.OhKsJZ59-lkp@intel.com>
In-Reply-To: <202102120313.OhKsJZ59-lkp@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 11 Feb 2021 21:13:51 +0100
Message-ID: <CAAeHK+yB4GLCn2Xu4z7FRLNOkVDFr0xXN3-D34BdJbRmWLpSxA@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] kasan: Add report for async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 9:04 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vincenzo,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on next-20210211]
> [cannot apply to arm64/for-next/core xlnx/master arm/for-next soc/for-next kvmarm/next linus/master hnaz-linux-mm/master v5.11-rc7 v5.11-rc6 v5.11-rc5 v5.11-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210212-004947
> base:    671176b0016c80b3943cb5387312c886aba3308d
> config: riscv-randconfig-s031-20210209 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-215-g0fb77bb6-dirty
>         # https://github.com/0day-ci/linux/commit/df25c9583cd523a49f2407e0aeee55bdec24a14e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210212-004947
>         git checkout df25c9583cd523a49f2407e0aeee55bdec24a14e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    riscv64-linux-ld: mm/kasan/report.o: in function `.L0 ':
>    report.c:(.text+0x480): undefined reference to `kasan_flag_async'
> >> riscv64-linux-ld: report.c:(.text+0x5c4): undefined reference to `kasan_flag_async'

Let's do something like this (untested):

https://github.com/xairy/linux/commit/91354d34b30ceedbc1b6417f1ff253de90618a97
