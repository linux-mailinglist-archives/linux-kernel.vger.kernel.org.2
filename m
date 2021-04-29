Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3936EBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhD2OFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237392AbhD2OF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AC8461411;
        Thu, 29 Apr 2021 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619705081;
        bh=5MbxqxgUR9hBdiMozeO9zn/3UkKj1344YYz3ViAO4vk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pwtcwa+rGfxwfYNTYXg+KJnep6YrwvrI+QL98DAkrmBjYkGjNsFNop9VzyOBSy7mP
         lPAqIfwery239iI7UBcs1yXnUinUmTJbF1pzoG7YuPR1GQklrBapNb1WiYc1a5thaR
         KO30Uer9qEKTCAFMEB8fdQGM5vohwLGyzXhp/GJ/HiZcFxQjqzHp9HbaiCAeyUTnzZ
         HCi8AxbnwVLTX6WxE3zpyAModtt8kRtoxUTnqtOsq6hGwrq8HOVxCKGUh5jTpb/t16
         ptyXHBDh1Pos5Qi5CcJeRM81KQ9HiQWAI5i/ql/DEPHCoAXxsCdUiDrY59k0Ap4SW5
         7IprE4aaRGgzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC0C75C0093; Thu, 29 Apr 2021 07:04:40 -0700 (PDT)
Date:   Thu, 29 Apr 2021 07:04:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     tglx@linutronix.de, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v11 clocksource 6/6] clocksource: Reduce clocksource-skew
 threshold for TSC
Message-ID: <20210429140440.GT975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210429013037.3958717-6-paulmck@kernel.org>
 <202104291438.PuHsxRkl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104291438.PuHsxRkl-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:02:36PM +0800, kernel test robot wrote:
> Hi "Paul,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on tip/x86/core linux/master linus/master v5.12]
> [cannot apply to next-20210428]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210429-093259
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d036dfa5f10df9782f5278fc591d79d283c1fad
> config: riscv-randconfig-p002-20210428 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/26be1e45593936a0c04aa1d268522f8c1cb646de
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Paul-E-McKenney/Do-not-mark-clocks-unstable-due-to-delays-for-v5-13/20210429-093259
>         git checkout 26be1e45593936a0c04aa1d268522f8c1cb646de
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/time/clocksource.c: In function '__clocksource_update_freq_scale':
> >> kernel/time/clocksource.c:1094:36: error: 'WATCHDOG_MAX_SKEW' undeclared (first use in this function)
>     1094 |   if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
>          |                                    ^~~~~~~~~~~~~~~~~
>    kernel/time/clocksource.c:1094:36: note: each undeclared identifier is reported only once for each function it appears in
> >> kernel/time/clocksource.c:1097:28: error: 'WATCHDOG_THRESHOLD' undeclared (first use in this function)
>     1097 |   cs->uncertainty_margin = WATCHDOG_THRESHOLD;
>          |                            ^~~~~~~~~~~~~~~~~~

Does the patch below help?

Longer term, these definitions will likely need to instead go into
a header file, but to move testing along in the here and now...

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c228f3727191..328a65ddb959 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -96,6 +96,20 @@ static char override_name[CS_NAME_LEN];
 static int finished_booting;
 static u64 suspend_start;
 
+/*
+ * Threshold: 0.0312s, when doubled: 0.0625s.
+ * Also a default for cs->uncertainty_margin when registering clocks.
+ */
+#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
+
+/*
+ * Maximum permissible delay between two readouts of the watchdog
+ * clocksource surrounding a read of the clocksource being validated.
+ * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
+ * a lower bound for cs->uncertainty_margin values when registering clocks.
+ */
+#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
+
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
 static void clocksource_select(void);
@@ -122,17 +136,9 @@ static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 /*
- * Interval: 0.5sec Threshold: 0.0312s, when doubled: 0.0625s
+ * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
-
-/*
- * Maximum permissible delay between two readouts of the watchdog
- * clocksource surrounding a read of the clocksource being validated.
- * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
- */
-#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
