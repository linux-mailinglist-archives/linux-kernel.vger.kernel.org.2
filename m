Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61EB409B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbhIMSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345961AbhIMSBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7C560F3A;
        Mon, 13 Sep 2021 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631556022;
        bh=DYDrQ8asXy8E6ShLKQ8yhrI2cPvVW4y0r3KhwB7+5Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCeCAfmBHwqjlMj/QhfHamnuGx5cSzG51yvIe+FIijNu6X+9gXf/9cnmAzVVtyyxL
         q2Y0Kr0wxOF4/72rWthAHmPdu6IjurW3fFdopOty8VninXwQJy8ZiAIfU8wvkwaSUq
         G/6qZER6UT+4/URf8L956foWL/fLT8WC/8vdsbFcaRl8LDPg1B5mrfK1SJyzNL8pw4
         pXJfLuKgNEOSmj1moGi9XSlRCoq+SYBG1hlmY3VQ3BvZBdKhPV16gXCy39fQPijV9v
         ZlAWkDwG3WemwJN+YvgvkxE8Pjf9fDnELQ99l4R53L25Rg7lOTZZT6GM5gbuf7V7+b
         3/7YsEOqE2vyA==
Date:   Mon, 13 Sep 2021 11:00:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        philip.li@intel.com, alexei.starovoitov@gmail.com,
        andrii@kernel.org
Subject: Re: [dborkman:pr/bpf-cgrp 2/4] include/linux/cgroup-defs.h:771:70:
 warning: unused parameter 'skcd'
Message-ID: <YT+RqrkQAOVhbkWu@archlinux-ax161>
References: <202109110835.fBYQcLIG-lkp@intel.com>
 <89bba45c-d15c-88b7-0e32-9280cd4e4990@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89bba45c-d15c-88b7-0e32-9280cd4e4990@iogearbox.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Sep 13, 2021 at 05:19:26PM +0200, Daniel Borkmann wrote:
> [ +Philip ]
> 
> On 9/11/21 2:38 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/bpf-cgrp
> > head:   5a6e78baee7515884b93a90c5d03db601bc9063a
> > commit: f36377d0c40cce0cdeaff50031c268bc640d94f0 [2/4] bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode
> > config: i386-randconfig-r032-20210910 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f36377d0c40cce0cdeaff50031c268bc640d94f0
> >          git remote add dborkman https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
> >          git fetch --no-tags dborkman pr/bpf-cgrp
> >          git checkout f36377d0c40cce0cdeaff50031c268bc640d94f0
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> 
> Not sure how useful these warnings below are given it is quite conventional in the kernel
> to have some static inline helper which e.g. look:
> 
> static inline int bla(struct foo *bar)
> {
> #ifdef CONFIG_<XYZ>
>         return ... /// do something with bar
> #else
>         return 0;
> #endif
> }
> 
> I presume consensus here is to ignore these given also the gazillion other cases in the
> kernel tree. In other words, goal on -Wunused-parameter for kernel would be to really
> only catch cases where a parameter is indeed in all cases unused and should be removed
> from the signature.

Unfortunately, it looks like you are getting bit by a tangential issue
here:

https://lore.kernel.org/r/YSQE2f5teuvKLkON@Ryzen-9-3900X.localdomain/

The full include log:

In file included from drivers/gpu/drm/i915/display/intel_dpll.c:7:
In file included from drivers/gpu/drm/i915/display/intel_de.h:9:
In file included from ./drivers/gpu/drm/i915/i915_drv.h:39:
In file included from ./include/linux/i2c.h:18:
In file included from ./include/linux/regulator/consumer.h:35:
In file included from ./include/linux/suspend.h:5:
In file included from ./include/linux/swap.h:9:
In file included from ./include/linux/memcontrol.h:13:
In file included from ./include/linux/cgroup.h:28:
In file included from ./include/linux/cgroup-defs.h:22:
In file included from ./include/linux/bpf-cgroup.h:5:
./include/linux/bpf.h:770:61: warning: unused parameter 'prog' [-Wunused-parameter]
static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
                                                            ^
./include/linux/bpf.h:771:32: warning: unused parameter 'tr' [-Wunused-parameter]
                                           struct bpf_trampoline *tr)
                                                                  ^
...

The fixes are here:

https://lore.kernel.org/r/20210824022640.2170859-1-nathan@kernel.org/
https://lore.kernel.org/r/20210824232237.2085342-1-nathan@kernel.org/

I will push to get these fixes accepted as quickly as possible.

Philip, would it be possible for you guys to avoid sending reports for
i386 configurations that contain any of the following three
configurations for the time being?

CONFIG_MCRUSOE=y
CONFIG_MEFFICEON=y
CONFIG_MCYRIXIII=y

They are resulting in a lot of false positives, as I have linked above.

Cheers,
Nathan
