Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E523376953
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhEGROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhEGROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:14:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CE5C610CD;
        Fri,  7 May 2021 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620407580;
        bh=zFapcfGOgC3O/0mNO723wBmbSDDp4RZDLXU57riBmLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DYR3SASqhtUsxrXUtZJPoGsi/CrYhaJAUjVKpAvO8w2AaIpMG9nHvU7/FxiskJAfe
         amI5SSXE3GIUyON29Eei0AZCpgkGu0rcc52wOQ4IPsburunq8QSyXFEaNYsf2LKrlS
         Y3v+fHun7vc3Aq9UBT6ssrN3a7Xv7MfjW4hwzunOlZ0sYCAFwE5EX4Dndsjcwjl5UL
         mSg/RGrv1XHVFo2f6fqEGBMQOPOqrMOzK6r1UxtY4ym81fO+nANU1IKW79Bu/WrHoX
         YyVCeEBeOr3s9m0VoCZneUA1PLIc+N9SLJkVvmmNsFJngSvkJar2snTcEWBF2DT0nM
         TX+Wbg7kITQzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1CBE5C0293; Fri,  7 May 2021 10:12:59 -0700 (PDT)
Date:   Fri, 7 May 2021 10:12:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [clocksource]  8e614d5b58:
 WARNING:at_kernel/time/clocksource-wdtest.c:#wdtest_func.cold
Message-ID: <20210507171259.GA236800@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210505143616.GC9038@xsang-OptiPlex-9020>
 <20210505180312.GM975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505180312.GM975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 11:03:12AM -0700, Paul E. McKenney wrote:
> On Wed, May 05, 2021 at 10:36:16PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 8e614d5b58992e722f07de7c2426f2c44668092b ("clocksource: Provide kernel module to test clocksource watchdog")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +-------------------------------------------------------------------------+------------+------------+
> > |                                                                         | bdbd9c673e | 8e614d5b58 |
> > +-------------------------------------------------------------------------+------------+------------+
> > | WARNING:at_kernel/time/clocksource-wdtest.c:#wdtest_func.cold           | 0          | 11         |
> > | RIP:wdtest_func.cold                                                    | 0          | 11         |
> > +-------------------------------------------------------------------------+------------+------------+
> 
> Might it be useful to address the lockdep issues that preceded this splat?
> 
> Leaving that aside, the system appears to still be booting.  There are
> RCU CPU stall warning messages later on, and then the system hangs more
> than six minutes while still booting, presumably due to the large number
> of self-tests and debug options enabled.
> 
> The intent is that the clocksource-wdtest tests run after boot has
> completed.  One approach would be to test it using modprobe after boot
> has completed.  In addition, the clocksource-wdtest module is not designed
> to handle CPU overload conditions, and making it do so would reduce the
> effectiveness of the test.
> 
> I suggest setting clocksource-wdtest.holdoff=N, where "N" is in seconds
> and is large enough that boot has completed.  Alternatively, use modprobe
> to activate this module from userspace after boot has completed.
> 
> What I do is just set CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y in an ordinary
> rcutorture run, if that helps.

All that aside, does the patch below help in your environment?

If so, I can adjust so that my testing gets done quickly and yours
avoids false-positive failures.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index 01df12395c0e..0d8542f8b1d2 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -149,7 +149,7 @@ static int wdtest_func(void *arg)
 			s = ", expect clock skew";
 		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
-		schedule_timeout_uninterruptible(2 * HZ);
+		schedule_timeout_uninterruptible(60 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
 		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
