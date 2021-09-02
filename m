Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248303FF6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhIBWMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhIBWMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55C5660E9B;
        Thu,  2 Sep 2021 22:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630620685;
        bh=EoBMWi7HOlvzsuS15srDlfB6FhCF/CcwEIOS16SFOE0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s38N3ay/Xf8PFVbtN6Eg/jidBYwgg5d8SNY0FsCdYPoZ966m3hxOcr0hAnZ4QKmJg
         aQCT4OY7k+nCUbcVj4a/EL1zqfS+t7mLdjL1vSQFfPeX47T8JfeuFIgNnZ41s/BHsA
         HK0ZrxaZPiApLhyT4Xj8vFwetRZWug4tc1DXU9zLpf36uYFdvg8UP7AGkweRN6Up82
         7ARwQablur19qSCt8R6zPiwIbc8Ta8fyghNqJkM53vWU3i6KORXI4eXVyQIhffdJXR
         50kzjxmDuAcT4e+wzJi+FUn76L4bcO2yRCwySYAcmGl4KNenLiADtVLxRlHDk4NqQG
         mJq3EYRpcRA9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 139115C0E58; Thu,  2 Sep 2021 15:11:25 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:11:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2021.08.25a 99/115] kernel/time/hrtimer.c:1478:7:
 warning: no previous prototype for '__run_hrtimer_get_debug'
Message-ID: <20210902221125.GQ4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202109030640.6NuTjfs6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109030640.6NuTjfs6-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 06:01:47AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.25a
> head:   2ba1d046d9bc5b4496027d120e3ddcdfbb2fe9f4
> commit: b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf [99/115] EXP cpu: Print out last hrtimer handler

This is a debug-only commit, and will not go to mainline.  Plus I am
getting rid of it soon.  (Famous last words...)

							Thanx, Paul

> config: i386-tinyconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2021.08.25a
>         git checkout b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/time/hrtimer.c:120:21: warning: initialized field overwritten [-Woverride-init]
>      120 |  [CLOCK_REALTIME] = HRTIMER_BASE_REALTIME,
>          |                     ^~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:120:21: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
>    kernel/time/hrtimer.c:121:22: warning: initialized field overwritten [-Woverride-init]
>      121 |  [CLOCK_MONOTONIC] = HRTIMER_BASE_MONOTONIC,
>          |                      ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:121:22: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
>    kernel/time/hrtimer.c:122:21: warning: initialized field overwritten [-Woverride-init]
>      122 |  [CLOCK_BOOTTIME] = HRTIMER_BASE_BOOTTIME,
>          |                     ^~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:122:21: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
>    kernel/time/hrtimer.c:123:17: warning: initialized field overwritten [-Woverride-init]
>      123 |  [CLOCK_TAI]  = HRTIMER_BASE_TAI,
>          |                 ^~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c:123:17: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
> >> kernel/time/hrtimer.c:1478:7: warning: no previous prototype for '__run_hrtimer_get_debug' [-Wmissing-prototypes]
>     1478 | void *__run_hrtimer_get_debug(int cpu)
>          |       ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/hrtimer.c: In function '__run_hrtimer':
>    kernel/time/hrtimer.c:1507:7: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
>     1507 |  bool expires_in_hardirq;
>          |       ^~~~~~~~~~~~~~~~~~
> 
> 
> vim +/__run_hrtimer_get_debug +1478 kernel/time/hrtimer.c
> 
>   1477	
> > 1478	void *__run_hrtimer_get_debug(int cpu)
>   1479	{
>   1480		return READ_ONCE(per_cpu(__run_hrtimer_fn, cpu));
>   1481	}
>   1482	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


