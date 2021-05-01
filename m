Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7453707CB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhEAQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 12:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhEAQCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 12:02:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B57A611CA;
        Sat,  1 May 2021 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619884910;
        bh=J/ZkFfidH9XPIkZ1CbyLP2+FP//ogTEi99ikADMt8Bg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZCgVosKE94aGKfwRusAHcU2LP+9loviPL2zCD25qglsKHE4T4Zi34NvKDbW9itEHy
         NqKwFnQKJtUKakNt3yPjyxNAnjMCCnpGGd6XFTb3zjMyfyyT5zOVBZNhcrVlxglcz9
         O6yp+TXbDOL/KqBIOmiadHQlzxfPXT1mTa+/7K+Fu4r/oTNrII7mkSgqovi8AqrqaA
         tdvPI5FlzynktncHwOXkXtUofpAZXJxTe+/0V3xEOX5RtwNph7dHUDyhMqeSwB+R4q
         9vyIW1tw3ha47DL05+D4EwZkwSc9MUrbq7abslep/zl0d4J3Tw5RUPC5pmYhhEa0qe
         Z7Mg469SkjIow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2083A5C0348; Sat,  1 May 2021 09:01:50 -0700 (PDT)
Date:   Sat, 1 May 2021 09:01:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     tglx@linutronix.de, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v12 clocksource 5/5] clocksource: Provide kernel module
 to test clocksource watchdog
Message-ID: <20210501160150.GM975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210501003247.2448287-5-paulmck@kernel.org>
 <202105011731.6c80nr0T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105011731.6c80nr0T-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 05:49:51PM +0800, kernel test robot wrote:
> Hi "Paul,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on tip/x86/core linux/master linus/master v5.12]
> [cannot apply to next-20210430]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210501-083404
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d036dfa5f10df9782f5278fc591d79d283c1fad
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/95bd62102b4d0bedef8d834a09697cd6daa96f25
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210501-083404
>         git checkout 95bd62102b4d0bedef8d834a09697cd6daa96f25
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "clocksource_verify_percpu" [kernel/time/clocksource-wdtest.ko] undefined!

Good show, you beat my test suite that includes allmodconfig.  ;-)

Does the fixup patch below help?  (It works here.)

							Thanx, Paul

------------------------------------------------------------------------

commit 70e662d3cfe370490f310b81aaedf47d5d7cf55e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sat May 1 08:57:53 2021 -0700

    squash! clocksource: Provide kernel module to test clocksource watchdog
    
    [ paulmck: Export clocksource_verify_percpu per kernel test robot. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f9466dcd4bf3..9ac76fbe00fb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -347,6 +347,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
 			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
 }
+EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
