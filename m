Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAA3EAB70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhHLUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhHLUBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D812360FBF;
        Thu, 12 Aug 2021 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628798472;
        bh=mjnohHPhIW/VrmHJUWTOd4zlGrZbM+o6iH7Bu2HF/ks=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dwdSueWmB636agNop1pxgAahGHwTvckhGIyovqkdd29gdIx5zueYqS3O31d/5hN2r
         hPoef5lBVgbXFyHFbki9lVJ1KGjSrUxtNFQvrguKrT4dRwBrzbBODFiGIzvCdVNCCb
         XMtzWsD2D51DA1gI/lol0UO3Mxz9iC4ZTn2CPn7SFVjKd9xmI9KfB+eRQwz8b13Nhc
         goLCy7e4VJx2v6VceiAddbn2/YB9JKKWRi9hXSZz+oxq48URwuHI/c6boiedam2/Pn
         toDpYJqgxqkr+krAnhWP/WGHzo2DLt2pG9DiW39JhiayHZhn5BZgnvWrM89aHCRVmU
         PsKrCCP7w7TGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A323A5C0531; Thu, 12 Aug 2021 13:01:12 -0700 (PDT)
Date:   Thu, 12 Aug 2021 13:01:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v5.15
Message-ID: <20210812200112.GY4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
 <87czqiixml.ffs@tglx>
 <20210812163753.GW4126399@paulmck-ThinkPad-P17-Gen-1>
 <87mtpmh9k4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtpmh9k4.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:11:55PM +0200, Thomas Gleixner wrote:
> On Thu, Aug 12 2021 at 09:37, Paul E. McKenney wrote:
> 
> > On Thu, Aug 12, 2021 at 03:46:42PM +0200, Thomas Gleixner wrote:
> >> On Wed, Aug 11 2021 at 17:01, Paul E. McKenney wrote:
> >> > This pull request contains a single change that prevents clocksource
> >> > watchdog testing on systems with HZ < 100, thus preventing the integer
> >> > underflow that can occur on leisurely HZed systems.  This has been
> >> > posted to LKML:
> >> >
> >> > https://lore.kernel.org/lkml/20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1/
> >> 
> >> So with HZ < 100 .mult overflows, but why not simply adjusting the
> >> mult, shift value to be
> >> 
> >>       .mult	= TICK_NSEC,
> >>       .shift	= 0,
> >> 
> >> which is effectively the same as
> >> 
> >>       .mult	= TICK_NSEC << 8,
> >>       .shift	= 8,
> >> 
> >> Hmm?
> >
> > Another option would be for me to be less lazy and to move this code:
> >
> > 	/* Since jiffies uses a simple TICK_NSEC multiplier
> > 	 * conversion, the .shift value could be zero. However
> > 	 * this would make NTP adjustments impossible as they are
> > 	 * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
> > 	 * shift both the nominator and denominator the same
> > 	 * amount, and give ntp adjustments in units of 1/2^8
> > 	 *
> > 	 * The value 8 is somewhat carefully chosen, as anything
> > 	 * larger can result in overflows. TICK_NSEC grows as HZ
> > 	 * shrinks, so values greater than 8 overflow 32bits when
> > 	 * HZ=100.
> > 	 */
> > 	#if HZ < 34
> > 	#define JIFFIES_SHIFT	6
> > 	#elif HZ < 67
> > 	#define JIFFIES_SHIFT	7
> > 	#else
> > 	#define JIFFIES_SHIFT	8
> > 	#endif
> >
> > from kernel/time/jiffies.c to include/linux/clocksource.h.
> 
> No need to expose this globaly.
> 
>   kernel/time/tick-internal.h or kernel/time/jiffies.h

How about like this?

						Thanx, Paul

------------------------------------------------------------------------
 clocksource-wdtest.c |    5 ++---
 jiffies.c            |   21 +--------------------
 tick-internal.h      |   20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

commit 2419f70beeb885ad96b832c64648e42559d7cf1d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Aug 12 09:31:28 2021 -0700

    clocksource: Make clocksource-wdtest.c safe for slow-HZ systems
    
    Currently, clocksource-wdtest.c sets a local JIFFIES_SHIFT macro for
    operation at HZ>=67, which can cause this test suite to fail on systems
    with HZ<67.  Therefore, move the HZ-based definitions of JIFFIES_SHIFT
    from kernel/time/jiffies.c to kernel/time/tick-internal.h, allowing
    the local JIFFIES_SHIFT macro to be removed from clocksource-wdtest.c
    in favor of a properly HZ-based definition.  This in turn makes
    clocksource-wdtest.c safe for slow-HZ systems.
    
    [ paulmck: Moved JIFFIES_SHIFT from include/linux/clocksource.h. ]
    
    Link: https://lore.kernel.org/lkml/20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1/
    Cc: John Stultz <john.stultz@linaro.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Rong Chen <rong.a.chen@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index b72a969f7b938..7e82500c400b9 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -19,6 +19,8 @@
 #include <linux/prandom.h>
 #include <linux/cpu.h>
 
+#include "tick-internal.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 
@@ -34,9 +36,6 @@ static u64 wdtest_jiffies_read(struct clocksource *cs)
 	return (u64)jiffies;
 }
 
-/* Assume HZ > 100. */
-#define JIFFIES_SHIFT	8
-
 static struct clocksource clocksource_wdtest_jiffies = {
 	.name			= "wdtest-jiffies",
 	.rating			= 1, /* lowest valid rating*/
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 01935aafdb460..bc4db9e5ab70c 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -10,28 +10,9 @@
 #include <linux/init.h>
 
 #include "timekeeping.h"
+#include "tick-internal.h"
 
 
-/* Since jiffies uses a simple TICK_NSEC multiplier
- * conversion, the .shift value could be zero. However
- * this would make NTP adjustments impossible as they are
- * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
- * shift both the nominator and denominator the same
- * amount, and give ntp adjustments in units of 1/2^8
- *
- * The value 8 is somewhat carefully chosen, as anything
- * larger can result in overflows. TICK_NSEC grows as HZ
- * shrinks, so values greater than 8 overflow 32bits when
- * HZ=100.
- */
-#if HZ < 34
-#define JIFFIES_SHIFT	6
-#elif HZ < 67
-#define JIFFIES_SHIFT	7
-#else
-#define JIFFIES_SHIFT	8
-#endif
-
 static u64 jiffies_read(struct clocksource *cs)
 {
 	return (u64) jiffies;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 6a742a29e545f..5459bab2f4f70 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,3 +165,23 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
+
+/* Since jiffies uses a simple TICK_NSEC multiplier
+ * conversion, the .shift value could be zero. However
+ * this would make NTP adjustments impossible as they are
+ * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
+ * shift both the nominator and denominator the same
+ * amount, and give ntp adjustments in units of 1/2^8
+ *
+ * The value 8 is somewhat carefully chosen, as anything
+ * larger can result in overflows. TICK_NSEC grows as HZ
+ * shrinks, so values greater than 8 overflow 32bits when
+ * HZ=100.
+ */
+#if HZ < 34
+#define JIFFIES_SHIFT	6
+#elif HZ < 67
+#define JIFFIES_SHIFT	7
+#else
+#define JIFFIES_SHIFT	8
+#endif
