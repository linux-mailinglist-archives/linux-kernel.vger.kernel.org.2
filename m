Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58AF368557
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhDVQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVQ6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A4961445;
        Thu, 22 Apr 2021 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110663;
        bh=wYp6m2cid2L7a8QcEzSJ/G5GF3Io5Y/imXwpcni9DUk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DEwntaGatZvUkGJ2neEmn7SOk/zoKA3aQADZThJprL81U4hJT2gEstRiCxTauuSNI
         mJtWl7vzazKqhKA1+CBFbVdkKU0xfLBH/zxylm5cShKBDaxmtCczaPp/GeSQleQgAL
         /9DLCiQxJkrv70NTzS4okufandJIa+7zYenNerT72vJ1cxp+wDYcM2MsoocKwTvGQG
         lN6MaHnWBVpk/Nh1sIu6NdsWCAP8rbnrkx6n1U8x5s1XD2BJez/yg1YfynqSZTXumz
         hWgRuUjKh1el05Dx09W1M6G6sp0zvBG8Vou5+VU52j+fM/INUbcENq2Y2bbTWu3d1l
         i28g53n+SxLig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 39E285C010F; Thu, 22 Apr 2021 09:57:43 -0700 (PDT)
Date:   Thu, 22 Apr 2021 09:57:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec
 -14.4% regression
Message-ID: <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210420064934.GE31773@xsang-OptiPlex-9020>
 <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1>
 <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:24:54AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 22, 2021 at 03:41:26PM +0800, Feng Tang wrote:
> > Hi Paul,
> > 
> > On Thu, Apr 22, 2021 at 02:58:27PM +0800, Xing Zhengjun wrote:
> > > 
> > > 
> > > On 4/21/2021 9:42 PM, Paul E. McKenney wrote:
> > > >On Wed, Apr 21, 2021 at 02:07:19PM +0800, Xing, Zhengjun wrote:
> > > >>
> > > >>On 4/20/2021 10:05 PM, Paul E. McKenney wrote:
> > > >>>On Tue, Apr 20, 2021 at 06:43:31AM -0700, Paul E. McKenney wrote:
> > > >>>>On Tue, Apr 20, 2021 at 02:49:34PM +0800, kernel test robot wrote:
> > > >>>>>Greeting,
> > > >>>>>
> > > >>>>>FYI, we noticed a -14.4% regression of stress-ng.opcode.ops_per_sec due to commit:
> > > >>>>>
> > > >>>>>
> > > >>>>>commit: 6c52b5f3cfefd6e429efc4413fd25e3c394e959f ("clocksource: Reduce WATCHDOG_THRESHOLD")
> > > >>>>>https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.13a
> > > >>>>>
> > > >>>>>
> > > >>>>>in testcase: stress-ng
> > > >>>>>on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > > >>>>>with following parameters:
> > > >>>>>
> > > >>>>>	nr_threads: 10%
> > > >>>>>	disk: 1HDD
> > > >>>>>	testtime: 60s
> > > >>>>>	fs: ext4
> > > >>>>>	class: os
> > > >>>>>	test: opcode
> > > >>>>>	cpufreq_governor: performance
> > > >>>>>	ucode: 0x5003006
> > > >>>>Hmmm...  I will try a less-aggressive reduction.  Thank you for testing!
> > > >>>But wait...  This code is only running twice per second.  It is very
> > > >>>hard to believe that a clock-read retry twice per second is worth 2% of
> > > >>>performance, let alone 14.4%.
> > > >>>
> > > >>>Is something else perhaps going on here?
> > > >>>
> > > >>>For example, did this run enable any of the new diagnositic clocksource.*
> > > >>>kernel parameters?
> > > >>>
> > > >>>								Thanx, Paul
> > > >>I attached the kernel log, the following logs are related with the
> > > >>clocksource.
> > > >>[    3.453206] clocksource: timekeeping watchdog on CPU1: Marking
> > > >>clocksource 'tsc-early' as unstable because the skew is too large:
> > > >>[    3.455197] clocksource:                       'hpet' wd_now: 288fcc0
> > > >>wd_last: 1a8b333 mask: ffffffff
> > > >>[    3.455199] clocksource:                       'tsc-early' cs_now:
> > > >>1def309ebfdee cs_last: 1def2bd70d92c mask: ffffffffffffffff
> > > >>[    3.455201] clocksource:                       No current clocksource.
> > > >>[    3.457197] tsc: Marking TSC unstable due to clocksource watchdog
> > > >>
> > > >>6c52b5f3cf reduced WATCHDOG_THRESHOLD, then in clocksource_watchdog, the
> > > >>warning logs are print, the TSC is marked as unstable.
> > > >>/* Check the deviation from the watchdog clocksource. */
> > > >Aha, so this system really does have an unstable TSC!  Which means that
> > > >the patch is operating as designed.
> > > >
> > > >Or are you saying that this is a false positive?
> > > >
> > > >							Thanx, Paul
> > > 
> > > It happened during boot and before TSC calibration
> > > (tsc_refine_calibration_work()), so on some machines "abs(cs_nsec - wd_nsec)
> > > > WATCHDOG_THRESHOLD", WATCHDOG_THRESHOLD is set too small at that time.
> > > After TSC calibrated, abs(cs_nsec - wd_nsec) should be very small,
> > > WATCHDOG_THRESHOLD for here is ok. So I suggest increasing the
> > > WATCHDOG_THRESHOLD before TSC calibration, for example, the clocks be skewed
> > > by more than 1% to be marked unstable.
> 
> This is common code, so we do need an architecture-independent way to
> handle this.
> 
> > As Zhengjun measuered, this is a Cascade Lake platform, and it has 2
> > times calibration of tsc, the first one of early quick calibration gives
> > 2100 MHz, while the later accurate calibration gives 2095 MHz, so there
> > is about 2.5/1000 deviation for the first number, which just exceeds the
> > 1/1000 threshold you set :)
> 
> Even my 2/1000 initial try would have caused this, then.  ;-)
> 
> But even 1/1000 deviation would cause any number of applications some
> severe heartburn, so I am not at all happy with the thought of globally
> increasing to (say) 3/1000.
> 
> > Following is the tsc freq info from kernel log
> > 
> > [    0.000000] DMI: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > [    0.000000] tsc: Detected 2100.000 MHz processor
> > ...
> > [   13.859982] tsc: Refined TSC clocksource calibration: 2095.077 MHz
> 
> So what are our options?
> 
> 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
> 
> 2.	#1, but add tsc-early into the watchdog list and set
> 	CLOCK_SOURCE_MUST_VERIFY once it is better calibrated.
> 
> 3.	Add a field to struct clocksource that, if non-zero, gives
> 	the maximum drift in nanoseconds per half second (AKA
> 	WATCHDOG_INTERVAL).  If zero, the WATCHDOG_MAX_SKEW value
> 	is used.  Set this to (say) 150,000ns for tsc-early.
> 
> 4.	As noted earlier, increase WATCHDOG_MAX_SKEW to 150 microseconds,
> 	which again is not a good approach given the real-world needs
> 	of real-world applications.
> 
> 5.	Your ideas here.

Oh, and:

6.	Improve the quick calibration to be better than one part per thousand.

> All in all, I am glad that I made the patch that decreases
> WATCHDOG_MAX_SKEW be separate and at the end of the series.  ;-)

							Thanx, Paul
