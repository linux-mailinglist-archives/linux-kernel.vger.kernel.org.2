Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E193796DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEJSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhEJSQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:16:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1187D611F0;
        Mon, 10 May 2021 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620670496;
        bh=ypUzHgI3DDcWO+oAfwbWFnBxdqOAYhvWBP5s0EGEWiw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cV/WHw+lmmLatO+tAhiHDMVL9xNANJ3LZVL8Ep44U7vaQkhRWIuaWrsWQFAq+mS6n
         tqVUpqqkHs0KBwXn6OqeA5B59tdZx6Bl63NzbUZaN2O+HcqrLRpBdXV0sDxIjo1JZL
         3ToM/YCUGHeP65saSY9vmct2ymjAPYLDm9aCNgIvqoSHmDn4SduKfAaQB0yFZJh/gK
         QpljD6Nhlyr5eBKNqFtKoxkntuFK0GS4i5wxAMi/t1a+zlzVkWMS+1q7+P+LFaZikx
         oAZXOon0jUb0TBxAXSxM4fUajSYbPqd4p/Otrn3ydO57NPp7YdhfRU5PaK9nL3PPul
         8LmblpLQnnMbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B6B3D5C0333; Mon, 10 May 2021 11:14:55 -0700 (PDT)
Date:   Mon, 10 May 2021 11:14:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2021.05.02a 114/114] kernel/rcu/refscale.c:472:15:
 warning: variable 'x' set but not used
Message-ID: <20210510181455.GH975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202105061040.osgFAKrJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105061040.osgFAKrJ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 10:16:43AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.02a
> head:   35d2c62851bc03a945ae81ab0726985f726107b1
> commit: 35d2c62851bc03a945ae81ab0726985f726107b1 [114/114] refscale: Add measurement of clock readout
> config: nios2-randconfig-r014-20210505 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=35d2c62851bc03a945ae81ab0726985f726107b1
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2021.05.02a
>         git checkout 35d2c62851bc03a945ae81ab0726985f726107b1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=nios2 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/rcu/refscale.c: In function 'ref_clock_section':
> >> kernel/rcu/refscale.c:472:15: warning: variable 'x' set but not used [-Wunused-but-set-variable]
>      472 |  volatile u64 x;
>          |               ^
>    kernel/rcu/refscale.c: In function 'ref_clock_delay_section':
>    kernel/rcu/refscale.c:484:15: warning: variable 'x' set but not used [-Wunused-but-set-variable]
>      484 |  volatile u64 x;
>          |               ^
> 
> 
> vim +/x +472 kernel/rcu/refscale.c
> 
>    469	
>    470	static void ref_clock_section(const int nloops)
>    471	{
>  > 472		volatile u64 x;
>    473		int i;
>    474	
>    475		preempt_disable();
>    476		for (i = nloops; i >= 0; i--) {
>    477			x = ktime_get_real_fast_ns();
>    478		}
>    479		preempt_enable();
>    480	}
>    481	

OK, how about with the following fixup patch?

But please note that this compiler warning is incorrect.  The variable
is marked volatile, so the compiler cannot possibly know that it is in
fact unused.  Some debugger might be examining it, for but one example.

Thus, the fixup patch below is a workaround for the compiler bug.

							Thanx, Paul

------------------------------------------------------------------------

commit 1838223c42250bfc27a15b9712591e663babb1f0
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon May 10 11:12:01 2021 -0700

    squash! refscale: Add measurement of clock readout
    
    [ paulmck: Adjust volatility per kernel test robot feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index bef61a322104..20e892b2502c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -467,29 +467,33 @@ static struct ref_scale_ops acqrel_ops = {
 	.name		= "acqrel"
 };
 
+static volatile u64 stopopts;
+
 static void ref_clock_section(const int nloops)
 {
-	volatile u64 x;
+	u64 x;
 	int i;
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		x = ktime_get_real_fast_ns();
+		x += ktime_get_real_fast_ns();
 	}
 	preempt_enable();
+	stopopts = x;
 }
 
 static void ref_clock_delay_section(const int nloops, const int udl, const int ndl)
 {
-	volatile u64 x;
+	u64 x;
 	int i;
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		x = ktime_get_real_fast_ns();
+		x += ktime_get_real_fast_ns();
 		un_delay(udl, ndl);
 	}
 	preempt_enable();
+	stopopts = x;
 }
 
 static struct ref_scale_ops clock_ops = {
