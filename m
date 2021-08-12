Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ABC3EA89B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhHLQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232621AbhHLQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:38:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C13A603E7;
        Thu, 12 Aug 2021 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628786274;
        bh=SpN/Z09ejna3Bhd4vpJNnGWmQbFcrh/2v1tDaruVhxU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cw8u0V8Ci2MQRfFc8uY4HFU2pONVcyKy4yz/A0L8NEJ2GH+qMfUvzhOsvXcKlPXNm
         nTK8TXQJ08m5fFJDT78sGELJf4zZPxuwjzK/akHYwPbPQ6NLzLLMpZ95YkQTdC5FTy
         TRxhRoIxMllFFjUP8z9yzG1iRso4rdkljqmi13D395/Y2NbXAGTfKXCd8Z24DEO9Na
         apkTinu6OKQML8LZhdeG36seVfNb5cfm6DRnqsS2kiAIclGcEhLZPyLFJ7HisiOsqr
         nU1WigV/LbsKuNk0NbghdHkalN+ysbTlveODj3olT1D4eU6XN3bo51zl4Dg2qka+hW
         5Qd/uyjcuTufA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 001265C0355; Thu, 12 Aug 2021 09:37:53 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:37:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        kernel-team@fb.com, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v5.15
Message-ID: <20210812163753.GW4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1>
 <87czqiixml.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czqiixml.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 03:46:42PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 11 2021 at 17:01, Paul E. McKenney wrote:
> > This pull request contains a single change that prevents clocksource
> > watchdog testing on systems with HZ < 100, thus preventing the integer
> > underflow that can occur on leisurely HZed systems.  This has been
> > posted to LKML:
> >
> > https://lore.kernel.org/lkml/20210721212755.GA2066078@paulmck-ThinkPad-P17-Gen-1/
> 
> So with HZ < 100 .mult overflows, but why not simply adjusting the
> mult, shift value to be
> 
>       .mult	= TICK_NSEC,
>       .shift	= 0,
> 
> which is effectively the same as
> 
>       .mult	= TICK_NSEC << 8,
>       .shift	= 8,
> 
> Hmm?

Another option would be for me to be less lazy and to move this code:

	/* Since jiffies uses a simple TICK_NSEC multiplier
	 * conversion, the .shift value could be zero. However
	 * this would make NTP adjustments impossible as they are
	 * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
	 * shift both the nominator and denominator the same
	 * amount, and give ntp adjustments in units of 1/2^8
	 *
	 * The value 8 is somewhat carefully chosen, as anything
	 * larger can result in overflows. TICK_NSEC grows as HZ
	 * shrinks, so values greater than 8 overflow 32bits when
	 * HZ=100.
	 */
	#if HZ < 34
	#define JIFFIES_SHIFT	6
	#elif HZ < 67
	#define JIFFIES_SHIFT	7
	#else
	#define JIFFIES_SHIFT	8
	#endif

from kernel/time/jiffies.c to include/linux/clocksource.h.

Then remove this from kernel/time/clocksource-wdtest.c:

	/* Assume HZ > 100. */
	#define JIFFIES_SHIFT	8

Then I could get rid of the HZ < 100 restriction.

So how about as shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 413933be37676419414fc7cd03e333c8eaf8a2db
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Aug 12 09:31:28 2021 -0700

    clocksource: Make clocksource-wdtest.c safe for slow-HZ systems
    
    Currently, clocksource-wdtest.c sets a local JIFFIES_SHIFT macro for
    operation at HZ>=67, which can cause this test suite to fail on systems
    with HZ<67.  Therefore, move the HZ-based definitions of JIFFIES_SHIFT
    from kernel/time/jiffies.c to include/linux/clocksource.h, allowing
    the local JIFFIES_SHIFT macro to be removed from clocksource-wdtest.c
    in favor of a properly HZ-based definition.  This in turn makes
    clocksource-wdtest.c safe for slow-HZ systems.
    
    Cc: John Stultz <john.stultz@linaro.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Rong Chen <rong.a.chen@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b173271..61b9a132a7e00 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -294,4 +294,24 @@ static inline void timer_probe(void) {}
 extern ulong max_cswd_read_retries;
 void clocksource_verify_percpu(struct clocksource *cs);
 
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
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index b72a969f7b938..781d8dc69be47 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -34,9 +34,6 @@ static u64 wdtest_jiffies_read(struct clocksource *cs)
 	return (u64)jiffies;
 }
 
-/* Assume HZ > 100. */
-#define JIFFIES_SHIFT	8
-
 static struct clocksource clocksource_wdtest_jiffies = {
 	.name			= "wdtest-jiffies",
 	.rating			= 1, /* lowest valid rating*/
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 01935aafdb460..74f4b292900d1 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -12,26 +12,6 @@
 #include "timekeeping.h"
 
 
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
