Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001AC306759
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhA0W5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhA0W4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D9C061788
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:26:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i63so2333660pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMFtAtZNI0COZaqF8mB8/06frm5QBEITJpap0cTagq8=;
        b=CRXdKGJOGXXsOQpHtELIKR8umZ5rhCnWLRE36xgaT6dDVwCPEZjCeBR2Qsk7DeBK8t
         GWwKHGqh6cb6Fo5dOCjrFchI4QQ89+oaW5HAjc5xx3YuDcqPEcf6kdF6T98nxDSLUnkx
         fBgBERt0O3M9585mXFDborfe6U0cHo57JYy6hVW81eqgZGPWKR1An2L2yv9+paOg3CXH
         tCVrdAtbgv444EeewcZ6ba0aJYVoQ9S09DHAXWwLR1VEJ7UndfBlBjQT+Dcb1uaNW+wF
         TJmXQlSft7xyE1BlHvgn+w3v/p5eFlE74xEJHfRfIwJfNEGxjRThenG+fIFn+j0kj6qs
         dW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMFtAtZNI0COZaqF8mB8/06frm5QBEITJpap0cTagq8=;
        b=TMGuvIjgl1HnneeF0N2U5Ozw2bZCENZBAzZ8ZMGijd/FJD2ySZ3ospwacluETqpuUo
         OnuSB+xiEgqGKkAiNUj3d6s97hh8F2z3BuMn6f1/Q9ad3E8R+loGH36euniq9Vop35qH
         EPZBFSWk0F7/aqXnuPuWexE9JlhlnhwG80Vuuc+c7eLB3eXXAv8ghJxOJYfU1UnxLUkF
         yGSCpoPUzXZ4J3xIi6+EFcr6FzMAM+9XwUnVvHFDwB89rwMHdEsqQ8QiR943jTYK1NEP
         ng1QBdb+9H+haoWgI0nfpgzg+fjKR9bwSRL6V25rDZk0wOP2YgyhsUjlKKDWEt0rGJP1
         GJ3A==
X-Gm-Message-State: AOAM533t+l6iJ6keh/4RBJsYtuDo+ZSYdytCm475LfHEmOXmARRamqfR
        ibskFMekmHPM+GS/04xD0yCrJ1JpnzR43a784/M8Uw==
X-Google-Smtp-Source: ABdhPJzOWe2d9GCIKgOrAtd2j0dugg5j43ntl0uPF21manG+gGVrrjiRx873lNw4xwTd8k/hi0vONdzecQhgyBv8vSs=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr13557544pgc.263.1611786417749;
 Wed, 27 Jan 2021 14:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <202101130859.JSORPQUn-lkp@intel.com> <20210113013130.GA3446359@ubuntu-m3-large-x86>
 <CAKwvOdnx99YTGhP-mH-9E6YTLLUfauuteFtqZSeXLv5Vy+XowA@mail.gmail.com>
In-Reply-To: <CAKwvOdnx99YTGhP-mH-9E6YTLLUfauuteFtqZSeXLv5Vy+XowA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Jan 2021 14:26:45 -0800
Message-ID: <CAKwvOd=WpK52Y4HpqoeaukmfOAWqTg-+NV1wdBjokwRuumdtSw@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 5:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 12, 2021 at 5:31 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Jan 13, 2021 at 08:39:52AM +0800, kernel test robot wrote:
> > > Hi Nathan,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on 7c53f6b671f4aba70ff15e1b05148b10d58c2837]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
> > > base:    7c53f6b671f4aba70ff15e1b05148b10d58c2837
> > > config: arm64-randconfig-r031-20210112 (attached as .config)
> > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 32bcfcda4e28375e5a85268d2acfabcfcc011abf)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install arm64 cross compiling tool for clang build
> > >         # apt-get install binutils-aarch64-linux-gnu
> > >         # https://github.com/0day-ci/linux/commit/775adad26a60878926c0ee6cd460a1375bbe51e6
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
> > >         git checkout 775adad26a60878926c0ee6cd460a1375bbe51e6
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    lib/ubsan.c:192:6: warning: no previous prototype for function '__ubsan_handle_add_overflow' [-Wmissing-prototypes]
> > >    void __ubsan_handle_add_overflow(void *data,
> > >         ^
> > >    lib/ubsan.c:192:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > >    void __ubsan_handle_add_overflow(void *data,
> > >    ^
> > >    static
> > >    lib/ubsan.c:200:6: warning: no previous prototype for function '__ubsan_handle_sub_overflow' [-Wmissing-prototypes]
> > >    void __ubsan_handle_sub_overflow(void *data,
> > >         ^
> > >    lib/ubsan.c:200:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > >    void __ubsan_handle_sub_overflow(void *data,
> > >    ^
> >
> > Given that these are compiler inserted functions, there is not much of a
> > point to having prototypes to them. If people feel shutting these
> > warnings up is worthwhile, we can just add the prototypes right above
> > the function definition in a follow up patch.
>
> Same as stpcpy; it would be nice though. ;)

If you would be so kind, I'd be happy to sign off on such a v3.

> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
