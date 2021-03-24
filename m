Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE22347E79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhCXREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhCXREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:04:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40991C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:04:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a1so31166188ljp.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdzgWN/3EyVqs7LL1UB6MB8anRRzjh+ULV006vyWNDw=;
        b=LwDrzvPsAHMsjWTQAfLneSXEq40YN0QaNTk1k6gsf7VrnN8iVbpw2lJLd7SzjY0WDy
         8XHB2ZsbjnwLa83eUecLPjXJruWzMic7Lr55kXOKQvHnLJoTsxxNcWrk03dDYV+ToUFf
         WwaAFNbVel/FxXSrEqnb9Us1xGPf5TTqYFOWm0d8LYumUeKKCnOSUpuKONaS6rlD1nMx
         qIeWZ0XN3CfYmVGxVzVQPFbajFqA9PxvnAdXvvUALVskfzgh/NqSfMs12Oi1zL9PMk/x
         fgRg6xP0VRiWy3NxyWbwKpDkSz9HA+qnrN8sEz0j13l9cMMt6VLxedzKH1ZBNz9XIKPd
         jT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdzgWN/3EyVqs7LL1UB6MB8anRRzjh+ULV006vyWNDw=;
        b=jboZslFj1zOJ0B4+CeoTQySFkwKmuVLu/VZmUiMsP/9pqohtRbsffUef5uVWCg+6/c
         xobkCekjp6MC0l+5/sP6rYCj6SjrlxfJg8xZQiULYnF8R7YynhG7GpnCwqWiLyg9d3W1
         V2f2P6bTcJ/x0j006hqPG9stMTeIO/xBx/B2H9L7P0/CsOQazrQbKWCr310xM9q9Gcgw
         NNUGZ67YkeBdFpbraNlnf7hc9zw6Un3xcJmmx6LgsJPklQKx0MxuKHbo6Q1uMNP9KSNX
         YMqVUix4kwa5Ot8H4QJJIuuWc4dRTAB9E8tANACSdlNSwcCE1W5BRF1rJG/egYYBzfZ+
         8UgA==
X-Gm-Message-State: AOAM531cn+NWO4vpCu5EJPza482LGqr2pRWcvzQg3Itik2NBgb8CcgeC
        PbNfQ4EZXWqzVbYXdXTBfnYtMxD3mub/jVqKfs7Zu6FWR68rVw==
X-Google-Smtp-Source: ABdhPJyBHmyke8jMl7kIZV3GpI1f5YLMaPY+LmQaSx43SCdIkXup8B/h9JHhRktiqH1xYKEsuQS/QOmTVK4s8uMz9Zc=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr2787850ljc.0.1616605471373;
 Wed, 24 Mar 2021 10:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <202103201405.UV0ZEGEW-lkp@intel.com> <CAKwvOdnik8k7-xMmwtVbwtnispGt03C0acPAPWJRuo7t+VkftQ@mail.gmail.com>
 <20210324085531.GL1551@zhen-hp.sh.intel.com>
In-Reply-To: <20210324085531.GL1551@zhen-hp.sh.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Mar 2021 10:04:20 -0700
Message-ID: <CAKwvOd=eCgAVqhdJzNGnkODD4BnTWGEDR_nbevH3cgbyf94zXg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function 'get_pt_type'
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 2:12 AM Zhenyu Wang <zhenyuw@linux.intel.com> wrote:
>
> On 2021.03.23 15:15:29 -0700, Nick Desaulniers wrote:
> > On Fri, Mar 19, 2021 at 11:45 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Nick,
> > >
> > > FYI, the error/warning still remains.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c
> > > commit: 9f4069b055d1508c833115df7493b6e0001e5c9b drm/i915: re-disable -Wframe-address
> >
> > This in unrelated to my change.
> >
> > + Changbin, Zhenyu (authors of 3aff3512802) and Zhi (author of
> > 054f4eba2a298) in case there's any interest in fixing this up.
> > Otherwise I don't think these tiny helpful functions were meant to be
> > used somewhere but are not, so there's not much value in cleaning them
> > up.
>
> I'll check that, should be some left over last big gtt code refactor.
> Looks lkp guys don't apply -Wunused-function for gvt tree build test...

Thanks, yeah the report from the bot mentions it had `make W=1 ...` on.

>
> Thanks
>
> >
> > > date:   11 months ago
> > > config: x86_64-randconfig-a016-20210319 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project fcc1ce00931751ac02498986feb37744e9ace8de)
> > > reproduce (this is a W=1 build):

^ hidden note about W=1, easy to miss.

> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f4069b055d1508c833115df7493b6e0001e5c9b
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 9f4069b055d1508c833115df7493b6e0001e5c9b
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function 'get_pt_type' [-Werror,-Wunused-function]
> > >    static inline int get_pt_type(int type)
> > >                      ^
> > > >> drivers/gpu/drm/i915/gvt/gtt.c:590:20: error: unused function 'ppgtt_set_guest_root_entry' [-Werror,-Wunused-function]
> > >    static inline void ppgtt_set_guest_root_entry(struct intel_vgpu_mm *mm,
> > >                       ^
> > >    2 errors generated.
> > >
> > >
> > > vim +/get_pt_type +267 drivers/gpu/drm/i915/gvt/gtt.c
> > >
> > > 2707e44466881d6 Zhi Wang 2016-03-28  266
> > > 054f4eba2a2985b Zhi Wang 2017-10-10 @267  static inline int get_pt_type(int type)
> > > 054f4eba2a2985b Zhi Wang 2017-10-10  268  {
> > > 054f4eba2a2985b Zhi Wang 2017-10-10  269        return gtt_type_table[type].pt_type;
> > > 054f4eba2a2985b Zhi Wang 2017-10-10  270  }
> > > 054f4eba2a2985b Zhi Wang 2017-10-10  271
> > >
> > > :::::: The code at line 267 was first introduced by commit
> > > :::::: 054f4eba2a2985b1db43353b7b5ce90e96cf9bb9 drm/i915/gvt: Introduce page table type of current level in GTT type enumerations
> > >
> > > :::::: TO: Zhi Wang <zhi.a.wang@intel.com>
> > > :::::: CC: Zhenyu Wang <zhenyuw@linux.intel.com>
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
